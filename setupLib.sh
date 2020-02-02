#!/bin/bash
# Build essential tool for c/c++
sudo apt-get -y install build-essential clang clang-9 clang-format clang-format-9 clang-tools clang-tools-9
# VPN
sudo apt-get -y install openvpn resolvconf
# Build code utils
sudo apt-get -y install automake libtool cmake
sudo apt-get -y install htop atop iotop dstat nethogs vim unrar rar p7zip-full uuid autoconf ssh
sudo apt-get -y install libboost-all-dev flex unixodbc-dev mysql-client libmysqlclient-dev libevent-dev bison autoconf ssh sshfs samba libpcre++-dev libcurl3 libc6-dbg libnspr4 libnspr4-0d libnss3-1d libdb-dev
sudo apt-get -y install apache2 apache2-utils libapache2-mod-php5 php5 php5-dev php5-xdebug php-pear php5-cgi php5-cli php5-odbc php5-mysql
sudo apt-get -y install libgtop2-dev openssl libssl-dev
sudo apt-get -y install ttf-mscorefonts-installer openvpn lib32z1 lib32ncurses5 lib32bz2-1.0
sudo apt-get -y install g++ subversion git

# Optional for qtlib - Qt creator
sudo apt install -y qt5-default libqt5charts5-dev qtcreator

# Optional for fix dualboot time
read -p " => Do you want to use Local Time instead of UTC (Dualboot Time differences) Yes(y), No(N) ? : " RTC
if [ $RTC == "y" ]
then
	sudo timedatectl set-local-rtc 1 --adjust-system-clock
	timedatectl
fi


