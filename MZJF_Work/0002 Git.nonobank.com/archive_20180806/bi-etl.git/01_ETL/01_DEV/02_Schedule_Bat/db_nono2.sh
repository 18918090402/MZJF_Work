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

                ### ---    account_relation ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------account_relation-----" >> /opt/data-integration/db_nono_log/account_relation$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/account_relation/account_relation.kjb /level:Basic >> /opt/data-integration/db_nono_log/account_relation$etllog.log


               ### ---    activity_vip_physicalgoods ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------activity_vip_physicalgoods-----" >> /opt/data-integration/db_nono_log/activity_vip_physicalgoods$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/activity_vip_physicalgoods/activity_vip_physicalgoods.kjb /level:Basic >> /opt/data-integration/db_nono_log/activity_vip_physicalgoods$etllog.log

              ### ---    activity_vip_virtualgoods ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------activity_vip_virtualgoods-----" >> /opt/data-integration/db_nono_log/activity_vip_virtualgoods$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/activity_vip_virtualgoods/activity_vip_virtualgoods.kjb /level:Basic >> /opt/data-integration/db_nono_log/activity_vip_virtualgoods$etllog.log
             
			 ### ---    bank ----

   echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------bank-----" >> /opt/data-integration/db_nono_log/bank$etllog.log
  /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/bank/bank.kjb /level:Basic >> /opt/data-integration/db_nono_log/bank$etllog.log
             
			 ### ---    borrows_guarantee ----

    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows_guarantee-----" >> /opt/data-integration/db_nono_log/borrows_guarantee$etllog.log
  /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/borrows_guarantee/borrows_guarantee.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows_guarantee$etllog.log

              ### ---    borrows_repayment ----

 #   echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows_repayment-----" >> /opt/data-integration/db_nono_log/borrows_repayment$etllog.log
 # /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/borrows_repayment/borrows_repayment.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows_repayment$etllog.log

 
			  ### ---    debt_accept ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------debt_accept-----" >> /opt/data-integration/db_nono_log/debt_accept$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/debt_accept/debt_accept.kjb /level:Basic >> /opt/data-integration/db_nono_log/debt_accept$etllog.log

             ### ---    debt_borrows_accept ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------debt_borrows_accept-----" >> /opt/data-integration/db_nono_log/debt_borrows_accept$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/debt_borrows_accept/debt_borrows_accept.kjb /level:Basic >> /opt/data-integration/db_nono_log/debt_borrows_accept$etllog.log

               ### ---    fund_account ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------fund_account-----" >> /opt/data-integration/db_nono_log/fund_account$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/fund_account/fund_account.kjb /level:Basic >> /opt/data-integration/db_nono_log/fund_account$etllog.log

                ### ---    online_recharge ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------online_recharge-----" >> /opt/data-integration/db_nono_log/online_recharge$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/online_recharge/online_recharge.kjb /level:Basic >> /opt/data-integration/db_nono_log/online_recharge$etllog.log
          ### ---    recharge_log ----

  #echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------recharge_log-----" >> /opt/data-integration/db_nono_log/recharge_log$etllog.log
 #/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/recharge_log/recharge_log.kjb /level:Basic >> /opt/data-integration/db_nono_log/recharge_log$etllog.log
          ### ---    sesame_credit ----

    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------sesame_credit-----" >> /opt/data-integration/db_nono_log/sesame_credit$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/sesame_credit/sesame_credit.kjb /level:Basic >> /opt/data-integration/db_nono_log/sesame_credit$etllog.log

           ### ---    sft_recharges ----

      echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------sft_recharges-----" >> /opt/data-integration/db_nono_log/sft_recharges$etllog.log
     /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/sft_recharges/sft_recharges.kjb /level:Basic >> /opt/data-integration/db_nono_log/sft_recharges$etllog.log

       ### ---    sms_task_detail ----

      echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------sms_task_detail-----" >> /opt/data-integration/db_nono_log/sms_task_detail$etllog.log
    /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/sms_task_detail/sms_task_detail.kjb /level:Basic >> /opt/data-integration/db_nono_log/sms_task_detail$etllog.log

      ### ---    user_experience_earnings_log ----

      echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_experience_earnings_log-----" >> /opt/data-integration/db_nono_log/user_experience_earnings_log$etllog.log
    /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/user_experience_earnings_log/user_experience_earnings_log.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_experience_earnings_log$etllog.log
      ### ---    user_hkconpon ----

      echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_hkconpon-----" >> /opt/data-integration/db_nono_log/user_hkconpon$etllog.log
    /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/user_hkconpon/user_hkconpon.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_hkconpon$etllog.log

      ### ---    yilian_orders ----

      echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------yilian_orders-----" >> /opt/data-integration/db_nono_log/yilian_orders$etllog.log
    /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/yilian_orders/yilian_orders.kjb /level:Basic >> /opt/data-integration/db_nono_log/yilian_orders$etllog.log

      ### ---    yilian_recharges ----

      echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------yilian_recharges-----" >> /opt/data-integration/db_nono_log/yilian_recharges$etllog.log
    /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/yilian_recharges/yilian_recharges.kjb /level:Basic >> /opt/data-integration/db_nono_log/yilian_recharges$etllog.log
   ### ---    tb_pay_order ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------tb_pay_order-----" >> /opt/data-integration/db_nono_log/tb_pay_order$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/tb_pay_order/tb_pay_order.kjb /level:Basic >> /opt/data-integration/db_nono_log/tb_pay_order$etllog.log

	  ### ---    tb_pay_record ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------tb_pay_record-----" >> /opt/data-integration/db_nono_log/tb_pay_record$etllog.log
  /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono2/tb_pay_record/tb_pay_record.kjb /level:Basic >> /opt/data-integration/db_nono_log/tb_pay_record$etllog.log

	
 
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

