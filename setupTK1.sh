#!/bin/sh
# Configure a NVIDIA Jetson 
# and setup USB 3.0 port to run USB; usb_port_owner_info=2 indicates USB 3.0
sudo sed -i 's/usb_port_owner_info=0/usb_port_owner_info=2/' /boot/extlinux/extlinux.conf
# Disable USB autosuspend
sudo sed -i '$s/$/ usbcore.autosuspend=-1/'  /boot/extlinux/extlinux.conf
# /bin/ required for echo to work correctly in /bin/sh file
/bin/echo -e "\e[1;32mPlease reboot for changes to take effect.\e[0m"

