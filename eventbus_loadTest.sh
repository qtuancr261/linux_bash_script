#!/bin/bash
# script to run an load test with eventbus
# by tuantq3
userName=`id -u -n`
# zeventbusd
serverName=$1
# watcher_client 
clientName=$2
# b:watcher for listening
# b:notifier_load for notifying
clientOption_1=$3
#clientOption_2=$4
numInstances=$4
# suppose we're in zeventbus folder
./bin/$serverName &
for ((instanceIndex=1; instanceIndex<=$numInstances; ++instanceIndex))
do
    echo "Run watcher instance "$instanceIndex
    ./$clientName/bin_58_4_clone_$instanceIndex/$clientName"d" -$clientOption_1 &
done
