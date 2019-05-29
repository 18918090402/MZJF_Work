set mapreduce.job.name = dmt_mxd_fact_mxd_operation_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true ;
    

insert overwrite table DMT_MXD.FACT_MXD_OPERATION
  -- 1 用户注册
  select SUBSTR(ui.REGISTER_TIME, 1, 10) TAG_DATE,
         null P_ID,
         null BO_PURPOSE,
         ui.USER_ID,
         null bo_id,
         ui.USER_ID REGISTER_USER_ID,
         null STU_AUTH_USER_ID,
         null APPLY_USER_ID,
         null BO_USER_ID,
         null VIDEO_AUDIT_BO_ID,
         null LOAN_BO_ID,
         null BO_AMT,
         null BO_TIME,
         null SEVEN_BO_USER_ID,
         null RE_BO_USER_ID,
         null RE_BO_AMT,
         null IS_FIRST_REPAY_OVERDUE,
         null FIRST_REPAY_OVERDUE_B,
         null IS_FIRST_REPAY_OVERDUE_UNREPAY,
         null FIRST_REPAY_OVERDUE_UNREPAY_B,
         null IS_FIRST_REPAY,
         null FIRST_REPAY_B,
         null IS_OVERDUE,
         null OVERDUE_B,
         null IS_OVERDUE_UNREPAY,
         null OVERDUE_UNREPAY_B,
         null BR_PRICE,
         null BR_PRICE_B,
         null BR_PRICE_L,
         null BR_PRICE_PUNISH,
         null UNREPAY_PRICE_B,
         null UNREPAY_PRICE_L,
         null UNREPAY_PRICE_PUNISH,
         null IS_FIRST_OVERDUE,
         null FIRST_OVERDUE_B,
         null IS_FIRST_OVERDUE_UNREPAY,
         null FIRST_OVERDUE_UNREPAY_B,
         null IS_NEVER_OVERDUE,
         null NEVER_OVERDUE_B,
         1 DATA_TYPE,
         ui.USER_ID SRC_ID,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         null BO_APPLY_AMT
    from idw.dim_user ui
   where (ui.register_biz = 'mxd' or upper(ui.channel_name) like '%MXD%')
     and ui.REGISTER_TIME is not null
  union all
  -- 2 学籍验证通过
  select SUBSTR(ui.STU_AUTH_TIME, 1, 10) TAG_DATE,
         null P_ID,
         null BO_PURPOSE,
         ui.USER_ID,
         null bo_id,
         null REGISTER_USER_ID,
         ui.USER_ID STU_AUTH_USER_ID,
         null APPLY_USER_ID,
         null BO_USER_ID,
         null VIDEO_AUDIT_BO_ID,
         null LOAN_BO_ID,
         null BO_AMT,
         null BO_TIME,
         null SEVEN_BO_USER_ID,
         null RE_BO_USER_ID,
         null RE_BO_AMT,
         null IS_FIRST_REPAY_OVERDUE,
         null FIRST_REPAY_OVERDUE_B,
         null IS_FIRST_REPAY_OVERDUE_UNREPAY,
         null FIRST_REPAY_OVERDUE_UNREPAY_B,
         null IS_FIRST_REPAY,
         null FIRST_REPAY_B,
         null IS_OVERDUE,
         null OVERDUE_B,
         null IS_OVERDUE_UNREPAY,
         null OVERDUE_UNREPAY_B,
         null BR_PRICE,
         null BR_PRICE_B,
         null BR_PRICE_L,
         null BR_PRICE_PUNISH,
         null UNREPAY_PRICE_B,
         null UNREPAY_PRICE_L,
         null UNREPAY_PRICE_PUNISH,
         null IS_FIRST_OVERDUE,
         null FIRST_OVERDUE_B,
         null IS_FIRST_OVERDUE_UNREPAY,
         null FIRST_OVERDUE_UNREPAY_B,
         null IS_NEVER_OVERDUE,
         null NEVER_OVERDUE_B,
         2 DATA_TYPE,
         ui.USER_ID SRC_ID,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         null BO_APPLY_AMT
    from idw.dim_user ui
   where ui.IS_STUDENT_AUTH = 1
     and (ui.register_biz = 'mxd' or upper(ui.channel_name) like '%MXD%')
     and ui.STU_AUTH_TIME is not null
  union all
  -- 3 申请
  select SUBSTR(bp.bp_publish_time, 1, 10) TAG_DATE,
         bp.P_ID,
         CASE
           WHEN length(bp.bp_title) < 5 and bp.bp_title not regexp
            '^[0-9A-Za-z]*$' THEN
            bp.bp_title
           WHEN bp.bp_title regexp '创业' THEN
            '创业'
           WHEN bp.bp_title regexp '应急周转' THEN
            '应急周转'
           WHEN bp.bp_title regexp '培训' THEN
            '培训'
           WHEN bp.bp_title regexp '消费' THEN
            '消费'
           WHEN bp.bp_title regexp '就业' THEN
            '就业'
           WHEN bp.bp_title regexp '旅游|旅行' THEN
            "旅行"
           ELSE
            '(未知)'
         END BO_PURPOSE,
         bp.USER_ID,
         null bo_id,
         null REGISTER_USER_ID,
         null STU_AUTH_USER_ID,
         bp.USER_ID APPLY_USER_ID,
         null BO_USER_ID,
         null VIDEO_AUDIT_BO_ID,
         null LOAN_BO_ID,
         null BO_AMT,
         null BO_TIME,
         null SEVEN_BO_USER_ID,
         null RE_BO_USER_ID,
         null RE_BO_AMT,
         null IS_FIRST_REPAY_OVERDUE,
         null FIRST_REPAY_OVERDUE_B,
         null IS_FIRST_REPAY_OVERDUE_UNREPAY,
         null FIRST_REPAY_OVERDUE_UNREPAY_B,
         null IS_FIRST_REPAY,
         null FIRST_REPAY_B,
         null IS_OVERDUE,
         null OVERDUE_B,
         null IS_OVERDUE_UNREPAY,
         null OVERDUE_UNREPAY_B,
         null BR_PRICE,
         null BR_PRICE_B,
         null BR_PRICE_L,
         null BR_PRICE_PUNISH,
         null UNREPAY_PRICE_B,
         null UNREPAY_PRICE_L,
         null UNREPAY_PRICE_PUNISH,
         null IS_FIRST_OVERDUE,
         null FIRST_OVERDUE_B,
         null IS_FIRST_OVERDUE_UNREPAY,
         null FIRST_OVERDUE_UNREPAY_B,
         null IS_NEVER_OVERDUE,
         null NEVER_OVERDUE_B,
         3 DATA_TYPE,
         bp.BP_ID SRC_ID,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         null BO_APPLY_AMT
    from idw.fact_borrows_prepare bp
   where busi_line = '名校贷'
     and bp.bp_publish_time is not null
  union all
  -- 4 视频提交
  select SUBSTR(bo.VIDEO_AUDIT_TIME, 1, 10) TAG_DATE,
         bo.P_ID,
         bo.BO_PURPOSE,
         bo.USER_ID,
         bo.bo_id,
         null REGISTER_USER_ID,
         null STU_AUTH_USER_ID,
         null APPLY_USER_ID,
         null BO_USER_ID,
         bo.bo_id VIDEO_AUDIT_BO_ID,
         null LOAN_BO_ID,
         null BO_AMT,
         null BO_TIME,
         null SEVEN_BO_USER_ID,
         null RE_BO_USER_ID,
         null RE_BO_AMT,
         null IS_FIRST_REPAY_OVERDUE,
         null FIRST_REPAY_OVERDUE_B,
         null IS_FIRST_REPAY_OVERDUE_UNREPAY,
         null FIRST_REPAY_OVERDUE_UNREPAY_B,
         null IS_FIRST_REPAY,
         null FIRST_REPAY_B,
         null IS_OVERDUE,
         null OVERDUE_B,
         null IS_OVERDUE_UNREPAY,
         null OVERDUE_UNREPAY_B,
         null BR_PRICE,
         null BR_PRICE_B,
         null BR_PRICE_L,
         null BR_PRICE_PUNISH,
         null UNREPAY_PRICE_B,
         null UNREPAY_PRICE_L,
         null UNREPAY_PRICE_PUNISH,
         null IS_FIRST_OVERDUE,
         null FIRST_OVERDUE_B,
         null IS_FIRST_OVERDUE_UNREPAY,
         null FIRST_OVERDUE_UNREPAY_B,
         null IS_NEVER_OVERDUE,
         null NEVER_OVERDUE_B,
         4 DATA_TYPE,
         bo.BO_ID SRC_ID,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         null BO_APPLY_AMT
    from IDW.FACT_BORROWS bo
   where bo.busi_line = '名校贷'
     and bo.VIDEO_AUDIT_TIME is not null
  union all
  -- 5 借款
  select SUBSTR(bo.BO_AUDIT_TIME, 1, 10) TAG_DATE,
         bo.P_ID,
         bo.BO_PURPOSE,
         bo.USER_ID,
         bo.bo_id,
         null REGISTER_USER_ID,
         null STU_AUTH_USER_ID,
         null APPLY_USER_ID,
         bo.USER_ID BO_USER_ID,
         null VIDEO_AUDIT_BO_ID,
         bo.bo_id LOAN_BO_ID,
         bo.BO_FINISH_PRICE BO_AMT,
         bo.BO_AGREE_TIME BO_TIME,
         case
           when bo.BO_AUDIT_TIME < date_add(ui.REGISTER_TIME, 8) then
            bo.USER_ID
           else
            0
         end SEVEN_BO_USER_ID,
         case
           when bo.IS_REPEAT_BORROW = 1 then
            bo.USER_ID
           else
            0
         end RE_BO_USER_ID,
         case
           when bo.IS_REPEAT_BORROW = 1 then
            bo.BO_FINISH_PRICE
           else
            0
         end RE_BO_AMT,
         null IS_FIRST_REPAY_OVERDUE,
         null FIRST_REPAY_OVERDUE_B,
         null IS_FIRST_REPAY_OVERDUE_UNREPAY,
         null FIRST_REPAY_OVERDUE_UNREPAY_B,
         null IS_FIRST_REPAY,
         null FIRST_REPAY_B,
         null IS_OVERDUE,
         null OVERDUE_B,
         null IS_OVERDUE_UNREPAY,
         null OVERDUE_UNREPAY_B,
         null BR_PRICE,
         null BR_PRICE_B,
         null BR_PRICE_L,
         null BR_PRICE_PUNISH,
         null UNREPAY_PRICE_B,
         null UNREPAY_PRICE_L,
         null UNREPAY_PRICE_PUNISH,
         null IS_FIRST_OVERDUE,
         null FIRST_OVERDUE_B,
         null IS_FIRST_OVERDUE_UNREPAY,
         null FIRST_OVERDUE_UNREPAY_B,
         null IS_NEVER_OVERDUE,
         null NEVER_OVERDUE_B,
         5 DATA_TYPE,
         bo.BO_ID SRC_ID,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         bo.BO_PRICE BO_APPLY_AMT
    from IDW.FACT_BORROWS bo
    join idw.dim_user ui
   where bo.user_id = ui.user_id
     and bo.busi_line = '名校贷'
     and bo.bo_is_success = 1
     and bo.BO_AUDIT_TIME is not null
  union all
  -- 6 计划还款 
  select SUBSTR(br.BR_TIME, 1, 10) TAG_DATE,
         bo.P_ID,
         bo.BO_PURPOSE,
         br.USER_ID,
         br.bo_id,
         null REGISTER_USER_ID,
         null STU_AUTH_USER_ID,
         null APPLY_USER_ID,
         null BO_USER_ID,
         null VIDEO_AUDIT_BO_ID,
         null LOAN_BO_ID,
         null BO_AMT,
         bo.BO_AUDIT_TIME BO_TIME,
         null SEVEN_BO_USER_ID,
         null RE_BO_USER_ID,
         null RE_BO_AMT,
         br.IS_FIRST_REPAY_OVERDUE,
         case
           when br.IS_FIRST_REPAY_OVERDUE = 1 then
            BR_PRICE_B
           else
            0
         end FIRST_REPAY_OVERDUE_B,
         case
           when br.IS_FIRST_REPAY_OVERDUE = 1 and BR_IS_REPAY = 0 then
            1
           else
            0
         end IS_FIRST_REPAY_OVERDUE_UNREPAY,
         case
           when br.IS_FIRST_REPAY_OVERDUE = 1 and BR_IS_REPAY = 0 then
            BR_PRICE_B
           else
            0
         end FIRST_REPAY_OVERDUE_UNREPAY_B,
         case
           when br.BR_EXPECT_NUM = 1 then
            1
           else
            0
         end IS_FIRST_REPAY,
         case
           when br.BR_EXPECT_NUM = 1 then
            BR_PRICE_B
           else
            0
         end FIRST_REPAY_B,
         case
           when BR_OVERDUE_TERMS > 0 then
            1
           else
            0
         end IS_OVERDUE,
         case
           when BR_OVERDUE_TERMS > 0 then
            BR_PRICE_B
           else
            0
         end OVERDUE_B,
         case
           when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
            1
           else
            0
         end IS_OVERDUE_UNREPAY,
         case
           when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
            BR_PRICE_B
           else
            0
         end OVERDUE_UNREPAY_B,
         br.BR_PRICE,
         br.BR_PRICE_B,
         br.BR_PRICE_L,
         br.BR_PRICE_PUNISH,
         case
           when BR_IS_REPAY = 0 then
            BR_PRICE_B
           else
            0
         end UNREPAY_PRICE_B,
         case
           when BR_IS_REPAY = 0 then
            BR_PRICE_L
           else
            0
         end UNREPAY_PRICE_L,
         case
           when BR_IS_REPAY = 0 then
            BR_PRICE_PUNISH
           else
            0
         end UNREPAY_PRICE_PUNISH,
         br.IS_FIRST_OVERDUE,
         case
           when IS_FIRST_OVERDUE = 1 then
            BR_PRICE_B
           else
            0
         end FIRST_OVERDUE_B,
         case
           when IS_FIRST_OVERDUE = 1 and BR_IS_REPAY = 0 then
            1
           else
            0
         end IS_FIRST_OVERDUE_UNREPAY,
         case
           when IS_FIRST_OVERDUE = 1 and BR_IS_REPAY = 0 then
            BR_PRICE_B
           else
            0
         end FIRST_OVERDUE_UNREPAY_B,
         case
           when br.BR_EXPECT_NUM > tmp.BR_EXPECT_NUM then
            0
           else
            1
         end IS_NEVER_OVERDUE,
         case
           when br.BR_EXPECT_NUM > tmp.BR_EXPECT_NUM then
            0
           else
            BR_PRICE_B
         end NEVER_OVERDUE_B,
         6 DATA_TYPE,
         br.br_id SRC_ID,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         null BO_APPLY_AMT
    from IDW.FACT_BORROWS_REPAYMENT br
    join IDW.FACT_BORROWS bo
      on br.bo_id = bo.bo_id
     and bo.busi_line = '名校贷'
    left outer join (select br.bo_id, br.BR_EXPECT_NUM
                       from IDW.FACT_BORROWS_REPAYMENT br
                      where br.IS_FIRST_OVERDUE = 1) tmp
      on br.bo_id = tmp.bo_id
  union all
  -- 7 实际还款
  select SUBSTR(br.BR_REPAY_TIME, 1, 10) TAG_DATE,
         bo.P_ID,
         bo.BO_PURPOSE,
         br.USER_ID,
         br.bo_id,
         null REGISTER_USER_ID,
         null STU_AUTH_USER_ID,
         null APPLY_USER_ID,
         null BO_USER_ID,
         null VIDEO_AUDIT_BO_ID,
         null LOAN_BO_ID,
         null BO_AMT,
         bo.BO_AUDIT_TIME BO_TIME,
         null SEVEN_BO_USER_ID,
         null RE_BO_USER_ID,
         null RE_BO_AMT,
         null IS_FIRST_REPAY_OVERDUE,
         null FIRST_REPAY_OVERDUE_B,
         null IS_FIRST_REPAY_OVERDUE_UNREPAY,
         null FIRST_REPAY_OVERDUE_UNREPAY_B,
         null IS_FIRST_REPAY,
         null FIRST_REPAY_B,
         null IS_OVERDUE,
         null OVERDUE_B,
         null IS_OVERDUE_UNREPAY,
         null OVERDUE_UNREPAY_B,
         br.BR_PRICE,
         br.BR_PRICE_B,
         null BR_PRICE_L,
         null BR_PRICE_PUNISH,
         null UNREPAY_PRICE_B,
         null UNREPAY_PRICE_L,
         null UNREPAY_PRICE_PUNISH,
         null IS_FIRST_OVERDUE,
         null FIRST_OVERDUE_B,
         null IS_FIRST_OVERDUE_UNREPAY,
         null FIRST_OVERDUE_UNREPAY_B,
         null IS_NEVER_OVERDUE,
         null NEVER_OVERDUE_B,
         7 DATA_TYPE,
         br.br_id SRC_ID,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         null BO_APPLY_AMT
    from IDW.FACT_BORROWS_REPAYMENT br
    join IDW.FACT_BORROWS bo
      on br.bo_id = bo.bo_id
     and bo.busi_line = '名校贷'
   where br.BR_REPAY_TIME is not null;
