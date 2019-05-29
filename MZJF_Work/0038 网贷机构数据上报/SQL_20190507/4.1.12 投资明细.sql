--4.1.12 投资明细

set mapreduce.job.name = pdw_report_12_lendparticulars; 
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



      insert overwrite table pdw.report_12_lendparticulars
      --计划类
      select ""                             as version,             --接口版本号
             "CERT20190411026"              as sourceCode,          --平台编号
             isa.trans_id                   as transId,             --网贷机构交易流水号
             fp.id                          as sourceFinancingCode, --产品信息编号
             "2-成功出借金额"               as transType,           --交易类型
             cast(t.price as decimal(38,2)) as transMoney,          --交易金额（元）
             certIdcardHash(ui.id_num)      as userIdcardHash,      --交易主体证件号 hash 值
             t.create_time                  as transTime,           --交易发生时间
             ""                             as batchnum,
             ""                             as sendtime
        from odsopr.debt_exchange_account_20190430 t 
   left join odsopr.invt_seri_auth_link isa
          on isa.seri_no = t.seri_no    
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from ods.t_acc_p2p_hist 
             ) ui 
          on ui.user_id = t.user_id
   left join odsopr.vip_account va 
          on va.id = t.va_id
   left join odsopr.finance_plan fp 
          on fp.id = va.fp_id 
       where t.price > 0 
         and t.bank_flag = 1 
         and t.va_id > 0 
         
         union all 
      --
      select ""                             as version,             --接口版本号
             "CERT20190411026"              as sourceCode,          --平台编号
             isa.trans_id                   as transId,             --网贷机构交易流水号
             bo.id                          as sourceFinancingCode, --产品信息编号
             "2-成功出借金额"               as transType,           --交易类型
             cast(t.price as decimal(38,2)) as transMoney,          --交易金额（元）
             certIdcardHash(ui.id_num)      as userIdcardHash,      --交易主体证件号 hash 值
             t.create_time                  as transTime,           --交易发生时间
             ""                             as batchnum,
             ""                             as sendtime
        from odsopr.debt_exchange_account_20190430 t 
   left join odsopr.invt_seri_auth_link isa
          on isa.seri_no = t.seri_no    
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from ods.t_acc_p2p_hist 
             ) ui 
          on ui.user_id = t.user_id
   left join odsopr.borrows bo 
          on bo.id = t.bo_id
       where t.price > 0 
         and t.bank_flag = 1 
         and t.va_id = 0 
         ;
