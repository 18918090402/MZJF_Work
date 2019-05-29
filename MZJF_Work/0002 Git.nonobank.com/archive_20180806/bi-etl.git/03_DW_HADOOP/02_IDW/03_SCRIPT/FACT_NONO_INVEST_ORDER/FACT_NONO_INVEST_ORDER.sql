set mapreduce.job.name = idw_fact_nono_invest_order_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_NONO_INVEST_ORDER partition
  (DATA_STATE)
  SELECT vf.id INVEST_SRC_ID, -- 精选
         'vip_form' INVEST_SRC_TAB,
         vf.user_id USER_ID,
         vf.fp_id FP_KEY,
         vf.fp_id FP_ID,
         NULL BO_ID,
         null DT_ID,
         fp.scope CATEGORY_CODE_02,
         fps.label CATEGORY_NAME_02,
         vf.service_time INVEST_TIME,
         vf.amount_payed INVEST_AMT,
         fp.expect EXPECT,
         CASE
           WHEN fp.expect_unit = 0 THEN
            2
           WHEN fp.expect_unit = 1 THEN
            1
         END EXPECT_UNIT_CODE,
         fp.start_date LOCK_BEGIN_TIME,
         IF(fp.expect_unit = 0,
            add_months(fp.start_date, fp.expect),
            DATE_ADD(fp.start_date, fp.expect)) LOCK_END_TIME,
         fp.rate_min MIN_RATE,
         fp.rate_max MAX_RATE,
         cp.add_rate ADD_RATE,
         cp.deductible_amt DEDUCTIBLE_AMT,
         CAST(vf.terminal AS STRING) TERMINAL_CODE,
         CASE
           WHEN vf.service_status = 1 THEN
            2
           WHEN vf.service_status = 2 THEN
            4
           ELSE
            vf.service_status
         END STATUS,
         3 INVEST_TYPE_CODE,
         null REMARK,
         CONCAT_WS('_',
                   '02',
                   CAST(vf.user_id AS STRING),
                   CAST(vf.fp_id AS STRING)) INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when fp.scope in (15, 26) then
            vf.amount_payed * 1 / 12
           when fp.expect_unit = 1 then
            vf.amount_payed * fp.expect / 365
           when fp.expect_unit = 0 then
            vf.amount_payed * fp.expect / 12
         end INVEST_AMT_YEARLY,
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
         vf.PLATFORM,
         'current' DATA_STATE
    FROM ods.t_vip_form_hist vf
    LEFT JOIN ods.t_finance_plan_hist fp
      ON vf.fp_id = fp.id
    LEFT JOIN ods.t_finance_plan_scope_hist fps
      ON fp.scope = fps.id
    LEFT JOIN (SELECT cu.bb_id id,
                      SUM(CASE
                            WHEN uc.type = 1 THEN
                             uc.value
                            ELSE
                             0
                          END) add_rate,
                      SUM(CASE
                            WHEN uc.type = 0 THEN
                             uc.value
                            ELSE
                             0
                          END) deductible_amt
                 FROM ods.t_coupon_use_hist cu
                 JOIN ods.t_db_nono_user_coupon_hist uc
                   ON cu.uv_id = uc.id
                  AND uc.is_used = 1
                GROUP BY cu.bb_id) cp
      ON vf.id = cp.id
    left join ods.t_invt_trd_order_hist ito
      on vf.trans_id = ito.trans_id
   where vf.fp_id is not null
  union all
  SELECT bd.id INVEST_SRC_ID, -- 散投
         'borrows_bidding' INVEST_SRC_TAB,
         bd.user_id USER_ID,
         NULL FP_KEY,
         NULL FP_ID,
         bd.bo_id BO_ID,
         NULL DT_ID,
         NULL CATEGORY_CODE_02,
         NULL CATEGORY_NAME_02,
         bd.pay_time INVEST_TIME,
         bd.price_in INVEST_AMT,
         bo.bo_expect EXPECT,
         bo.bo_expect_cat EXPECT_UNIT_CODE,
         to_date(bo.bo_agree_time) LOCK_BEGIN_TIME,
         CASE
           WHEN bo_expect_cat = 1 THEN
            to_date(DATE_ADD(bo.bo_agree_time, bo.bo_expect))
           WHEN bo_expect_cat = 2 THEN
            to_date(add_months(bo.bo_agree_time, bo.bo_expect))
           ELSE
            to_date(add_months(bo.bo_agree_time, bo.bo_expect * 12))
         END LOCK_END_TIME,
         coalesce(bp.bp_rate_lender, bo.bo_rate) MIN_RATE,
         coalesce(bp.bp_rate_lender, bo.bo_rate) MAX_RATE,
         null ADD_RATE,
         null DEDUCTIBLE_AMT,
         cast(bd.terminal as string) TERMINAL_CODE,
         bd.status STATUS,
         1 INVEST_TYPE_CODE,
         bd.reason REMARK,
         concat_ws('_',
                   '01',
                   cast(bd.user_id as string),
                   cast(bd.bo_id as string)) INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when bo.bo_expect_cat = 1 -- 日
            then
            bd.price_in * bo.bo_expect / 365
           when bo.bo_expect_cat = 2 -- 月
            then
            bd.price_in * bo.bo_expect / 12
           when bo.bo_expect_cat = 3 -- 年
            then
            bd.price_in * bo.bo_expect
         end INVEST_AMT_YEARLY,
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
         'current' DATA_STATE
    FROM ods.t_borrows_bidding_hist bd
    LEFT JOIN ods.t_borrows_hist bo
      ON bd.bo_id = bo.id
    left join ods.t_borrows_prepare_hist bp
      on bo.bp_id = bp.id
    left join ods.t_invt_trd_order_hist ito
      on bd.trans_id = ito.trans_id
   WHERE bd.is_vip = 0
  union all
  SELECT dbl.id INVEST_SRC_ID, -- 债转
         'debt_buy_log' INVEST_SRC_TAB,
         dbl.user_id USER_ID,
         NULL FP_KEY,
         NULL FP_ID,
         dbl.bo_id BO_ID,
         NULL DT_ID,
         NULL CATEGORY_CODE_02,
         NULL CATEGORY_NAME_02,
         dbl.pay_time INVEST_TIME,
         dbl.price INVEST_AMT,
         ds.expect EXPECT,
         bo.bo_expect_cat EXPECT_UNIT_CODE,
         CASE
           WHEN bo.bo_expect_cat = 1 THEN
            to_date(DATE_ADD(bo.bo_agree_time, bo.bo_expect - ds.expect))
           WHEN bo.bo_expect_cat = 2 THEN
            to_date(add_months(bo.bo_agree_time, bo.bo_expect - ds.expect))
           ELSE
            to_date(add_months(bo.bo_agree_time,
                               (bo.bo_expect - ds.expect) * 12))
         END LOCK_BEGIN_TIME,
         CASE
           WHEN bo.bo_expect_cat = 1 THEN
            to_date(DATE_ADD(bo.bo_agree_time, bo.bo_expect))
           WHEN bo.bo_expect_cat = 2 THEN
            to_date(add_months(bo.bo_agree_time, bo.bo_expect))
           ELSE
            to_date(add_months(bo.bo_agree_time, bo.bo_expect * 12))
         END LOCK_END_TIME,
         coalesce(bp.bp_rate_lender, bo.bo_rate) MIN_RATE,
         coalesce(bp.bp_rate_lender, bo.bo_rate) MAX_RATE,
         null ADD_RATE,
         null DEDUCTIBLE_AMT,
         cast(dbl.terminal as string) TERMINAL_CODE,
         case
           when dbl.status = 1 then
            2
           when dbl.status = 2 then
            0
           else
            dbl.status
         end STATUS,
         2 INVEST_TYPE_CODE,
         null REMARK,
         concat_ws('_',
                   '01',
                   cast(dbl.user_id as string),
                   cast(dbl.bo_id as string)) INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when bo.bo_expect_cat = 1 -- 日
            then
            dbl.price * ds.expect / 365
           when bo.bo_expect_cat = 2 -- 月
            then
            dbl.price * ds.expect / 12
           when bo.bo_expect_cat = 3 -- 年
            then
            dbl.price * ds.expect
         end INVEST_AMT_YEARLY,
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
         'current' DATA_STATE
    FROM ods.t_debt_buy_log_hist dbl
    LEFT JOIN ods.t_debt_sale_hist ds
      ON dbl.ds_id = ds.id
    LEFT JOIN ods.t_borrows_hist bo
      ON dbl.bo_id = bo.id
    left join ods.t_borrows_prepare_hist bp
      on bo.bp_id = bp.id
    left join ods.t_invt_trd_order_hist ito
      on dbl.trans_id = ito.trans_id
   WHERE dbl.p_type = 3
     AND dbl.va_id = 0;

