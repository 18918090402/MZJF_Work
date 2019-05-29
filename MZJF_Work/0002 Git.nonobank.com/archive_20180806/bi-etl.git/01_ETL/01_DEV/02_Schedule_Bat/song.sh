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


# ---    finance_order_insert_table ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------finance_order_insert_table-----" >> /opt/data-integration/log/finance_order_insert_table$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_order_insert_table/finance_order_insert_table.kjb /level:Basic >> /opt/data-integration/log/finance_order_insert_table$etllog.log
 
sleep 1

 # ---    finance_order_update_table ----
 # ---    ORD_ATTACHMENT ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ORD_ATTACHMENT-----" >> /opt/data-integration/log/ORD_ATTACHMENT$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_order_update_table/ORD_ATTACHMENT/ORD_ATTACHMENT.kjb /level:Basic >> /opt/data-integration/log/ORD_ATTACHMENT$etllog.log
 

sleep 1

 # ---    ORD_ORDER ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ORD_ORDER-----" >> /opt/data-integration/log/ORD_ORDER$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_order_update_table/ORD_ORDER/ORD_ORDER.kjb /level:Basic >> /opt/data-integration/log/ORD_ORDER$etllog.log
 

sleep 1
 # ---    ORD_ORDER_CHECK_HISTORY ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ORD_ORDER_CHECK_HISTORY-----" >> /opt/data-integration/log/ORD_ORDER_CHECK_HISTORY$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_order_update_table/ORD_ORDER_CHECK_HISTORY/ORD_ORDER_CHECK_HISTORY.kjb /level:Basic >> /opt/data-integration/log/ORD_ORDER_CHECK_HISTORY$etllog.log
 

sleep 1
 # ---    ORD_USER ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ORD_USER-----" >> /opt/data-integration/log/ORD_USER$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_order_update_table/ORD_USER/ORD_USER.kjb /level:Basic >> /opt/data-integration/log/ORD_USER$etllog.log
 

sleep 1
 # ---    ORD_USER_ACCOUNT ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ORD_USER_ACCOUNT-----" >> /opt/data-integration/log/ORD_USER_ACCOUNT$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_order_update_table/ORD_USER_ACCOUNT/ORD_USER_ACCOUNT.kjb /level:Basic >> /opt/data-integration/log/ORD_USER_ACCOUNT$etllog.log
 

sleep 1
 # ---    ORD_USER_DETAIL ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ORD_USER_DETAIL-----" >> /opt/data-integration/log/ORD_USER_DETAIL$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_order_update_table/ORD_USER_DETAIL/ORD_USER_DETAIL.kjb /level:Basic >> /opt/data-integration/log/ORD_USER_DETAIL$etllog.log
 

sleep 1
 # ---    ORD_USER_HONOR ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ORD_USER_HONOR-----" >> /opt/data-integration/log/ORD_USER_HONOR$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_order_update_table/ORD_USER_HONOR/ORD_USER_HONOR.kjb /level:Basic >> /opt/data-integration/log/ORD_USER_HONOR$etllog.log
 

sleep 1

 # ---    finance_shop_insert_table ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------finance_shop_insert_table-----" >> /opt/data-integration/log/finance_shop_insert_table$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_insert_table/finance_shop_insert_table.kjb /level:Basic >> /opt/data-integration/log/finance_shop_insert_table$etllog.log
 

sleep 1

 ###################### ---    finance_shop_update_time ----
#----------    SOP_EMPLOYEE----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_EMPLOYEE-----" >> /opt/data-integration/log/SOP_EMPLOYEE$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_EMPLOYEE/SOP_EMPLOYEE.kjb /level:Basic >> /opt/data-integration/log/SOP_EMPLOYEE$etllog.log
 
#----------    SOP_SHOP----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP-----" >> /opt/data-integration/log/SOP_SHOP$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP/SOP_SHOP.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP$etllog.log
 
#----------    SOP_SHOP_ACCOUNT----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP_ACCOUNT-----" >> /opt/data-integration/log/SOP_SHOP_ACCOUNT$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP_ACCOUNT/SOP_SHOP_ACCOUNT.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP_ACCOUNT$etllog.log
 
#----------    SOP_SHOP_CHECK_REPORT----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP_CHECK_REPORT-----" >> /opt/data-integration/log/SOP_SHOP_CHECK_REPORT$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP_CHECK_REPORT/SOP_SHOP_CHECK_REPORT.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP_CHECK_REPORT$etllog.log
 
#----------    SOP_SHOP_CONTRACT_FILE----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP_CONTRACT_FILE-----" >> /opt/data-integration/log/SOP_SHOP_CONTRACT_FILE$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP_CONTRACT_FILE/SOP_SHOP_CONTRACT_FILE.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP_CONTRACT_FILE$etllog.log
 
