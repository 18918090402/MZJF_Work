## ETL_Dashboard 20160927 概览报表
cd /opt/data-integration/scripts
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%F")

JAVA_HOME=/opt/jdk1.8.0_40
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH


etllogfile=/opt/data-integration/etl_log
date="$(date +"%Y-%m-%d %H:%M:%S")"
filedate=`date +%Y-%m-%d`
export LANG="en_US.UTF-8"
monitoroutlog=/opt/data-integration/monitor/logs/monitor_$filedate.log



 # ---    ETL_DASHBOARD_MAIN ----

   echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_DASHBOARD_MAIN-----" >> /opt/data-integration/etl_log/ETL_DASHBOARD_MAIN$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/ETL_Dashboard/ETL_DASHBOARD_MAIN.kjb /param:P_T=2016-10-05 /level:Basic >> /opt/data-integration/etl_log/ETL_DASHBOARD_MAIN$etllog.log
 
 



