#!/bin/bash

if [ $# -eq 0 ];then
  echo "参数1：DAILY,HOURLY,10MIN"
  echo "参数2: nono,caishen,archive,dw_slave,hive,impala"
  exit 1
fi

index_freq=$1
sql_db=$2

#source /etc/profile
export JAVA_HOME="/opt/jdk1.8.0_111"

kettle_home='/home/localadmin/ETL/00_PDI_Kettle/data-integration'
#kettle_home='/opt/kettle-6.1'
job_home='/webapps/index-system/kettle'
log_home='/webapps/index-system/logs'
running_home='/webapps/index-system/running'
db_short_name=${sql_db:0:2}
log_file=${log_home}/is_run_crontab_${index_freq}_${db_short_name}_$(date +"%Y%m%d_%H_%M_%S").log
pid_file=$running_home/is_run_crontab_${index_freq}_${db_short_name}.pid


# if [ -f $pid_file ];then
#  echo "${index_freq}_${db_short_name} is running,ignore this schedule." > $log_file
#  exit 1
# fi

echo $$ > $pid_file

${kettle_home}/kitchen.sh -file:${job_home}/IS_MAIN.kjb -level:Basic -param:P_INDEX_FREQ=$index_freq -param:P_SQL_DB=$sql_db  >> ${log_file} 2>&1 

rm $pid_file









