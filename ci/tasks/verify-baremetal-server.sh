#!/usr/bin/env bash

set -e -x

function verify_return_val() {
    local cmd=$1
    local ret=$2
    local expt=$3
    if [ $ret -ne $expt ]; then
       echo "command bmp" $cmd "failed"
       exit 1
    fi
}

bmp_server=`cat ${PWD}/bmp-server-info | sed -n '1p'`
director=$BM_DIRECTOR_IP
data_center=$SL_DATACENTER
bm_deployment_file=deployment.yml
public_vlan_id=$SL_VLAN_PUBLIC
private_vlan_id=$SL_VLAN_PRIVATE
bm_netboot_image=$BM_NETBOOT_IMAGE
bm_stemcell=$BM_STEMCELL
cat > "$bm_deployment_file"<<EOF
---
name: bps-pipeline
resource_pools:

- name: coreNode-bm
  size: 1
  cloud_properties:
    bosh_ip: ${dirctor}
    datacenter: ${data_center}
    domain: bluemix.com
    name_prefix: bm-pipeline
    server_spec:
      cores: 4
      memory: 4
      max_port_speed: 100
      public_vlan_id: 524956
      private_vlan_id: 524954
      hourly: true
    baremetal: true
    bm_stemcell: ${bm_stemcell}
    bm_netboot_image: ${bm_netboot_image}
EOF

tar -zxvf bosh-softlayer-tools/bosh-softlayer-tools-*.tgz
mv bmp /usr/local/bin
echo "{}" > $HOME/.bmp_config
export NON_VERBOSE=true
bmp target -t http://$bmp_server:8080
verify_return_val "target" $? 0

bmp login -u admin -p admin
verify_return_val "login" $? 0

bmp status
verify_return_val "status" $? 0

bmp bms
verify_return_val "bms" $? 0

bmp stemcells
verify_return_val "stemcells" $? 0

bmp tasks
verify_return_val "tasks" $? 0

bmp task --task_id=1
verify_return_val "task --task_id" $? 0

bmp sl --packages
verify_return_val "sl --packages" $? 0

bmp sl --package-options=255
verify_return_val "sl --package-options" $? 0


