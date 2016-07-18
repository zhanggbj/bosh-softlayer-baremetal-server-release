#!/bin/bash
set -e -x

# Config bosh with bmp server
#publicIp=`bosh vms|grep 'bps-pipeline/0' | awk '{print $11}'`
bosh -n target ${BM_DIRECTOR_IP}
bosh login admin admin
publicIp=`bosh vms|grep 'a6f5fcd2-6b3e-4272-88a8-300d16f31dbb' | awk '{print $11}'`
url='https://'"${SL_USERNAME}"':'"${SL_API_KEY}"'@api.softlayer.com/rest/v3/SoftLayer_Account/getVirtualGuests?objectMask=mask[primaryBackendIpAddress]&objectFilter={"virtualGuests":{"primaryIpAddress":{"operation":"'"${publicIp}"'"}}}'
result=`curl -g $url`
privateIp=`grep -oP "primaryIpAddress.*?}}]" $result | grep -o "[0-9]*"|awk "NR==1"`
echo $privateIp > bmp-server-info
cat bmp-server-info
#cpiJson=""
#spawn scp cpiJson root@${BM_DIRECTOR_IP}:/var/vcap/bash/cpi.json
#expect "*password:"
#send ${BM_DIRECTOR_PASSWORD}
# Create default netboot image

# Create stemcell
