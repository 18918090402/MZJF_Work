

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




### ---    userproduct_ratecard_relation ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------userproduct_ratecard_relation-----" >> /opt/data-integration/log/userproduct_ratecard_relation$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/userproduct_ratecard_relation/userproduct_ratecard_relation.kjb /level:Basic >> /opt/data-integration/log/userproduct_ratecard_relation$etllog.log
 
### ---    user_approach ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_approach-----" >> /opt/data-integration/log/user_approach$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/user_approach/user_approach.kjb /level:Basic >> /opt/data-integration/log/user_approach$etllog.log
 
### ---    withdraw_reward ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------withdraw_reward-----" >> /opt/data-integration/log/withdraw_reward$etllog.log
  /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/withdraw_reward/withdraw_reward.kjb /level:Basic >> /opt/data-integration/log/withdraw_reward$etllog.log
 

### ---    user_detail ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_detail-----" >> /opt/data-integration/log/user_detail$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/user_detail/user_detail.kjb /level:Basic >> /opt/data-integration/log/user_detail$etllog.log
 
### ---    activity_info ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------activity_info-----" >> /opt/data-integration/log/activity_info$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/activity_info/activity_info.kjb /level:Basic >> /opt/data-integration/log/activity_info$etllog.log
 
### ---    debt_detail ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------debt_detail-----" >> /opt/data-integration/log/debt_detail$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/debt_detail/debt_detail.kjb /level:Basic >> /opt/data-integration/log/debt_detail$etllog.log
 
# ---    trans_detail ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------trans_detail-----" >> /opt/data-integration/log/trans_detail$etllog.log
  /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/trans_detail/trans_detail.kjb /level:Basic >> /opt/data-integration/log/trans_detail$etllog.log
 
### ---    user ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user-----" >> /opt/data-integration/log/user$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/user/user.kjb /level:Basic >> /opt/data-integration/log/user$etllog.log
 
 # ---    activity_user ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------activity_user-----" >> /opt/data-integration/log/activity_user$etllog.log
  /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/activity_user/activity_user.kjb /level:Basic >> /opt/data-integration/log/activity_user$etllog.log
 
 
  # ---    user_product ----

    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_product-----" >> /opt/data-integration/log/user_product$etllog.log
     /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/user_product/user_product.kjb /level:Basic >> /opt/data-integration/log/user_product$etllog.log
 
 
   # ---    redpackge ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------redpackge-----" >> /opt/data-integration/log/redpackge$etllog.log
     /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/redpackge/redpackge.kjb /level:Basic >> /opt/data-integration/log/redpackge$etllog.log
 # ---    nono_trans_detail ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------nono_trans_detail-----" >> /opt/data-integration/log/nono_trans_detail$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/nono_trans_detail/nono_trans_detail.kjb /level:Basic >> /opt/data-integration/log/nono_trans_detail$etllog.log
 
# ---    nono_user_product ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------nono_user_product-----" >> /opt/data-integration/log/nono_user_product$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/nono_user_product/nono_user_product.kjb /level:Basic >> /opt/data-integration/log/nono_user_product$etllog.log
 
 # ---    user_coupon ----

  echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_coupon-----" >> /opt/data-integration/log/user_coupon$etllog.log
    /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/user_coupon/user_coupon.kjb /level:Basic >> /opt/data-integration/log/user_coupon$etllog.log
 
 # ---    red_user_relation ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------red_user_relation-----" >> /opt/data-integration/log/red_user_relation$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/red_user_relation/red_user_relation.kjb /level:Basic >> /opt/data-integration/log/red_user_relation$etllog.log
 
# ---    red_olduser ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------red_olduser-----" >> /opt/data-integration/log/red_olduser$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/red_olduser/red_olduser.kjb /level:Basic >> /opt/data-integration/log/red_olduser$etllog.log
 

 # ---    user_point ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_point-----" >> /opt/data-integration/log/user_point$etllog.log
     /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/user_point/user_point.kjb /level:Basic >> /opt/data-integration/log/user_point$etllog.log
 

 # ---    user_bind_card ----

    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_bind_card-----" >> /opt/data-integration/log/user_bind_card$etllog.log
   /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/user_bind_card/user_bind_card.kjb /level:Basic >> /opt/data-integration/log/user_bind_card$etllog.log
 
 # ---    red_newuser ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------red_newuser-----" >> /opt/data-integration/log/red_newuser$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/red_newuser/red_newuser.kjb /level:Basic >> /opt/data-integration/log/red_newuser$etllog.log
 
 # ---    red_recover ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------red_recover-----" >> /opt/data-integration/log/red_recover$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/red_recover/red_recover.kjb /level:Basic >> /opt/data-integration/log/red_recover$etllog.log
 
 # ---    withdraw_log ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------withdraw_log-----" >> /opt/data-integration/log/withdraw_log$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/withdraw_log/withdraw_log.kjb /level:Basic >> /opt/data-integration/log/withdraw_log$etllog.log
 
 
  


 
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

