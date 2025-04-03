#!/bin/sh

# Buy: https://reurl.cc/xazl7e
# URL: https://www.waveshare.net/wiki/Fan_HAT

cd

sudo apt update && sudo apt upgrade -y

# Install BCM2835 library
wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.60.tar.gz
tar zxvf bcm2835-1.60.tar.gz
cd bcm2835-1.60/
sudo ./configure
sudo make && sudo make check && sudo make install
cd ..

# Install WiringPi library
arch=$(uname -m)
if [ "$arch" = "armv7l" ]; then
    wget https://github.com/WiringPi/WiringPi/releases/download/3.6/wiringpi_3.6_armhf.deb
    sudo apt install ./wiringpi_3.6_armhf.deb
elif [ "$arch" = "aarch64" ]; then
    wget https://github.com/WiringPi/WiringPi/releases/download/3.6/wiringpi_3.6_arm64.deb
    sudo apt install ./wiringpi_3.6_arm64.deb
else
    echo "Unknown architecture: $arch"
    exit 1
fi

# Build Fan Code
sudo apt-get install -y p7zip-full
wget http://www.waveshare.net/w/upload/0/06/Fan_HAT.7z
7z x Fan_HAT.7z -r -o./Fan_HAT
cd ~/Fan_HAT/c/
make
sudo ./main
