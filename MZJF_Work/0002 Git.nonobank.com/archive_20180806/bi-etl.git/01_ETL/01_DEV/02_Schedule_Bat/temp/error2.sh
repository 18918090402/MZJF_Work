#!/bin/sh
date="$(date +"%Y-%m-%d %H:%M:%S")"
filedate='2016-07-26'
## Configre system PATH ...monitor
export LANG="en_US.UTF-8"
java8=/opt/jdk1.8.0_40/bin
monitoroutlog=/opt/data-integration/monitor/logs/monitor_$filedate.log
runsenddir=/usr/sbin/sendmail




###  Configure Etl runing logfile shell .... 
etllogfile=/opt/data-integration/log

for etllog in $(echo `find $etllogfile/* -mtime -5`);
  do
		/bin/egrep -l -i 'error|Unable' $etllog
		if [ $? -ne 1 ]; then
		  echo "Etl script runing error info $etllog ..." | mail -s  "Etl script runing error info $etllog ..."  540079477@qq.com
		else
		   echo " ------	$etllog No error $date... " >> $monitoroutlog
		fi
  done

