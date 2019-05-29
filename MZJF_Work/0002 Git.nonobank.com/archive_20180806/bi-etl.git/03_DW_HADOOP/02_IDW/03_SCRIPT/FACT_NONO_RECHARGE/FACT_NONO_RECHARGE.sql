set mapreduce.job.name = idw_fact_nono_recharge_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table idw.FACT_NONO_RECHARGE partition
  (DATA_STATE)
  SELECT 'SYS' AS DW_CREATE_BY, -- 快钱1
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         tpr.id RECHARGE_SRC_ID,
         'tb_pay_record' RECHARGE_SRC_TAB,
         tpr.member_id USER_ID,
         coalesce(tpr.pay_time, tpr.update_time) RECHARGE_TIME,
         2 PAY_TYPE,
         null RECHARGE_TYPE,
         tpr.pay_amount RECHARGE_AMT,
         tpr.order_no ORDER_NO, -- 交易号
         tpr.seal_no ORDER_SN, -- 第三方流水号
         tpr.bank BANK_NAME,
         tpr.card_no BANK_CARD_NO,
         case
           when tpr.sub_provider = '' then
            null
           else
            tpr.sub_provider
         end TERMINAL,
         null SYSTEM_ID,
         'current' DATA_STATE
    FROM ods.t_tb_pay_record_hist tpr
   WHERE tpr.provider = 'COMPENSATORY_99BILL_FASTPAY'
     and tpr.status = 'PAID'
     and tpr.pay_amount > 0
  union all
  SELECT 'SYS' AS DW_CREATE_BY, -- 微商存管
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         pr.id RECHARGE_SRC_ID,
         'tb_p2p_record_recharge' RECHARGE_SRC_TAB,
         pr.user_id USER_ID,
         pr.pay_time RECHARGE_TIME,
         8 PAY_TYPE,
         pr.TYPE RECHARGE_TYPE,
         pr.amount RECHARGE_AMT,
         pr.trans_no ORDER_NO, -- 交易号
         pr.record_no ORDER_SN, -- 第三方流水号
         b.NAME BANK_NAME,
         pr.bank_card_no BANK_CARD_NO,
         case
           when po.terminal_id = '' then
            null
           else
            po.terminal_id
         end TERMINAL,
         case
           when po.system_id = '' then
            null
           else
            po.system_id
         end SYSTEM_ID,
         'current' DATA_STATE
    FROM ods.t_tb_p2p_record_recharge_hist pr
    left join ods.t_user_bankcard_info_hist ubi
      on pr.bank_card_id = ubi.id
    left join ods.t_bank_hist b
      on ubi.BANK_CODE = cast(b.ID as string)
    left join ods.t_tb_p2p_order_hist po
      on pr.order_no = po.id
   WHERE pr.TYPE IN ('payApply', 'rechargePatch')
     AND pr.STATUS = 'SUCCESS';

set mapreduce.job.name = idw_fact_nono_recharge_curing;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

