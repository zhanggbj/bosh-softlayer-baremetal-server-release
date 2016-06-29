#!/usr/bin/env bash

set -e -x

BPS=`cat ${PWD}/baremetal-server-deployment/baremetal-server-info`
DIRECTOR=`cat ${PWD}/deployment/director-info | awk "NR==1"`
data_center=$SL_DATACENTER
deployment_file=deployment.yml
public_vlan_id=$SL_VLAN_PUBLIC
private_vlan_id=$SL_VLAN_PRIVATE
bm_netboot_image=$BM_NETBOOT_IMAGE
bm_stemcell=$BM_STEMCELL
cat > "$deployment_file"<<EOF
---
name: bps
resource_pools:

- name: coreNode-bm
  size: 1
  cloud_properties:
    bosh_ip: $DIRECTOR
    datacenter: $data_center
    name_prefix: baremetal-ppl
    server_spec:
      package: 255
      server: 50399
      ram: 50389
      disk0: 50043
      port_speed: 24713
      public_vlan_id: $public_vlan_id
      private_vlan_id: $private_vlan_id
      hourly: false
    baremetal: true
    bm_stemcell: $bm_stemcell
    bm_netboot_image: $bm_netboot_image
EOF

tar -zxvf bosh-softlayer-tools/bosh-softlayer-tools-*.tgz
mv bosh-softlayer-tools/bmp /usr/local/bin
echo "{}" > $HOME/.bmp_config
export NON_VERBOSE=true
bmp target -t http://$BPS:8080
bmp login -u admin -p admin
bmp status
bmp bms
bmp stemcells
bmp create-baremetals --dryrun -d $deployment_file
bmp tasks
bmp task --task_id=1
bmp sl --packages
bmp sl --package-options=255


