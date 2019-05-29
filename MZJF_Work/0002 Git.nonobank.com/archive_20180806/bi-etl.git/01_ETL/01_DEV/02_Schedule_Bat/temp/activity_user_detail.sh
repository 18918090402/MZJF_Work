cd /opt/data-integration/scripts
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%F")

JAVA_HOME=/opt/jdk1.8.0_40
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH


etllogfile=/opt/data-integration/log
date="$(date +"%Y-%m-%d %H:%M:%S")"
filedate=`date +%Y-%m-%d`
## Configre system PATH ...monitor
export LANG="en_US.UTF-8"
monitoroutlog=/opt/data-integration/monitor/logs/monitor_$filedate.log




 # ---    activity_user_detail ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------activity_user_detail-----" >> /opt/data-integration/log/activity_user_detail$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/activity_user_detail/activity_user_detail.kjb /level:Basic >> /opt/data-integration/log/activity_user_detail$etllog.log
 
 

 ###  Configure Etl runing logfile shell ...

for etllogs in $(echo `find $etllogfile/* -mtime -1`);
  do
		/bin/egrep -l -i 'error' $etllogs
		if [ $? -ne 1 ]; then
		  echo "Etl script runing error info $etllogs ..." | mail -s  "Etl script runing error info $etllogs ..."  2223035270@qq.com
		else
		   echo " ------	$etllogs No error $date... " >> $monitoroutlog
		fi
  done

