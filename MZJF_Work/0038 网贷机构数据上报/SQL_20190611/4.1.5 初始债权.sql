
--4.1.5 初始债权


----impala
drop table if exists msc.tmp_debt_operation_log ;

create table msc.tmp_debt_operation_log 
as 
    SELECT irm.bo_id, dea.id, sum(ibau.price_principal) trans_price
      from pdw.invt_receipt_msg_reportbak20190610 irm 
 LEFT JOIN pdw.invt_borrows_accept_unpaid_reportbak20190610 ibau
        on ibau.bo_id = irm.bo_id 
       and ibau.plan_time = irm.plan_time
 LEFT JOIN pdw.debt_exchange_account_reportbak20190610 dea 
        on dea.bo_id = ibau.bo_id 
       and ibau.seri_no = dea.seri_no
     WHERE irm.status < 85 
       and ibau.is_pay <> 1 
       and dea.bank_flag = 1
  GROUP BY irm.bo_id,
           dea.id
;




drop table if exists msc.tmp_debt_exchange_account_20190430 ;

create table msc.tmp_debt_exchange_account_20190430 
as 
select t.id, t.user_id, t.bo_id, t.va_id, t.seri_no, t.price, t.create_time, a.id dea_id, a.trans_price
from pdw.debt_exchange_account_reportbak20190610 t 
left join msc.tmp_debt_operation_log a     --20190517 增加 0610前还款， 0610后扣减债权
on a.id = t.id 
where t.price >= 0.01 
and t.bank_flag = 1         --存管
and t.status in (1, 2, 3)   --1:持有中 2：债转中 3：还款中
and exists( select 1 from pdw.report_02_scatterinvest z where z.sourceProductCode = cast(t.bo_id as string) ) 
;





-- hive 
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
select t.*,
       row_number() over(order by t.userIdcardHash) id,
       "1" batch_type
from (
        SELECT ""                                                                        as version,              --接口版本号
               "CERT20190411026"                                                         as sourceCode,           --平台编号
               t.id                                                                      as finClaimId,           --初始债权编号
               t.bo_id                                                                   as sourceProductCode,    --散标信息编号
               certIdcardHash(coalesce(ui.id_num, uh.id_num))                            as userIdcardHash,       --出借用户证件号hash值
               case when t.dea_id is not null 
                    then printf("%.2f", (t.price-t.trans_price) * 1.0) 
                    else printf("%.2f", t.price * 1.0) end                               as invAmount,            --出借金额(元)
               printf("%.6f", coalesce(bp.bp_rate_lender, bo.bo_rate) / 100 * 1.0)       as invRate,              --出借预期年化利率
               t.create_time                                                             as invTime,              --出借计息时间
               printf("%.2f", 0 * 1.0)                                                   as redpackage,           --出借红包（满减）（元）
               t.create_time                                                             as lockTime,             --锁定截止时间
               ""                                                                        as batchnum,             --批次号
               ""                                                                        as sendtime              --发送时间
          FROM msc.tmp_debt_exchange_account_20190430 t 
     LEFT JOIN idw.fact_borrows bo
            ON t.bo_id = bo.bo_id
     left join odsopr.borrows_prepare_reportbak20190610 bp
            on bo.bp_id = bp.id
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
) t ;

