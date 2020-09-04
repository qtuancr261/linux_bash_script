#!/bin/bash
# Build essential tool for c/c++
sudo zypper install gcc-c++
# VPN
sudo zypper install openresolv
# Build code utils
sudo zypper install cmake-full 
# Optinal for libboost

# ibus

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
#	echo "tuantq3"
#fi
