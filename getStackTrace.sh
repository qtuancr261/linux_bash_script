#!/bin/bash
# Run notifier and get eventbus stack trace graph
severPID=$1
traceTime=$2
flameGraphInfo=$3
perfTraceTime=$(date +"%A_%d%m%Y_%H.%M.%S")
perf record -F 99 -a -g -p $severPID sleep $traceTime
perf script | ./stackcollapse-perf.pl > out.perf-folded
./flamegraph.pl out.perf-folded > perf-kernel_$perfTraceTime.svg

