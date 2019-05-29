set mapreduce.job.name = IDW_MXD_FACT_MXD_WW_DETAIL;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

/*催收相关信息*/
 DROP TABLE IF EXISTS TMP.TMP_DUNNING_WW_BO_ID;
 CREATE TABLE TMP.TMP_DUNNING_WW_BO_ID AS
 SELECT BO_ID
 ,CREATE_TIME AS start_time
 ,mod_money --委外当天逾期总额
 ,mod_contract --委案批次
 ,MOD_COMPANY_NAME --服务商
 ,mod_start_time --委案开始时间
,mod_close_time --结案时间
,mod_end_time --委外结束时间
,DUNNING_NUM --手别
 ,CASE WHEN mod_status=0 THEN '委外在案'
		  WHEN mod_status=1 THEN '委外结案'
		  WHEN mod_status=2 THEN '委外退案'
		  WHEN mod_status=3 THEN '提前退案' 
		  WHEN mod_status=4 THEN '延期案件' END AS mod_status --委案状态
FROM idw.FACT_BORROWS_DUNNING
WHERE IS_LAST_DUNNING=1
AND mod_contract 
IN('NNBK20170601',
'NNBK20170616',
'NNBK20170703',
'NNBK20170711',
'NNBK20170724',
'NNBK20170801',
'NNBK20170807',
'NNBK20170811',
'NNBK20170828',
'NNBK20170901')
;

/*提前还款违约金*/
DROP TABLE IF EXISTS TMP.TMP_PREPAYMENT_PENALTY_WW;
CREATE TABLE TMP.TMP_PREPAYMENT_PENALTY_WW AS
SELECT t1.borrows_id AS bo_id, MAX(penalty_fee_amount) AS amount
  FROM TMP.TMP_DUNNING_WW_BO_ID t
  INNER JOIN odsopr.trans_repayment_order t1
  on t.BO_ID=cast(t1.borrows_id as bigint)
  INNER JOIN odsopr.trans_repayment_info t2
    ON t1.trans_id = t2.practice_id
 WHERE t1.repayment_type = '4'
   AND t1.status IN ('1', '5', '6', '7')
 GROUP BY t1.borrows_id;
 
 

insert overwrite table DMT_MXD.FACT_MXD_WW_DETAIL partition(stat_date)
SELECT bo.id AS BO_ID --标ID
,p.p_name --产品
,du.mod_start_time --委案开始时间
,du.MOD_COMPANY_NAME as odc_name --服务商
,du.mod_contract --委案批次
,du.mod_close_time --结案时间
,du.mod_end_time --委外结束时间
,du.mod_status --委案状态
,ui.real_name --借款姓名
,ui.user_name --用户名
,ui.mobile_num --手机号
,br1.overdue_unrepay_days --截止目前为止的逾期天数
,br1.aging --账龄 
,br1.overdue_unrepay_cnt --剩余逾期期数
,br1.mod_overdue_repay_price  --逾期还款金额
,br1.mod_normal_repay_price --正常还款金额
,fl.amount as advance_break_price--提前还款违约金
,nvl(br1.mod_price,0)+nvl(fl.amount,0) as mod_repay_money --委外后还款总额
,du.mod_money --委外当天逾期总额
,br1.unrepay_price --剩余本息
,br1.unrepay_price_punish --剩余罚息和违约金
,br1.unrepay_price_b --剩余本金
,fa.balance --可用余额
,fa.locking --锁定金额
,br1.last_repay_time --最近还款日期
,case when br1.posted_bill_num < 12 then br1.posted_bill_unrepay_amt + br1.pending_bill_unrepay_b * 1.06
        when br1.posted_bill_num >= 12 then br1.posted_bill_unrepay_amt + br1.pending_bill_unrepay_b * 1.05
        end settlement_should_repay_amt --提前结清金额
,case when bo.bo_all_repayed=1 then '是' else '' end is_all_repayed -- 状态_是否已还清
,br1.overdue_unrepay_price --逾期未还总额
,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') stat_time--取数时间
,du.DUNNING_NUM --手别
,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') stat_date --分区时间
FROM odsopr.borrows  bo
INNER JOIN TMP.TMP_DUNNING_WW_BO_ID du ON bo.id=du.bo_id
INNER JOIN IDW.dim_user ui on bo.user_id=ui.user_id
LEFT JOIN odsopr.products p ON bo.p_id=p.id
LEFT JOIN odsopr.finance_account fa  ON fa.user_id=ui.user_id AND fa.role_id =7 
LEFT JOIN TMP.TMP_PREPAYMENT_PENALTY_WW fl ON bo.id=cast(fl.bo_id as bigint)
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
                            ,SUM(CASE WHEN BR.BR_TIME < ADD_MONTHS('{T}', 1) THEN 1 ELSE 0 END) POSTED_BILL_NUM
                            ,SUM(CASE WHEN BR.BR_TIME < ADD_MONTHS('{T}', 1) AND BR.BR_IS_REPAY = 0 THEN BR.BR_PRICE + BR.BR_PRICE_PUNISH ELSE 0 END) POSTED_BILL_UNREPAY_AMT
                            ,SUM(CASE WHEN BR.BR_TIME >= ADD_MONTHS('{T}', 1) AND BR.BR_IS_REPAY = 0 THEN BR.BR_PRICE_B ELSE 0 END) PENDING_BILL_UNREPAY_B							
FROM ODSOPR.BORROWS_REPAYMENT BR
INNER JOIN TMP.TMP_DUNNING_WW_BO_ID du 
ON du.bo_id=br.bo_id
group by br.bo_id
) as br1 on bo.id=br1.bo_id
WHERE bo.bo_is_success=1