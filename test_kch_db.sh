#!/bin/bash
# script to run check kc hash database file
dbName=$1
partitionNum=$2
echo "The test will backup kch db files from /data/apps/"$dbName"/db_data/"$dbName" to /backup/"$dbName
# list all the db files
ls -l /data/apps/$dbName/db_data/$dbName
echo "Total partions: "$partitionNum
# let's rsync
mkdir -p /backup/$dbName
#rsync -av /data/apps/$dbName/db_data/* /backup/$dbName

# do the check using kchashmgr
echo "cd into /backup/"$dbName
cd /backup/$dbName
# kchashmgr check
for ((index=0; index<$partitionNum; index++))
do
    echo "#### Checking Partition " $index " ####"
    fileName=$dbName-$index
    kchashmgr inform -otl $fileName.kch
    kchashmgr check -otl $fileName.kch
done
echo ".....Done......"
