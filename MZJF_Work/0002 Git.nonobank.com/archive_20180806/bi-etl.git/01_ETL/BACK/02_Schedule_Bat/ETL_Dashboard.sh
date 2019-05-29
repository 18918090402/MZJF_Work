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



 # ---    ETL_DASHBOARD_MAIN ----

   echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_DASHBOARD_MAIN-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_DASHBOARD_MAIN$etllog.log
   /home/localadmin/ETL/00_PDI_Kettle/data-integration/kitchen.sh /file  /home/localadmin/ETL/01_Kettle_File/ETL_Dashboard/ETL_DASHBOARD_MAIN.kjb /level:Basic >> /home/localadmin/ETL/03_ETL_LOG/ETL_DASHBOARD_MAIN$etllog.log
 
 



