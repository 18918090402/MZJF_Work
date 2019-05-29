cd /opt/data-integration/scripts
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%Y%m%d_%H_%M_%S")


JAVA_HOME=/opt/jdk1.8.0_40
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH


etllogfile=/opt/data-integration/etl_log
date="$(date +"%Y-%m-%d %H:%M:%S")"
filedate=`date +%Y-%m-%d`
export LANG="en_US.UTF-8"
monitoroutlog=/opt/data-integration/monitor/logs/monitor_$filedate.log



 # ---    ETL_SCHEDULING_PLATFORM_100000003 ----

   echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_SCHEDULING_PLATFORM_100000003-----" >> /opt/data-integration/etl_log/ETL_SCHEDULING_PLATFORM_100000003_$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/ETL_SCHEDULING_PLATFORM/000_000_000/01_ETL_CONTROL_MAIN.kjb /param:P_JOB_ID=100000003 /level:Basic >> /opt/data-integration/etl_log/ETL_SCHEDULING_PLATFORM_100000003_$etllog.log
 
 
