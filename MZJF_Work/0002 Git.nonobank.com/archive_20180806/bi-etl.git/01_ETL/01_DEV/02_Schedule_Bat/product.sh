cd /opt/data-integration/scripts
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%F")

JAVA_HOME=/opt/jdk1.8.0_40
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH


etllogfile=/opt/data-integration/products_log
date="$(date +"%Y-%m-%d %H:%M:%S")"
filedate=`date +%Y-%m-%d`
export LANG="en_US.UTF-8"
monitoroutlog=/opt/data-integration/monitor/logs/monitor_$filedate.log

 # ---    products ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------products-----" >> /opt/data-integration/products_log/products$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/product/products/products.kjb /level:Basic >> /opt/data-integration/products_log/products$etllog.log
 
  # ---    products_config ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------products_config-----" >> /opt/data-integration/products_log/products_config$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/product/products_config/products_config.kjb /level:Basic >> /opt/data-integration/products_log/products_config$etllog.log
 
  # ---    borrows ----

  #    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows-----" >> /opt/data-integration/products_log/borrows$etllog.log
  #    /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/product/borrows/borrows.kjb /level:Basic >> /opt/data-integration/products_log/borrows$etllog.log

 
 ###  Configure Etl runing logfile shell ...

#for etllogs in $(echo `find $etllogfile/* -mtime -1`);
#  do
#		/bin/egrep -l -i 'error' $etllogs
#		if [ $? -ne 1 ]; then
#		  echo "Etl script runing error info $etllogs ..." | mail -s  "Etl script runing error info $etllogs ..."  540079477@qq.com
#		else
#		   echo " ------	$etllogs No error $date... " >> $monitoroutlog
#		fi
#  done

