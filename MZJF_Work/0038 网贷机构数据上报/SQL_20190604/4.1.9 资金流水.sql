--4.1.9 交易流水
set mapreduce.job.name = pdw_report_09_transact; 
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




      insert overwrite table pdw.report_09_transact
      select * from ( 
      --2-出借
      select ""                                                  as version,             --接口版本号
             "CERT20190411026"                                   as sourceCode,          --平台编号
             isa.trans_id                                        as transId,             --网贷机构交易流水号
             t.bo_id                                             as sourceProductCode,   --散标信息编号
             concat(bpc.loan_use_name,                           
                    "需",                                        
                    bo_finish_price,                             
                    "元")                                        as sourceProductName,   --散标名称
             t.id                                                as finClaimId,          --债权编号
             -1                                                  as transferId,          --转让信息编号
             -1                                                  as replanId,            --还款计划编号
             "2"                                                 as transType,           --交易类型
             printf("%.2f", t.price * 1.0)                       as transMoney,          --交易金额（元）
             certIdcardHash(coalesce(ui.id_num, uh.id_num))      as userIdcardHash,      --交易主体证件号hash 值
             t.create_time                                       as transTime,           --交易发生时间
             ""                                                  as batchnum,            --批次号
             ""                                                  as sendtime             --发送时间
        from msc.tmp_debt_exchange_account_20190430 t 
   left join odsopr.invt_seri_auth_link isa
          on isa.seri_no = t.seri_no
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from pdw.tmp_acc_p2p_20190507
                     where account_type = "user" 
             ) ui 
          on ui.user_id = t.user_id
   left join (
                  SELECT id,
                         regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                    FROM ods.t_user_info_hist
             ) uh
          on t.user_id = uh.id
   left join (
                  select bo_id, bo_purpose, 
                         cast(cast(bo_finish_price as decimal(38,2)) as string) bo_finish_price
                    from idw.fact_borrows 
             ) bo 
          on bo.bo_id = t.bo_id 
   left join msc.bo_purpose_category bpc          --"借款用途"需“借款金额”元
          on bpc.bo_purpose = bo.bo_purpose   
       
       union all 
             
      --1-放款
      select ""                                                as version,
             "CERT20190411026"                                 as sourceCode,
             br.bo_id                                          as transId,
             br.bo_id                                          as sourceProductCode,
             concat(bpc.loan_use_name,                         
                    "需",                                      
                    bo_finish_price,                          
                    "元")                                      as sourceProductName,   --散标名称
             -1                                                as finClaimId,
             -1                                                as transferId,
             -1                                                as replanId,
             "1"                                               as transType,
             printf("%.2f", br.br_price_b * 1.0)               as transMoney,
             certIdcardHash(coalesce(ui.id_num, uh.id_num))    as userIdcardHash,
             br.create_time                                    as transTime,           --??待确认
             ""                                                as batchnum,            --批次号
             ""                                                as sendtime             --发送时间
        from (
                  select  br.bo_id                                          
                         ,sum(br.br_price) br_price
                         ,sum(br.price_return) price_return
                         ,sum(br.br_price_b) br_price_b
                         ,sum(br.br_price_l) br_price_l
                         ,max(br.create_time) create_time
                    from odsopr.borrows_repayment br 
                   where ( br.br_repay_time is null or to_date(br.br_repay_time) >= '2019-05-01' )
                     and exists(select 1 from msc.tmp_debt_exchange_account_20190430 t where t.bo_id = br.bo_id) 
                group by br.bo_id
             ) br 
   left join (
                  select bo_id, bo_purpose, user_id, bo_success_time,
                         cast(cast(bo_finish_price as decimal(38,2)) as string) bo_finish_price
                    from idw.fact_borrows 
             ) bo 
          on bo.bo_id = br.bo_id 
   left join msc.bo_purpose_category bpc          --"借款用途"需“借款金额”元
          on bpc.bo_purpose = bo.bo_purpose
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from pdw.tmp_acc_p2p_20190507
                     where account_type = "user" 
             ) ui 
          on ui.user_id = bo.user_id
   left join (
                  SELECT id,
                         regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                    FROM ods.t_user_info_hist
             ) uh
          on bo.user_id = uh.id    
    
    union all 
       
      --4-借款服务费
      select ""                                                                              as version,
             "CERT20190411026"                                                               as sourceCode,
             br.bo_id                                                                        as transId, 
             br.bo_id                                                                        as sourceProductCode,
             concat(bpc.loan_use_name,                                                       
                    "需",                                                                    
                    bo_finish_price,                                                         
                    "元")                                                                    as sourceProductName,   --散标名称
             -1                                                                              as finClaimId,
             -1                                                                              as transferId,
             -1                                                                              as replanId,
             "4"                                                                             as transType,
             printf("%.2f", (br.br_price+br.price_return-br.br_price_b-br.br_price_l) * 1.0) as transMoney,      
             certIdcardHash(coalesce(ui.id_num, uh.id_num))                                  as userIdcardHash,
             create_time                                                                     as transTime, 
             ""                                                                              as batchnum,            --批次号
             ""                                                                              as sendtime             --发送时间             
        from (
                  select  br.bo_id                                          
                         ,sum(br.br_price) br_price
                         ,sum(br.price_return) price_return
                         ,sum(br.br_price_b) br_price_b
                         ,sum(br.br_price_l) br_price_l
                         ,max(br.create_time) create_time
                    from odsopr.borrows_repayment br 
                   where ( br.br_repay_time is null or to_date(br.br_repay_time) >= '2019-05-01' )
                     and exists(select 1 from msc.tmp_debt_exchange_account_20190430 t where t.bo_id = br.bo_id) 
                group by br.bo_id        
             ) br 
   left join (
                  select bo_id, bo_purpose, user_id, bo_success_time,
                         cast(cast(bo_finish_price as decimal(38,2)) as string) bo_finish_price
                    from idw.fact_borrows 
             ) bo 
          on bo.bo_id = br.bo_id 
   left join msc.bo_purpose_category bpc          --"借款用途"需“借款金额”元
          on bpc.bo_purpose = bo.bo_purpose
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from pdw.tmp_acc_p2p_20190507
                     where account_type = "user" 
             ) ui 
          on ui.user_id = bo.user_id
   left join (
                  SELECT id,
                         regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                    FROM ods.t_user_info_hist
             ) uh
          on bo.user_id = uh.id     
    
    union all 
    
    --37-代偿-未归还
      select "" as version,
             "CERT20190411026" as sourceCode,
             br.br_id as transId,
             br.bo_id as sourceProductCode,
             concat(bpc.loan_use_name,                                                       
                    "需",                                                                    
                    bo_finish_price,                                                         
                    "元") as sourceProductName,
             -1 as finClaimId,
             -1 as transferId,
             -1 as replanId,
             "37" as transType,
             printf("%.2f", br.br_price_b * 1.0) as transMoney,
             certIdcardHash(coalesce(ui.id_num, uh.id_num)) as userIdcardHash,
             br.compensate_time as transTime,
             "" as batchnum,
             "" as sendtime
        from (
                  select * from idw.fact_borrows_repayment br
                   where br.br_transfer_fa_id > 0 
                     and (br.br_is_repay = 0 or to_date(br.br_repay_time) >= '2019-05-01') 
                     and not exists(select 1 from msc.tmp_history_debt b where b.id = br.br_id)
             ) br 
   left join (
                select bo_id, bo_purpose, user_id, bo_success_time,
                       cast(cast(bo_finish_price as decimal(38,2)) as string) bo_finish_price
                  from idw.fact_borrows 
             ) bo 
          on bo.bo_id = br.bo_id
   left join msc.bo_purpose_category bpc          --"借款用途"需“借款金额”元
          on bpc.bo_purpose = bo.bo_purpose
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from pdw.tmp_acc_p2p_20190507
                     where account_type = "user" 
             ) ui 
          on ui.user_id = bo.user_id
   left join (
                  SELECT id,
                         regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                    FROM ods.t_user_info_hist
             ) uh
          on bo.user_id = uh.id                 
       where exists( select 1 from pdw.report_02_scatterinvest z where z.sourceProductCode = cast(br.bo_id as string) )    --保持与上报的散标一致 
       ) t 
     where t.transMoney <> '0.00'
      ;
    






    
--  select    820060538.7 - 638036130.33 ;    --182024408.37
    
    
 --确认 ?? 
    drop view if exists msc.tmp_history_debt ;
    
    create view msc.tmp_history_debt
    as 
    select t.id from odsopr.borrows_repayment t 
    inner join ( select distinct bo_id, plan_time from odsopr.invt_history_debt_info where is_transfer = 1 and to_date(update_time) <= '2019-04-30' ) b 
    on b.bo_id = t.bo_id 
    and b.plan_time = t.br_time  
    ; 

