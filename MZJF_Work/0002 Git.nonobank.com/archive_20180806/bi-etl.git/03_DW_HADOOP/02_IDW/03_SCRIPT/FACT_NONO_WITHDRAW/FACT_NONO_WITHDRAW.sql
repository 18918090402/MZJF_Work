set mapreduce.job.name = idw_fact_nono_withdraw_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_NONO_WITHDRAW partition
  (DATA_STATE)
  SELECT 'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         t1.id WITHDRAW_SRC_ID,
         'tb_p2p_record_withdraw' WITHDRAW_SRC_TAB,
         t1.user_id USER_ID,
         8 WITHDRAW_CHANNEL,
         t1.amount WITHDRAW_AMT,
         t1.update_time WITHDRAW_TIME,
         t1.fee FEE,
         t1.bank_name BANK_NAME,
         t1.bank_card_no BANK_CARD_NO,
         case
           when t1.province = '' then
            null
           else
            t1.province
         end PROVINCE_NAME,
         case
           when t1.city = '' then
            null
           else
            t1.city
         end CITY_NAME,
         null ALIPAY_NO,
         t2.terminal_id TERMINAL,
         case
           when t1.bo_id in (0, -1) then
            null
           else
            t1.bo_id
         end bo_id,
         t2.system_id SYSTEM_ID,
         'current' DATA_STATE
    FROM ods.t_tb_p2p_record_withdraw_hist t1
    left join ods.t_tb_p2p_order_hist t2
      on t1.order_no = t2.id
   WHERE t1.type = 'withdraw'
     and t1.STATUS = 'SUCCESS'
  union all
  SELECT 'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         id WITHDRAW_SRC_ID,
         'withdraw_cash_alipay' WITHDRAW_SRC_TAB,
         user_id USER_ID,
         case TYPE
           when 1 then
            1
           when 2 then
            2
         end WITHDRAW_CHANNEL,
         price WITHDRAW_AMT,
         update_time WITHDRAW_TIME,
         fee FEE,
         NULL BANK_NAME,
         NULL BANK_CARD_NO,
         NULL PROVINCE_NAME,
         NULL CITY_NAME,
         alipay_no ALIPAY_NO,
         NULL TERMINAL,
         case
           when bo_id in (0, -1) then
            null
           else
            bo_id
         end bo_id,
         null SYSTEM_ID,
         'current' DATA_STATE
    FROM ods.t_withdraw_cash_alipay_hist
   WHERE STATUS = 4;
   
set mapreduce.job.name = idw_fact_nono_withdraw_curing;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_NONO_WITHDRAW partition
  (DATA_STATE)
  SELECT 'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         t1.id WITHDRAW_SRC_ID,
         'withdraw_cash' WITHDRAW_SRC_TAB,
         t1.user_id USER_ID,
         case t1.TYPE
           when 1 then
            1
           when 2 then
            2
           when 3 then
            3
           when 4 then
            4
           when 5 then
            5
           when 6 then
            6
           when 7 then
            7
         end WITHDRAW_CHANNEL,
         t1.price + t1.free WITHDRAW_AMT,
         t1.update_time WITHDRAW_TIME,
         t1.free FEE,
         t1.bank_name BANK_NAME,
         t1.bank_card_no BANK_CARD_NO,
         t1.province_name PROVINCE_NAME,
         t1.city_name CITY_NAME,
         NULL ALIPAY_NO,
         t1.terminal TERMINAL,
         case
           when t1.bo_id in (0, -1) then
            null
           else
            t1.bo_id
         end bo_id,
         null SYSTEM_ID,
         'curing' DATA_STATE
    FROM ods.t_withdraw_cash_hist t1
    left join ods.t_tb_p2p_record_withdraw_hist t2
      on t1.id = t2.withdraw_cash_id
   where t1.STATUS = 4
     and t2.id is null;