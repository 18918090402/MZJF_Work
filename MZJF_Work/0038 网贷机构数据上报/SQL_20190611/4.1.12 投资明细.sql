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
      select t.* ,
             row_number() over(order by t.sourceFinancingCode) id,
             "1" batch_type
      from (        
      --计划类
      select ""                                                  as version,             --接口版本号
             "CERT20190411026"                                   as sourceCode,          --平台编号
             isa.trans_id                                        as transId,             --网贷机构交易流水号
             concat("FP", cast(fp.id as string))                 as sourceFinancingCode, --产品信息编号
             "2"                                                 as transType,           --交易类型
             printf("%.2f", t.price*1.0)                         as transMoney,          --交易金额（元）
             certIdcardHash(coalesce(ui.id_num, uh.id_num))      as userIdcardHash,      --交易主体证件号 hash 值
             t.create_time                                       as transTime,           --交易发生时间
             ""                                                  as batchnum,
             ""                                                  as sendtime
        from msc.tmp_debt_exchange_account_20190430 t 
   left join odsopr.invt_seri_auth_link isa
          on isa.seri_no = t.seri_no 
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from odsopr.acc_p2p_reportbak20190610
                     where account_type = "user" 
             ) ui 
          on ui.user_id = t.user_id 
   left join (
                  SELECT id,
                         regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                    FROM odsopr.user_info_reportbak20190610
             ) uh
          on t.user_id = uh.id                               
   left join odsopr.vip_account va 
          on va.id = t.va_id 
   left join odsopr.finance_plan fp 
          on fp.id = va.fp_id 
       where t.va_id > 0 
         
         union all 
      
      select ""                                                   as version,             --接口版本号
             "CERT20190411026"                                    as sourceCode,          --平台编号
             isa.trans_id                                         as transId,             --网贷机构交易流水号
             concat("NN", cast(bo.id as string))                  as sourceFinancingCode, --产品信息编号
             "2"                                                  as transType,           --交易类型
             printf("%.2f", t.price*1.0)                          as transMoney,          --交易金额（元）
             certIdcardHash(coalesce(ui.id_num, uh.id_num))       as userIdcardHash,      --交易主体证件号 hash 值
             t.create_time                                        as transTime,           --交易发生时间
             ""                                                   as batchnum,
             ""                                                   as sendtime
        from msc.tmp_debt_exchange_account_20190430 t 
   left join odsopr.invt_seri_auth_link isa 
          on isa.seri_no = t.seri_no    
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from odsopr.acc_p2p_reportbak20190610
                     where account_type = "user" 
             ) ui 
          on ui.user_id = t.user_id
   left join (
                  SELECT id,
                         regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                    FROM odsopr.user_info_reportbak20190610
             ) uh
          on t.user_id = uh.id                               
   left join odsopr.borrows_reportbak20190610 bo 
          on bo.id = t.bo_id
       where t.va_id = 0 
       
       
) t ;