#----------    SOP_SHOP_FACE----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP_FACE-----" >> /opt/data-integration/log/SOP_SHOP_FACE$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP_FACE/SOP_SHOP_FACE.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP_FACE$etllog.log
 
#----------    SOP_SHOP_FACE_RISK----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP_FACE_RISK-----" >> /opt/data-integration/log/SOP_SHOP_FACE_RISK$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP_FACE_RISK/SOP_SHOP_FACE_RISK.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP_FACE_RISK$etllog.log
 #----------    SOP_SHOP_RATE_COLUMN----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP_RATE_COLUMN-----" >> /opt/data-integration/log/SOP_SHOP_RATE_COLUMN$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP_RATE_COLUMN/SOP_SHOP_RATE_COLUMN.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP_RATE_COLUMN$etllog.log
 #----------    SOP_SHOP_RATE_ROW----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP_RATE_ROW-----" >> /opt/data-integration/log/SOP_SHOP_RATE_ROW$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP_RATE_ROW/SOP_SHOP_RATE_ROW.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP_RATE_ROW$etllog.log
 #----------    SOP_SHOP_RATE_TABLE----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP_RATE_TABLE-----" >> /opt/data-integration/log/SOP_SHOP_RATE_TABLE$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP_RATE_TABLE/SOP_SHOP_RATE_TABLE.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP_RATE_TABLE$etllog.log
 
 #----------    SOP_SHOP_RISK----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP_RISK-----" >> /opt/data-integration/log/SOP_SHOP_RISK$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP_RISK/SOP_SHOP_RISK.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP_RISK$etllog.log
 
  #----------    SOP_SHOP_USER_RATE----
 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SOP_SHOP_USER_RATE-----" >> /opt/data-integration/log/SOP_SHOP_USER_RATE$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_shop_update_time/SOP_SHOP_USER_RATE/SOP_SHOP_USER_RATE.kjb /level:Basic >> /opt/data-integration/log/SOP_SHOP_USER_RATE$etllog.log
 

 # ---    finance_system_insert_table ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------finance_system_insert_table-----" >> /opt/data-integration/log/finance_system_insert_table$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_system_insert_table/finance_system_insert_table.kjb /level:Basic >> /opt/data-integration/log/finance_system_insert_table$etllog.log
 

sleep 1

 # ############################----    finance_system_update_table ----
 #-------------SYS_USER

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SYS_USER-----" >> /opt/data-integration/log/SYS_USER$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_system_update_table/SYS_USER/SYS_USER.kjb /level:Basic >> /opt/data-integration/log/SYS_USER$etllog.log
 
 #-------------SYS_SYSTEM

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SYS_SYSTEM-----" >> /opt/data-integration/log/SYS_SYSTEM$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_system_update_table/SYS_SYSTEM/SYS_SYSTEM.kjb /level:Basic >> /opt/data-integration/log/SYS_SYSTEM$etllog.log
 
 #-------------SYS_ROLE

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SYS_ROLE-----" >> /opt/data-integration/log/SYS_ROLE$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_system_update_table/SYS_ROLE/SYS_ROLE.kjb /level:Basic >> /opt/data-integration/log/SYS_ROLE$etllog.log
 
 #-------------SYS_PERMISSION

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SYS_PERMISSION-----" >> /opt/data-integration/log/SYS_PERMISSION$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_system_update_table/SYS_PERMISSION/SYS_PERMISSION.kjb /level:Basic >> /opt/data-integration/log/SYS_PERMISSION$etllog.log
 
 #-------------SYS_DIC_ITEM

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SYS_DIC_ITEM-----" >> /opt/data-integration/log/SYS_DIC_ITEM$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_system_update_table/SYS_DIC_ITEM/SYS_DIC_ITEM.kjb /level:Basic >> /opt/data-integration/log/SYS_DIC_ITEM$etllog.log
 
 #-------------SYS_DIC

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------SYS_DIC-----" >> /opt/data-integration/log/SYS_DIC$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_system_update_table/SYS_DIC/SYS_DIC.kjb /level:Basic >> /opt/data-integration/log/SYS_DIC$etllog.log
 
 #-------------FILE_STORAGE

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------FILE_STORAGE-----" >> /opt/data-integration/log/FILE_STORAGE$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_system_update_table/FILE_STORAGE/FILE_STORAGE.kjb /level:Basic >> /opt/data-integration/log/FILE_STORAGE$etllog.log
 

# ############################---    finance_wechat ----

 # ---    WE_APPS ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------WE_APPS-----" >> /opt/data-integration/log/WE_APPS$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_wechat_update_table/WE_APPS/WE_APPS.kjb /level:Basic >> /opt/data-integration/log/WE_APPS$etllog.log
 
