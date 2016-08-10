#!/usr/bin/env bash
set -e

semver=`cat version-semver/number`

pushd baremetal-server-release
  mkdir -p blobs/xcat/
  pushd blobs/xcat/
    wget https://xcat.org/files/xcat/xcat-core/2.12.x_Ubuntu/xcat-core/xcat-core-2.12.1-ubuntu.tar.bz2
    wget https://xcat.org/files/xcat/xcat-dep/2.x_Ubuntu/xcat-dep-2.12.1-ubuntu.tar.bz2
    wget http://sourceforge.net/projects/xcat/files/yum/devel/core-snap/xCAT-SoftLayer-2.10-snap201507240527.noarch.rpm/download -O xCAT-SoftLayer-2.10-snap201507240527.noarch.rpm
    wget https://s3.amazonaws.com/bosh-softlayer-tools/ubuntu-14.04.3-server-amd64.iso
  popd
  git submodule update --init --recursive --force

  echo "installing bosh CLI"
  gem install bosh_cli --no-ri --no-rdo c

  echo "using bosh CLI version..."
  bosh version

  bms_release_name="baremetal-provision-server"

  cat packages/xcat/spec
  echo "building baremetal server dev release..."
  bosh create release --name $bms_release_name --version $semver --with-tarball --force
popd

mv baremetal-server-release/dev_releases/$bms_release_name/$bms_release_name-$semver.tgz candidate/