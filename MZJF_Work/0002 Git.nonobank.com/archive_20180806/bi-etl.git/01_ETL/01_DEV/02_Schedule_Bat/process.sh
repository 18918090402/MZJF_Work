#!/bin/bash
 
function show_elapsed_time()
{
    user_hz=$(getconf CLK_TCK) #mostly it's 100 on x86/x86_64
    pid=$1
    jiffies=$(cat /proc/$pid/stat | cut -d" " -f22)
    sys_uptime=$(cat /proc/uptime | cut -d" " -f1)
    last_time=$(( ${sys_uptime%.*} - $jiffies/$user_hz ))
    #echo "the process $pid lasts for $last_time seconds."
    time_out=1800 #限制为 30 分钟
    if [ "$last_time" -ge "$time_out" ]
    then
        #echo "the process $pid lasts for $last_time seconds."
        kill -9 $pid
    fi
}
 
#pgrep borrows 用于返回进程名包含 borrows 字符的进程ID列表
for pid in `pgrep borrows` 
do
    #echo 'It is '$pid  
    show_elapsed_time $pid
     
done
