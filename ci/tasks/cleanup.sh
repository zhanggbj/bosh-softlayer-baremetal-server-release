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

echo "delete dummy-deployment"
dummy_deployment="dummy-bm-pipeline"
echo "yes" | bosh delete deployment $dummy_deployment --force

echo "delete bps-deployment"
bps_deployment="bps-pipeline"
echo "yes" | bosh delete deployment $bps_deployment --force

echo "update baremetal state in pool"
tar -zxvf bosh-softlayer-tools/bosh-softlayer-tools-*.tgz
mv bmp /usr/local/bin
echo "{}" > $HOME/.bmp_config
export NON_VERBOSE=true
bmp_server_info="${PWD}/bps-deployment/bmp-server-info"
bmp_server=`cat ${bmp_server_info} | sed -n '1p'`
bmp target -t http://$bmp_server:8080
bmp login -u admin -p admin
server_id="311806"
bmp update-state --server $server_id --state=bm.state.new

echo "done!"