# ---    WE_ARTICLES_WC ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------WE_ARTICLES_WC-----" >> /opt/data-integration/log/WE_ARTICLES_WC$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_wechat_update_table/WE_ARTICLES_WC/WE_ARTICLES_WC.kjb /level:Basic >> /opt/data-integration/log/WE_ARTICLES_WC$etllog.log
 
 # ---    WE_ARTICLES_XJ ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------WE_ARTICLES_XJ-----" >> /opt/data-integration/log/WE_ARTICLES_XJ$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_wechat_update_table/WE_ARTICLES_XJ/WE_ARTICLES_XJ.kjb /level:Basic >> /opt/data-integration/log/WE_ARTICLES_XJ$etllog.log
 
# ---    WE_AUTO_MESSAGE ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------WE_AUTO_MESSAGE-----" >> /opt/data-integration/log/WE_AUTO_MESSAGE$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_wechat_update_table/WE_AUTO_MESSAGE/WE_AUTO_MESSAGE.kjb /level:Basic >> /opt/data-integration/log/WE_AUTO_MESSAGE$etllog.log
 
# ---    WE_IMAGE ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------WE_IMAGE-----" >> /opt/data-integration/log/WE_IMAGE$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_wechat_update_table/WE_IMAGE/WE_IMAGE.kjb /level:Basic >> /opt/data-integration/log/WE_IMAGE$etllog.log
 
# ---    WE_KEY_MESSAGE ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------WE_KEY_MESSAGE-----" >> /opt/data-integration/log/WE_KEY_MESSAGE$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_wechat_update_table/WE_KEY_MESSAGE/WE_KEY_MESSAGE.kjb /level:Basic >> /opt/data-integration/log/WE_KEY_MESSAGE$etllog.log
  
 # ---    WE_MASS_ALL ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------WE_MASS_ALL-----" >> /opt/data-integration/log/WE_MASS_ALL$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_wechat_update_table/WE_MASS_ALL/WE_MASS_ALL.kjb /level:Basic >> /opt/data-integration/log/WE_MASS_ALL$etllog.log
  
  # ---    WE_MESSAGE_TEMPLATE ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------WE_MESSAGE_TEMPLATE-----" >> /opt/data-integration/log/WE_MESSAGE_TEMPLATE$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_wechat_update_table/WE_MESSAGE_TEMPLATE/WE_MESSAGE_TEMPLATE.kjb /level:Basic >> /opt/data-integration/log/WE_MESSAGE_TEMPLATE$etllog.log
  
   # ---    WE_QRCODE ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------WE_QRCODE-----" >> /opt/data-integration/log/WE_QRCODE$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_wechat_update_table/WE_QRCODE/WE_QRCODE.kjb /level:Basic >> /opt/data-integration/log/WE_QRCODE$etllog.log
  
    # ---    WE_USER_INFO ----

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------WE_USER_INFO-----" >> /opt/data-integration/log/WE_USER_INFO$etllog.log
/root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/finance/finance_wechat_update_table/WE_USER_INFO/WE_USER_INFO.kjb /level:Basic >> /opt/data-integration/log/WE_USER_INFO$etllog.log
  
 
 
 # ---    activity_reward ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------activity_reward-----" >> /opt/data-integration/log/activity_reward$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/activity_reward/activity_reward.kjb /level:Basic >> /opt/data-integration/log/activity_reward$etllog.log
 

sleep 1


 # ---    activity_reward_channel ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------activity_reward_channel-----" >> /opt/data-integration/log/activity_reward_channel$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/activity_reward_channel/activity_reward_channel.kjb /level:Basic >> /opt/data-integration/log/activity_reward_channel$etllog.log
 

sleep 1

 # ---    bank_define ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------bank_define-----" >> /opt/data-integration/log/bank_define$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/bank_define/bank_define.kjb /level:Basic >> /opt/data-integration/log/bank_define$etllog.log
 

sleep 1

  ### ---    banner_info ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------banner_info-----" >> /opt/data-integration/log/banner_info$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/banner_info/banner_info.kjb /level:Basic >> /opt/data-integration/log/banner_info$etllog.log
 
sleep 1

  ### ---    approach_define ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------approach_define-----" >> /opt/data-integration/log/approach_define$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/approach_define/approach_define.kjb /level:Basic >> /opt/data-integration/log/approach_define$etllog.log
 
sleep 1
  ### ---    debt_info ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------debt_info-----" >> /opt/data-integration/log/debt_info$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/debt_info/debt_info.kjb /level:Basic >> /opt/data-integration/log/debt_info$etllog.log
 
sleep 1
  ### ---    debter ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------debter-----" >> /opt/data-integration/log/debter$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/debter/debter.kjb /level:Basic >> /opt/data-integration/log/debter$etllog.log
 
sleep 1
  ### ---    nono_user ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------nono_user-----" >> /opt/data-integration/log/nono_user$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/nono_user/nono_user.kjb /level:Basic >> /opt/data-integration/log/nono_user$etllog.log
 
