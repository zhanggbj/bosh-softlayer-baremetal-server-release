#!/usr/bin/env bash

set -e

source vps-release/ci/tasks/utils.sh

check_param S3_ACCESS_KEY_ID
check_param S3_SECRET_ACCESS_KEY

source /etc/profile.d/chruby.sh
chruby 2.2.4

# Creates an integer version number from the semantic version format
# May be changed when we decide to fully use semantic versions for releases
integer_version=`cut -d "." -f1 release-version-semver/number`
echo $integer_version > promoted/integer_version

cp -r vps-release promoted/repo

dev_release=$(echo $PWD/vps-dev-artifacts/*.tgz)
final_release_name="bosh-softlayer-pool-server"

pushd promoted/repo
  set +x
  echo creating config/private.yml with blobstore secrets
  cat > config/private.yml << EOF
---
blobstore:
  s3:
    access_key_id: $S3_ACCESS_KEY_ID
    secret_access_key: $S3_SECRET_ACCESS_KEY
EOF
  set -x

  echo "using bosh CLI version..."
  bosh version

  echo "finalizing vps release..."
  bosh finalize release ${dev_release} --version $integer_version --name ${final_release_name}

  rm config/private.yml
popd


