#!/bin/bash
cd /home/localadmin/ETL/02_Schedule_Bat
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%Y%m%d_%H_%M_%S")


JAVA_HOME=/usr/local/java
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH


export CDH_HOME=/opt/cloudera/parcels/CDH
export PATH=$CDH_HOME/bin:$PATH


date="$(date +"%Y-%m-%d %H:%M:%S")"

export LANG="en_US.UTF-8"




 # ---    ETL_SCHEDULING_PLATFORM_310000004 ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_SCHEDULING_PLATFORM_310000004-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_310000004_$etllog.log
   
    /home/localadmin/ETL/00_PDI_Kettle/data-integration/kitchen.sh -rep=PROD -dir=/ETL_SCHEDULING_PLATFORM/000_000_000/ -job=01_ETL_CONTROL_MAIN /param:P_JOB_ID=310000004 /level:basic >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_310000004_$etllog.log
 
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts finish ....------ETL_SCHEDULING_PLATFORM_310000004-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_310000004_$etllog.log

