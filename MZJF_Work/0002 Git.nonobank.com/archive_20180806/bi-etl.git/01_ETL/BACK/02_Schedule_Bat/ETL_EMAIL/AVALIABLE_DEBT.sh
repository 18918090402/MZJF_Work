#!/bin/bash
cd /home/localadmin/ETL/02_Schedule_Bat/ETL_EMAIL
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
   
/home/localadmin/ETL/00_PDI_Kettle/data-integration/kitchen.sh -rep=PROD -job=ETL_EMAIL/AVALIABLE_DEBT/job_main -level:basic >> /home/localadmin/ETL/03_ETL_LOG/AVALIABLE_DEBT_$etllog.log
