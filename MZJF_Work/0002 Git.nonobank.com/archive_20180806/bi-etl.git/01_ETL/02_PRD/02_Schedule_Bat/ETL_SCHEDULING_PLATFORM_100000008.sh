#!/bin/bash
cd /home/localadmin/ETL/02_Schedule_Bat
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%Y%m%d_%H_%M_%S")


JAVA_HOME=/usr/local/java
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH


date="$(date +"%Y-%m-%d %H:%M:%S")"

export LANG="en_US.UTF-8"


 # ---    ETL_SCHEDULING_PLATFORM_100000008 ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_SCHEDULING_PLATFORM_100000008-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_100000008_$etllog.log
   /home/localadmin/ETL/00_PDI_Kettle/data-integration/kitchen.sh /file  /home/localadmin/ETL/01_Kettle_File/ETL_SCHEDULING_PLATFORM/000_000_000/01_ETL_CONTROL_MAIN.kjb /param:P_JOB_ID=100000008 /level:Detailed >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_100000008_$etllog.log
 
echo "$(date +"%Y-%m-%d %H:%M:%S") scripts finish ....------ETL_SCHEDULING_PLATFORM_100000008-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_100000008_$etllog.log

