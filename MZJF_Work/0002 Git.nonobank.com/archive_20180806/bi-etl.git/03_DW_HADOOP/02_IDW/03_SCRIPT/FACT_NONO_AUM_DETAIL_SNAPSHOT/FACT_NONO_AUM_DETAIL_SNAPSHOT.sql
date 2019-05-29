set mapreduce.job.name = idw_fact_nono_aum_detail_snapshot_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table idw.FACT_NONO_AUM_DETAIL_SNAPSHOT partition
  (STAT_DATE)
  select ic.user_id USER_ID,
         ic.fp_key FP_KEY,
         ic.fp_id FP_ID,
         ic.bo_id BO_ID,
         ic.dt_id DT_ID,
         ic.invest_type_code INVEST_TYPE_CODE,
         ic.category_code_02 CATEGORY_CODE_02,
         ic.category_name_02 CATEGORY_NAME_02,
         io.invest_amt INVEST_AMT,
         ic.aum AUM,
         ic.invest_relation_no INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         case
           when ic.INVEST_TYPE_CODE in (1, 2) then
            ic.aum
           else
            if(ii.in_invest_amt > ic.aum, ic.aum, ii.in_invest_amt)
         end in_invest_amt,
         ic.trans_id,
         ic.seri_no,
         ic.platform,
         case
           when ic.INVEST_TYPE_CODE = 1 then
            '散投'
           when ic.INVEST_TYPE_CODE = 2 then
            '债转'
           when ic.INVEST_TYPE_CODE = 3 then
            CATEGORY_NAME_02
         end PRODUCT_CATEGORY,
         ic.va_id,
         '{T_SUB_1}' STAT_DATE
    from (select user_id,
                 fp_key,
                 fp_id,
                 bo_id,
                 dt_id,
                 invest_type_code,
                 category_code_02,
                 category_name_02,
                 invest_relation_no,
                 sum(price_principal) aum,
                 trans_id,
                 seri_no,
                 platform,
                 va_id
            from IDW.FACT_NONO_INVEST_CASH
           where INVEST_TYPE_CODE in (1, 2, 3)
             and CASH_STATUS = 0
           group by user_id,
                    fp_key,
                    fp_id,
                    bo_id,
                    dt_id,
                    invest_type_code,
                    category_code_02,
                    category_name_02,
                    invest_relation_no,
                    trans_id,
                    seri_no,
                    platform,
                    va_id) ic
    join (select invest_relation_no,
                 trans_id,
                 seri_no,
                 sum(invest_amt) invest_amt
            from IDW.FACT_NONO_INVEST_ORDER
           where INVEST_TYPE_CODE in (1, 2, 3)
             and STATUS in (1, 2)
           group by invest_relation_no, trans_id, seri_no) io
      on ic.invest_relation_no = io.invest_relation_no
     and ic.trans_id = io.trans_id
     and ic.seri_no = io.seri_no
     and ic.aum > 0
    left join (select ba.va_id, sum(price_principal) in_invest_amt
                 from odsopr.borrows_accept ba
                where ba.is_pay = 0
                  and ba.va_id > 0
                group by ba.va_id
               having sum(price_principal) > 0) ii
      on ic.va_id = ii.va_id;

set mapreduce.job.name = idw_fact_nono_aum_detail_snapshot_05;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

-- 诺诺活期
INSERT INTO TMP.TMP_IDW_FACT_NONO_AUM_DETAIL_SNAPSHOT_01 partition
  (STAT_DATE)
  SELECT fl.user_id USER_ID,
         NULL FP_KEY,
         NULL FP_ID,
         NULL BO_ID,
         NULL DT_ID,
         5 INVEST_TYPE_CODE,
         NULL CATEGORY_CODE_02,
         NULL CATEGORY_NAME_02,
         NULL INVEST_AMT,
         fl.balance AUM,
         NULL INVEST_RELATION_NO,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         STAT_DATE         
    FROM (SELECT to_date(fl.create_time) STAT_DATE,
                 fl.user_id,
                 fl.balance,
                 row_number() over(partition by substr(fl.create_time, 1, 10), fl.user_id order by id DESC) as rn
            FROM odsopr.finance_log_all fl
           WHERE fl.operation_relation IN (470, 323)) fl
   where rn = 1;