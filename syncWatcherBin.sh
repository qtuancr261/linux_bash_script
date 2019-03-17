#!/bin/bash
# build watcher_clientd and clone its binary
# suppose we're in eventbus folder
clientName=watcher_client
nproc=`nproc --all`
mode=$1
numClones=$2
# build 
cd watcher_client/
make clean
make -j$nproc
# clone
if [ "x$1" = "x" ]
then
    echo "usage $0 cloneNum mode(bin only or all)"
else
    for ((cloneIndex=1; cloneIndex<=$numClones; ++cloneIndex))
    do
        if [ $mode = "bin" ]
        then
            echo "Bin mode"
        else
            echo "All files mode"
        fi
    done
fi