drop table if exists TMP.TMP_IDW_FACT_NONO_RECHARGE_CURING;
create table if not exists TMP.TMP_IDW_FACT_NONO_RECHARGE_CURING
(
   RECHARGE_SRC_ID      bigint comment '充值源表ID',
   RECHARGE_SRC_TAB     string comment '充值源表名',
   USER_ID              bigint comment '用户ID',
   RECHARGE_TIME        string comment '充值时间',
   PAY_TYPE             int comment '支付类型 1:易联 2:快钱 3:钱方 4:连连 5:宝付 6:盛付通 7:微信直连',
   RECHARGE_AMT         decimal(38,10) comment '充值金额',
   ORDER_NO             string comment '订单号',
   ORDER_SN             string comment '流水号',
   BANK_NAME            string comment '银行名称',
   BANK_CARD_NO         string comment '银行卡号',
   TERMINAL             string comment '终端',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '诺诺固化充值记录临时表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");

drop table if exists TMP.TMP_IDW_FACT_NONO_RECHARGE_02;
create table if not exists TMP.TMP_IDW_FACT_NONO_RECHARGE_02 stored as parquet as 
select key_value, user_id, pay_type
  from (select key_value,
               user_id,
               pay_type,
               count(1) over(partition by key_value) cnt
          from (select coalesce(fl.key_value,
                                case
                                  when remark regexp
                                   '^.*充值流水号[MDA|PO_]*[0-9]*[,补入|，补入]*$' then
                                   regexp_extract(remark,
                                                  '^.*充值流水号([MDA|PO_]*[0-9]*)[,补入|，补入]*$',
                                                  1)
                                  when remark regexp '^.*代扣订单号:[PO_|NN]*[0-9]*,充值.*$' then
                                   regexp_extract(remark,
                                                  '^.*代扣订单号:([PO_|NN]*[0-9]*),充值.*$',
                                                  1)
                                  when remark regexp '^.*订单号:PO_[0-9]*$' then
                                   regexp_extract(remark, '^.*订单号:(PO_[0-9]*)$', 1)
                                end) key_value,
                       fa.user_id,
                       case
                         when (fl.role_id = 2 and fl.account_id = 20) or
                              (fl.role_id = 3 and fl.remark LIKE "%盛付通%") then
                          6
                         when (fl.role_id = 2 and fl.account_id = 37) or
                              (fl.role_id = 3 and fl.remark LIKE "%快钱%") then
                          2
                       end PAY_TYPE
                  from odsopr.finance_log_all fl
                  LEFT JOIN odsopr.finance_account fa
                    on fa.id = fl.opposite_account_id
                 where ((fl.role_id = 2 and fl.account_id in (20, 37)) or
                       (fl.role_id = 3 and
                       (fl.remark LIKE "%盛付通%" or fl.remark LIKE "%快钱%")))
                   AND fl.operation_relation IN (49, 50, 466, 468)) a
         where key_value is not null
           and key_value <> '') b
 where cnt = 1;

INSERT overwrite table TMP.TMP_IDW_FACT_NONO_RECHARGE_CURING
  SELECT rl.id RECHARGE_SRC_ID, -- 易联
         'recharge_log' RECHARGE_SRC_TAB,
         rl.user_id USER_ID,
         rl.update_time RECHARGE_TIME,
         1 PAY_TYPE,
         rl.amount RECHARGE_AMT,
         yr.batchNo ORDER_NO,
         rl.order_sn ORDER_SN,
         rl.bank_card_name BANK_NAME,
         rl.bank_card_id BANK_CARD_NO,
         rl.terminal TERMINAL,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM ods.t_recharge_log_hist rl
    LEFT JOIN ods.t_yilian_recharges_hist yr
      ON yr.sn = rl.order_sn
   WHERE rl.pay_type = 1
     and rl.recharge_status = 1
     and rl.amount > 0
  union all
  SELECT tpr.id RECHARGE_SRC_ID, -- 快钱1
         'tb_pay_record' RECHARGE_SRC_TAB,
         tpr.member_id USER_ID,
         coalesce(tpr.pay_time, tpr.update_time) RECHARGE_TIME,
         2 PAY_TYPE,
         tpr.pay_amount RECHARGE_AMT,
         tpr.order_no ORDER_NO, -- 交易号
         tpr.seal_no ORDER_SN, -- 第三方流水号
         tpr.bank BANK_NAME,
         tpr.card_no BANK_CARD_NO,
         tpr.sub_provider TERMINAL,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM ods.t_tb_pay_record_hist tpr
   WHERE tpr.provider = '_99BILL_FASTPAY'
     and tpr.status = 'PAID'
     and tpr.pay_amount > 0
  union all
  SELECT br.id RECHARGE_SRC_ID, -- 快钱2
         'bill_recharges' RECHARGE_SRC_TAB,
         tmp2.user_id USER_ID,
         br.notify_time RECHARGE_TIME,
         2 PAY_TYPE,
         br.orderAmount RECHARGE_AMT,
         br.dealId ORDER_NO,
         br.orderId ORDER_SN,
         NULL BANK_NAME,
         NULL BANK_CARD_NO,
         NULL TERMINAL,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM ods.t_bill_recharges_hist br
    left join TMP.TMP_IDW_FACT_NONO_RECHARGE_02 tmp2
      on br.dealId = tmp2.key_value
     and tmp2.pay_type = 2
   WHERE br.transstatus = '1'
     and cast(br.orderAmount as decimal(38, 10)) > 0
  union all
  SELECT ko.id RECHARGE_SRC_ID, -- 快钱3
         'kuaiq_orders' RECHARGE_SRC_TAB,
         ko.user_id USER_ID,
         ko.update_time RECHARGE_TIME,
         2 PAY_TYPE,
         ko.amount RECHARGE_AMT,
         ko.orders_id ORDER_NO,
         NULL ORDER_SN,
         NULL BANK_NAME,
         ko.banks_account BANK_CARD_NO,
         ko.terminal TERMINAL,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM ods.t_kuaiq_orders_hist ko
   WHERE ko.order_status = 1
     AND ko.amount > 0
  union all
  SELECT rl.id RECHARGE_SRC_ID, -- 连连 宝付
         'recharge_log' RECHARGE_SRC_TAB,
         rl.user_id USER_ID,
         rl.update_time RECHARGE_TIME,
         CASE
           WHEN tpr.provider = 'LL_FASTPAY' THEN
            4
           WHEN tpr.provider IN ('BAOFOO_FASTPAY',
                                 'BAOFOO_ONLINE_PAY',
                                 'BAOFOO_PAY_FOUR_ELEMENT') THEN
            5
         END PAY_TYPE,
         rl.amount RECHARGE_AMT,
         rl.order_sn ORDER_NO,
         rl.order_sn ORDER_SN,
         rl.bank_card_name BANK_NAME,
         rl.bank_card_id BANK_CARD_NO,
         CASE
           WHEN tpr.sub_provider = "" THEN
            rl.terminal
           ELSE
            ''
         END TERMINAL,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM ods.t_recharge_log_hist rl
    JOIN (select order_no,
                 provider,
                 sub_provider,
                 ROW_NUMBER() OVER(PARTITION BY order_no ORDER BY version DESC) VERSION_DESC
            from ods.t_tb_pay_record_hist
           where provider IN ('LL_FASTPAY',
                              'BAOFOO_FASTPAY',
                              'BAOFOO_ONLINE_PAY',
                              'BAOFOO_PAY_FOUR_ELEMENT')) tpr
      ON tpr.order_no = rl.order_sn
   WHERE rl.recharge_status = 1
     and tpr.VERSION_DESC = 1
     and rl.amount > 0
  union all
  SELECT tpr.id RECHARGE_SRC_ID, -- 微信直连
         'tb_pay_record' RECHARGE_SRC_TAB,
         tpr.member_id USER_ID,
         coalesce(tpr.pay_time, tpr.update_time) RECHARGE_TIME,
         7 PAY_TYPE,
         tpr.pay_amount RECHARGE_AMT,
         tpr.order_no ORDER_NO,
         tpr.seal_no ORDER_SN,
         tpr.bank BANK_NAME,
         tpr.card_no BANK_CARD_NO,
         tpr.sub_provider TERMINAL,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM ods.t_tb_pay_record_hist tpr
   WHERE tpr.provider = 'WECHATDIRECT_PAY'
     and tpr.status = 'PAID'
     and tpr.pay_amount > 0
  union all
  SELECT tpr.id RECHARGE_SRC_ID, -- 钱方
         'tb_pay_record' RECHARGE_SRC_TAB,
         tpr.member_id USER_ID,
         coalesce(tpr.pay_time, tpr.update_time) RECHARGE_TIME,
         3 PAY_TYPE,
         tpr.pay_amount RECHARGE_AMT,
         tpr.order_no ORDER_NO,
         tpr.seal_no ORDER_SN,
         tpr.bank BANK_NAME,
         tpr.card_no BANK_CARD_NO,
         tpr.sub_provider TERMINAL,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM ods.t_tb_pay_record_hist tpr
   WHERE tpr.provider = 'QTB_PAY'
     and tpr.status = 'PAID'
     and tpr.pay_amount > 0
  union all
  SELECT sr.id RECHARGE_SRC_ID, -- 盛付通
         'sft_recharges' RECHARGE_SRC_TAB,
         tmp2.user_id USER_ID,
         if(sr.sendtime is null or sr.sendtime = '',
            sr.notify_time,
            FROM_UNIXTIME(UNIX_TIMESTAMP(sr.sendtime, 'yyyyMMddHHmmss'),
                          'yyyy-MM-dd HH:mm:ss')) RECHARGE_TIME,
         6 PAY_TYPE,
         sr.orderamount RECHARGE_AMT,
         sr.transno ORDER_NO,
         sr.orderno ORDER_SN,
         NULL BANK_NAME,
         NULL BANK_CARD_NO,
         NULL TERMINAL,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM ods.t_sft_recharges_hist sr
    left join TMP.TMP_IDW_FACT_NONO_RECHARGE_02 tmp2
      on sr.transno = tmp2.key_value
     and tmp2.pay_type = 6
   WHERE sr.transstatus = '01'
     and cast(sr.orderamount as decimal(38, 10)) > 0;

insert overwrite table IDW.FACT_NONO_RECHARGE partition
  (DATA_STATE)
  select DW_CREATE_BY,
         DW_CREATE_TIME,
         DW_UPDATE_BY,
         DW_UPDATE_TIME,
         RECHARGE_SRC_ID,
         RECHARGE_SRC_TAB,
         USER_ID,
         RECHARGE_TIME,
         PAY_TYPE,
         null RECHARGE_TYPE,
         RECHARGE_AMT,
         ORDER_NO,
         ORDER_SN,
         BANK_NAME,
         BANK_CARD_NO,
         case
           when TERMINAL = '' then
            null
           else
            TERMINAL
         end TERMINAL,
         null SYSTEM_ID,
         'curing' DATA_STATE
    from TMP.TMP_IDW_FACT_NONO_RECHARGE_CURING;