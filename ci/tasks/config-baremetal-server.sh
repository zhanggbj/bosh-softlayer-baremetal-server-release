#!/usr/bin/env bash
set -e -x

# Config bosh with bmp server
echo "installing bosh CLI"
gem install bosh_cli --no-ri --no-rdo c

echo "using bosh CLI version..."
bosh version

echo "login director..."
bosh -n target ${BM_DIRECTOR_IP}
bosh login admin admin
publicIp=`bosh vms|grep 'bmp-server/0' | awk '{print $11}'`
#publicIp=169.50.65.46
echo "public ip is" $publicIp
#SL_USERNAME=cuixuex%40cn.ibm.com
USERNAME=${SL_USERNAME/@/%40}
url='https://'"${USERNAME}"':'"${SL_API_KEY}"'@api.softlayer.com/rest/v3/SoftLayer_Account/getVirtualGuests?objectMask=mask[primaryBackendIpAddress,operatingSystem.passwords.password]&objectFilter={"virtualGuests":{"primaryIpAddress":{"operation":"'"${publicIp}"'"}}}'
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
sleep 10
packimage bps-netboot-ixgbe

#create baremetal stemcell
cd /var/vcap/store/baremetal-provision-server/stemcells/
mkdir bosh-stemcell-0.3-softlayer-baremetal
cd bosh-stemcell-0.3-softlayer-baremetal
wget https://s3.amazonaws.com/dev-bosh-softlayer-cpi-stemcells/bosh-stemcell-0.3-softlayer-baremetal.fsa
cp /var/vcap/packages/baremetal-provision-server/scripts/stemcell_template/* .
EOF

sudo apt-get -y install expect
set timeout 30
/usr/bin/env expect<<EOF
spawn scp -o StrictHostKeyChecking=no $create_image_file root@$privateIp:/root/
expect "*?assword:*"
exp_send "$password\r"

spawn ssh -o StrictHostKeyChecking=no root@$privateIp
expect "*?assword:*"
exp_send "$password\r"
sleep 5
send "./$create_image_file | tee ${create_image_file}.log\r"
sleep 1200
expect eof
EOF

# config director with bmp server
cpi_file=cpi.json
cat > "${cpi_file}" << EOF
{"cloud":{"plugin":"softlayer","properties":{"softlayer":{"username":"${SL_USERNAME}","apiKey":"${SL_API_KEY}"},"agent":{"ntp":[],"blobstore":{"provider":"dav","options":{"endpoint":"http://127.0.0.1:25250","user":"agent","password":"agent"}},"mbus":"nats://nats:nats@127.0.0.1:4222"},"baremetal":{"username":"admin","password":"admin","endpoint":"http://${privateIp}:8080"}}}}
EOF
cat ${cpi_file}

/usr/bin/env expect<<EOF
spawn scp -o StrictHostKeyChecking=no $cpi_file root@${BM_DIRECTOR_IP}:/var/vcap/data/jobs/softlayer_cpi/a53b4520362228e32052e95f1cb1a5d8bfd06059-52c1fc5bca79f647ee29f87cf658b6d5843d5656/config/
expect "*?assword:*"
exp_send "$password\r"
expect eof
EOF

