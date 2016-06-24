#!/bin/bash

ROOT_DIR="$(dirname $(readlink -e $0))"

git submodule update --init --recursive --force

mkdir -p $ROOT_DIR/blobs/xcat/
cd $ROOT_DIR/blobs/xcat/
wget https://github.com/xcat2/xcat-core/releases/download/2.11_release/xcat-core-2.11-ubuntu.tar.bz2
wget https://github.com/xcat2/xcat-core/releases/download/2.11_release/xcat-dep-ubuntu-2.11.tar.bz
wget wget http://sourceforge.net/projects/xcat/files/yum/devel/core-snap/xCAT-SoftLayer-2.10-snap201507240527.noarch.rpm/download -O xCAT-SoftLayer-2.10-snap201507240527.noarch.rpm

#wget http://ftp.usf.edu/pub/centos/6.7/isos/x86_64/CentOS-6.7-x86_64-netinstall.iso
wget http://releases.ubuntu.com/14.04.3/ubuntu-14.04.3-server-amd64.iso

d