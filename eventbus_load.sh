#!/bin/bash
# script to run an load test with eventbus
# by tuantq3
userName=`id -u -n`
serverName=$1
clientName=$2
clientOption=$3
# suppose we're in zeventbus folder
./bin/$serverName &
for ((instanceIndex=1; instanceIndex<3; ++instanceIndex))
do
    echo "Run watcher instance "$instanceIndex
    ./$clientName/bin_58_4_clone_$instanceIndex/$clientName"d" -$clientOption &
done