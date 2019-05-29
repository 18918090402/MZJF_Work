set mapreduce.job.name = DMT_MXD_FACT_NC_M1_REPAYMENT;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

DROP TABLE IF EXISTS TMP.TMP_DUNNING_BO_ID_M1;
CREATE TABLE TMP.TMP_DUNNING_BO_ID_M1 AS
SELECT a.BO_ID,
       CONCAT(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM'), '-01 06:00:00') as start_time,
       mod_contract,
       MOD_COMPANY_NAME as odc_name,
       mod_start_time
  FROM idw.FACT_BORROWS_DUNNING a
 WHERE (a.mod_contract =
       CONCAT('NC', FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyyMM'), '01') and
       MOD_COMPANY_NAME in ('合肥', '张宸', '岑峰', '华道'))
    or (a.mod_contract =
       CONCAT('MZDEJ', FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyyMM'), '01') and
       MOD_COMPANY_NAME in ('合肥'));

insert overwrite table DMT_MXD.FACT_NC_M1_REPAYMENT partition
  (stat_date)
  SELECT ncm.bo_id, --标ID        
         p.p_name, --产品        
         ui.real_name, --客户姓名        
         overdue_uprepay_price, --逾期总额        
         month_repay_price, --月还款金额        
         unrepay_price_punish, --罚息      
         OVERDUE_UNREPAY_DAYS, --逾期天数
         case
           when a.POSTED_BILL_NUM < 12 then
            a.POSTED_BILL_UNREPAY_AMT + a.PENDING_BILL_UNREPAY_B * 1.06
           when a.POSTED_BILL_NUM >= 12 then
            a.POSTED_BILL_UNREPAY_AMT + a.PENDING_BILL_UNREPAY_B * 1.05
         end SETTLEMENT_SHOULD_REPAY_AMT, --提前结清金额
         last_repay_time, --最近还款日期
         repay_price, --还款金额
         ncm.mod_contract,
         odc_name, --操作人   
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') stat_time, --取数时间        
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') stat_date --分区时间
    FROM TMP.TMP_DUNNING_BO_ID_M1 ncm
   INNER JOIN odsopr.borrows bo
      ON ncm.bo_id = bo.id
    LEFT JOIN odsopr.products p
      ON bo.p_id = p.id
   INNER JOIN idw.dim_user ui
      ON bo.user_id = ui.user_id
    LEFT JOIN (SELECT br.bo_id,
                      MAX(CASE
                            WHEN br.br_repay_time >= trunc('{T}', 'MM') then
                             br.br_repay_time
                          end) last_repay_time, --最近还款日期                     
                      SUM(CASE
                            WHEN br.br_is_repay = 0 AND
                                 DATEDIFF(nvl(br.br_repay_time,
                                              FROM_UNIXTIME(UNIX_TIMESTAMP(),
                                                            'yyyy-MM-dd')),
                                          br.br_time) > 0 THEN
                             br.br_price + br.br_price_punish
                          END) AS overdue_uprepay_price, --逾期总额                     
                      SUM(case
                            when br_expect_num = 1 then
                             br.br_price
                            else
                             0
                          end) AS month_repay_price , --月还款金额                    
                      SUM(CASE
                            WHEN br.br_is_repay = 0 THEN
                             br.br_price_punish
                          END) unrepay_price_punish, --剩余罚息和违约金                     
                      MAX(CASE
                            WHEN br.BR_OVERDUE_TERMS > 0 AND BR_IS_REPAY = 0 THEN
                             DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(),
                                                    'yyyy-MM-dd'),
                                      BR.BR_TIME)
                          END) AS OVERDUE_UNREPAY_DAYS, --当前逾期未还天数                     
                      SUM(CASE
                            WHEN br.BR_TIME < ADD_MONTHS('{T}', 1) OR
                                 br.BR_IS_REPAY > 0 THEN
                             1
                            ELSE
                             0
                          END) POSTED_BILL_NUM,
                      SUM(CASE
                            WHEN br.BR_TIME < ADD_MONTHS('{T}', 1) AND
                                 br.BR_IS_REPAY = 0 THEN
                             br.BR_PRICE + br.BR_PRICE_PUNISH
                            ELSE
                             0
                          END) POSTED_BILL_UNREPAY_AMT,
                      SUM(CASE
                            WHEN br.BR_TIME >= ADD_MONTHS('{T}', 1) AND
                                 br.BR_IS_REPAY = 0 THEN
                             br.BR_PRICE_B
                            ELSE
                             0
                          END) PENDING_BILL_UNREPAY_B,
                      SUM(CASE
                            WHEN br.br_repay_time BETWEEN trunc('{T}', 'MM') AND
                                 to_date('{T}') then
                             br.br_price + br.br_price_punish
                            else
                             0
                          end) AS repay_price --还款金额
                 FROM odsopr.borrows_repayment br
                inner join TMP.TMP_DUNNING_BO_ID_M1 ncm
                   on br.bo_id = ncm.bo_id
                GROUP BY br.bo_id) a
      ON ncm.bo_id = a.bo_id;