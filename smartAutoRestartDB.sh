#!/bin/bash
# Auto restart DMPActiveUserListV2
# by tuantq3
userName=`id -u -n`
dbName="dmpactiveuserlistv2"
dbType="strlist64bm"
userHomeDir="/home/"$userName
dbDataLocation="/data/apps/"$dbName"/commitlog/"$dbType
dbBinLocation="/zserver/apps/dmp/DMPActiveUserListV2-2.2.24.214/bin"
dbBackupLocation=$userHomeDir"/"$dbName
dbArg="-r:cml "
newestCmlDir=""

#get newest cml folder
cd $dbDataLocation
for dir in */; do
    if [ "$dir" \> "$newestCmlDir" ]; then
        newestCmlDir=$dir
    fi
done
echo "Newest dir: "$newestCmlDir
#check service status

# while true;
# do
#     for dir in ./* do
#         echo dir
#     done
# done

# echo "The cript will backup newest dump file from /data/apps/"$dbName"/commitlog/"$dbName" to "$userHomeDir"/"$dbName
# echo "And restart server"
# echo "-------------------------------------------------------------------------------------------------------------------------"
# # list cml
# ls -al $dbDataLocation
# # let's rsync
# echo "-> making backup folder in "$userHomeDir/$dbName
# mkdir -p $userHomeDir/$dbName
# # get newest dump file and move it to 
# cd $dbDataLocation
# newestCmlDir=`ls -td -- */ | head -n 1`
# echo $newestCmlDir
# mv -v $newestCmlDir $dbBackupLocation
# # restart server
# cd $dbBinLocation
# ./runservice start
#########################################
# # kchashmgr check
# for ((index=0; index<$partitionNum; index++))
# do  
#     startTime=$(date +%M)
#     echo "---------Checking Partition " $index " ---------------"
#     fileName=$dbName-$index
#     echo "------------------------------------------------------"
#     endTime=$(date +%M)
#     echo "START.$startTime.END.$endTime"
# done

# # Output the result test (or write to log)
# totalTest=$((partitionNum*3))
# writeLogTime=$(date +"%A_%d%m%Y_%H.%M.%S")
# echo $writeLogTime " -> Passed Tests: " $passedTests "/" $totalTest >> "$dbName.checkLog.ini" 

# # zip the kch file 
# compressedFileName=$dbName"_"$writeLogTime-$passedTests"_"$totalTest.zip 
# echo $compressedFileName
# zip $compressedFileName $dbName-*
# echo ".....Done......"
