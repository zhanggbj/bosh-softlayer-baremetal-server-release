#!/usr/bin/env bash

set -e -x

#source bosh-cpi-release/ci/tasks/utils.sh
#
#source /etc/profile.d/chruby.sh
#chruby 2.1.2

pushd deployment
  cp -r ./.bosh_init $HOME/

  chmod +x ../bosh-init/bosh-init*

  echo "using bosh-init CLI version..."
  ../bosh-init/bosh-init* version

  echo "deleting existing baremetal server..."
  ../bosh-init/bosh-init* delete bmp-manifest.yml
popd
