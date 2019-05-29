set mapreduce.job.name = DMT_RM_FACT_APPLY_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT_RM.FACT_APPLY partition
  (stat_date)
  select bo.bo_id APPLY_NO,
         ui.real_name APPLY_NAME,
         ui.ID_NUM IDENTITY_CARD_ID,
         coalesce(year(bo.publish_time) - year(ui.birthday), ui.age) age,
         case ui.GENDER
           when 1 then
            '男'
           when 2 THEN
            '女'
         end SEX,
         ui.HJ_PROVINCE_NAME HUJI_PROVINCE,
         ui.HJ_CITY_NAME HUJI_CITY,
         ui.CURRENT_PROVINCE_NAME CURRENT_PROVINCE,
         if(instr(ui.CURRENT_PROVINCE_NAME, '市') > 0,
            ui.CURRENT_PROVINCE_NAME,
            ui.CURRENT_CITY_NAME) CURRENT_CITY,
         ui.ACADEMY SCHOOL_NAME,
         ui.SCHOOL_TYPE_DESC SCHOOL_TYPE,
         ui.SCHOOL_CITY_NAME SCHOOL_CITY,
         ui.SCHOOL_PROVINCE_NAME SCHOOL_PROVINCE,
         ui.MAJOR MAJOR_NAME,
         case
           when MONTH(bo.publish_time) < 9 then
            year(bo.publish_time) - year(EDU_START_DATE)
           when MONTH(bo.publish_time) >= 9 then
            (year(bo.publish_time) - year(EDU_START_DATE)) + 1
         end GRADE,
         ui.MXD_EDUCATION EDUCATION,
         ui.edu_start_date ENTER_SCHOOL_DATE,
         ui.IS_GRADUATE GRADUATE_FLAG,
         ui.EDU_GRADUATE_DATE GRADUATE_DATE,
         ui.mobile_num PHONE_NO,
         ui.INSTRUCTOR_MOBILE PHONE_INSTRUCTOR_NO,
         ui.PARENT_MOBILE PHONE_PARENTS_NO,
         ui.FRIEND1_MOBILE PHONE_CONTACT1_NO,
         ui.FRIEND2_MOBILE PHONE_CONTACT2_NO,
         ui.FRIEND3_MOBILE PHONE_CONTACT3_NO,
         ui.qq QQ,
         ui.email EMAIL,
         ui.job OCCUPATION,
         ui.CURRENT_JOB_TIME WORKING_YEAR,
         ui.COMPANY_NAME COMPANY_NAME,
         ui.COMPANY_BUSINESS_TYPE COMPANY_TYPE,
         ui.COMPANY_TEL PHONE_COMPANY_NO,
         bo.publish_time APPLY_DATE,
         case
           when bo.p_id = 87 and bp.bp_channel = 5 then
            '社保贷'
           when bo.p_id = 87 and bp.bp_channel = 6 then
            '应届贷'
           when bo.p_id = 87 and bp.bp_channel = 7 then
            '按揭贷'
           when bo.p_id = 110 and bo.credit_type = 2 then
            '高学历贷'
           when bo.p_id = 110 and bo.credit_type = 3 then
            '消费能力贷'
           else
            bo.p_name
         end PRODUCT,
         bo.bo_price APPLY_AMT,
         bo.bo_expect APPLY_TERM,
         CASE bo.bo_sign_result
           WHEN 0 THEN
            '未处理'
           WHEN 1 THEN
            '通过'
           WHEN 2 THEN
            '拒绝'
           WHEN 3 THEN
            '待处理'
           WHEN 4 THEN
            '回退'
           WHEN 5 THEN
            '取消'
         END SIGN_RESULT,
         CASE
           WHEN bo.bo_can_success = 3 AND bo.bo_is_success = 0 AND
                bo.bo_is_finish <> 2 THEN
            '终审通过（还未放款）'
           WHEN bo.bo_is_success = 1 THEN
            '终审通过已放款'
           WHEN ba.is_audit = 3 AND bo.bo_is_success = 0 AND
                bo.bo_is_finish = 0 THEN
            '初审中'
           WHEN ba.is_audit = 1 AND ba.is_confirm = 3 AND
                bo.bo_is_success = 0 AND bo.bo_is_finish = 0 THEN
            '终审中'
           WHEN ba.is_audit = 4 AND bo.bo_is_success = 0 AND
                bo.bo_is_finish = 0 THEN
            '初审回退'
           WHEN ba.is_audit = 2 THEN
            '初审拒绝'
           WHEN ba.is_audit = 5 THEN
            '初审取消'
           WHEN ba.is_confirm = 4 AND bo.bo_is_success = 0 AND
                bo.bo_is_finish = 0 THEN
            '终审回退'
           WHEN ba.is_confirm = 2 THEN
            '终审拒绝'
           WHEN ba.is_confirm = 5 THEN
            '终审取消'
           WHEN bo.bo_is_success = 3 OR bo.bo_is_finish = 2 THEN
            '自动流标'
         END APPROVE_RESULT,
         bp.bp_price_audit APPROVE_AMT,
         if(bo.bo_sign_result = 2,
            coalesce(ba.REJECT_REASON, bo.bo_audit_remark),
            null) REFUSE_REASON,
         null CANCELL_REASON,
         if(bo_sign_result = 4, bo.bo_audit_remark, null) BACK_REASON,
         ui.channel_name CHANNEL,
         ui.CAMPUS_APPROACH_DESC RESOURCE,
         bo.bo_title PURPOSE,
         dm.SCORE_RESULT SCORE,
         dm.SCORE_LEVEL LEVEL,
         case
           when ba.bo_id IS NOT NULL THEN
            1
           ELSE
            0
         END VIDEO_FLAG,
         null PHONECALL_FLAG,
         ui.PARENT_MOBILE_STATE PHONECALL_PARENTS_FLAG,
         ui.INSTRUCTOR_MOBILE_STATE PHONECALL_GUIDER_FLAG,
         ui.FRIEND1_MOBILE_STATE PHONECALL_CONTACT1_FLAG,
         ui.FRIEND2_MOBILE_STATE PHONECALL_CONTACT2_FLAG,
         ui.FRIEND3_MOBILE_STATE PHONECALL_CONTACT3_FLAG,
         ui.REGISTER_IP REGISTER_IP,
         ui.IS_STUDENT_AUTH STUDENT_CERTIFICATE1_FLAG,
         ui.IS_EDUCATION_AUTH STUDENT_CERTIFICATE2_FLAG,
         ui.is_social_security INSURANCE_SOCIETY_FLAG,
         ui.family_income FAMILY_INCOME_AMT,
         ui.is_cheat FRAUD_FLAG,
         NULL FRAUD_TYPE,
         cs.shopName MERCHANT_NAME,
         ui.INSTRUCTOR_NAME COUNSELLOR_NAME,
         ui.PARENT_NAME PARENT_NAME,
         ui.FRIEND1_NAME CONTACT_NAME1,
         ui.FRIEND2_NAME CONTACT_NAME2,
         ui.FRIEND3_NAME CONTACT_NAME3,
         ui.INSTRUCTOR_MOBILE_ADDRESS COUNSELLOR_PHONE,
         ui.PARENT_MOBILE_ADDRESS PARENT_PHONE,
         ui.FRIEND1_MOBILE_ADDRESS CONTACT_PHONE1,
         ui.FRIEND2_MOBILE_ADDRESS CONTACT_PHONE2,
         ui.FRIEND3_MOBILE_ADDRESS CONTACT_PHONE3,
         ba.LAST_AUDIT_PASS_TIME AM_AUDIT_TIME,
         ui.LAST_BIND_CARD_ACCOUNT BANK_CARD_NO,
         ui.LAST_BIND_CARD_BANK BANK_NAME,
         bo.user_id USER_ID,
         dm.FINAL_DES_REMARK AUTO_DECISION,
         dm.FINAL_DES_TIME AUTO_DECISION_DATE,
         dm.IS_NEW_USER ISNEWUSER,
         dm.ED_RULE_ID RULE_ID,
         if(dm.TONGDUN_UUID is not null, '1', '0') IS_TONGDUN,
         cast(ui.IS_BLACK_GRAY as string) IS_BLACK_GRAY,
         dm.USER_RISK_BILL USERRISKBILL,
         ui.address_home ADDRESS_HOME,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         ui.BL_GRADUATE_TIME,
         ui.IS_GJJ_SUBMIT,
         ui.MOBILE_ADDRESS,
         dm.PASS_RULE_ID pass_rule,
         CASE
           WHEN bo.BO_AIM = '使用APP5.0进行的借款' THEN
            '马甲包'
           WHEN bo.BO_AIM = '使用APP进行的借款' THEN
            '新APP'
           WHEN bo.BO_AIM = '使用微信进行的借款' THEN
            'H5/微站'
           ELSE
            'PC端进件'
         END APPLY_CHANNEL,
         dm.FINAL_DES auto_decision_code,
         unix_timestamp(bo.publish_time, 'yyyy-MM-dd HH:mm:ss') -
         unix_timestamp(bp.bp_publish_time, 'yyyy-MM-dd HH:mm:ss') publish_duration,
         unix_timestamp(bo.confirm_pass_time, 'yyyy-MM-dd HH:mm:ss') -
         unix_timestamp(bo.video_audit_time, 'yyyy-MM-dd HH:mm:ss') confirm_duration,
         unix_timestamp(coalesce(transfer_account_time, bo_agree_time),
                        'yyyy-MM-dd HH:mm:ss') -
         unix_timestamp(bo.confirm_pass_time, 'yyyy-MM-dd HH:mm:ss') lend_duration,
         bo.is_stock_campaign,
         null content,
         case
           when ba.FUSHU_FUND_RAWDATA_UUID is not null then
            1
           else
            0
         end IS_GJJ_AUTH,
         case
           when bo.p_id = 110 then
            bo.INCREASE_AMOUNT
         end INCREASE_AMT_110,
         case
           when bo.p_id = 110 then
            bo.TOTAL_AMOUNT
         end TOTAL_AMT_110,
         case
           when bo.p_id = 111 then
            bo.TOTAL_AMOUNT
         end AMT_111,
         ui.KNOW_APPROACH_NAME,
         dm.ED_REASON_ID,
         dm.RG_RULE_ID,
         dm.RG_REASON_ID,
         ui.UNIFI_REGISTER_COUNTRY_NAME,
         bo.IS_REPEAT_BORROW,
         bo.lbs_complete_data_city as video_lbs_address,
         concat(coalesce(ui.CURRENT_PROVINCE_NAME, ''),
                coalesce(ui.CURRENT_CITY_NAME, ''),
                coalesce(ui.CONTACT_ADDRESS, '')) current_address,
         uc.company_address,
         case
           when bo.p_id = 87 then
            ui.USER_CREDIT_RANK
         end BLD_OLD_LEVEL,
         bo.P_KEY,
         bo.IS_BORROWS_RAISE,
         ui.MONTHLY_SALARY,
         ulin.MONTHLY_DEBT,
         ui.BASE_AMOUNT_TYPE_110,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyyMMdd') STAT_DATE
    from idw.fact_borrows bo
    left join idw.dim_user ui
      on bo.user_id = ui.user_id
    left join idw.FACT_BORROWS_AUDIT ba
      on bo.bo_id = ba.bo_id
    left join idw.fact_borrows_prepare bp
      on bo.bp_id = bp.bp_id
    left join odsopr.user_csmFinInfo cs
      on bo.bo_id = cs.bo_id
    left join IDW.FACT_RM_DES_MAIN dm
      on bo.bp_id = dm.bp_id
     and bo.user_id = dm.user_id
    left join (select user_id,
                      company_address,
                      row_number() over(partition by user_id order by id desc) rn
                 from odsopr.user_company_info_hist) uc
      on bo.user_id = uc.user_id
     and uc.rn = 1
    left join odsopr.user_loan_info_new_hist ulin
      on bo.user_id = ulin.user_id;