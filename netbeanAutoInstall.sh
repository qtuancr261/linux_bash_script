#!/bin/bash
# Auto download and install Netbeas 10.0 with custom config
userName=$(id -u -n)
# dowload link
bin10DownloadLink="https://archive.apache.org/dist/incubator/netbeans/incubating-netbeans/incubating-10.0/incubating-netbeans-10.0-bin.zip"
bin11DownloadLink="https://www-eu.apache.org/dist/incubator/netbeans/incubating-netbeans/incubating-11.0/incubating-netbeans-11.0-bin.zip"
#configDownloadLink="https://www.dropbox.com/s/md9quy42smf3onv/netbeansconf.zip?dl=0"
downloadLocation="/home/"$userName"/Downloads/installer"
installLocation="/home/"$userName
if [[ $(dpkg -s wget | grep Status) != "Status: install ok installed" ]]; then
    echo "#### wget is not currently installed on this system. ####"
    sudo apt install --yes -f wget
fi
echo "Support NetBeans version:
 -> 10
 -> 11"
read -p " -> Which version you want to install: " installVer
if [ $installVer -eq 10 ]; then
    binDownloadLink=$bin10DownloadLink
else
    binDownloadLink=$bin11DownloadLink
fi
echo "Version to download:"$installVer
# Download
echo "Preparing download location at: "$downloadLocation
mkdir -p $downloadLocation
cd $downloadLocation
wget -P . $binDownloadLink
#wget -O "./netbeansconf.zip" $configDownloadLink
downloadedBinZip=$(ls | grep incubating-netbeans | head -1)
downloadedConfZip=$(ls | grep netbeansconf | head -1)
# Install bin - desktop entry - config
unzip $downloadedBinZip -d $installLocation
unzip $downloadedConfZip -d $installLocation
echo -e "[Desktop Entry]
Encoding=UTF-8
Name=NetBeans IDE
GenericName=NetBeans IDE
Comment=NetBeans IDE
Icon=netbeans
Exec=/home/"$userName"/netbeans/bin/netbeans
Category=Development;IDE;Java;
Type=Application
Terminal=false
StartupNotify=false" >>"/home/"$userName"/.local/share/applications/netbeans_ide.desktop"
# Default conf
/home/"$userName"/netbeans/bin/netbeans
sed -i "s/\(IgnoreUnrecognizedVMOptions.*\)/IgnoreUnrecognizedVMOptions \-J\-Dawt\.useSystemAAFontSettings\=on \-J\-Dswing\.aatext\=true\"/g" $installLocation"/netbeans/etc/netbeans.conf"
