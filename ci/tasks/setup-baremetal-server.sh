#!/usr/bin/env bash

set -e -x

#semver=`cat version-semver/number`
semver=0.0.167
baremetal_server_release_name=baremetal-server-dev-release

deployment_dir="${PWD}/bmp-deployment"
manifest_filename="baremetal-provision-server.yml"

mkdir -p $deployment_dir

cat > "${deployment_dir}/${manifest_filename}"<<EOF
---
name: bps

releases:
- name: baremetal-server-dev-release
  url: file://./baremetal-server-dev-release.tgz
- name: bosh-softlayer-cpi
  url: file://./bosh-softlayer-cpi.tgz

resource_pools:
- name: vms
  network: default
  stemcell:
    url: file://./stemcell.tgz
  cloud_properties:
    Domain: $SL_VM_DOMAIN
    VmNamePrefix: $SL_VM_NAME_PREFIX
    EphemeralDiskSize: 100
    StartCpus: 4
    MaxMemory: 8192
    Datacenter:
       Name: $SL_DATACENTER
    HourlyBillingFlag: true
    PrimaryNetworkComponent:
       NetworkVlan:
          Id: $SL_VLAN_PUBLIC
    PrimaryBackendNetworkComponent:
       NetworkVlan:
          Id: $SL_VLAN_PRIVATE
    NetworkComponents:
    - MaxSpeed: 1000
disk_pools:
- name: disks
  disk_size: 40_000


networks:
- name: default
  type: dynamic
  dns:
  - 8.8.8.8

jobs:
- name: bps
  instances: 1

  templates:
  - name: xcat-server
    release: baremetal-server-dev-release
  - name: redis
    release: baremetal-server-dev-release
  - name: baremetal-provision-server
    release: baremetal-server-dev-release

  resource_pool: vms

  networks:
  - name: default

  properties:
    bps:
      sl_user: $SL_USERNAME
      sl_key: $SL_API_KEY
      port: 8080
      user: admin
      password: admin
      redis:
        address: 127.0.0.1
        password: 123456
        port: 25255

    softlayer: &softlayer
      username: $SL_USERNAME # <--- Replace with username
      apiKey: $SL_API_KEY # <--- Replace with password

    agent: {mbus: "nats://nats:nats@127.0.0.1:4222"}

    ntp: &ntp []

cloud_provider:
  template: {name: softlayer_cpi, release: bosh-softlayer-cpi}

  # Tells bosh-init how to contact remote agent
  mbus: https://admin:admin@$SL_VM_NAME_PREFIX.$SL_VM_DOMAIN:6868

  properties:
    softlayer: *softlayer

    # Tells CPI how agent should listen for bosh-init requests
    agent: {mbus: "https://admin:admin@$SL_VM_NAME_PREFIX.$SL_VM_DOMAIN:6868"}

    blobstore: {provider: local, path: /var/vcap/micro_bosh/data/cache}

    ntp: *ntp

EOF

echo "current files..."
ls
cp ./baremetal-server-dev-artifacts/${baremetal_server_release_name}-${semver}.tgz ${deployment_dir}/baremetal-server-dev-release.tgz
cp ./stemcell/*.tgz ${deployment_dir}/stemcell.tgz
cp ./bosh-softlayer-cpi/*.tgz ${deployment_dir}/bosh-softlayer-cpi.tgz

pushd ${deployment_dir}

  function finish {
    echo "Final state of baremetal server deployment:"
    echo "=========================================="
    cat baremetal-provision-server-state.json
    echo "=========================================="

    echo "Director:"
    echo "=========================================="
    cat /etc/hosts | grep "$SL_VM_NAME_PREFIX.$SL_VM_DOMAIN" | awk '{print $1}' | tee baremetal-server-info
    echo "=========================================="

    cp -r $HOME/.bosh_init ./
  }
  trap finish ERR

  chmod +x ../bosh-init/bosh-init*
  echo "using bosh-init CLI version..."
  ../bosh-init/bosh-init* version

  echo "deploying baremetal server..."
  ../bosh-init/bosh-init* deploy ${manifest_filename}

  trap - ERR
  finish
popd