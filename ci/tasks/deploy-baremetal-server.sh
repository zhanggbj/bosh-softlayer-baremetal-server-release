#!/usr/bin/env bash

set -e

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
check_param BM_DIRECTOR_IP
check_param BM_DIRECTOR_UUID

source /etc/profile.d/chruby.sh
chruby 2.2.4

DIRECTOR_IP=$BM_DIRECTOR_IP
DIRECTOR_UUID=$BM_DIRECTOR_UUID
echo "DirectorIP =" $DIRECTOR_IP
echo "DirectorUUID =" $DIRECTOR_UUID

deployment_dir="${PWD}/baremetal-server-deployment"
manifest_filename="baremetal-server-manifest.yml"
release_name=baremetal-provision-server
mkdir -p $deployment_dir

cat > "${deployment_dir}/${manifest_filename}"<<EOF
---
name: bps-pipeline
director_uuid: ${DIRECTOR_UUID}
releases:
- name: ${release_name}
  version: latest

compilation:
  workers: 5
  network: default
  reuse_compilation_vms: true
  stemcell:
    name: bosh-softlayer-esxi-ubuntu-trusty-go_agent
    version: latest
  cloud_properties:
    Bosh_ip:  ${DIRECTOR_IP}
    StartCpus:  4
    MaxMemory:  8192
    EphemeralDiskSize: 25
    HourlyBillingFlag: true
    Datacenter: { Name:  ${SL_DATACENTER} }
    PrimaryNetworkComponent: { NetworkVlan: { Id:  ${SL_VLAN_PUBLIC} } }
    PrimaryBackendNetworkComponent: { NetworkVlan: { Id:  ${SL_VLAN_PRIVATE} } }
    VmNamePrefix:  bps-pipeline
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
  - ${DIRECTOR_IP}
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
    Bosh_ip: ${DIRECTOR_IP}
    StartCpus:  4
    MaxMemory:  8192
    HourlyBillingFlag: true
    Datacenter: { Name:  ${SL_DATACENTER} }
    PrimaryNetworkComponent: { NetworkVlan: { Id:  ${SL_VLAN_PUBLIC} } }
    PrimaryBackendNetworkComponent: { NetworkVlan: { Id:  ${SL_VLAN_PRIVATE} } }
    VmNamePrefix:  bps-pipeline
    EphemeralDiskSize: 25

jobs:
- name: bmp-server
  templates:
  - name: xcat-server
    release: ${release_name}
  - name: redis
    release: ${release_name}
  - name: baremetal-provision-server
    release: ${release_name}
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
      address: 0.bmp-server.default.bps-pipeline.microbosh
      password: 123456
      port: 25255
EOF

cp ./baremetal-server-dev-artifacts/*.tgz bps-deployment/
cp $deployment_dir/$manifest_filename bps-deployment/
cp ./stemcell/light-bosh-stemcell-*.tgz bps-deployment/