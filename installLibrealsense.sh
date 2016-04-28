sudo apt-get update && sudo apt-get upgrade
sudo apt-get install qt5-default qtcreator -y
sudo apt-get install libusb-1.0-0-dev
./scripts/install_glfw3.sh
sudo apt-get install qtcreator -y
sudo ./scripts/install_qt.sh
git clone https://github.com/jetsonhacks/librealsense.git
cd librealsense
git checkout jetson
sudo cp config/99-realsense-libusb.rules /etc/udev/rules.d/
sudo cp config/uvc.conf /etc/modprobe.d/
sudo udevadm control --reload-rules && udevadm trigger
# Make
make BACKEND=LIBUVC
sudo make install


