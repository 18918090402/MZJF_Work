#!/bin/bash
script_path='/home/localadmin/ETL/DISK_MONITOR'
files=('/home/localadmin/ETL/DISK_MONITOR/file_size.sh' '/home/localadmin/ETL/DISK_MONITOR/disk_monitor.sh')
for f in ${files[@]}
do
$script_path/file_size.sh $f
done