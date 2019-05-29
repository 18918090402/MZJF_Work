#!/bin/bash

#fix hourly/10min gap everyday,just workaround

index_freq='HOURLY,10MIN,30MIN'

stat_date=$(date -d yesterday +"%Y-%m-%d")

#source /etc/profile

export JAVA_HOME="/opt/jdk1.8.0_111"

kettle_home='/home/localadmin/ETL/00_PDI_Kettle/data-integration'
#kettle_home='/opt/kettle-6.1'
job_home='/webapps/index-system/kettle'
log_home='/webapps/index-system/logs'
running_home='/webapps/index-system/running'
log_file=${log_home}/is_run_fix_$(date +"%Y%m%d_%H_%M_%S").log
pid_file=$running_home/$0.pid

if [ -f $pid_file ];then
  echo "$0 is running,ignore this schedule."
  exit 1
fi

echo $$ > $pid_file

${kettle_home}/kitchen.sh -file:${job_home}/IS_MAIN.kjb -level:Basic -param:P_INDEX_FREQ=$index_freq -param:P_STAT_DATE=$stat_date  >> ${log_file} 2>&1 

rm $pid_file









