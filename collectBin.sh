#!/bin/bash
input="binList"
collectTime=$(date +"%Y%m%d")
spec=$1
binFolder="bin_"$collectTime"_"$spec
while IFS= read -r line;
do 
    echo $line;
    cd $line
    for dir in */;
    do
        echo $dir;
        serviceBinFolder="../"$binFolder"/"$line"/"$dir"bin"
        mkdir -p $serviceBinFolder
        rsync -rav $dir"bin"/* $serviceBinFolder
    done
    cd ..
done < $input