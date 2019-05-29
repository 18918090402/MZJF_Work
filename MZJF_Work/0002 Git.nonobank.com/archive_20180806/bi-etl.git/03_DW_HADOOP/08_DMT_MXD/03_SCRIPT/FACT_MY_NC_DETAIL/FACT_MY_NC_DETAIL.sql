set mapreduce.job.name = DMT_MAIYA_FACT_MY_NC_DETAIL_AFTER;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

 /*催收相关信息*/
 DROP TABLE IF EXISTS TMP.TMP_DUNNING_BO_ID_MY;
 CREATE TABLE TMP.TMP_DUNNING_BO_ID_MY AS
 SELECT BO_ID
 ,CONCAT(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01 03:00:00') AS start_time
 ,mod_contract
 ,odc_name
 ,mod_start_time
FROM odsopr.borrows_outsource_dunning bod
LEFT JOIN odsopr.borrows_outsource_dunning_company bodc 
ON bodc.id=bod.mod_company
WHERE bo_id IS NOT NULL 
AND mod_contract=CONCAT('MYFQ',FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyyMM'),'01')
;

/*提前还款违约金*/
DROP TABLE IF EXISTS TMP.TMP_PREPAYMENT_PENALTY_MY;
CREATE TABLE TMP.TMP_PREPAYMENT_PENALTY_MY AS
SELECT t1.borrows_id AS bo_id, MAX(penalty_fee_amount) AS amount
  FROM TMP.TMP_DUNNING_BO_ID_MY t
  INNER JOIN odsopr.trans_repayment_order t1
  on t.BO_ID=cast(t1.borrows_id as bigint)
  JOIN odsopr.trans_repayment_info t2
    ON t1.trans_id = t2.practice_id
 WHERE t1.repayment_type = '4'
   AND t1.status IN ('1', '5', '6', '7')
 GROUP BY t1.borrows_id;
 


insert overwrite table DMT_MAIYA.FACT_MY_NC_DETAIL partition(stat_date,stat_hour)
SELECT bo.id AS BO_ID
,du.mod_start_time --委案开始时间
,du.odc_name --服务商
,du.mod_contract --委案批次
,ui.real_name --借款姓名
,ui.user_name --用户名
,p.p_name --产品
,bo.bo_expect --借款期限
,br1.should_repay_cnt --应还期数
,br1.repayed_cnt --实际已还期数
,br1.overdue_unrepay_days --截止目前为止的逾期天数
,br1.aging --账龄 
,br1.overdue_price --逾期总额 
,br1.start_overdue_price --截止委外开始时间的逾期总额
,fl.amount as advance_break_price--提前还款违约金
,br1.mod_normal_repay_price --正常还款金额
,br1.mod_overdue_repay_price  --逾期还款金额
,br1.mod_price --委外后还款总额
,CONCAT(cast(ROUND((NVL(br1.mod_price,0)/start_overdue_price)*100,2) as string),'%') AS overdue_rate --逾期回收率
,br1.unrepay_price_b --剩余本金
,br1.unrepay_price_punish --剩余罚息和违约金    
,br1.repay_end_time --到期时间
,CASE WHEN bo.bo_all_repayed=1 THEN 'Y' ELSE 'F' END is_all_repayed -- 是否已还清
,CASE WHEN bo.bo_all_repayed=1 then advance_repay_price else 0 end AS advance_repay_price --提前还款金额
,br1.last_repay_time --最近还款日期
,br1.unrepay_price_p --未还总额
,fa.balance --可用余额
,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') stat_time--取数时间
,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') stat_date --分区时间
,case when  hour(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss'))>=16 then 2 else 1 end as stat_hour --分区小时
FROM odsopr.borrows  bo
INNER JOIN TMP.TMP_DUNNING_BO_ID_MY du ON bo.id=du.bo_id
INNER JOIN IDW.dim_user ui on bo.user_id=ui.user_id
LEFT JOIN odsopr.products p ON bo.p_id=p.id
LEFT JOIN  odsopr.finance_account fa  ON fa.user_id=ui.user_id AND fa.role_id =7 
LEFT JOIN TMP.TMP_PREPAYMENT_PENALTY_MY fl ON bo.id=cast(fl.bo_id as bigint)
LEFT JOIN (SELECT br.bo_id
							,MAX(br.br_time) AS repay_end_time --到期时间
							,MAX(br.br_repay_time) as last_repay_time --最近还款日期
							,MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END) AS overdue_unrepay_days --当前逾期未还天数       
							,CASE WHEN MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)>=1
									AND MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)<=30 THEN 'M1'
									WHEN MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)>=31
									AND MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)<=60 THEN 'M2'
									WHEN MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)>=61
									AND MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)<=90 THEN 'M3'
									WHEN MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)>=91
									AND MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)<=120 THEN 'M4'
									WHEN MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)>=121
									AND MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)<=150 THEN 'M5'
									WHEN MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)>=151
									AND MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)<=180 THEN 'M6'
									WHEN MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)>=181
									AND MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)<=210 THEN 'M7'
									WHEN MAX(CASE WHEN br.br_overdue_terms>0  AND br_is_repay=0 THEN DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),br.br_time) END)>=211 THEN 'M7+'
									END AS aging --账龄 
                            ,SUM(CASE WHEN DATEDIFF(NVL(br.br_repay_time,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd')),br.br_time)>0  AND br_time<du.start_time  AND (br_is_repay=0 OR br_repay_time>=du.start_time) THEN br_price+br_price_punish END ) AS start_overdue_price--截止取数时间的逾期总额   
                            ,SUM(CASE WHEN br.br_is_repay=1 AND ADD_MONTHS(br.br_repay_time,1)<=br.br_time THEN br.br_price+br_price_punish END) AS advance_repay_price --提前还款金额
							,COUNT(br_time) as should_repay_cnt --应还期数
							,SUM(CASE WHEN br.br_is_repay=0 AND br.br_overdue_terms>0 THEN 1 ELSE 0 END ) AS overdue_unrepay_cnt  --未还逾期期数
							,SUM(CASE WHEN br.br_is_repay=1 AND br.br_time <FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') THEN 1 ELSE 0 END ) AS repayed_cnt--实际已还期数
							,SUM(CASE WHEN br.br_is_repay=0 THEN br.br_price END) AS unrepay_price --剩余本息
							,SUM(CASE WHEN br.br_is_repay=0 THEN br.br_price_b END) AS unrepay_price_b --剩余本金
							,SUM(CASE WHEN br.br_is_repay=0 THEN br_price_punish END) AS unrepay_price_punish --剩余罚息和违约金
							,SUM(CASE WHEN br.br_is_repay=0 THEN br_price+br_price_punish END ) AS unrepay_price_p --未还总额
							,SUM(CASE WHEN br.br_is_repay=0 AND br.br_overdue_terms>0 THEN br_price+br_price_punish + price_return END ) AS overdue_unrepay_price --逾期未还总额
							,SUM(CASE WHEN br.br_is_repay=0 AND  DATEDIFF(nvl(br.br_repay_time,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd')),br.br_time)>0  THEN br.br_price+br.br_price_punish END) AS overdue_price --逾期总额
							,SUM(CASE WHEN (br.br_overdue_terms=0  OR br.br_overdue_terms IS NULL )AND br.br_time>=FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') AND br.br_is_repay=0 THEN br_price+br_price_punish ELSE 0 END) AS  normal_unrepay_price_p --正常未还款总额
                            ,SUM(CASE WHEN (br.br_overdue_terms=0  OR br.br_overdue_terms IS NULL )AND br.br_time>=FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') AND br.br_is_repay=0 THEN br.br_price ELSE 0 END) AS normal_unrepay_price --正常未还款本息
							,SUM(CASE WHEN (br.br_overdue_terms=0  OR br.br_overdue_terms IS NULL )AND br.br_time>=FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') AND br.br_is_repay=0 THEN br.br_price_b ELSE 0 END) AS normal_unrepay_price_b --正常未还款本金
                            ,SUM(CASE WHEN (br.br_overdue_terms=0  OR br.br_overdue_terms IS NULL )AND br.br_time>=FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') AND br.br_is_repay=0 THEN br.br_price_l ELSE 0 END) AS normal_unrepay_price_l --正常未还款利息
                            ,SUM(CASE WHEN (br.br_overdue_terms=0  OR br.br_overdue_terms IS NULL )AND br.br_time>=FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') AND br.br_is_repay=0 THEN br.br_price_punish ELSE 0 END) AS normal_unrepay_price_punish --正常未还款罚息
							,NVL(SUM(CASE WHEN br.br_is_repay=0 AND ADD_MONTHS(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),1)>br.br_time THEN br_price+br_price_punish END),0) AS unrepay_price1--未还款总额1
                            ,NVL(SUM(CASE WHEN br.br_is_repay=0 AND ADD_MONTHS(FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd'),1)<=br.br_time  THEN br_price_b END),0) AS unrepay_price2 --未还款总额2
                            ,SUM(CASE WHEN br.br_repay_time>=du.start_time AND br.br_is_repay=1 AND DATEDIFF(NVL(br.br_repay_time,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd')),br.br_time)>0   THEN br.br_price+br.br_price_punish ELSE 0 END)  AS mod_overdue_repay_price --委外逾期还款总额
                            ,SUM(CASE WHEN br.br_repay_time>=du.start_time AND br.br_is_repay=1 AND DATEDIFF(NVL(br.br_repay_time,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd')),br.br_time)<=0 THEN br.br_price+br.br_price_punish ELSE 0 END)  AS mod_normal_repay_price   --委外正常还款总额
                            ,SUM(CASE WHEN br.br_repay_time>=du.start_time AND br.br_is_repay=1 THEN br.br_price+br.br_price_punish ELSE 0 END ) AS mod_price --委外总额							
FROM odsopr.borrows_repayment br
INNER JOIN TMP.TMP_DUNNING_BO_ID_MY du 
ON du.bo_id=br.bo_id
group by br.bo_id
) as br1 on bo.id=br1.bo_id
WHERE bo.bo_is_success=1