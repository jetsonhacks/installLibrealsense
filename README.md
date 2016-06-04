Installs the librealsense library for the Intel Realsense cameras on the NVIDIA Jetson platform.

Installation is broken up into two parts. The shell file 'installLibrealsense.sh' installs dependences for the librealsense library on the Jetson, including libusb-dev and the glfw library, and then clones the librealsense library, patches it for ARM, and then builds the library and installs it. As a convenience, the script also builds the examples using the LIBUVC backend, which end up in the 'bin' directory.

<b>Note:</b> As of this writing (June 3, 2016) the Jetson TK1 uses v3.1.2 of the glfw, as later versions crash. The version supplied within librealsense currently builds v3.2, which causes issues.

There is also a shell file for installing Qt Creator, which can be used to work with the supplied Qt Creator project files included in the installation.

The Jetson Development Kits have a feature used for power saving, called autosuspend, which will power down the USB ports after they have been idle for a while. The script 'disableAutosuspend.sh' will turn that feature off, which is needed for the RealSense camera.

Also, the Realsense cameras are USB 3.0, which requires that the proper flag be set on a Jetson TK1. For example:

# Jetson TK1: Setup USB port to run USB 3.0; usb_port_owner_info=2 indicates USB 3.0
sudo sed -i 's/usb_port_owner_info=0/usb_port_owner_info=2/' /boot/extlinux/extlinux.conf

The Jetson TX1 enables USB 3.0 by default.

The Realsense R200 is the only camera tested so far on the Jetson.

* May 1, 2016
As of this writing, a plug/replug may be needed before the camera will work


