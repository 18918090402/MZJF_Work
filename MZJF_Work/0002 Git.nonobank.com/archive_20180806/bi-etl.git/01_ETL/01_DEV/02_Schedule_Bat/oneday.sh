cd /opt/data-integration/scripts
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%F")

JAVA_HOME=/opt/jdk1.8.0_40
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH


etllogfile=/opt/data-integration/db_nono_log
date="$(date +"%Y-%m-%d %H:%M:%S")"
filedate=`date +%Y-%m-%d`
## Configre system PATH ...monitor
export LANG="en_US.UTF-8"
monitoroutlog=/opt/data-integration/monitor/logs/monitor_$filedate.log


### ---    america_region ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------america_region-----" >> /opt/data-integration/db_nono_log/america_region$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/america_region/america_region.kjb /level:Basic >> /opt/data-integration/db_nono_log/america_region$etllog.log

 ### ---    america_school ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------america_school-----" >> /opt/data-integration/db_nono_log/america_school$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/america_school/america_school.kjb /level:Basic >> /opt/data-integration/db_nono_log/america_school$etllog.log

  #-------------SYS_APP_VERSION

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SYS_APP_VERSION-----" >> /opt/data-integration/log/SYS_APP_VERSION$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_system_update_table/SYS_APP_VERSION/SYS_APP_VERSION.kjb /level:Basic >> /opt/data-integration/log/SYS_APP_VERSION$etllog.log
 
   #-------------SYS_PRODUCT

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SYS_PRODUCT-----" >> /opt/data-integration/log/SYS_PRODUCT$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_system_update_table/SYS_PRODUCT/SYS_PRODUCT.kjb /level:Basic >> /opt/data-integration/log/SYS_PRODUCT$etllog.log
 
  # ---    ORD_APP_MESSAGE_USER ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ORD_APP_MESSAGE_USER-----" >> /opt/data-integration/log/ORD_APP_MESSAGE_USER$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_order_update_table/ORD_APP_MESSAGE_USER/ORD_APP_MESSAGE_USER.kjb /level:Basic >> /opt/data-integration/log/ORD_APP_MESSAGE_USER$etllog.log
 
   # ---    ORD_APP_MESSAGE ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ORD_APP_MESSAGE-----" >> /opt/data-integration/log/ORD_APP_MESSAGE$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_order_update_table/ORD_APP_MESSAGE/ORD_APP_MESSAGE.kjb /level:Basic >> /opt/data-integration/log/ORD_APP_MESSAGE$etllog.log
 
 
 
 
 
 ###  Configure Etl runing logfile shell ...

#for etllogs in $(echo `find $etllogfile/* -mtime -1`);
#  do
#		/bin/egrep -l -i 'error|Unable' $etllogs
#		if [ $? -ne 1 ]; then
#		  echo "Etl script runing error info $etllogs ..." | mail -s  "Etl script runing error info $etllogs ..."  2223035270@qq.com
#		else
#		   echo " ------	$etllogs No error $date... " >> $monitoroutlog
#		fi
#  done

