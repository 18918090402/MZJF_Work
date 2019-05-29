set mapreduce.job.name = IDW_FACT_BORROWS_DUNNING;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table idw.FACT_BORROWS_DUNNING
SELECT DUNNING_ID,
		   BO_ID,
		   USER_ID,
		   MOD_PRODUCT,
		   MOD_COMPANY,
		   MOD_COMPANY_NAME,
		   MOD_COMPANY_TYPR,
		   MOD_CONTRACT,
		   MOD_MONEY,
		   MOD_TOTAL_MONEY,
		   MOD_START_TIME,
		   MOD_END_TIME,
		   MOD_CLOSE_TIME,
		   MOD_STATUS ,
		   MOD_IS_CANCEL,
		   CREATE_TIME,
		   UPDATE_TIME,
		   CREATER,
		   UPDATER,
		   OVERDUE_UNREPAY_DAYS,
		   AGING ,
		   DUNNING_NUM,
		   DUNNED_OVERDUE_AMT,
		   DUNNED_NORMAL_AMT,
		   CASE WHEN DUNNING_DESC=1 THEN 1 ELSE 0 END IS_LAST_DUNNING,
		   'SYS' AS DW_CREATE_BY,
           from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
           'SYS' DW_UPDATE_BY,
          from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
		  DUNNING_NUM_MXD
