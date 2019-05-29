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

                ### ---    activity_point_log ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------activity_point_log-----" >> /opt/data-integration/db_nono_log/activity_point_log$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/activity_point_log/activity_point_log.kjb /level:Basic >> /opt/data-integration/db_nono_log/activity_point_log$etllog.log
                ### ---    activity_prize_gain_list ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------activity_prize_gain_list-----" >> /opt/data-integration/db_nono_log/activity_prize_gain_list$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/activity_prize_gain_list/activity_prize_gain_list.kjb /level:Basic >> /opt/data-integration/db_nono_log/activity_prize_gain_list$etllog.log
                ### ---    admin_work_remark ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------admin_work_remark-----" >> /opt/data-integration/db_nono_log/admin_work_remark$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/admin_work_remark/admin_work_remark.kjb /level:Basic >> /opt/data-integration/db_nono_log/admin_work_remark$etllog.log

                ### ---    authen_author_log ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------authen_author_log-----" >> /opt/data-integration/db_nono_log/authen_author_log$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/authen_author_log/authen_author_log.kjb /level:Basic >> /opt/data-integration/db_nono_log/authen_author_log$etllog.log
              ### ---    authentication_htsb ----暂不更新

  # echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------authentication_htsb-----" >> /opt/data-integration/db_nono_log/authentication_htsb$etllog.log
  #/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/authentication_htsb/authentication_htsb.kjb /level:Basic >> /opt/data-integration/db_nono_log/authentication_htsb$etllog.log
                
				### ---    bank_code ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------bank_code-----" >> /opt/data-integration/db_nono_log/bank_code$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/bank_code/bank_code.kjb /level:Basic >> /opt/data-integration/db_nono_log/bank_code$etllog.log
  				### ---    bill ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------bill-----" >> /opt/data-integration/db_nono_log/bill$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/bill/bill.kjb /level:Basic >> /opt/data-integration/db_nono_log/bill$etllog.log
    				### ---    bill_recharges ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------bill_recharges-----" >> /opt/data-integration/db_nono_log/bill_recharges$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/bill_recharges/bill_recharges.kjb /level:Basic >> /opt/data-integration/db_nono_log/bill_recharges$etllog.log
      				### ---    borrows_dunning_contact ----
   # echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows_dunning_contact-----" >> /opt/data-integration/db_nono_log/borrows_dunning_contact$etllog.log
 #/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/borrows_dunning_contact/borrows_dunning_contact.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows_dunning_contact$etllog.log
  
      				### ---    borrows_dunning_content ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows_dunning_content-----" >> /opt/data-integration/db_nono_log/borrows_dunning_content$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/borrows_dunning_content/borrows_dunning_content.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows_dunning_content$etllog.log
  
				### ---    debt_package_borrows ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------debt_package_borrows-----" >> /opt/data-integration/db_nono_log/debt_package_borrows$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/debt_package_borrows/debt_package_borrows.kjb /level:Basic >> /opt/data-integration/db_nono_log/debt_package_borrows$etllog.log
  
				### ---    debt_sale ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------debt_sale-----" >> /opt/data-integration/db_nono_log/debt_sale$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/debt_sale/debt_sale.kjb /level:Basic >> /opt/data-integration/db_nono_log/debt_sale$etllog.log
  
				### ---    kuaiq_orders ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------kuaiq_orders-----" >> /opt/data-integration/db_nono_log/kuaiq_orders$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/kuaiq_orders/kuaiq_orders.kjb /level:Basic >> /opt/data-integration/db_nono_log/kuaiq_orders$etllog.log
  				### ---    nono_studentAuth_log ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------nono_studentAuth_log-----" >> /opt/data-integration/db_nono_log/nono_studentAuth_log$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/nono_studentAuth_log/nono_studentAuth_log.kjb /level:Basic >> /opt/data-integration/db_nono_log/nono_studentAuth_log$etllog.log
  				### ---    pengyuan_recharge_log ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------pengyuan_recharge_log-----" >> /opt/data-integration/db_nono_log/pengyuan_recharge_log$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/pengyuan_recharge_log/pengyuan_recharge_log.kjb /level:Basic >> /opt/data-integration/db_nono_log/pengyuan_recharge_log$etllog.log
    				### ---    user_contact_info ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_contact_info-----" >> /opt/data-integration/db_nono_log/user_contact_info$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/user_contact_info/user_contact_info.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_contact_info$etllog.log
      				### ---    user_education_auth_log ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_education_auth_log-----" >> /opt/data-integration/db_nono_log/user_education_auth_log$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/user_education_auth_log/user_education_auth_log.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_education_auth_log$etllog.log
  
    				### ---    user_InterestrateCut ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_InterestrateCut-----" >> /opt/data-integration/db_nono_log/user_InterestrateCut$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/user_InterestrateCut/user_InterestrateCut.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_InterestrateCut$etllog.log
      				### ---    user_login_info ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_login_info-----" >> /opt/data-integration/db_nono_log/user_login_info$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/user_login_info/user_login_info.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_login_info$etllog.log
        				### ---    user_type_change_log ----
    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_type_change_log-----" >> /opt/data-integration/db_nono_log/user_type_change_log$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono3/user_type_change_log/user_type_change_log.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_type_change_log$etllog.log
  
 
 
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

