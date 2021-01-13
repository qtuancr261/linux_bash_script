#!/bin/bash
# build watcher_clientd and clone its binary
# suppose we're in eventbus folder
clientName=watcher_client
nproc=`nproc --all`
mode=$1
numInstances=$2
nwatchers=$3
# build 
cd watcher_client/
make clean
make -j$nproc
# clone
if [ "x$1" = "x" ]
then
    echo "usage $0 numInstances mode(bin only or all)"
else
    for ((instancesIndex=1; instancesIndex\<=$numInstances; ++instancesIndex))
    do
        mkdir bin_clone_$instancesIndex
        if [ $mode = "bin" ]
        then
            rsync -av bin/watcher_clientd bin_clone_$instancesIndex/ 
        else
            # $mode = "all"
            rsync -rav bin/* bin_clone_$instancesIndex/ 
        fi
    done
fi
