#!/bin/bash
# script to run an load test with eventbus
# by tuantq3
userName=`id -u -n`
appName=$1
# suppose we're in zeventbus folder
./bin/$appName &

