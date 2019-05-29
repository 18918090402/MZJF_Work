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


#### 判断进程是否执行结束
fileName=`echo $0`
echo "filename is "$fileName
count=`ps -ef | grep $fileName |wc -l`
if [ $count -gt 3 ];
then
   echo  "old job is running,old file is" $fileName" process  exit......"
   # todo do something
   exit
else
   echo "start new job......"
fi

       ### ---    user_coupon ----
 # echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_coupon-----" >> /opt/data-integration/db_nono_log/user_coupon$etllog.log
 #   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/user_coupon/user_coupon.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_coupon$etllog.log
      

	   ### ---    region ----
  #  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------region-----" >> /opt/data-integration/db_nono_log/region$etllog.log
  #  /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/region/region.kjb /level:Basic >> /opt/data-integration/db_nono_log/region$etllog.log

	   ### ---    finance_account ----
  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------finance_account-----" >> /opt/data-integration/db_nono_log/finance_account$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/finance_account/finance_account.kjb /level:Basic >> /opt/data-integration/db_nono_log/finance_account$etllog.log
                    
   
 
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

