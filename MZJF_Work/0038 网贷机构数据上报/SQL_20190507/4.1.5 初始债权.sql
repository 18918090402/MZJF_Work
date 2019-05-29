
--4.1.5 初始债权

set mapreduce.job.name = pdw_report_05_creditor; 
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




        insert overwrite table pdw.report_05_creditor
        SELECT ""                                      as version,              --接口版本号
               "CERT20190411026"                       as sourceCode,           --平台编号
               t.id                                    as finClaimId,           --初始债权编号
               t.bo_id                                 as sourceProductCode,    --散标信息编号
               certIdcardHash(ui.id_num)               as userIdcardHash,       --出借用户证件号hash值
               cast(t.price as decimal(38,2))          as invAmount,            --出借金额(元)
               coalesce(bp.bp_rate_lender, bo.bo_rate) as invRate,              --出借预期年化利率
               t.create_time                           as invTime,              --出借计息时间
               0                                       as redpackage,           --出借红包（满减）（元）
               t.create_time                           as lockTime,             --锁定截止时间
               ""                                      as batchnum,             --批次号
               ""                                      as sendtime              --发送时间
          FROM odsopr.debt_exchange_account_20190430 t 
     LEFT JOIN idw.fact_borrows bo
            ON t.bo_id = bo.bo_id
     left join odsopr.borrows_prepare bp
            on bo.bp_id = bp.id
     left join (
                    SELECT owner_id as user_id,
                           id_card as id_num
                      from ods.t_acc_p2p_hist 
               ) ui 
            on ui.user_id = t.user_id
         where t.price > 0 
           and t.bank_flag = 1         --存管
           and t.status in (1, 2, 3)   --1:持有中 2：债转中 3：还款中
;


