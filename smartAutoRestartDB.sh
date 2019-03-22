#!/bin/bash
# Auto restart DMPActiveUserListV2
# check db status here
# by tuantq3
userName=`id -u -n`
dbName="dmpactiveuserlistv2"
dbType="strlist64bm"
partitionNum=$2
dbLocation="/data/apps/"$dbName"/commitlog/"$dbName
dbBackupLocation="/backup/"$dbName
dbArg="-r:cml "

echo "The test will backup kch db files from /data/apps/"$dbName"/commitlog/"$dbName" to /backup/"$dbName
echo "-------------------------------------------------------------------------------------------------------------------------"
# list all the db files
ls -l /data/apps/$dbName/commitlog/$dbName
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
    startTime=$(date +%M)
    echo "---------Checking Partition " $index " ---------------"
    fileName=$dbName-$index
    echo "------------------------------------------------------"
    endTime=$(date +%M)
    echo "START.$startTime.END.$endTime"
done

# Output the result test (or write to log)
totalTest=$((partitionNum*3))
writeLogTime=$(date +"%A_%d%m%Y_%H.%M.%S")
echo $writeLogTime " -> Passed Tests: " $passedTests "/" $totalTest >> "$dbName.checkLog.ini" 

# zip the kch file 
compressedFileName=$dbName"_"$writeLogTime-$passedTests"_"$totalTest.zip 
echo $compressedFileName
zip $compressedFileName $dbName-*
echo ".....Done......"
cd
