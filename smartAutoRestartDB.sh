#!/bin/bash
# Auto restart DMPActiveUserListV2
# by tuantq3
userName=`id -u -n`
dbName="dmpactiveuserlistv2"
dbType="strlist64bm"
userHomeDir="/home/"$userName
dbDataLocation="/data/apps/"$dbName"/commitlog/"$dbType
dbBinLocation="/zserver/apps/dmp/DMPActiveUserListV2-2.2.24.214/bin"
dbBackupLocation=$userHomeDir"/"$dbName"_trace"
lastestCmlDir=""

#check db status
while true;
do
    while true;
    do 
        FINDAPP=`ps -x |grep $dbBinLocation | grep -v "grep"` 
        echo $FINDAPP
        if [[ $FINDAPP = "" ]]; then 
            break
        fi
        sleep 1
    done

    echo "#####DB CRASH ######"    
    autoRestartTime=$(date +"%A_%d%m%Y_%H.%M.%S")
    mkdir -p $dbBackupLocation/$autoRestartTime
    #get newest cml folder
    cd $dbDataLocation
    for dir in */; do
        if [ "$dir" \> "$lastestCmlDir" ]; then
            lastestCmlDir=$dir
        fi
    done
    echo "Move : "$lastestCmlDir" to "$dbBackupLocation/$autoRestartTime
    mv $lastestCmlDir $dbBackupLocation/$autoRestartTime
    lastestCmlDir=""
    for dir in */; do
        if [ "$dir" \> "$lastestCmlDir" ]; then
            lastestCmlDir=$dir
        fi
    done
    echo "Backup "$lastestCmlDir" to "$dbBackupLocation/$autoRestartTime
    rsync -rav $lastestCmlDir $dbBackupLocation/$autoRestartTime/$lastestCmlDir

    cd $dbBinLocation
    ./runservice start
    echo "Restart completed......."
    sleep 1
done
# echo ".....Done......"
