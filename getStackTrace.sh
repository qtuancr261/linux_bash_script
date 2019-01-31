[root@WT_Zalo_GW-58 FlameGraph]# perf record -F 99 -a -g -p 39696 sleep 300
[root@WT_Zalo_GW-58 FlameGraph]# perf script | ./stackcollapse-perf.pl > out.perf-folded
[root@WT_Zalo_GW-58 FlameGraph]# ./flamegraph.pl out.perf-folded > perf-kernel_31012019_2.svg

