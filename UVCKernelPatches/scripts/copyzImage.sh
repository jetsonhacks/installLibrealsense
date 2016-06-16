#!/bin/bash
cd /usr/src/kernel
sudo cp arch/arm/boot/zImage /boot/zImage
grep -q -F 'uvcvideo' /etc/modules ||  echo 'uvcvideo' | tee -a /etc/modules
