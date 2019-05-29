set mapreduce.job.name = DMT_RM_FACT_APPLY_MAIYA_DATA_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_RM.FACT_APPLY_MAIYA_DATA partition
  (stat_date)
  select 'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         mo.order_no,
         mo.BO_ID APPLY_NO,
         ui.MAIYA_REAL_NAME APPLY_NAME,
         mo.STATUS_DESC ORDER_STATUS,
         mo.RETURN_REASON_DESC RETURN_REMARK,
         mo.REJECT_REASON_DESC_1 REFUSE_REASON,
         mo.REJECT_REASON_DESC_2 SUB_REFUSE_REASON,
         ui.MAIYA_ID_NUM IDCARD,
         CASE
           WHEN ui.MAIYA_GENDER = '1' THEN
            '男'
           WHEN ui.MAIYA_GENDER = '2' THEN
            '女'
         END SEX,
         ui.MAIYA_EDUCATION EDUCATION,
         ui.MAIYA_MOBILE_NUM MOBILE,
         ui.MAIYA_EMAIL EMAIL,
         ui.MAIYA_WORK_POSITION_NAME POSITION,
         ui.MAIYA_COMPANY_NAME COMPANY_NAME,
         ui.MAIYA_REGISTER_PROVINCE_NAME CURRENT_PROVINCE,
         ui.MAIYA_REGISTER_CITY_NAME CURRENT_CITY,
         mo.CREATE_TIME CREATE_TIME,
         mo.ORDER_BEGIN_DATE ORDER_BEGIN_DATE,
         mo.PASS_TIME PASS_TIME,
         mo.LENDING_TIME LENDING_TIME,
         mo.principal PRACTICAL_MONEY,
         mo.TOTAL_PARTS TOTAL_PARTS,
         mo.CHANNEL_ID CHANNEL,
         ui.MAIYA_USER_SOURCE SOURCE,
         mo.IS_CALL PHONECALL_FLAG,
         ui.MAIYA_SALARY FAMILY_INCOME_AMT,
         ui.MAIYA_IS_QIZHA FRAUD_FLAG,
         mo.SHOP_ID SHOP_ID,
         mo.FACE_ID FACE_ID,
         mo.SHOP_NAME MERCHANT_NAME,
         '' MERCHANT_TYPE,
         mo.TONGDUN_SCORE SCORE,
         mo.CREDIT_LEVEL LEVEL,
         mo.APPLY_AMOUNT APPLY_AMOUNT,
         mo.APPLY_PARTS APPLY_PARTS,
         mo.SHOP_COMPANY_TYPE DIC_ITEM,
         mo.CANCEL_REASON CANCEL_REASON,
         mo.CANCEL_REMARK CANCEL_REMARK,
         mo.CREATE_USER USER_ID,
         ui.MAIYA_USER_NAME USER_NAME,
         ui.MAIYA_MOBILE_ADDRESS PHONE_PROVICE,
         ui.MAIYA_WORK_TYPE WORK_TYPE,
         mo.CREDIT_NODE CREDIT_NODE,
         mo.BD_NAME BD_NAME,
         mo.AUTO_REJECT_REASON_DESC AUTO_REJECT_REASON,
         ui.user_id as NONO_USER_ID,
         mo.goods_id as goods_id,
         mo.REVIEW_SOURCE as REVIEW_SOURCE,
         mo.QD_PASS,
         mo.FACHANNEL_NAME,
         mo.subchannel_name,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyyMMdd') STAT_DATE
    from idw.FACT_MAIYA_ORDER mo
    left join idw.dim_user ui
      on mo.NONOBANK_USERID = ui.user_id;
