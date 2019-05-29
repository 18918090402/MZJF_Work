--4.1.11 产品配置   
set mapreduce.job.name = pdw_report_11_lendproductconfig; 
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



      insert overwrite table pdw.report_11_lendproductconfig
      --计划类
      select "" as version,
             "CERT20190411026" as sourcecode,
             t.seri_no as configId,
             t.id as finclaimid,
             concat("FP", cast(fp.id as string)) as sourceFinancingCode,
             certIdcardHash(ui.id_num) as useridcardhash,
             "" as batchnum,
             "" as sendtime
        from odsopr.debt_exchange_account_20190430 t 
   left join odsopr.vip_account va 
          on va.id = t.va_id
   left join odsopr.finance_plan fp 
          on fp.id = va.fp_id 
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from ods.t_acc_p2p_hist 
             ) ui 
          on ui.user_id = t.user_id
   left join odsopr.invt_seri_auth_link isa 
          on isa.seri_no = t.seri_no
   left join odsopr.debt_buy_log dbl 
          on dbl.trans_id = isa.trans_id
       where t.price > 0 
         and t.bank_flag = 1
         and t.status in (1, 2, 3)
         and t.va_id > 0 

       
       union all 
      
      --诺诺盈
      select "" as version,
             "CERT20190411026" as sourcecode,
             t.seri_no as configId,
             t.id as finclaimid,
             concat("NN", cast(bo.id as string)) as sourceFinancingCode,
             certIdcardHash(ui.id_num) as useridcardhash,
             "" as batchnum,
             "" as sendtime
        from odsopr.debt_exchange_account_20190430 t 
   left join odsopr.borrows bo 
          on bo.id = t.bo_id
   left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from ods.t_acc_p2p_hist 
             ) ui 
          on ui.user_id = t.user_id
   left join odsopr.invt_seri_auth_link isa 
          on isa.seri_no = t.seri_no
   left join odsopr.debt_buy_log dbl 
          on dbl.trans_id = isa.trans_id          
       where t.price > 0 
         and t.bank_flag = 1
         and t.status in (1, 2, 3)
         and t.va_id = 0 
; 
