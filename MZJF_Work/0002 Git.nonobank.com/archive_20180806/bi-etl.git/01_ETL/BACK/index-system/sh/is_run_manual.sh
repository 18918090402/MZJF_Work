#!/bin/bash

if [ $# -eq 0 ];then
  echo "===================================="
  echo "参数1:指标ID，多个ID之间以逗号分隔 " 
  echo "参数2:统计日期(yyyy-mm-dd),日期之间可以，~进行分隔，形如2016-10-11,2016-10-22(日期列表)或者2016-10-11~2016-10-15(日期序列)" 
  echo "参数3:统计模式,normal-更新指标值,pre_delete-先删除指标值，再插入"
  echo "=================================="
  exit 1
fi

index_id=$1
stat_date=$2
run_mode=$3

export JAVA_HOME="/opt/jdk1.8.0_111"

IS_HOME="/webapps/index-system"

KETTLE_HOME='/home/localadmin/ETL/00_PDI_Kettle/data-integration'
#KETTLE_HOME='/opt/kettle-6.1'

JOB_DIR="${IS_HOME}/kettle"

LOG_DIR="${IS_HOME}/logs"

log_file=${LOG_DIR}/IS_${index_id}_$(date +"%Y%m%d%H%M%S").log


${KETTLE_HOME}/kitchen.sh -file:${JOB_DIR}/IS_MAIN.kjb -level:Debug -param:P_INDEX_ID=${index_id} -param:P_STAT_DATE=${stat_date} -param:P_RUN_MODE=${run_mode}







