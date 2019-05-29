--4.1.10 产品信息  
set mapreduce.job.name = pdw_report_10_lendproduct; 
set mapreduce.job.queuename = etl-dw;  
set hive.exec.parallel = true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict; 
set hive.exec.max.dynamic.partitions.pernode = 100000000;
set hive.exec.max.dynamic.partitions = 100000000;
set hive.exec.max.created.files = 100000000;




      insert overwrite table pdw.report_10_lendproduct
      --计划类
        select version,sourceCode,sourceFinancingCode,financingStartTime,productName,rate,
                  minRate,maxRate,term,batchnum,sendtime
            from 
                (
                    SELECT "" as version,
                           "CERT20190411026" as sourceCode,
                           fp.id as sourceFinancingCode,
                           fp.publish_date as financingStartTime,
                           fp.title as productName,
                           case when fp.scope in (0, 1, 11, 29) then cast(fp.rate_min as DECIMAL(38,6)) 
                                when fp.scope in (26, 15, 28)   then -1 
                           end as rate,
                           case when fp.scope in (0, 1, 11, 29) then -1 
                                when fp.scope in (26, 15, 28)   then cast(fp.rate_min as DECIMAL(38,6)) 
                           end as minRate,
                           case when fp.scope in (0, 1, 11, 29) then -1 
                                when fp.scope in (26, 15, 28)   then cast(fp.rate_max as DECIMAL(38,6)) 
                           end as maxRate,
                           case when fp.expect_unit = 0 then fp.expect * 30 else fp.expect end as term,
                           "" as batchnum,
                           "" as sendtime
                      from odsopr.vip_account va 
                      join odsopr.finance_plan fp 
                        on fp.id = va.fp_id 
                     where (va.is_cash = 0 or (va.is_cash = 1 and to_date(va.cash_time) >= '2019-05-01')) 
                       and to_date(va.create_time) <= '2019-04-30' 
                ) t 
         group by version,sourceCode,sourceFinancingCode,financingStartTime,productName,rate,
                  minRate,maxRate,term,batchnum,sendtime          

        
        union all 
        
      --诺诺盈
      select ""                                       as version,
             "CERT20190411026"                        as sourceCode,
             bo.id                                    as sourceFinancingCode,
             bo.publish_time                          as financingStartTime,
             concat("诺诺盈", 
                    cast(bo.id as string))            as productName,
             cast(bp.bp_rate_lender as decimal(38,6)) as rate,
             cast(bp.bp_rate_lender as decimal(38,6)) as minRate,
             cast(bp.bp_rate_lender as decimal(38,6)) as maxRate,
             case when bo.bo_expect_cat = 2 then bo.bo_expect * 30 else bo.bo_expect end as term,
             ""                                       as batchnum,
             ""                                       as sendtime             
        from odsopr.borrows bo 
   left join odsopr.borrows_prepare bp
          on bo.bp_id = bp.id
  inner join odsopr.debt_exchange_account_20190430 t 
          on bo.id = t.bo_id
         and t.price > 0 
         and t.bank_flag = 1 
         and t.va_id = 0
   ;
