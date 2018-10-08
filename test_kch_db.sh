#!/bin/bash
# script to run check kc hash database file
# you need to install  kchashmgr for this test
# kchashmgr is a Command line Utilities of Kytoto Cabinet to manage the file hash database
# by tuantq3
userName=`id -u -n`
dbName=$1
partitionNum=$2
passedTests=0
failedTests=0
dbLocation="/data/apps/"$dbName"/db_data/"$dbName
dbBackupLocation="/backup/"$dbName

check_kchashmgr_result(){
    if [ $? == 0 ]
    then
        ((++passedTests))
    else
        ((++failedTests)) 
    fi
}

echo "The test will backup kch db files from /data/apps/"$dbName"/db_data/"$dbName" to /backup/"$dbName
echo "-------------------------------------------------------------------------------------------------------------------------"
# list all the db files
ls -l /data/apps/$dbName/db_data/$dbName
echo "Total partions: "$partitionNum
# let's rsync
echo "-> making backup folder in /backup/"$dbName
sudo mkdir -p $dbBackupLocation
sudo chown -R $userName:$userName $dbBackupLocation
rsync -av $dbLocation/* $dbBackupLocation

# do the check using kchashmgr
echo "-> cd into " $dbBackupLocation
cd $dbBackupLocation
# kchashmgr check
for ((index=0; index<$partitionNum; index++))
do
    echo "---------Checking Partition " $index " ---------------"
    fileName=$dbName-$index
    echo "Analyzing file: "$fileName.kch 
    kchashmgr inform -otl $fileName.kch
    # check with try lock option
    kchashmgr check -otl $fileName.kch
    check_kchashmgr_result
    # check with no lock option
    kchashmgr check -onl $fileName.kch
    check_kchashmgr_result
    # check with no repair option
    kchashmgr check -onr $fileName.kch
    check_kchashmgr_result
    echo "------------------------------------------------------"
done
echo ".....Done......"
cd ..
# Output the result test (or write to log)
totalTest=$((partitionNum*3))
writeLogTime=$(date +"%A %d/%m/%Y %H:%M:%S")
echo $writeLogTime " -> Passed Tests: " $passedTests "/" $totalTest >> "$dbName.checkLog.ini" 


