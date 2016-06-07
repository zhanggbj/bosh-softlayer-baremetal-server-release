#!/usr/bin/env bash
set -e

semver=`cat version-semver/number`

echo "pwd is "$PWD
ls

mkdir -p blobs/xcat/
cp bosh-softlayer-tools/xcat-* blobs/xcat/

pushd baremetal-server-release

#  source .envrc

  echo "installing bosh CLI"
  gem install bosh_cli --no-ri --no-rdoc

  echo "using bosh CLI version..."
  bosh version

  bms_release_name="baremetal-server-release"

  echo "downloading"

  echo "building baremetal server dev release..."
  bosh create release --name $bms_release_name --version $semver --with-tarball

popd

mv baremetal-server-release/dev_releases/$bms_release_name/$bms_release_name-$semver.tgz candidate/