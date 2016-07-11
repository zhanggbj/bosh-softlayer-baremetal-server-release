#!/usr/bin/env bash

set -e -x

source baremetal-server-release/ci/tasks/utils.sh

check_param SL_USERNAME
check_param SL_API_KEY
check_param SL_BM_NAME_PREFIX
check_param SL_BM_DOMAIN
check_param SL_DATACENTER
check_param SL_VLAN_PUBLIC
check_param SL_VLAN_PRIVATE
check_param BOSH_INIT_LOG_LEVEL
check_param BM_STEMCELL
check_param BM_NETBOOT_IMAGE

#DIRECTOR=`cat ${PWD}/deployment/director-info | awk "NR==1"`
#DIRECTOR_UUID=`cat ${PWD}/deployment/director-info | awk "NR==2"`

# for debug
DIRECTOR=10.113.189.212
DIRECTOR_UUID=08417c83-b77f-4ab1-9f16-de2f5bd1611d

source /etc/profile.d/chruby.sh
chruby 2.1.2

echo "DirectorIP =" $DIRECTOR
echo "DirectorUUID =" $DIRECTOR_UUID

#bosh -n target $DIRECTOR
#bosh login admin admin
#echo "Using This version of bosh:"
#bosh --version

deployment_dir="${PWD}/baremetal-server-deployment"
manifest_filename="baremetal-server-manifest.yml"

mkdir -p $deployment_dir

cat > "${deployment_dir}/${manifest_filename}"<<EOF
---
name: bps
director_uuid: ${DIRECTOR_UUID}
releases:
- name: baremetal-server-dev-release
  version: latest

compilation:
  workers: 5
  network: default
  reuse_compilation_vms: true
  stemcell:
    name: bosh-softlayer-esxi-ubuntu-trusty-go_agent
    version: latest
  cloud_properties:
    Bosh_ip:  ${DIRECTOR}
    StartCpus:  4
    MaxMemory:  8192
    EphemeralDiskSize: 25
    HourlyBillingFlag: true
    Datacenter: { Name:  ${SL_DATACENTER} }
    PrimaryNetworkComponent: { NetworkVlan: { Id:  ${SL_VLAN_PUBLIC} } }
    PrimaryBackendNetworkComponent: { NetworkVlan: { Id:  ${SL_VLAN_PRIVATE} } }
    VmNamePrefix:  bps-worker-
update:
  canaries: 1
  canary_watch_time: 30000-900000
  update_watch_time: 30000-900000
  max_in_flight: 2
  max_errors: 1
  serial: true
networks:
- name: default
  type: dynamic
  dns:
  - $DIRECTOR
  - 10.0.80.11
  - 10.0.80.12
  cloud_properties:
    security_groups:
    - default
    - cf
resource_pools:
- name: coreNode
  network: default
  size: 1
  stemcell:
    name: bosh-softlayer-esxi-ubuntu-trusty-go_agent
    version: latest
  cloud_properties:
    Bosh_ip: ${DIRECTOR}
    Datacenter: { Name: ${SL_DATACENTER} }
    VmNamePrefix: baremetal-165
    baremetal: true
    bm_stemcell: ${BM_STEMCELL}
    bm_netboot_image: ${BM_NETBOOT_IMAGE}

jobs:
- name: bps
  templates:
  - name: xcat-server
    release: baremetal-server-dev-release
  - name: redis
    release: baremetal-server-dev-release
  - name: baremetal-provision-server
    release: baremetal-server-dev-release
  instances: 1
  resource_pool: coreNode
  networks:
  - name: default
    default:
    - dns
    - gateway
properties:
  bps:
    sl_user: ${SL_USERNAME}
    sl_key: ${SL_API_KEY}
    port: 8080
    user: admin
    password: admin
    redis:
      address: 0.bps.default.bps.microbosh
      password: 123456
      port: 25255
EOF

echo "move stemcell, release and manifest to /tmp/build/put"
mkdir -p /tmp/build/bps-deployment
cp ./baremetal-server-dev-artifacts/*.tgz /tmp/build/bps-deployment/
cp $deployment_dir/$manifest_filename /tmp/build/bps-deployment/
cp ./stemcell/light-bosh-stemcell-*.tgz /tmp/build/bps-deployment/
ls /tmp/build/bps-deployment/

#echo "uploading baremetal server dev release ..."
#bosh upload release ./baremetal-server-dev-artifacts/*.tgz
#bosh releases
#
#echo "uploading stemcell ..."
#bosh upload stemcell ./stemcell/*.tgz --skip-if-exists
#bosh stemcells
#
#echo "bosh deployment ..."
#bosh deployment $deployment_dir/$manifest_filename
#bosh deployments
#
#pushd ${deployment_dir}
#
#  function finish {
#    echo "Final state of director deployment:"
#    echo "=========================================="
#    cat baremetal-server-manifest-state.json
#    echo "=========================================="
#
#    echo "Baremetal Server:"
#    echo "=========================================="
#    cat /etc/hosts | grep "$SL_BM_NAME_PREFIX.$SL_BM_DOMAIN" | awk '{print $1}' | tee baremetal-server-info
#    echo "=========================================="
#
#    cp -r $HOME/.bosh_init ./
#  }
#  trap finish ERR
#
#  bosh deploy
#  trap - ERR
#  finish
#popd
