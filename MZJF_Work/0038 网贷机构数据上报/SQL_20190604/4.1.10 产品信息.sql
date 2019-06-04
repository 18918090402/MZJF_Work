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
         select version,
                sourceCode,
                sourceFinancingCode,
                financingStartTime,
                productName,
                rate,
                minRate,
                maxRate,
                term,
                batchnum,
                sendtime
           from 
                (
                    SELECT "" as version,
                           "CERT20190411026" as sourceCode,
                           concat("FP", cast(fp.id as string)) as sourceFinancingCode,
                           fp.publish_date as financingStartTime,
                           fp.title as productName,
                           case when fp.scope in (0, 1, 11, 29) then fp.rate_min/100    --printf("%.6f", fp.rate_min / 100)
                                when fp.scope in (26, 15, 28)   then -1 
                           end as rate,
                           case when fp.scope in (0, 1, 11, 29) then -1 
                                when fp.scope in (26, 15, 28)   then fp.rate_min/100    --printf("%.6f", fp.rate_min / 100)
                           end as minRate,
                           case when fp.scope in (0, 1, 11, 29) then -1 
                                when fp.scope in (26, 15, 28)   then fp.rate_max/100    --printf("%.6f", fp.rate_max / 100)
                           end as maxRate,
                           case when fp.expect_unit = 0 then fp.expect * 30 else fp.expect end as term,
                           "" as batchnum,
                           "" as sendtime
                      from msc.tmp_debt_exchange_account_20190430 t
                 left join odsopr.vip_account va 
                        on va.id = t.va_id
                 left join odsopr.finance_plan fp 
                        on fp.id = va.fp_id 
                     where t.va_id > 0
                ) t 
         group by version,sourceCode,sourceFinancingCode,financingStartTime,productName,rate,
                  minRate,maxRate,term,batchnum,sendtime 

        
        union all 
        
      --诺诺盈
         select version,
                sourceCode,
                sourceFinancingCode,
                financingStartTime,
                productName,
                rate,
                minRate,
                maxRate,
                term,
                batchnum,
                sendtime
           from 
                (      
      select ""                                                    as version,
             "CERT20190411026"                                     as sourceCode,
             concat("NN", cast(bo.id as string))                   as sourceFinancingCode,
             bo.publish_time                                       as financingStartTime,
             concat("诺诺盈",                                      
                    cast(bo.id as string))                         as productName,
             bp.bp_rate_lender / 100                               as rate,
             bp.bp_rate_lender / 100                               as minRate,
             bp.bp_rate_lender / 100                               as maxRate,
             case when bo.bo_expect_cat = 2 then bo.bo_expect * 30 else bo.bo_expect end as term,
             ""                                                    as batchnum,
             ""                                                    as sendtime
        from msc.tmp_debt_exchange_account_20190430 t
   left join odsopr.borrows bo 
          on bo.id = t.bo_id
   left join odsopr.borrows_prepare bp
          on bo.bp_id = bp.id
  inner join (
                  select distinct t.bo_id 
                    from msc.tmp_debt_exchange_account_20190430 t 
                   where t.va_id = 0
             ) t1
          on t1.bo_id = bo.id 
                ) t 
         group by version,sourceCode,sourceFinancingCode,financingStartTime,productName,rate,
                  minRate,maxRate,term,batchnum,sendtime 
    
   ;





--中转 处理6位精度   impala 

insert overwrite table msc.report_10_lendproduct
   SELECT version
           ,sourcecode
           ,sourcefinancingcode
           ,financingstarttime
           ,productname
           ,case when length(rate) = 3 then concat(rate, "00000") 
                 when length(rate) = 4 then concat(rate, "0000") 
                 when length(rate) = 5 then concat(rate, "000") 
                 when length(rate) = 6 then concat(rate, "00") 
                 when length(rate) = 2 then rate 
            end as rate
           ,case when length(minrate) = 3 then concat(minrate, "00000") 
                 when length(minrate) = 4 then concat(minrate, "0000") 
                 when length(minrate) = 5 then concat(minrate, "000") 
                 when length(minrate) = 6 then concat(minrate, "00") 
                 when length(minrate) = 2 then minrate 
            end as minrate
           ,case when length(maxrate) = 3 then concat(maxrate, "00000") 
                 when length(maxrate) = 4 then concat(maxrate, "0000") 
                 when length(maxrate) = 5 then concat(maxrate, "000") 
                 when length(maxrate) = 6 then concat(maxrate, "00") 
                 when length(maxrate) = 2 then maxrate 
            end as maxrate            
           ,term
           ,batchnum
           ,sendtime
      from pdw.report_10_lendproduct 
;




insert overwrite table pdw.report_10_lendproduct
select * from msc.report_10_lendproduct ;



