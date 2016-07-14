#!/bin/bash
# Install the Intel Realsense library librealsense on a Jetson Development Kit
# Copyright (c) 2016 Jetsonhacks 
# MIT License
# sudo apt-get update && sudo apt-get upgrade
sudo apt-get install libusb-1.0-0-dev
# Install glfw3 3.1.2 ; Jetson TK1 currently has issues with later releases
./install_glfw3.sh
# Install into home directory
cd ~/
git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense
# Checkout version 0.9.2 of librealsense, last tested version
git checkout v0.9.2
# git checkout 495d18667aba615a3e19501ce96e28492a71b46e
# Patches uvc-v4l2.cpp to avoid crash; removes -sse flag from .pro file 
patch -p 1 -i ~/installLibrealsense/arm.patch
# Copy over the udev rules so that camera can be run from user space
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo cp config/uvc.conf /etc/modprobe.d/
sudo udevadm control --reload-rules && udevadm trigger
# Make and Install
make BACKEND=LIBUVC
sudo make install


