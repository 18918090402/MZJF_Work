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



           ### ---    activity_prolocutor ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------activity_prolocutor-----" >> /opt/data-integration/db_nono_log/activity_prolocutor$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/activity_prolocutor/activity_prolocutor.kjb /level:Basic >> /opt/data-integration/db_nono_log/activity_prolocutor$etllog.log

          ### ---    borrows_archive ----

   echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows_archive-----" >> /opt/data-integration/db_nono_log/borrows_archive$etllog.log
     /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/borrows_archive/borrows_archive.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows_archive$etllog.log

         ### ---    borrows_bidding ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows_bidding-----" >> /opt/data-integration/db_nono_log/borrows_bidding$etllog.log
      /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/borrows_bidding/borrows_bidding.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows_bidding$etllog.log

          ### ---    borrows_consulted_fee ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows_consulted_fee-----" >> /opt/data-integration/db_nono_log/borrows_consulted_fee$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/borrows_consulted_fee/borrows_consulted_fee.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows_consulted_fee$etllog.log
          ### ---    borrows ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows-----" >> /opt/data-integration/db_nono_log/borrows$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/borrows/borrows.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows$etllog.log

   
         ### ---    vip_form ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------vip_form-----" >> /opt/data-integration/db_nono_log/vip_form$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/vip_form/vip_form.kjb /level:Basic >> /opt/data-integration/db_nono_log/vip_form$etllog.log
  
         ### ---    withdraw_cash ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------withdraw_cash-----" >> /opt/data-integration/db_nono_log/withdraw_cash$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/withdraw_cash/withdraw_cash.kjb /level:Basic >> /opt/data-integration/db_nono_log/withdraw_cash$etllog.log
  
         ### ---    vip_account ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------vip_account-----" >> /opt/data-integration/db_nono_log/vip_account$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/vip_account/vip_account.kjb /level:Basic >> /opt/data-integration/db_nono_log/vip_account$etllog.log
  
        ### ---    user_student_info ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_student_info-----" >> /opt/data-integration/db_nono_log/user_student_info$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/user_student_info/user_student_info.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_student_info$etllog.log
        ### ---    user_spouse_info ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_spouse_info-----" >> /opt/data-integration/db_nono_log/user_spouse_info$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/user_spouse_info/user_spouse_info.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_spouse_info$etllog.log
        ### ---    user_level ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_level-----" >> /opt/data-integration/db_nono_log/user_level$etllog.log
     /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/user_level/user_level.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_level$etllog.log
        ### ---    user_info_detail ----

   echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_info_detail-----" >> /opt/data-integration/db_nono_log/user_info_detail$etllog.log
    /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/user_info_detail/user_info_detail.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_info_detail$etllog.log
        ### ---    user_info ----
  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_info-----" >> /opt/data-integration/db_nono_log/user_info$etllog.log
     /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/user_info/user_info.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_info$etllog.log
          
       ### ---    user_bankcard_info ----
   echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_bankcard_info-----" >> /opt/data-integration/db_nono_log/user_bankcard_info$etllog.log
     /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/user_bankcard_info/user_bankcard_info.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_bankcard_info$etllog.log
       ### ---    user_bankcard_auth ----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_bankcard_auth-----" >> /opt/data-integration/db_nono_log/user_bankcard_auth$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/user_bankcard_auth/user_bankcard_auth.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_bankcard_auth$etllog.log
       ### ---    user_approach_info ----
  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_approach_info-----" >> /opt/data-integration/db_nono_log/user_approach_info$etllog.log
    /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/user_approach_info/user_approach_info.kjb /level:Basic >> /opt/data-integration/db_nono_log/user_approach_info$etllog.log
       ### ---    nono_authentication ----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------nono_authentication-----" >> /opt/data-integration/db_nono_log/nono_authentication$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/nono_authentication/nono_authentication.kjb /level:Basic >> /opt/data-integration/db_nono_log/nono_authentication$etllog.log
        ### ---    fund_form ----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------fund_form-----" >> /opt/data-integration/db_nono_log/fund_form$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/fund_form/fund_form.kjb /level:Basic >> /opt/data-integration/db_nono_log/fund_form$etllog.log
        ### ---    finance_plan ----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------finance_plan-----" >> /opt/data-integration/db_nono_log/finance_plan$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/finance_plan/finance_plan.kjb /level:Basic >> /opt/data-integration/db_nono_log/finance_plan$etllog.log
        
        ### ---    debt_buy_log ----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------debt_buy_log-----" >> /opt/data-integration/db_nono_log/debt_buy_log$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/debt_buy_log/debt_buy_log.kjb /level:Basic >> /opt/data-integration/db_nono_log/debt_buy_log$etllog.log
        ### ---    borrows_raise ----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows_raise-----" >> /opt/data-integration/db_nono_log/borrows_raise$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/borrows_raise/borrows_raise.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows_raise$etllog.log
         ### ---    borrows_prepare ----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows_prepare-----" >> /opt/data-integration/db_nono_log/borrows_prepare$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/borrows_prepare/borrows_prepare.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows_prepare$etllog.log
        ### ---    borrows_outsource_dunning ----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------borrows_outsource_dunning-----" >> /opt/data-integration/db_nono_log/borrows_outsource_dunning$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/borrows_outsource_dunning/borrows_outsource_dunning.kjb /level:Basic >> /opt/data-integration/db_nono_log/borrows_outsource_dunning$etllog.log
                             
           ### ---    region ----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------region-----" >> /opt/data-integration/db_nono_log/region$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/db_nono/region/region.kjb /level:Basic >> /opt/data-integration/db_nono_log/region$etllog.log
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
 # done

