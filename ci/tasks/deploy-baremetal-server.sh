#!/usr/bin/env bash

set -e -x

DIRECTOR=`cat ${PWD}/deployment/director-info | awk "NR==1"`
DIRECTOR_UUID=`cat ${PWD}/deployment/director-info | awk "NR==2"`

source /etc/profile.d/chruby.sh
chruby 2.1.2

echo "DirectorIP =" $DIRECTOR
echo "DirectorUUID =" $DIRECTOR_UUID

bosh -n target $DIRECTOR
echo "Using This version of bosh:"
bosh --version

deployment_dir="${PWD}/baremetal-server-deployment"
manifest_filename="baremetal-server-manifest.yml"

mkdir -p $deployment_dir

cat > "${deployment_dir}/${manifest_filename}"<<EOF
---
<%
name="bps"
bosh_ip=$DIRECTOR
public_vlan_id=$SL_VLAN_PUBLIC
private_vlan_id=$SL_VLAN_PRIVATE
data_center=$SL_DATACENTER
%>
name: <%=name%>
director_uuid: $DIRECTOR_UUID
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
    Bosh_ip:  <%=bosh_ip%>
    StartCpus:  4
    MaxMemory:  8192
    EphemeralDiskSize: 25
    HourlyBillingFlag: true
    Datacenter: { Name:  <%=data_center%> }
    PrimaryNetworkComponent: { NetworkVlan: { Id:  <%=public_vlan_id%> } }
    PrimaryBackendNetworkComponent: { NetworkVlan: { Id:  <%=private_vlan_id%> } }
    VmNamePrefix:  <%=name%>-worker-
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
  - <%=bosh_ip%>
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
    Bosh_ip: <%=bosh_ip%>
    StartCpus:  4
    MaxMemory:  8192
    HourlyBillingFlag: true
    Datacenter: { Name:  <%=data_center%> }
    PrimaryNetworkComponent: { NetworkVlan: { Id:  <%=public_vlan_id%> } }
    PrimaryBackendNetworkComponent: { NetworkVlan: { Id:  <%=private_vlan_id%> } }
    VmNamePrefix:  <%=name%>-core-
    EphemeralDiskSize: 25

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
    sl_user: $SL_USERNAME
    sl_key: $SL_API_KEY
    port: 8080
    user: admin
    password: admin
    redis:
      address: 0.bps.default.<%=name%>.microbosh
      password: 123456
      port: 25255
EOF

echo "uploading baremetal server dev release ..."
bosh upload release ./baremetal-server-dev-artifacts/*.tgz
bosh releases

echo "uploading stemcell ..."
bosh upload stemcell ./stemcell/*.tgz
bosh stemcells

echo "bosh deployment ..."
bosh deployment $manifest_filename

pushd ${deployment_dir}

  function finish {
    echo "Final state of director deployment:"
    echo "=========================================="
    cat baremetal-server-manifest-state.json
    echo "=========================================="

    echo "Baremetal Server:"
    echo "=========================================="
    cat /etc/hosts | grep "$SL_VM_NAME_PREFIX.$SL_VM_DOMAIN" | awk '{print $1}' | tee baremetal-server-info
    echo "=========================================="

    cp -r $HOME/.bosh_init ./
  }
  trap finish ERR

  bosh deploy
  trap - ERR
  finish
popd
