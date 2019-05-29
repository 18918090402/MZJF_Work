#!/bin/bash
# @author: yening
# @date: 2016-11-11
#
# 抽取业务库到hadoop中ods库的sqoop脚本
# 	调用说明:./sqoop_mysql_to_hive.sh 开始位置 结束位置 
# 	例如：./sqoop_mysql_to_hive.sh 1 25 > sqoop_import.log 2>&1 &
# 
# 

		
			

export JAVA_HOME=/usr/local/java
start=$1
end=$2
printf "start run sqoop import task,from $start to $end .................................................................\n"  
#list=`(cat sqoop_mysql_to_hive_tables.txt)`
list=`sed -n "$start,$end p" sqoop_mysql_to_hive_tables.txt`
for line in $list
do
	echo "current line:"$line
	arr=(${line//,/ })  
	port=${arr[0]}
	db=${arr[1]}
	mysql_table=${arr[2]}
	primary=${arr[3]}
	stg_table=${arr[4]}
	ods_table=${arr[5]}
	map=${arr[6]}
	map_column_hive=${arr[7]}
	
 
	# 判断临时目录是否存在 
	hadoop fs -test -e /user/hdfs/$mysql_table
	if [ $? -ne 0 ]; then
	    echo "directory not exists!"
	else
	   hadoop fs -rm -r /user/hdfs/$mysql_table
	   echo "rm directory：/user/hdfs/$mysql_table"
	fi

	# 特殊的字段类型处理
	if [ "$map_column_hive" != "''" ]; then
		map_column_hive='--map-column-hive '$map_column_hive
	else
		map_column_hive=''
	fi

	# 删除hive中stg库对应的表
	hive -e "drop table if exists stg.$stg_table;"

sqoop import \
-D mapreduce.output.fileoutputformat.compress=false \
-D mapreduce.job.queuename=t_all_load \
-D mapred.job.name=sqoop_import_t_$mysql_table \
--connect jdbc:mysql://172.16.0.109:$port/$db --username risk --password WYTn1Q1q \
--table $mysql_table \
--split-by $primary \
-m $map \
--hive-import \
--create-hive-table \
--hive-table stg.$stg_table \
$map_column_hive \
--fields-terminated-by '\001' \
--hive-drop-import-delims \
--null-string '\\N' \
--null-non-string '\\N' \
--as-textfile;
	
	create_time = `date '+%Y-%m-%d %H:%M:%S'`
	pd=`date '+%Y%m%d'`

	# 转为ods库的parquet格式
	if [ "$db" != "db_nono" ]; then
  		hive -e "set hive.lock.numretries=3;set hive.lock.sleep.between.retries=3;insert overwrite table ods.$ods_table select * from stg.$stg_table;"
	else
  		hive -e "set hive.lock.numretries=3;set hive.lock.sleep.between.retries=3;insert overwrite table ods.$ods_table partition(p_run_id=${pd})  select *,'sys_crontab','${create_time}','sys_crontab','${create_time}' from stg.$stg_table;"
	fi

	echo "----------------------------------------------------------------------------------------------------------------------------------------"
	sleep 1
done  

echo "############################################################################################################################################"