#!/usr/bin/env bash
set -e

#semver=`cat version-semver/number`
semver=0.0.167
echo "pwd is "$PWD

pushd baremetal-server-release
  mkdir -p blobs/xcat/
  wget https://github.com/xcat2/xcat-core/releases/download/2.11_release/xcat-core-2.11-ubuntu.tar.bz2 -P blobs/xcat/
  wget https://github.com/xcat2/xcat-core/releases/download/2.11_release/xcat-dep-ubuntu-2.11.tar.bz -P blobs/xcat/
  wget http://sourceforge.net/projects/xcat/files/yum/devel/core-snap/xCAT-SoftLayer-2.10-snap201507240527.noarch.rpm/download -O xCAT-SoftLayer-2.10-snap201507240527.noarch.rpm -P blobs/xcat/
  wget https://s3.amazonaws.com/bosh-softlayer-tools/ubuntu-14.04.3-server-amd64.iso blobs/xcat/
  git submodule update --init --recursive --force

  echo "installing bosh CLI"
  gem install bosh_cli --no-ri --no-rdoc

  echo "using bosh CLI version..."
  bosh version

  bms_release_name="baremetal-server-dev-release"

  cat packages/xcat/spec
  echo "building baremetal server dev release..."
  bosh create release --name $bms_release_name --version $semver --with-tarball --force

#  for debug
#  mkdir -p dev_releases/$bms_release_name/
#  wget https://s3.amazonaws.com/bosh-softlayer-tools/baremetal-server-dev-release-0.0.167.tgz -P dev_releases/$bms_release_name/
popd

mv baremetal-server-release/dev_releases/$bms_release_name/$bms_release_name-$semver.tgz candidate/