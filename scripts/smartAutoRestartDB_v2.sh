#!/bin/bash
# Auto restart DMPActiveUserListV2
# /zserver/apps/dmp/DMPActiveUserListV2-2.2.24.237/bin/smartAutoRestartDB.sh >> smartAutoRestartDB.console.txt &
# by tuantq3
dbName="dmpactiveuserlistv2"
dbType="strlist64bm"
dbDataLocation="/data/apps/"$dbName"/commitlog/"$dbType
dbBin="/zserver/apps/dmp/DMPActiveUserListV2-2.2.24.237/bin/strlist64bmserver"
dbBinLocation="/zserver/apps/dmp/DMPActiveUserListV2-2.2.24.237/bin/"
dbBackupLocation="/data/apps/"$dbName"/commitlog/debug_data"

#check db status
while true;
do
    while true;
    do 
        FINDAPP=`ps -x | grep $dbBin | grep -v "grep"` 
        #echo $FINDAPP
        if [[ $FINDAPP = "" ]]; then 
            break
        fi
        sleep 1
    done
    #
    echo "#####DB CRASH ######"    
    autoRestartTime=$(date +"%Y%m%d_%H%M%S")
    mkdir -p $dbBackupLocation/$autoRestartTime
    #get newest cml folder
    cd $dbDataLocation
    lastestCmlDir=""
    for dir in */; do
        if [ "$dir" \> "$lastestCmlDir" ]; then
            lastestCmlDir=$dir
        fi
    done
    lastestCmlDir=`echo $lastestCmlDir | rev | cut -c 2- | rev`
    echo "Move : "$lastestCmlDir" to "$dbBackupLocation/$autoRestartTime
    mv $lastestCmlDir $dbBackupLocation/$autoRestartTime/
    #
    lastestCmlDir=""
    for dir in */; do
        if [ "$dir" \> "$lastestCmlDir" ]; then
            lastestCmlDir=$dir
        fi
    done
    lastestCmlDir=`echo $lastestCmlDir | rev | cut -c 2- | rev`
    echo "Backup "$lastestCmlDir" to "$dbBackupLocation/$autoRestartTime
    rsync -rav --bwlimit=80000 $lastestCmlDir $dbBackupLocation/$autoRestartTime/
    #
    cd $dbBinLocation
    ./runservice start
    echo "Restart completed......."
    sleep 2
done
# echo ".....Done......"
