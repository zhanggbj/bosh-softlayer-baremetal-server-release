#!/usr/bin/env bash
set -e

semver=`cat version-semver/number`

echo "pwd is "$PWD
ls

mkdir -p blobs/xcat/
wget https://github.com/xcat2/xcat-core/releases/download/2.11_release/xcat-core-2.11-ubuntu.tar.bz2 -P blobs/xcat/
wget https://github.com/xcat2/xcat-core/releases/download/2.11_release/xcat-dep-ubuntu-2.11.tar.bz -P blobs/xcat/
wget http://sourceforge.net/projects/xcat/files/yum/devel/core-snap/xCAT-SoftLayer-2.10-snap201507240527.noarch.rpm/download -O xCAT-SoftLayer-2.10-snap201507240527.noarch.rpm -P blobs/xcat/

pushd baremetal-server-release

#  source .envrc

  echo "installing bosh CLI"
  gem install bosh_cli --no-ri --no-rdoc

  echo "using bosh CLI version..."
  bosh version

  bms_release_name="baremetal-server-release"
  echo "building baremetal server dev release..."
  bosh create release --name $bms_release_name --version $semver --with-tarball --force

popd

mv baremetal-server-release/dev_releases/$bms_release_name/$bms_release_name-$semver.tgz candidate/