sleep 1

  ### ---    point_approach ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------point_approach-----" >> /opt/data-integration/log/point_approach$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/point_approach/point_approach.kjb /level:Basic >> /opt/data-integration/log/point_approach$etllog.log
 
sleep 1

  ### ---    red_activity ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------red_activity-----" >> /opt/data-integration/log/red_activity$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/red_activity/red_activity.kjb /level:Basic >> /opt/data-integration/log/red_activity$etllog.log
 
sleep 1

  ### ---    reward_type_define ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------reward_type_define-----" >> /opt/data-integration/log/reward_type_define$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/reward_type_define/reward_type_define.kjb /level:Basic >> /opt/data-integration/log/reward_type_define$etllog.log
 
sleep 1

  ### ---    point_mart_product ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------point_mart_product-----" >> /opt/data-integration/log/point_mart_product$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/point_mart_product/point_mart_product.kjb /level:Basic >> /opt/data-integration/log/point_mart_product$etllog.log
 
sleep 1

  ### ---    product_eff_day ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------product_eff_day-----" >> /opt/data-integration/log/product_eff_day$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/product_eff_day/product_eff_day.kjb /level:Basic >> /opt/data-integration/log/product_eff_day$etllog.log
 
sleep 1

  ### ---    product_periods ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------product_periods-----" >> /opt/data-integration/log/product_periods$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/product_periods/product_periods.kjb /level:Basic >> /opt/data-integration/log/product_periods$etllog.log
 
sleep 1

  ### ---    product_profile ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------product_profile-----" >> /opt/data-integration/log/product_profile$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/product_profile/product_profile.kjb /level:Basic >> /opt/data-integration/log/product_profile$etllog.log
 
sleep 1

  ### ---    product_rate ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------product_rate-----" >> /opt/data-integration/log/product_rate$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/product_rate/product_rate.kjb /level:Basic >> /opt/data-integration/log/product_rate$etllog.log
 
sleep 1

  ### ---    product_rule ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------product_rule-----" >> /opt/data-integration/log/product_rule$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/product_rule/product_rule.kjb /level:Basic >> /opt/data-integration/log/product_rule$etllog.log
 
sleep 1

  ### ---    system_month_rate ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------system_month_rate-----" >> /opt/data-integration/log/system_month_rate$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/system_month_rate/system_month_rate.kjb /level:Basic >> /opt/data-integration/log/system_month_rate$etllog.log
 
sleep 1

  ### ---    trans_code ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------trans_code-----" >> /opt/data-integration/log/trans_code$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/trans_code/trans_code.kjb /level:Basic >> /opt/data-integration/log/trans_code$etllog.log
 
sleep 1

  ### ---    point_exchange_receiver ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------point_exchange_receiver-----" >> /opt/data-integration/log/point_exchange_receiver$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/point_exchange_receiver/point_exchange_receiver.kjb /level:Basic >> /opt/data-integration/log/point_exchange_receiver$etllog.log
 
sleep 1

  ### ---    reward_define ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------reward_define-----" >> /opt/data-integration/log/reward_define$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/reward_define/reward_define.kjb /level:Basic >> /opt/data-integration/log/reward_define$etllog.log
 
sleep 1

  ### ---    red_fill_log ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------red_fill_log-----" >> /opt/data-integration/log/red_fill_log$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/red_fill_log/red_fill_log.kjb /level:Basic >> /opt/data-integration/log/red_fill_log$etllog.log
 
sleep 1

  ### ---    red_mxd_log ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------red_mxd_log-----" >> /opt/data-integration/log/red_mxd_log$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/red_mxd_log/red_mxd_log.kjb /level:Basic >> /opt/data-integration/log/red_mxd_log$etllog.log
 
sleep 1

  ### ---    product_info_detail ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------product_info_detail-----" >> /opt/data-integration/log/product_info_detail$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/product_info_detail/product_info_detail.kjb /level:Basic >> /opt/data-integration/log/product_info_detail$etllog.log
 
sleep 1

  ### ---    user_relation ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------user_relation-----" >> /opt/data-integration/log/user_relation$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/user_relation/user_relation.kjb /level:Basic >> /opt/data-integration/log/user_relation$etllog.log
 
sleep 1


  ### ---    point_consume ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------point_consume-----" >> /opt/data-integration/log/point_consume$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/point_consume/point_consume.kjb /level:Basic >> /opt/data-integration/log/point_consume$etllog.log
 
sleep 1

  ### ---    product_info ----

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------product_info-----" >> /opt/data-integration/log/product_info$etllog.log
 /root/data-integration/kitchen.sh /file  /opt/data-integration/shipment_data/nonobank_app/product_info/product_info.kjb /level:Basic >> /opt/data-integration/log/product_info$etllog.log
 
sleep 1



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

