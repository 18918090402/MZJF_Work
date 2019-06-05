
--4.1.5 初始债权


----
drop table if exists msc.tmp_debt_operation_log ;

create table msc.tmp_debt_operation_log 
as 
SELECT t.bo_id, t.dea_id, sum(t.trans_price) trans_price
FROM odsopr.invt_debt_operation_log t 
left join odsopr.invt_receipt_msg a 
on a.trans_id = t.trans_id
where t.trans_type = 7    --收款
and t.status = 10         --处理成功
and to_date(a.create_time) <= '2019-04-30'    --bo表0430前还款
and to_date(t.update_time) > '2019-04-30'     --dea表0430后扣减
GROUP BY 1 ,2 
ORDER BY 2 
;




drop table if exists msc.tmp_debt_exchange_account_20190430 ;

create table msc.tmp_debt_exchange_account_20190430 
as 
select t.id, t.user_id, t.bo_id, t.va_id, t.seri_no, t.price, t.create_time, a.dea_id, a.trans_price
from odsopr.debt_exchange_account_20190430 t 
left join msc.tmp_debt_operation_log a     --20190517 增加 0430前还款， 0430后扣减债权
on a.dea_id = t.id 
where t.price >= 0.01 
and t.bank_flag = 1         --存管
and t.status in (1, 2, 3)   --1:持有中 2：债转中 3：还款中
and exists( select 1 from pdw.report_02_scatterinvest z where z.sourceProductCode = cast(t.bo_id as string) ) 
-----and exists(select 1 from msc.tmp_userinfo_20190520 x where x.user_id = t.user_id) 
;





--
drop view if exists pdw.tmp_acc_p2p_20190507 ;

CREATE view pdw.tmp_acc_p2p_20190507
as 
SELECT id, owner_id, name, account_no, account_type,
       id_card, mobile, bank_card, create_time, update_time
  from msc.tmp_acc_p2p_20190507     --ods.t_acc_p2p_hist 
 where account_type = "user" 
   and id <> 965212
   --and owner_id = 1209336 
   UNION all 
select 965212 id,1209336 owner_id,"卫勇兴" name,"9930040090019649047" account_no,"user" account_type,
       "411202199703041514" id_card,"13253973087" mobile,NULL bank_card,"2017-06-01 14:55:14.0" create_time,"2017-06-01 14:55:14.0" update_time
;





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
     left join odsopr.borrows_prepare bp
            on bo.bp_id = bp.id
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
;

