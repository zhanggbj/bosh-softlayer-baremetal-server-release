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

source /etc/profile.d/chruby.sh
chruby 2.2.4

DIRECTOR=$BM_DIRECTOR_IP
DIRECTOR_UUID=$BM_DIRECTOR_UUID
echo "DirectorIP =" $DIRECTOR
echo "DirectorUUID =" $DIRECTOR_UUID

deployment_dir="${PWD}/dummy-release-deployment"
manifest_filename="dummy-manifest.yml"

mkdir -p $deployment_dir

cat > "${deployment_dir}/${manifest_filename}"<<EOF
---
name: dummy-bm-pipeline
director_uuid: ${DIRECTOR_UUID}

releases:
- name: dummy
  version: latest

compilation:
  workers: 1
  network: default
  reuse_compilation_vms: true
  cloud_properties:
    Bosh_ip:  ${DIRECTOR}
    Datacenter: { Name:  ${SL_DATACENTER}  }
    PrimaryNetworkComponent: { NetworkVlan: { Id:  ${SL_VLAN_PUBLIC} } }
    PrimaryBackendNetworkComponent: { NetworkVlan: { Id:  ${SL_VLAN_PRIVATE} } }
    VmNamePrefix:  dummy-bm-worker-
    EphemeralDiskSize: 100
    HourlyBillingFlag: true

update:
  canaries: 1
  canary_watch_time: 30000-360000
  update_watch_time: 30000-360000
  max_in_flight: 1
  max_errors: 1
  serial: true

networks:
- name: default
  type: dynamic
  dns:
  - ${DIRECTOR}
  - 8.8.8.8
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
    vmNamePrefix: bm-pipeline
    baremetal: true
    bm_stemcell: ${BM_STEMCELL}
    bm_netboot_image: ${BM_NETBOOT_IMAGE}

jobs:
- name: dummy_bm
  template: dummy
  instances: 1
  resource_pool: coreNode
  networks:
  - name: default
    default: [dns, gateway]
  properties:
    network_name: default

properties:
  warden:
    kernel_network_tuning_enabled: true

  dummy_with_properties:
    echo_value: echo!echo!
EOF

cp ./dummy-release/dummy-*.tgz dummy-deployment/
cp $deployment_dir/$manifest_filename dummy-deployment/
cp ./stemcell/light-bosh-stemcell-*.tgz dummy-deployment/