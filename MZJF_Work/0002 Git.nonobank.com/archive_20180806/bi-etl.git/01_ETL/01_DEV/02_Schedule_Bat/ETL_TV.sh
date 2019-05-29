#!/usr/bin/env bash

## 电视轮播ETL

export JAVA_HOME=/opt/jdk1.8.0_40
export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export LANG="en_US.UTF-8"

job_home='/opt/data-integration/shipment_data'
kettle_home='/root/data-integration'
log_home='/opt/data-integration/etl_log'
log_file=${log_home}/ETL_TV_KPI_$(date +"%Y%m%d_%H_%M_%S").log

${kettle_home}/kitchen.sh -file:${job_home}/ETL_INDEX/ETL_INDEX_MAIN.kjb -level:Basic >> ${log_file}

#monitor by email
my_mailbox=892452368@qq.com

grep -i 'error' ${log_file} | mail -s  "TV_KPI run log"  ${my_mailbox}

#error=$(/bin/egrep -l -i 'error' ${log_file})
#echo ${error} | mail -s  "TV_KPI MONITOR:SUCCESS"  ${my_mailbox}
#
#if [ -n '${error}' ]; then
#  echo "success" | mail -s  "TV_KPI MONITOR:SUCCESS"  ${my_mailbox}
#else
#  cat ${log_file} | mail -s  "TV_KPI MONITOR:FAIL"  ${my_mailbox}
#fi



