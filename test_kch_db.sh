#!/bin/bash
# script to run check kc hash database file
# you need to install  kchashmgr for this test
# kchashmgr is a Command line Utilities of Kytoto Cabinet to manage the file hash database
# by tuantq3
dbName=$1
partitionNum=$2
echo "The test will backup kch db files from /data/apps/"$dbName"/db_data/"$dbName" to /backup/"$dbName
echo "-------------------------------------------------------------------------------------------------------------------------"
# list all the db files
ls -l /data/apps/$dbName/db_data/$dbName
echo "Total partions: "$partitionNum
# let's rsync
echo "-> making backup folder in /backup/"$dbName
sudo mkdir -p /backup/$dbName
#rsync -av /data/apps/$dbName/db_data/* /backup/$dbName

# do the check using kchashmgr
echo "-> cd into /backup/"$dbName
cd /backup/$dbName
# kchashmgr check
for ((index=0; index<$partitionNum; index++))
do
    echo "---------Checking Partition " $index " ---------------"
    fileName=$dbName-$index
    kchashmgr inform -otl $fileName.kch
    # check with try lock option
    kchashmgr check -otl $fileName.kch
    # check with no lock option
    kchashmgr check -onl $fileName.kch
    # check with no repair option
    kchashmgr check -onr $fileName.kch
    echo "------------------------------------------------------"
done

echo ".....Done......"
