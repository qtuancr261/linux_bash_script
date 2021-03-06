#!/bin/bash
# Build essential tool for c/c++
sudo apt-get -y install build-essential clang clang-format clang-tools cppcheck
# VPN
sudo apt-get -y install openvpn resolvconf
# Build code utils
sudo apt-get -y install automake libtool cmake
sudo apt-get -y install htop atop iotop dstat nethogs vim unrar rar p7zip-full uuid autoconf ssh
sudo apt-get -y install libboost-all-dev flex unixodbc-dev libevent-dev bison autoconf ssh sshfs samba libpcre++-dev libc6-dbg libdb-dev libdb++-dev
sudo apt-get -y install libgtop2-dev openssl libssl-dev libcrypto++-dev
sudo apt-get -y install ttf-mscorefonts-installer lib32z1 lib32ncurses5
sudo apt-get -y install g++ subversion git ubuntu-restricted-extras

# Optional for qtlib - Qt creatorqt5
#sudo apt install -y qt5-default libqt5charts5-dev qtmultimedia5-dev libqt5sensors5-dev
# Qt document and examples
#sudo apt install -y qt5-doc-html qtmultimedia5-doc qtserialport5-doc qtserialport5-doc-html qtmultimedia5-examples qt5serialport-examples qtcharts5-examples qtsensors5-examples
# KDE advanced text editor
#sudo apt install -y kate

# Optinal for libboost
sudo apt install -y libboost-all-dev

# Optinal for snapd - snap apps

# ibus
sudo apt install -y ibus
im-config -n ibus
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo apt update
sudo apt install -y ibus-bamboo

# Optional for fix dualboot time
read -p " => Do you want to use Local Time instead of UTC (Dualboot Time differences) Yes(y), No(N) ? : " RTC
if [ $RTC == "y" ]
then
	sudo timedatectl set-local-rtc 1 --adjust-system-clock
	timedatectl
fi

# Optional for kde - nvidia fix tearing
KDE_ENV="/home/"$USER"/.config/plasma-workspace/env/"
#if [ $XDG_CURRENT_DESKTOP == "KDE" ]
#then
#	mkdir -p $KDE_ENV
#	cd $KDE_ENV
#	touch kwin.sh
#	echo -e "#!/bin/sh\nexport __GL_YIELD=\"usleep\"\nexport KWIN_TRIPLE_BUFFER=1" >> kwin.sh
#	chmod a+x kwin.sh
#	cd
#else
#	echo "tuankjuT"
#fi

# zsh
sudo apt install -y zsh
echo "install oh my zsh tutorial https://www.tecmint.com/install-oh-my-zsh-in-ubuntu/"
