set mapreduce.job.name = idw_fact_nono_invest_cash_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_NONO_INVEST_CASH partition
  (DATA_STATE)
  SELECT ba.id CASH_SRC_ID, -- 散投、债转正常兑付
         'borrows_accept' CASH_SRC_TAB,
         ba.user_id USER_ID,
         null FP_KEY,
         null FP_ID,
         ba.bo_id BO_ID,
         null DT_ID,
         null CATEGORY_CODE_02,
         null CATEGORY_NAME_02,
         ba.plan_time PLAN_CASH_TIME,
         ba.success_time ACTUAL_CASH_TIME,
         ba.is_pay CASH_STATUS,
         ba.price_principal PRICE_PRINCIPAL,
         ba.price_interest PRICE_INTEREST,
         ba.price PRICE_AMT,
         ba.price_punish PRICE_PUNISH,
         1 CASH_TYPE_CODE,
         case
           when ba.is_lender = 1 then
            1
           when ba.is_lender = 0 then
            2
         end INVEST_TYPE_CODE,
         concat_ws('_',
                   '01',
                   cast(ba.user_id as string),
                   cast(ba.bo_id as string)) INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when ito.trans_id = '' or ito.trans_id is null then
            'NA'
           else
            ito.trans_id
         end TRANS_ID,
         case
           when ito.seri_no = '' or ito.seri_no is null then
            'NA'
           else
            ito.seri_no
         end SERI_NO,
         1 PLATFORM,
         null VA_ID,
         null EXPECT,
         null EXPECT_UNIT_CODE,
         null REINVEST_TYPE,
         null REINVEST_EXPECT,
         null REINVEST_EXPECT_UNIT_CODE,
         null REINVEST_STATUS,
         null NEXT_VA_ID,
         'current' DATA_STATE
    FROM ods.t_borrows_accept_hist ba
    left join ods.t_invt_trd_order_hist ito
      on ba.seri_no = ito.seri_no
     and ba.seri_no <> ''
     and ito.seri_no <> ''
   WHERE ba.is_vip = 0
  union all
  SELECT dbl.id CASH_SRC_ID, -- 散投、债转人工债转
         'debt_buy_log' CASH_SRC_TAB,
         ds.user_id USER_ID,
         null FP_KEY,
         null FP_ID,
         ds.bo_id BO_ID,
         null DT_ID,
         null CATEGORY_CODE_02,
         null CATEGORY_NAME_02,
         NULL PLAN_CASH_TIME,
         dbl.pay_time ACTUAL_CASH_TIME,
         1 CASH_STATUS,
         dbl.price PRICE_PRINCIPAL,
         NULL PRICE_INTEREST,
         NULL PRICE_AMT,
         NULL PRICE_PUNISH,
         2 CASH_TYPE_CODE,
         case
           when ba.is_lender = 1 then
            1
           when ba.is_lender = 0 then
            2
         end INVEST_TYPE_CODE,
         concat_ws('_',
                   '01',
                   cast(ds.user_id as string),
                   cast(ds.bo_id as string)) INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when ito.trans_id = '' or ito.trans_id is null then
            'NA'
           else
            ito.trans_id
         end TRANS_ID,
         case
           when ito.seri_no = '' or ito.seri_no is null then
            'NA'
           else
            ito.seri_no
         end SERI_NO,
         1 PLATFORM,
         null VA_ID,
         null EXPECT,
         null EXPECT_UNIT_CODE,
         null REINVEST_TYPE,
         null REINVEST_EXPECT,
         null REINVEST_EXPECT_UNIT_CODE,
         null REINVEST_STATUS,
         null NEXT_VA_ID,
         'current' DATA_STATE
    FROM ods.t_debt_buy_log_hist dbl
    JOIN ods.t_debt_sale_hist ds
      ON ds.id = dbl.ds_id
     AND ds.op_type = 3
     AND ds.va_id = 0
    JOIN (SELECT user_id,
                 bo_id,
                 is_lender,
                 if(seri_no = '' or seri_no is null, 'NA', seri_no) seri_no_new
            FROM ods.t_borrows_accept_hist
           WHERE is_vip = 0
           GROUP BY user_id,
                    bo_id,
                    is_lender,
                    if(seri_no = '' or seri_no is null, 'NA', seri_no)) ba
      ON ds.user_id = ba.user_id
     AND ds.bo_id = ba.bo_id
     and if(ds.seri_no = ''
         or ds.seri_no is null,
            'NA',
            ds.seri_no) = ba.seri_no_new
    left join ods.t_invt_trd_order_hist ito
      on ds.seri_no = ito.seri_no
     and ds.seri_no <> ''
     and ito.seri_no <> ''
   where dbl.status = 1
   and (ds.plan_time is null or trim(ds.plan_time) ='') --非单期债转
   union all
  SELECT dbl.id CASH_SRC_ID, -- 散投、债转单期债转
         'debt_buy_log' CASH_SRC_TAB,
         ds.user_id USER_ID,
         null FP_KEY,
         null FP_ID,
         ds.bo_id BO_ID,
         null DT_ID,
         null CATEGORY_CODE_02,
         null CATEGORY_NAME_02,
         NULL PLAN_CASH_TIME,
         dbl.pay_time ACTUAL_CASH_TIME,
         1 CASH_STATUS,
         dbl.price PRICE_PRINCIPAL,
         dbl.price_in-dbl.price PRICE_INTEREST,
         NULL PRICE_AMT,
         NULL PRICE_PUNISH,
         3 CASH_TYPE_CODE,
         case
           when ba.is_lender = 1 then
            1
           when ba.is_lender = 0 then
            2
         end INVEST_TYPE_CODE,
         concat_ws('_',
                   '01',
                   cast(ds.user_id as string),
                   cast(ds.bo_id as string)) INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when ito.trans_id = '' or ito.trans_id is null then
            'NA'
           else
            ito.trans_id
         end TRANS_ID,
         case
           when ito.seri_no = '' or ito.seri_no is null then
            'NA'
           else
            ito.seri_no
         end SERI_NO,
         1 PLATFORM,
         null VA_ID,
         null EXPECT,
         null EXPECT_UNIT_CODE,
         null REINVEST_TYPE,
         null REINVEST_EXPECT,
         null REINVEST_EXPECT_UNIT_CODE,
         null REINVEST_STATUS,
         null NEXT_VA_ID,
         'current' DATA_STATE
    FROM ods.t_debt_buy_log_hist dbl
    JOIN ods.t_debt_sale_hist ds
      ON ds.id = dbl.ds_id
     AND ds.va_id = 0
    JOIN (SELECT user_id,
                 bo_id,
                 is_lender,
                 if(seri_no = '' or seri_no is null, 'NA', seri_no) seri_no_new
            FROM ods.t_borrows_accept_hist
           WHERE is_vip = 0
           GROUP BY user_id,
                    bo_id,
                    is_lender,
                    if(seri_no = '' or seri_no is null, 'NA', seri_no)) ba
      ON ds.user_id = ba.user_id
     AND ds.bo_id = ba.bo_id
     and if(ds.seri_no = ''
         or ds.seri_no is null,
            'NA',
            ds.seri_no) = ba.seri_no_new
    left join ods.t_invt_trd_order_hist ito
      on ds.seri_no = ito.seri_no
     and ds.seri_no <> ''
     and ito.seri_no <> ''
   where dbl.status = 1
   and ds.plan_time is not null  --单期债转
   and trim(ds.plan_time) !=''
  union all
  SELECT va.id CASH_SRC_ID, -- 精选正常兑付
         'vip_account' CASH_SRC_TAB,
         va.user_id USER_ID,
         va.fp_id FP_KEY,
         va.fp_id FP_ID,
         NULL BO_ID,
         NULL DT_ID,
         fp.scope CATEGORY_CODE_02,
         fps.label CATEGORY_NAME_02,
         IF(fp.expect_unit = 0,
            if( date_add(add_months(concat(substr(fp.start_date,1,8),'01'), fp.expect), (cast(substr(fp.start_date,9) as int)-1))<=add_months(fp.start_date, fp.expect),
                date_add(add_months(concat(substr(fp.start_date,1,8),'01'), fp.expect), (cast(substr(fp.start_date,9) as int)-1)),
                add_months(fp.start_date, fp.expect)
                ),  
                DATE_ADD(fp.start_date, fp.expect)
               ) PLAN_CASH_TIME,
            
         CASE
           WHEN fl2.create_time IS NULL THEN
            va.cash_time
           ELSE
            fl.create_time
         END ACTUAL_CASH_TIME,
         va.is_cash CASH_STATUS,
         case
           when fp.scope <> 26 and va.amount > coalesce(debt.debt_amt, 0) then
            (va.amount - coalesce(debt.debt_amt, 0))
           when fp.scope = 26 then
            (va.amount - coalesce(qf.quit_amount, 0))
           else
            0
         end PRICE_PRINCIPAL,
         null PRICE_INTEREST,
         null PRICE_AMT,
         null PRICE_PUNISH,
         1 CASH_TYPE_CODE,
         3 INVEST_TYPE_CODE,
         concat_ws('_',
                   '02',
                   cast(va.user_id as string),
                   cast(va.fp_id as string)) INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when ito.trans_id = '' or ito.trans_id is null then
            'NA'
           else
            ito.trans_id
         end TRANS_ID,
         case
           when ito.seri_no = '' or ito.seri_no is null then
            'NA'
           else
            ito.seri_no
         end SERI_NO,
         va.platform,
         va.id VA_ID,
         fp.expect EXPECT,
         CASE
           WHEN fp.expect_unit = 0 THEN
            2
           WHEN fp.expect_unit = 1 THEN
            1
         END EXPECT_UNIT_CODE,
         va.reinvest_type REINVEST_TYPE,
         rt.expect REINVEST_EXPECT,
         CASE
           WHEN rt.expect_unit = 0 THEN
            2
           WHEN rt.expect_unit = 1 THEN
            1
         END REINVEST_EXPECT_UNIT_CODE,
         rt.status REINVEST_STATUS,
         rt.next_va_id NEXT_VA_ID,
         'current' DATA_STATE
    FROM ods.t_vip_account_hist va
    JOIN ods.t_finance_plan_hist fp
      ON va.fp_id = fp.id
    LEFT JOIN ods.t_finance_plan_scope_hist fps
      ON fp.scope = fps.id
    LEFT JOIN odsopr.finance_log_all fl
      ON fl.key_value = cast(va.id as string)
     AND fl.operation_relation = 598
    LEFT JOIN odsopr.finance_log_all fl2
      ON fl2.key_value = cast(va.id as string)
     AND fl2.operation_relation = 597
    left join (select ds.va_id, sum(dbl.price) debt_amt
                 from ods.t_debt_sale_hist ds
                 join ods.t_debt_buy_log_hist dbl
                   on ds.id = dbl.ds_id
                  and dbl.status = 1
                  and ds.op_type = 1
                  and ds.va_id > 0
                group by ds.va_id) debt
      on va.id = debt.va_id
    left join (select va_id, sum(quit_amount) quit_amount
                 from odsopr.invt_stage_quit_form_hist
                where scope = 26
                  and quit_mode <> 2
                  and quit_status = 2
                group by va_id) qf
      on va.id = qf.va_id
    left join ods.t_invt_trd_order_hist ito
      on va.trans_id = ito.trans_id
     and va.trans_id not like 'php%'
    left join odsopr.invt_va_reinvest_task_hist rt
      on va.id = rt.va_id
  union all
  select dbl.id CASH_SRC_ID, -- 精选人工债转
         'debt_buy_log' CASH_SRC_TAB,
         va.user_id USER_ID,
         va.fp_id FP_KEY,
         va.fp_id FP_ID,
         NULL BO_ID,
         NULL DT_ID,
         fp.scope CATEGORY_CODE_02,
         fps.label CATEGORY_NAME_02,
         NULL PLAN_CASH_TIME,
         dbl.pay_time ACTUAL_CASH_TIME,
         1 CASH_STATUS,
         dbl.price PRICE_PRINCIPAL,
         NULL PRICE_INTEREST,
         NULL PRICE_AMT,
         NULL PRICE_PUNISH,
         2 CASH_TYPE_CODE,
         3 INVEST_TYPE_CODE,
         concat_ws('_',
                   '02',
                   cast(va.user_id as string),
                   cast(va.fp_id as string)) INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when ito.trans_id = '' or ito.trans_id is null then
            'NA'
           else
            ito.trans_id
         end TRANS_ID,
         case
           when ito.seri_no = '' or ito.seri_no is null then
            'NA'
           else
            ito.seri_no
         end SERI_NO,
         va.platform,
         va.id VA_ID,
         fp.expect EXPECT,
         CASE
           WHEN fp.expect_unit = 0 THEN
            2
           WHEN fp.expect_unit = 1 THEN
            1
         END EXPECT_UNIT_CODE,
         null REINVEST_TYPE,
         null REINVEST_EXPECT,
         null REINVEST_EXPECT_UNIT_CODE,
         null REINVEST_STATUS,
         null NEXT_VA_ID,
         'current' DATA_STATE
    from ods.t_debt_buy_log_hist dbl
    JOIN ods.t_debt_sale_hist ds
      ON ds.id = dbl.ds_id
     AND ds.op_type = 1 --人工债转
     AND ds.va_id > 0
    join ods.t_vip_account_hist va
      on ds.va_id = va.id
    JOIN ods.t_finance_plan_hist fp
      ON va.fp_id = fp.id
    LEFT JOIN ods.t_finance_plan_scope_hist fps
      ON fp.scope = fps.id
    left join ods.t_invt_trd_order_hist ito
      on va.trans_id = ito.trans_id
     and va.trans_id not like 'php%'
   where dbl.status = 1
  union all
  select qf.id CASH_SRC_ID, -- 招牌财神用户申请退出
         'invt_stage_quit_form' CASH_SRC_TAB,
         va.user_id USER_ID,
         va.fp_id FP_KEY,
         va.fp_id FP_ID,
         NULL BO_ID,
         NULL DT_ID,
         fp.scope CATEGORY_CODE_02,
         fps.label CATEGORY_NAME_02,
         NULL PLAN_CASH_TIME,
         qf.quit_success_time ACTUAL_CASH_TIME,
         1 CASH_STATUS,
         qf.quit_amount PRICE_PRINCIPAL,
         NULL PRICE_INTEREST,
         NULL PRICE_AMT,
         NULL PRICE_PUNISH,
         2 CASH_TYPE_CODE,
         3 INVEST_TYPE_CODE,
         concat_ws('_',
                   '02',
                   cast(va.user_id as string),
                   cast(va.fp_id as string)) INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when ito.trans_id = '' or ito.trans_id is null then
            'NA'
           else
            ito.trans_id
         end TRANS_ID,
         case
           when ito.seri_no = '' or ito.seri_no is null then
            'NA'
           else
            ito.seri_no
         end SERI_NO,
         va.platform,
         va.id VA_ID,
         fp.expect EXPECT,
         CASE
           WHEN fp.expect_unit = 0 THEN
            2
           WHEN fp.expect_unit = 1 THEN
            1
         END EXPECT_UNIT_CODE,
         null REINVEST_TYPE,
         null REINVEST_EXPECT,
         null REINVEST_EXPECT_UNIT_CODE,
         null REINVEST_STATUS,
         null NEXT_VA_ID,
         'current' DATA_STATE
    from odsopr.invt_stage_quit_form_hist qf
    join ods.t_vip_account_hist va
      on qf.va_id = va.id
     and qf.scope = 26
     and qf.quit_mode <> 2
     and qf.quit_status = 2
    JOIN ods.t_finance_plan_hist fp
      ON va.fp_id = fp.id
    LEFT JOIN ods.t_finance_plan_scope_hist fps
      ON fp.scope = fps.id
    left join ods.t_invt_trd_order_hist ito
      on va.trans_id = ito.trans_id
     and va.trans_id not like 'php%';