set mapreduce.job.name = idw_fact_nono_invest_order_curing;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_NONO_INVEST_ORDER partition
  (DATA_STATE)
  SELECT vf.id INVEST_SRC_ID, -- e诺千金
         'vip_form' INVEST_SRC_TAB,
         vf.user_id USER_ID,
         null FP_KEY,
         null FP_ID,
         null BO_ID,
         vf.dt_id DT_ID,
         null CATEGORY_CODE_02,
         null CATEGORY_NAME_02,
         vf.service_time INVEST_TIME,
         vf.amount_payed INVEST_AMT,
         dt.dt_expect EXPECT,
         case
           when vf.dt_id IS NOT NULL THEN
            2
         end EXPECT_UNIT_CODE,
         dt.dt_valid_time LOCK_BEGIN_TIME,
         add_months(dt.dt_valid_time, dt.dt_expect) LOCK_END_TIME,
         dt.dt_rate MIN_RATE,
         dt.dt_rate MAX_RATE,
         null ADD_RATE,
         null DEDUCTIBLE_AMT,
         CAST(vf.terminal AS STRING) TERMINAL_CODE,
         CASE
           WHEN vf.service_status = 1 THEN
            2
           WHEN vf.service_status = 2 THEN
            4
           ELSE
            vf.service_status
         END STATUS,
         case
           when vf.dt_id IS NOT NULL THEN
            4
           ELSE
            99
         END INVEST_TYPE_CODE,
         null REMARK,
         case
           when vf.dt_id IS NOT NULL THEN
            CONCAT_WS('_',
                      '03',
                      CAST(vf.user_id AS STRING),
                      CAST(vf.dt_id AS STRING))
         end INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         vf.amount_payed * dt.dt_expect / 12 INVEST_AMT_YEARLY,
         'NA' TRANS_ID,
         'NA' SERI_NO,
         vf.PLATFORM,
         'curing' DATA_STATE
    FROM ods.t_vip_form_hist vf
    LEFT JOIN ods.t_debt_transfer_hist dt
      ON dt.id = vf.dt_id
   where vf.fp_id is null
  union all
  SELECT ff.id INVEST_SRC_ID, -- 诺诺钱包
         'fund_form' INVEST_SRC_TAB,
         ff.user_id USER_ID,
         null FP_KEY,
         null FP_ID,
         NULL BO_ID,
         NULL DT_ID,
         null CATEGORY_CODE_02,
         null CATEGORY_NAME_02,
         ff.ff_service_time INVEST_TIME,
         ff.ff_amount_payed INVEST_AMT,
         null EXPECT,
         null EXPECT_UNIT_CODE,
         null LOCK_BEGIN_TIME,
         null LOCK_END_TIME,
         cp.annualrate MIN_RATE,
         cp.annualrate MAX_RATE,
         null ADD_RATE,
         null DEDUCTIBLE_AMT,
         cast(ff.qudao as string) TERMINAL_CODE,
         case
           when ff.ff_service_status = 1 then
            2
           when ff.ff_service_status = 2 then
            4
           else
            ff.ff_service_status
         end STATUS,
         5 INVEST_TYPE_CODE,
         null REMARK,
         null INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         null INVEST_AMT_YEARLY,
         'NA' TRANS_ID,
         'NA' SERI_NO,
         1 PLATFORM,
         'curing' DATA_STATE
    FROM ods.t_fund_form_hist ff
    JOIN ods.t_csyy_plan_hist cp
      ON ff.csyy_serial_number = cp.serial_number;