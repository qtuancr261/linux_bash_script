#!/bin/bash
# prepare Reserve Engineering USB Protocol Wireshark by tuantq3
# ver 0.1 25/09/2019

# list all usb devices on usbmon if
echo "-> usbmon interfaces: "
lsusb
#uname=`id -u -n`

# add current user to wireshark group
echo "Add " $gnu_defVer " to wireshark group"
#sudo usermod -a -G wireshark $USER
sudo gpasswd -a $USER wireshark
sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip CAP_DAC_OVERRIDE+eip' /usr/bin/dumpcap
#read -p "-> GNU Version you want to be default: " gnu_alterVer
echo "Please relog or reboot to take effect"
echo "You have to run this command: sudo modprobe usbmon upon rebooting"
# Following instruction: https://github.com/openrazer/openrazer/wiki/Reverse-Engineering-USB-Protocol
