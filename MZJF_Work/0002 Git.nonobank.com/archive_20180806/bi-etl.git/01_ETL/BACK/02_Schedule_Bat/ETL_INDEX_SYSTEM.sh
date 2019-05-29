#!/bin/bash

source /etc/profile

#export JAVA_HOME=/opt/jdk1.8.0_111
#export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
#export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
#export LANG="en_US.UTF-8"

export kettle_home='/home/localadmin/ETL/00_PDI_Kettle/data-integration'
export job_home='/home/localadmin/ETL/01_Kettle_File'
export log_home='/home/localadmin/ETL/04_IS_LOG'

log_file=${log_home}/ETL_INDEX_SYSTEM_${1}_$(date +"%Y%m%d_%H_%M_%S").log


#指标系统

${kettle_home}/kitchen.sh -file:${job_home}/ETL_INDEX_SYSTEM/IS_MAIN.kjb -level:Basic -param:P_INDEX_FREQ=$1 >> ${log_file} 2>&1 

## grep -i 'error' ${log_file} | mail -s  "IS(run_freq=$1)"  ${my_mail_box}






