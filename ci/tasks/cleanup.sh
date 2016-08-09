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

echo "done!"