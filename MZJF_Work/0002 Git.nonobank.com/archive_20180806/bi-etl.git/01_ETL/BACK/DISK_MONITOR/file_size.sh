#!/bin/bash
file_path=$1
file_size=`du -s $file_path | awk '{print $1}'`
stat_time=$(date +"%Y-%m-%d %H:%M:%S")
sql="insert into ETL.DISK_MONITOR(FILE_PATH,FILE_SIZE,STAT_TIME) select '"${file_path}"',"${file_size}",'"${stat_time}"';"
#echo $file_size
#echo $sql
mysql -h172.16.2.147 -P3307 -ufile_size_monitor -paA53lghstPGElfOY <<EOF
$sql
EOF