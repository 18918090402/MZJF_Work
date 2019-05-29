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
      --2-出借
      select ""                             as version,             --接口版本号
             "CERT20190411026"              as sourceCode,          --平台编号
             isa.trans_id                   as transId,             --网贷机构交易流水号
             t.bo_id                        as sourceProductCode,   --散标信息编号
             concat(bpc.loan_use_name,
                    "需",
                    bo_finish_price,
                    "元")                   as sourceProductName,   --散标名称
             t.id                           as finClaimId,          --债权编号
             -1                             as transferId,          --转让信息编号
             -1                             as replanId,            --还款计划编号
             "2-出借"                       as transType,           --交易类型
             cast(t.price as decimal(38,2)) as transMoney,          --交易金额（元）
             certIdcardHash(ui.id_num)      as userIdcardHash,      --交易主体证件号hash 值
             t.create_time                  as transTime,           --交易发生时间
             ""                             as batchnum,            --批次号
             ""                             as sendtime             --发送时间
        from odsopr.debt_exchange_account_20190430 t 
   left join odsopr.invt_seri_auth_link isa
          on isa.seri_no = t.seri_no
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from ods.t_acc_p2p_hist 
             ) ui 
          on ui.user_id = t.user_id
   left join (
                  select bo_id, bo_purpose, 
                         cast(cast(bo_finish_price as decimal(38,2)) as string) bo_finish_price
                    from idw.fact_borrows 
             ) bo 
          on bo.bo_id = t.bo_id 
   left join msc.bo_purpose_category bpc          --"借款用途"需“借款金额”元
          on bpc.bo_purpose = bo.bo_purpose   
       where t.price > 0 
         and t.bank_flag = 1      --存管
       
       union all 
             
      --1-放款
      select ""                                          as version,
             "CERT20190411026"                           as sourceCode,
             br.id                                       as transId,             -- ?? 待确认
             br.bo_id                                    as sourceProductCode,
             concat(bpc.loan_use_name,                   
                    "需",                                
                    bo_finish_price,                     
                    "元")                                as sourceProductName,   --散标名称
             -1                                          as finClaimId,
             -1                                          as transferId,
             br.id                                       as replanId,
             "1-放款"                                    as transType,
             cast(br.br_price_b as decimal(38,2))        as transMoney,
             certIdcardHash(ui.id_num)                   as userIdcardHash,
             br.create_time                              as transTime,           --??待确认
             ""                                          as batchnum,            --批次号
             ""                                          as sendtime             --发送时间
        from odsopr.borrows_repayment br 
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
                      from ods.t_acc_p2p_hist 
             ) ui 
          on ui.user_id = bo.user_id
       where br.br_repay_time is null 
         and exists(select 1 from odsopr.debt_exchange_account_20190430 t where t.price > 0 and t.bank_flag = 1 and t.bo_id = br.bo_id) 
    
    union all 
       
      --4-借款服务费
      select ""                                                                              as version,
             "CERT20190411026"                                                               as sourceCode,
             br.id                                                                           as transId,             -- ?? 待确认
             br.bo_id                                                                        as sourceProductCode,
             concat(bpc.loan_use_name,                                                       
                    "需",                                                                    
                    bo_finish_price,                                                         
                    "元")                                                                    as sourceProductName,   --散标名称
             -1                                                                              as finClaimId,
             -1                                                                              as transferId,
             br.id                                                                           as replanId,
             "4-借款服务费"                                                                  as transType,
             cast(br.br_price+br.price_return-br.br_price_b-br.br_price_l  as decimal(38,2)) as transMoney,          --?? 待确认
             certIdcardHash(ui.id_num)                                                       as userIdcardHash,
             br.br_time                                                                      as transTime,           --?? 待确认
             ""                                                                              as batchnum,            --批次号
             ""                                                                              as sendtime             --发送时间             
        from odsopr.borrows_repayment br 
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
                      from ods.t_acc_p2p_hist 
             ) ui 
          on ui.user_id = bo.user_id
       where br.br_repay_time is null
         and exists(select 1 from odsopr.debt_exchange_account_20190430 t where t.price > 0 and t.bank_flag = 1 and t.bo_id = br.bo_id) 
    
    union all 
    
    --代偿-未归还
      select "" as version,
             "CERT20190411026" as sourceCode,
             t.id as transId,  
             t.bo_id as sourceProductCode,
             concat(bpc.loan_use_name,                                                       
                    "需",                                                                    
                    bo_finish_price,                                                         
                    "元") as sourceProductName,
             -1 as finClaimId,
             -1 as transferId, 
             -1 as replanId,
             "37-代偿金额–逾期平台代偿" as transType,
             cast(t.bg_price as decimal(38,2)) as transMoney, 
             certIdcardHash(ui.id_num) as userIdcardHash,
             t.bg_time as transTime,
             "" as batchnum,
             "" as sendtime
        from odsopr.borrows_guarantee t
   left join (
                  select bo_id, bo_purpose, user_id, bo_success_time,
                         cast(cast(bo_finish_price as decimal(38,2)) as string) bo_finish_price
                    from idw.fact_borrows 
             ) bo 
          on bo.bo_id = t.bo_id
   left join msc.bo_purpose_category bpc          --"借款用途"需“借款金额”元
          on bpc.bo_purpose = bo.bo_purpose
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from ods.t_acc_p2p_hist 
             ) ui 
          on ui.user_id = t.user_id          
       where t.bg_returned_time is null
         and not exists(select 1 from msc.tmp_history_debt b where b.id = t.br_id)
    ;
    
    
    
    
    
    
 --确认 ?? 
    create view msc.tmp_history_debt
    as 
    select t.id from odsopr.borrows_repayment t 
    inner join ( select distinct bo_id, plan_time from odsopr.invt_history_debt_info where is_transfer = 1 ) b 
    on b.bo_id = t.bo_id 
    and b.plan_time = t.br_time  ;
    