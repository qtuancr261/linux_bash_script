#!/bin/bash
# switch GNU gcc/g++ compiler script by tuantq3
# ver 0.2 23/09/2018

# list all the versions installed on your system
echo "-> GNU g++ version you can choose: "
find /usr/bin -iname "g++*"
gnu_defVer=`g++ -dumpversion`

# show the default version before switching
echo "-> GNU Default Version: " $gnu_defVer
read -p "-> GNU Version you want to be default: " gnu_alterVer
# let's do the job
if [ $gnu_defVer != $gnu_alterVer ]
then
    echo "Switching GNU version from " $gnu_defVer " to "  "$gnu_alterVer"
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$gnu_defVer 40 --slave /usr/bin/g++ g++ /usr/bin/g++-$gnu_defVer
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-$gnu_alterVer 80 --slave /usr/bin/g++ g++ /usr/bin/g++-$gnu_alterVer
    # that easiser
    # need more enhancement
    sudo update-alternatives --config g++
    g++ --version
    echo "Done"
else
    echo "Nothing to do with it !"
fi
