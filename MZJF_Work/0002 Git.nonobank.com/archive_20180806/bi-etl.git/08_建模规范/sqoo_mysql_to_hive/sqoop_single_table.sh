#!/bin/bash
# @author: yening
# @date: 2016-11-11
#
# 抽取指定单表的业务库到hadoop中ods库的sqoop脚本
# 	调用说明:./sqoop_single_table.sh 数据库名 表名 
# 	例如：./sqoop_single_table.sh nonobank_app product_profile > sqoop_import.log 2>&1 &
# 
# 


db_input=$1
table_input=$2

# 定义业务表信息(map 结构)
declare -A table_list=()
list=`(cat sqoop_mysql_to_hive_tables.txt)`
for line in $list
do
    arr=(${line//,/ })
    db_info=${arr[1]}
    table_info=${arr[2]}
    table_list["${db_info}_${table_info}"]="$line"
done

# 处理指定业务库信息
echo  ${table_list["${db_input}_${table_input}"]}
field_list=${table_list["${db_input}_${table_input}"]}
fields=(${field_list//,/ }) 
port=${fields[0]}
db=${fields[1]}
mysql_table=${fields[2]}
primary=${fields[3]}
stg_table=${fields[4]}
ods_table=${fields[5]}
map=${fields[6]}
map_column_hive=${fields[7]}

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

# sqoop 导入
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



echo "table:${table_input} import data successful,target table is:ods.$ods_table."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