FROM(
			SELECT bod.ID AS DUNNING_ID,
				   bod.bo_id AS BO_ID,
				   bod.USER_ID,
				   bod.MOD_PRODUCT,
				   bodc.id AS MOD_COMPANY,
				   bodc.odc_name AS MOD_COMPANY_NAME,
				   bodc.odc_type AS MOD_COMPANY_TYPR,
				   bod.mod_contract AS  MOD_CONTRACT,
				   bod.mod_money AS MOD_MONEY,
				   bod.MOD_TOTAL_MONEY,
				   bod.mod_start_time AS MOD_START_TIME,
				   bod.mod_end_time AS MOD_END_TIME,
				   case when bod.mod_close_time is null and bod.mod_status in(1,2,3,4) then bod.mod_end_time else bod.mod_close_time end AS MOD_CLOSE_TIME,
				   bod.mod_status AS MOD_STATUS,
				   bod.MOD_IS_CANCEL,
				   bod.create_time,
				   bod.update_time,
				   bod.CREATER,
				   bod.UPDATER,
				   T.OVERDUE_UNREPAY_DAYS,
				   CASE WHEN T.OVERDUE_UNREPAY_DAYS = 0 THEN 'M0'
						   WHEN T.OVERDUE_UNREPAY_DAYS > 0        AND T.OVERDUE_UNREPAY_DAYS < 30 THEN  'M1'
						   WHEN T.OVERDUE_UNREPAY_DAYS >= 30    AND T.OVERDUE_UNREPAY_DAYS < 60 THEN 'M2'
						   WHEN T.OVERDUE_UNREPAY_DAYS >= 60    AND T.OVERDUE_UNREPAY_DAYS < 90 THEN 'M3'
						   WHEN T.OVERDUE_UNREPAY_DAYS >= 90    AND T.OVERDUE_UNREPAY_DAYS < 120 THEN 'M4'
						   WHEN T.OVERDUE_UNREPAY_DAYS >= 120  AND T.OVERDUE_UNREPAY_DAYS < 150 THEN 'M5'
						   WHEN T.OVERDUE_UNREPAY_DAYS >= 150  then  'M6+'   end AGING,--账龄
				   TT.DUNNING_NUM,--当前标的第几次催收
				   case when bod.bo_id is not null then ROW_NUMBER() OVER(PARTITION BY bod.bo_id ORDER BY bod.id DESC) end AS DUNNING_DESC,--当前标的催收倒序排序
				   case when TT.DUNNING_NUM1>=2 THEN NVL(DUNNING_NUM2,0)+2 ELSE NVL(DUNNING_NUM2,0)+NVL(TT.DUNNING_NUM1,0) END DUNNING_NUM_MXD,
				   T.DUNNED_OVERDUE_AMT,--催回逾期总额
				   T.DUNNED_NORMAL_AMT--催回正常总额
				   --IS_LAST_DUNNING--是否最新催收
				   FROM ods.t_borrows_outsource_dunning_hist bod
				   LEFT JOIN ods.t_borrows_outsource_dunning_company_hist bodc ON bodc.id=bod.mod_company
				   LEFT JOIN(SELECT bod.id
									,COUNT(DISTINCT CASE WHEN bodc.odc_type=0 AND bod2.mod_start_time<'2017-09-04' AND bod.mod_start_time>=bod2.mod_start_time THEN bod2.mod_contract END) DUNNING_NUM1
									,COUNT(DISTINCT CASE WHEN bodc.odc_type=0 AND bod2.mod_start_time>='2017-09-04'  AND bod.mod_start_time>=bod2.mod_start_time THEN bod2.mod_contract END) DUNNING_NUM2
									,COUNT(DISTINCT CASE WHEN bodc.odc_type=0 AND bod.mod_start_time>=bod2.mod_start_time THEN bod2.mod_contract END) DUNNING_NUM
									FROM odsopr.borrows_outsource_dunning bod
									LEFT JOIN odsopr.borrows_outsource_dunning_company bodc ON bodc.id=bod.mod_company AND bodc.odc_type=0
									LEFT JOIN
										(
										SELECT bod.BO_ID,bodc.odc_type,bod.mod_start_time,bod.mod_contract
										FROM odsopr.borrows_outsource_dunning bod
										INNER JOIN odsopr.borrows_outsource_dunning_company bodc
										ON bodc.id=bod.mod_company AND bodc.odc_type=0
										) bod2 ON bod.BO_ID=bod2.BO_ID AND bodc.odc_type=bod2.odc_type
									GROUP BY bod.id
								) TT
				   ON BOD.id=TT.ID
				   LEFT JOIN (--计算催回逾期总额，正常总额和截止到催收开始逾期天数
										SELECT m1.bo_id,
													bod.ID,
													SUM(CASE WHEN to_date(m1.br_repay_time)>=bod.mod_start_time
																	 AND to_date(m1.br_repay_time)<=(case when bod.mod_close_time is null and bod.mod_status in(1,2,3,4) then bod.mod_end_time else bod.mod_close_time end)
																	 AND m1.br_overdue_terms>0 AND m1.br_is_repay=1 THEN m1.br_price+m1.br_price_punish ELSE 0 END)  AS DUNNED_OVERDUE_AMT,
													SUM(CASE WHEN to_date(m1.br_repay_time)>=bod.mod_start_time 
																	AND to_date(m1.br_repay_time)<=(case when bod.mod_close_time is null and bod.mod_status in(1,2,3,4) then bod.mod_end_time else bod.mod_close_time end)
																	AND (m1.br_overdue_terms=0  OR m1.br_overdue_terms IS NULL )  AND m1.br_is_repay=1 THEN m1.br_price+m1.br_price_punish ELSE 0 END)  AS DUNNED_NORMAL_AMT,
													MAX(datediff(to_date(bod.mod_start_time),CASE WHEN (m1.br_overdue_terms>0  AND m1.br_time<bod.mod_start_time) 
																		AND (m1.br_is_repay=0 OR m1.br_repay_time>=bod.mod_start_time) THEN m1.br_time END )) AS OVERDUE_UNREPAY_DAYS
									  FROM ods.t_borrows_outsource_dunning_hist bod
									  inner join ods.t_borrows_repayment_hist m1 
									  ON bod.bo_id=m1.BO_ID
									  GROUP BY m1.bo_id,bod.ID
								) T ON BOD.id=T.ID AND BOD.BO_ID=T.bo_id
) A