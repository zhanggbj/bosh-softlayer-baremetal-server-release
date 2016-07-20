#!/usr/bin/env bash
set -e -x

# Config bosh with bmp server
#echo "installing bosh CLI"
#gem install bosh_cli --no-ri --no-rdo c
#
#echo "using bosh CLI version..."
#bosh version

echo "login director..."
bosh -n target ${BM_DIRECTOR_IP}
bosh login admin admin
publicIp=`bosh vms|grep 'bmp-server/0' | awk '{print $11}'`
#publicIp=169.50.65.46
echo "public ip is" $publicIp
#SL_USERNAME=cuixuex%40cn.ibm.com
SL_USERNAME=${SL_USERNAME/@/%40}
url='https://'"${SL_USERNAME}"':'"${SL_API_KEY}"'@api.softlayer.com/rest/v3/SoftLayer_Account/getVirtualGuests?objectMask=mask[primaryBackendIpAddress,operatingSystem.passwords.password]&objectFilter={"virtualGuests":{"primaryIpAddress":{"operation":"'"${publicIp}"'"}}}'
result_file=result.file
curl -g $url > $result_file
privateIp=`grep -oP '(?<="primaryBackendIpAddress":")[^"]*' $result_file`
password=`grep -oP '(?<="password":")[^"]*' $result_file`
echo $privateIp > bmp-server-info
echo $password > bmp-server-info
cat bmp-server-info

# create netboot image and stemcell for bmp server
create_image_file=create_bmp_server_image.sh
cat > "${create_image_file}"<<EOF
#!/bin/bash
#create default netboot image
lsdef -t osimage -z ubuntu14.04.3-x86_64-netboot-compute | sed 's/^[^ ]\+:/bps-netboot-ixgbe:/' | mkdef -z
genimage -n ixgbe bps-netboot-ixgbe
packimage bps-netboot-ixgbe

#create baremetal stemcell
cd /var/vcap/store/baremetal-provision-server/stemcells/
mkdir bosh-stemcell-3262.2-softlayer-baremetal
cd bosh-stemcell-3262.2-softlayer-baremetal
wget https://s3.amazonaws.com/dev-bosh-softlayer-cpi-stemcells/bosh-stemcell-3262.2-softlayer-baremetal.fsa
cp /var/vcap/packages/baremetal-provision-server/scripts/stemcell_template/* .
EOF

sudo apt-get -y install expect
set timeout -1
/usr/bin/env expect<<EOF
spawn scp $create_image_file root@$privateIp:/root/
expect "*?assword:*"
exp_send "$password\r"

spawn ssh root@$privateIp "./$create_image_file"
expect "*?assword:*"
exp_send "$password\r"
expect eof
EOF