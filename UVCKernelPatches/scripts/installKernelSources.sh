#!/bin/bash
apt-add-repository universe
apt-get update
apt-get install libqt4-dev pkg-config -y
cd /usr/src
wget http://developer.download.nvidia.com/embedded/L4T/r21_Release_v4.0/source/kernel_src.tbz2
tar -xvf kernel_src.tbz2
cd kernel
zcat /proc/config.gz > .config
make xconfig



