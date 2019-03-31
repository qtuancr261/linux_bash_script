#!/bin/bash
# Auto download and install Netbeas 10.0 with custom config
userName=`id -u -n`
binDownloadLink="http://mirrors.viethosting.com/apache/incubator/netbeans/incubating-netbeans/incubating-10.0/incubating-netbeans-10.0-bin.zip"
configDownloadLink="https://www.dropbox.com/s/md9quy42smf3onv/netbeansconf.zip?dl=0"
downloadLocation="/home/"$userName"/Downloads/installer"
installLocation="/home/"$userName
if [[ $(dpkg -s wget | grep Status) != "Status: install ok installed" ]]; then
    echo "wget is not installed in this system. We will use it to download netbeans"
    sudo apt install --yes -f wget 
fi
# Download
mkdir -p $downloadLocation
wget -P $downloadLocation $binDownloadLink
wget -O $downloadLocation"/netbeansconf.zip" $configDownloadLink
downloadedBinZip=$(ls $downloadLocation | grep bin.zip)
downloadedConfZip=$(ls $downloadLocation | grep conf.zip)
# Install bin - desktop entry - config
#unzip $downloadedBinZip -d $installLocation
echo -e "[Desktop Entry]
Encoding=UTF-8
Name=NetBeans IDE 10
GenericName=NetBeans IDE
Comment=NetBeans IDE
Icon=netbeans
Exec=/home/"$userName"/netbeans/bin/netbeans
Category=Development;IDE;Java;
Type=Application
Terminal=false
StartupNotify=false" >> "/home/"$userName"/.local/share/applications/netTest.desktop"
# 


