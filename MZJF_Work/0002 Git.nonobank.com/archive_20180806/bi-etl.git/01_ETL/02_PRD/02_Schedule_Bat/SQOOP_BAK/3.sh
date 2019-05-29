#!/bin/bash
cd /home/localadmin/ETL/02_Schedule_Bat
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%Y%m%d_%H_%M_%S")


JAVA_HOME=/usr/local/java
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH


export CDH_HOME=/opt/cloudera/parcels/CDH
export PATH=$CDH_HOME/bin:$PATH


date="$(date +"%Y-%m-%d %H:%M:%S")"

export LANG="en_US.UTF-8"




 # ---    ETL_SCHEDULING_PLATFORM_33333 ----

     echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_SCHEDULING_PLATFORM_33333-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_33333_$etllog.log

# sqoop import \
# -D mapreduce.job.queuename=etl-dw \
# -D mapreduce.job.name==Sqoop_TMP_BORROWS_ACCEPT \
# --connect jdbc:mysql://172.16.0.109:3306/db_nono?zeroDateTimeBehavior=round --username risk --password "WYTn1Q1q" \
# --query 'SELECT A.`ID`,A.`USER_ID`,A.`BO_ID`,CAST(A.`IS_VIP` AS SIGNED ) AS `IS_VIP`,A.`VA_ID`,A.`ORIGINAL_PRINCIPAL`,A.`PRICE_PRINCIPAL`,A.`PRICE_INTEREST`,A.`PRICE`,A.`PRICE_PUNISH`,A.`PLAN_TIME`,A.`SUCCESS_TIME`,CAST(A.`IS_PAY` AS SIGNED ) AS `IS_PAY`,A.`OWNER_RATE`,CAST(A.`IS_LENDER` AS SIGNED ) AS `IS_LENDER`,A.`EXPECT_NUM`,A.`BA_TRANSFER`,A.`BA_IS_TRANSFER`,A.`VERSION`,A.`CREATE_TIME`,A.`UPDATE_TIME` ,"SYS" AS DW_CREATE_BY , SYSDATE() AS DW_CREATE_TIME , "SYS" AS DW_UPDATE_BY , SYSDATE() AS DW_UPDATE_TIME FROM db_nono.borrows_accept AS A WHERE (update_time>="2016-11-24 13:51:14" OR "F" LIKE "F%" ) AND $CONDITIONS' \
# --split-by id \
# -m 1 \
# --hive-drop-import-delims \
# --fields-terminated-by '\001' --lines-terminated-by '\n' --null-string '\\N' --null-non-string '\\N' \
# --hive-import \
# --hive-database tmp \
# --hive-overwrite \
# --hive-table TMP_BORROWS_ACCEPT_aaa \
# --delete-target-dir \
# --target-dir "/user/hive/warehouse/tmp.db/TMP_BORROWS_ACCEPT_aaa" \
# -- --default-character-set=utf-8 ;

sqoop export \
-D mapred.job.name=t_borrows_accept_all_export \
--connect jdbc:mysql://172.16.0.165:3307/ODS   \
--username BI  --password kVyzlxsD+jKYgbUG \
--table T_BORROWS_ACCEPT        \
--export-dir /user/hive/warehouse/stg.db/t_borrows_accept_hist  \
--input-null-string '\\N' \
--input-null-non-string '\\N' \
--fields-terminated-by '\001';

    echo "$(date +"%Y-%m-%d %H:%M:%S") scripts finish ....------ETL_SCHEDULING_PLATFORM_33333-----" >> /home/localadmin/ETL/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_33333_$etllog.log

