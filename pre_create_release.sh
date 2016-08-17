#!/bin/bash

ROOT_DIR="$(dirname $(readlink -e $0))"

git submodule update --init --recursive --force

mkdir -p $ROOT_DIR/blobs/xcat/
cd $ROOT_DIR/blobs/xcat/
wget https://xcat.org/files/xcat/xcat-core/2.12.x_Ubuntu/xcat-core/xcat-core-2.12.1-ubuntu.tar.bz2
wget https://xcat.org/files/xcat/xcat-dep/2.x_Ubuntu/xcat-dep-2.12.1-ubuntu.tar.bz2
wget http://search.cpan.org/CPAN/authors/id/M/MI/MIYAGAWA/App-cpanminus-1.7042.tar.gz
wget http://search.cpan.org/CPAN/authors/id/M/MO/MONS/XML-Hash-LX-0.0603.tar.gz
wget wget http://sourceforge.net/projects/xcat/files/yum/devel/core-snap/xCAT-SoftLayer-2.10-snap201507240527.noarch.rpm/download -O xCAT-SoftLayer-2.10-snap201507240527.noarch.rpm
wget http://releases.ubuntu.com/14.04.3/ubuntu-14.04.3-server-amd64.iso

