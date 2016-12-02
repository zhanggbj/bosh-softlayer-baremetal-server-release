#!/usr/bin/env bash
set -e

semver=`cat version-semver/number`

pushd vps-release

  mkdir -p blobs/golang_1.7/
  pushd blobs/golang_1.7/
    wget https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz
  popd
  
  echo "installing bosh CLI"
  gem install bosh_cli --no-ri --no-rdo c

  echo "using bosh CLI version..."
  bosh version

  vps_release_name="bosh-softlayer-pool-server"


  echo "building baremetal server dev release..."
  bosh create release --name $vps_release_name --version $semver --with-tarball --force
popd

mv vps-release/dev_releases/$vps_release_name/$vps_release_name-$semver.tgz candidate/