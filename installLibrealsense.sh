#!/bin/bash
# Install the Intel Realsense library librealsense on a Jetson Development Kit
# Copyright (c) 2016 Jetsonhacks 
# MIT License
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install libusb-1.0-0-dev
# Install into home directory
cd ~/
git clone https://github.com/jetsonhacks/librealsense.git
cd librealsense
# Install glfw3
./scripts/install_glfw3.sh
# Checkout the Jetson branch
git checkout jetson
# Copy over the udev rules so that camera can be run from user space
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo cp config/uvc.conf /etc/modprobe.d/
sudo udevadm control --reload-rules && udevadm trigger
# Make and Install
make BACKEND=LIBUVC
sudo make install


