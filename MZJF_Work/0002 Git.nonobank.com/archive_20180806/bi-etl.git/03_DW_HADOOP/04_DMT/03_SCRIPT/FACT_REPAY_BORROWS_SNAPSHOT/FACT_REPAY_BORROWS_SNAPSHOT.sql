set mapreduce.job.name = DMT_FACT_REPAY_BORROWS_SNAPSHOT;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table DMT.FACT_REPAY_BORROWS_SNAPSHOT partition
  (STAT_DATE)
  select t1.BO_ID,--借款ID
         t1.P_ID,--产品ID
         t1.BUSI_LINE,--所属业务线
         t1.USER_ID,--用户ID
         t1.BO_RATE,--借款年利率
		 t1.bo_finish_price,--完成金额
		 t1.bo_expect,--借款期限
		 t1.bo_expect_cat,--借款期限单位
         t1.INTEREST_RATE_CUT,--减息
         t1.BO_AUDIT_TIME,--审核时间
         t1.BO_AGREE_TIME,--协议生成时间
         t1.SHOULD_REPAY_CNT,--应还期数
         t1.REPAYED_CNT,--已还期数
         t1.UNREPAY_CNT,--未还期数
		 t1.should_repay_cnt_this_month,--当月应还期数 月底之前该还并且未还的期数总和
         t1.REPAYED_CNT_THIS_MONTH,--本月已还期数
         t1.SHOULD_REPAY_PRICE,--应还金额
         t1.REPAYED_PRICE,--已还金额
         t1.UNREPAY_PRICE,--未还金额
		 t1.should_repay_price_this_month, --当月应还金额 月底之前该还并且未还的金额总和 
         t1.REPAYED_PRICE_THIS_MONTH,--本月已还金额
         t1.SHOULD_REPAY_PRICE_B,--应还本金
         t1.REPAYED_PRICE_B,--已还本金
         t1.UNREPAY_PRICE_B,--未还本金
		 t1.should_repay_price_b_this_month,--当月应还本金 月底之前该还并且未还的本金总和
         t1.REPAYED_PRICE_B_THIS_MONTH,--本月已还本金
         t1.SHOULD_REPAY_PRICE_L,--应还利息
         t1.REPAYED_PRICE_L,--已还利息
         t1.UNREPAY_PRICE_L,--未还利息
		 t1.should_repay_price_l_this_month,--当月应还利息 月底之前该还并且未还的利息总和
         t1.REPAYED_PRICE_L_THIS_MONTH,--本月已还利息
         t1.SHOULD_REPAY_PRICE_PUNISH,--应还罚息
         t1.REPAYED_PRICE_PUNISH,--已还罚息
         t1.UNREPAY_PRICE_PUNISH,--未还罚息
		 t1.should_repay_price_punish_this_month,--当月应还罚息 月底之前该还并且未还的利息总和
         t1.REPAYED_PRICE_PUNISH_THIS_MONTH,--本月已还罚息
         t1.SHOULD_REPAY_SERVICE_FEE,--应还服务费
         t1.REPAYED_SERVICE_FEE,--已还服务费
         t1.UNREPAY_SERVICE_FEE,--未还服务费
		 t1.should_repay_service_fee_this_month,--当月应还服务费 月底之前该还并且未还的服务费总和
         t1.REPAYED_SERVICE_FEE_THIS_MONTH,--本月已还服务费
         t1.REPAY_BEGIN_DAY,--起始还款日
		 t1.REPAY_END_DAY,--最终还款日
         t1.LAST_REPAYED_TIME,--最近还款时间
         t1.COMPENSATE_AMT,--代偿金额
         t1.REPAYED_COMPENSATE_AMT,--已还代偿金额
         t1.IS_FIRST_REPAY_OVERDUE,--是否首还逾期
         t1.FIRST_REPAY_OVERDUE_DAYS,--首还逾期天数
         t1.IS_OVERDUE,--是否有过逾期
         t1.MAX_OVERDUE_DAYS,--最大逾期天数
         t1.IS_OVERDUE_UNREPAY,--是否逾期未还
         case when (t1.bo_id is null or t2.DUN_STATUS<>0) then 0 else 1 end IS_DUNNING,--是否在催收
         t2.DUN_TYPE,--催收类型
         t2.DUN_COMPANY,--催收服务商
         t2.DUN_COMPANY_NAME,--催收服务商名称
         t2.DUN_START_TIME,--催收开始时间
         t2.DUN_END_TIME,--催收结束时间
		 t2.DUN_CLOSE_TIME,--催收结案时间
		 t2.DUN_STATUS,--催收状态
         t1.OVERDUE_EXPECT_CNT,--当前逾期期数
         t1.OVERDUE_REPAYED_PRICE,--逾期已还金额
         t1.OVERDUE_UNREPAY_EXPECT_CNT,--当前逾期未还期数
         t1.OVERDUE_UNREPAY_DAYS,--当前逾期未还天数
         case
           when t1.OVERDUE_UNREPAY_DAYS = 0 then 'M0'
           when t1.OVERDUE_UNREPAY_DAYS > 0 and t1.OVERDUE_UNREPAY_DAYS < 30 then 'M1'
           when t1.OVERDUE_UNREPAY_DAYS >= 30 and  t1.OVERDUE_UNREPAY_DAYS < 60 then 'M2'
           when t1.OVERDUE_UNREPAY_DAYS >= 60 and  t1.OVERDUE_UNREPAY_DAYS < 90 then 'M3'
           when t1.OVERDUE_UNREPAY_DAYS >= 90 and t1.OVERDUE_UNREPAY_DAYS < 120 then'M4'
           when t1.OVERDUE_UNREPAY_DAYS >= 120 and t1.OVERDUE_UNREPAY_DAYS < 150 then'M5'
           when t1.OVERDUE_UNREPAY_DAYS >= 150 then 'M6+' end AGING,--账龄
         t1.OVERDUE_UNREPAY_PRICE,--逾期未还金额
         t1.OVERDUE_UNREPAY_PRICE_B,--逾期未还本金
         t1.OVERDUE_UNREPAY_PRICE_L,--逾期未还利息
         t1.OVERDUE_UNREPAY_PRICE_PUNISH,--逾期未还罚息
         t1.OVERDUE_UNREPAY_SERVICE_FEE,--逾期未还服务费
         t1.COMPENSATE_PRICE_B,--代偿本金
         t1.REPAYED_COMPENSATE_PRICE_B,--已还代偿本金
         t1.CUR_PRICE,--当期应还金额
         t1.CUR_PRICE_B,--当期应还本金
         t1.CUR_PRICE_L,--当期应还利息
         t1.CUR_SERVICE_FEE,--当期应还平台服务费
         t1.FIRST_REPAY_TIME,--首次还款时间
         t1.SHOULD_RETURN_PRICE,--应返还金额
         t1.RETURNED_PRICE,--已返还金额
         t1.UNRETURNED_PRICE,--未返还金额
		 t1.should_returned_price_this_month,--当月应返还金额 月底之前该还并且未返还的返还金额总和
         t1.RETURNED_PRICE_THIS_MONTH,--本月已返还金额
		 t1.overdue_returned_price,--逾期已返还金额
         t1.overdue_unreturned_price,--逾期未返还金额
         t1.unrepay_br_time_min,--未还最早逾期计划时间
         t1.overdue_term_max,--最大逾期期数
         t3.overdue_price_b_max,--最大连续逾期本金
         t1.is_all_repayed,--是否还清
		 'SYS' AS DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
		 t1.OVERDUE_REPAY_PRICE,--逾期已还金额
         t1.OVERDUE_REPAY_PRICE_B,--逾期已还本金
         t1.OVERDUE_REPAY_PRICE_L,--逾期已还利息
         t1.OVERDUE_REPAY_PRICE_PUNISH,--逾期已还罚息
         t1.OVERDUE_REPAY_SERVICE_FEE,--逾期已还服务费
		 t1.category_name_01,--产品分类01
		 t1.biz_code_01,--	业务线编码01
		 t1.biz_name_01,--	业务线名称01
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') STAT_DATE	 
    from (select bo.bo_id,
                 bo.p_id,
                 bo.busi_line,
                 bo.user_id,
                 bo.bo_rate,
                 bo.interest_rate_cut,
                 bo.bo_audit_time,
                 bo.bo_agree_time,
                 sum(case when br.br_time <from_unixtime(unix_timestamp(), 'yyyy-MM-dd') then 1
                       else 0 end) SHOULD_REPAY_CNT,--应还期数
                 sum(case when BR_IS_REPAY > 0 then 1
                       else  0  end) REPAYED_CNT,
                 sum(case
                       when BR_IS_REPAY = 0 then 1 
					   else 0 end) UNREPAY_CNT,
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >=
                            concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'), '-01') then
                        1 else 0
                     end) REPAYED_CNT_THIS_MONTH,
				sum(case
                       when BR_IS_REPAY = 0 and
                            BR_TIME <add_months(concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01'),1)  then
                        1 else 0
                     end) should_repay_cnt_this_month,--月底之前该还并且未还的期数总和
                 sum(case
                       when br.br_time <from_unixtime(unix_timestamp(), 'yyyy-MM-dd') then
                        BR_PRICE
                       else
                        0
                     end) SHOULD_REPAY_PRICE,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        BR_PRICE
                       else
                        0
                     end) REPAYED_PRICE,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        BR_PRICE
                       else
                        0
                     end) UNREPAY_PRICE,
				sum(case
                       when BR_IS_REPAY = 0 and
                            BR_TIME <add_months(concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01'),1)  then
                        BR_PRICE else 0
                     end) should_repay_price_this_month,--月底之前该还并且未还的金额总和
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >=
                            concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01') then
                        BR_PRICE
                       else
                        0
                     end) REPAYED_PRICE_THIS_MONTH,
                 sum(case
                       when br.br_time <from_unixtime(unix_timestamp(), 'yyyy-MM-dd') then
                        BR_PRICE_B
                       else
                        0
                     end) SHOULD_REPAY_PRICE_B,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        BR_PRICE_B
                       else
                        0
                     end) REPAYED_PRICE_B,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        BR_PRICE_B
                       else
                        0
                     end) UNREPAY_PRICE_B,
				sum(case
                       when BR_IS_REPAY = 0 and
                            BR_TIME <add_months(concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01'),1)  then
                          BR_PRICE_B else 0
                     end) should_repay_price_b_this_month,--月底之前该还并且未还的本金总和
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >=
                            concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),
                                   '-01') then
                        BR_PRICE_B
                       else
                        0
                     end) REPAYED_PRICE_B_THIS_MONTH,
                 sum(case
                       when br.br_time <
                            FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') then
                        BR_PRICE_L
                       else
                        0
                     end) SHOULD_REPAY_PRICE_L,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        BR_PRICE_L
                       else
                        0
                     end) REPAYED_PRICE_L,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        BR_PRICE_L
                       else
                        0
                     end) UNREPAY_PRICE_L,
				sum(case
                       when BR_IS_REPAY = 0 and
                            BR_TIME <add_months(concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01'),1)  then
                          BR_PRICE_L else 0
                     end) should_repay_price_l_this_month,--当月应还利息 月底之前该还并且未还的利息总和
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >=
                            concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),
                                   '-01') then
                        BR_PRICE_L
                       else
                        0
                     end) REPAYED_PRICE_L_THIS_MONTH,
                 sum(case
                       when br.br_time <from_unixtime(unix_timestamp(), 'yyyy-MM-dd') then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) SHOULD_REPAY_PRICE_PUNISH,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) REPAYED_PRICE_PUNISH,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) UNREPAY_PRICE_PUNISH,
				sum(case
                       when BR_IS_REPAY = 0 and
                            BR_TIME <add_months(concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01'),1)  then
                          BR_PRICE_PUNISH else 0
                     end) should_repay_price_punish_this_month,--当月应还利息 月底之前该还并且未还的罚息总和
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >=
                            concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),
                                   '-01') then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) REPAYED_PRICE_PUNISH_THIS_MONTH,
                 sum(case
                       when br.br_time <from_unixtime(unix_timestamp(), 'yyyy-MM-dd') then
                        BR_SERVICE_FEE
                       else
                        0
                     end) SHOULD_REPAY_SERVICE_FEE,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        BR_SERVICE_FEE
                       else
                        0
                     end) REPAYED_SERVICE_FEE,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        BR_SERVICE_FEE
                       else
                        0
                     end) UNREPAY_SERVICE_FEE,
				sum(case
                       when BR_IS_REPAY = 0 and
                            BR_TIME <add_months(concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01'),1)  then
                          BR_SERVICE_FEE else 0
                     end) should_repay_service_fee_this_month,--当月应还服务费 月底之前该还并且未还的服务费总和
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >=
                            concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),
                                   '-01') then
                        BR_SERVICE_FEE
                       else
                        0
                     end) REPAYED_SERVICE_FEE_THIS_MONTH,
                 min(BR_TIME) REPAY_BEGIN_DAY,
				 max(BR_TIME) REPAY_END_DAY,
                 max(case
                       when BR_IS_REPAY > 0 then
                        BR_REPAY_TIME
                     end) LAST_REPAYED_TIME,
                 sum(case
                       when IS_COMPENSATE = 1 then
                        BR_PRICE
                       else
                        0
                     end) COMPENSATE_AMT,
                 sum(case
                       when IS_COMPENSATE_RETURNED = 1 then
                        BR_PRICE
                       else
                        0
                     end) REPAYED_COMPENSATE_AMT,
                 bo.IS_FIRST_REPAY_OVERDUE,
                 bo.FIRST_REPAY_OVERDUE_DAYS,
                 if(sum(case
                          when br.BR_OVERDUE_TERMS > 0 then
                           1
                        end) > 0,
                    1,
                    0) IS_OVERDUE,
                 max(case
                       when br.BR_OVERDUE_TERMS > 0 then
                        datediff(coalesce(br.br_repay_time,
                                          FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd')),
                                 br.br_time)
                     end) MAX_OVERDUE_DAYS,
                 if(sum(case
                          when br.BR_OVERDUE_TERMS > 0 and br.BR_IS_REPAY = 0 then
                           1
                        end) > 0,
                    1,
                    0) IS_OVERDUE_UNREPAY,
                 sum(case
                       when BR_OVERDUE_TERMS > 0 then
                        1
                       else
                        0
                     end) OVERDUE_EXPECT_CNT,
                 sum(case
                       when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY > 0 then
                        BR_PRICE
                       else
                        0
                     end) OVERDUE_REPAYED_PRICE,
                 sum(case
                       when BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        1
                       else
                        0
                     end) OVERDUE_UNREPAY_EXPECT_CNT,
                 max(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        datediff(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd'),
                                 br.br_time)
                     end) OVERDUE_UNREPAY_DAYS,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        BR_PRICE
                       else
                        0
                     end) OVERDUE_UNREPAY_PRICE,
				sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY >0 then
                        BR_PRICE
                       else
                        0
                     end) OVERDUE_REPAY_PRICE,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        BR_PRICE_B
                       else
                        0
                     end) OVERDUE_UNREPAY_PRICE_B,
				sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY > 0 then
                        BR_PRICE_B
                       else
                        0
                     end) OVERDUE_REPAY_PRICE_B,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        BR_PRICE_L
                       else
                        0
                     end) OVERDUE_UNREPAY_PRICE_L,
				sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY > 0 then
                        BR_PRICE_L
                       else
                        0
                     end) OVERDUE_REPAY_PRICE_L,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) OVERDUE_UNREPAY_PRICE_PUNISH,
				sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY > 0 then
                        BR_PRICE_PUNISH
                       else
                        0
                     end) OVERDUE_REPAY_PRICE_PUNISH,
                 sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        BR_SERVICE_FEE
                       else
                        0
                     end) OVERDUE_UNREPAY_SERVICE_FEE,
				sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY > 0 then
                        BR_SERVICE_FEE
                       else
                        0
                     end) OVERDUE_REPAY_SERVICE_FEE,
                 sum(case
                       when IS_COMPENSATE = 1 then
                        BR_PRICE_B
                       else
                        0
                     end) COMPENSATE_PRICE_B,
                 sum(case
                       when IS_COMPENSATE_RETURNED = 1 then
                        BR_PRICE_B
                       else
                        0
                     end) REPAYED_COMPENSATE_PRICE_B,
                 bo.BO_FINISH_PRICE,
                 bo.BO_EXPECT,
                 bo.BO_EXPECT_CAT,
                 sum(case
                       when br.br_time >=date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd'),1) and
                            br.br_time < add_months(concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01'),1) 
							then  br.BR_PRICE
                       else
                        0
                     end) CUR_PRICE,
                 sum(case
                       when br.br_time >=
                            date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd'),
                                     1) and
                            br.br_time < add_months(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd'),1),
                                                    1) then
                        br.BR_PRICE_B
                       else
                        0
                     end) CUR_PRICE_B,
                 sum(case
                       when br.br_time >=
                            date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd'),
                                     1) and
                            br.br_time < add_months(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd'),1),
                                                    1) then
                        br.BR_PRICE_L
                       else
                        0
                     end) CUR_PRICE_L,
                 sum(case
                       when br.br_time >=
                            date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd'),
                                     1) and
                            br.br_time < add_months(date_sub(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd'),1),
                                                    1) then
                        br.BR_SERVICE_FEE
                       else
                        0
                     end) CUR_SERVICE_FEE,
                 min(br.br_repay_time) FIRST_REPAY_TIME,
                 sum(case
                       when br.br_time <from_unixtime(unix_timestamp(), 'yyyy-MM-dd') then
                        br.PRICE_RETURN
                       else
                        0
                     end) SHOULD_RETURN_PRICE,
                 sum(case
                       when BR_IS_REPAY > 0 then
                        br.PRICE_RETURN
                       else
                        0
                     end) RETURNED_PRICE,
                 sum(case
                       when BR_IS_REPAY = 0 then
                        br.PRICE_RETURN
                       else
                        0
                     end) UNRETURNED_PRICE,
				sum(case
                       when BR_IS_REPAY = 0 and
                            BR_TIME <add_months(concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01'),1)  then
                          br.PRICE_RETURN else 0
                     end) should_returned_price_this_month,--当月应返还金额 月底之前该还并且未返还的返还金额总和
                 sum(case
                       when BR_IS_REPAY > 0 and
                            BR_REPAY_TIME >=
                            concat(FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM'),'-01') then
                        br.PRICE_RETURN
                       else
                        0
                     end) RETURNED_PRICE_THIS_MONTH,
				sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY = 0 then
                        PRICE_RETURN
                       else
                        0
                     end) overdue_unreturned_price,
				sum(case
                       when br.BR_OVERDUE_TERMS > 0 and BR_IS_REPAY > 0 then
                        PRICE_RETURN
                       else
                        0
                     end) overdue_returned_price,
				max(br.br_overdue_terms) overdue_term_max,--最大逾期期数
				min(case when br.br_is_repay=0 and br.BR_OVERDUE_TERMS > 0 then br.br_time end) as unrepay_br_time_min ,--未还最早逾期计划时间
				max(bo.BO_ALL_REPAYED) as IS_ALL_REPAYED, --是否还清
				bo.category_name_01,
				bo.biz_code_01,
				bo.biz_name_01
            from idw.fact_borrows bo
            join idw.fact_borrows_repayment br
              on bo.bo_id = br.bo_id
           where bo.bo_is_success = 1
           group by bo.bo_id,
                    bo.p_id,
                    bo.busi_line,
                    bo.user_id,
                    bo.bo_rate,
                    bo.interest_rate_cut,
                    bo.bo_audit_time,
                    bo.bo_agree_time,
                    bo.IS_FIRST_REPAY_OVERDUE,
                    bo.FIRST_REPAY_OVERDUE_DAYS,
                    bo.BO_FINISH_PRICE,
                    bo.BO_EXPECT,
                    bo.BO_EXPECT_CAT,
					bo.category_name_01,
					bo.biz_code_01,
					bo.biz_name_01) t1
    left join( SELECT BO_ID,
                             MOD_COMPANY_TYPR as dun_type,
                             MOD_COMPANY as dun_company,
                             MOD_COMPANY_NAME as dun_company_name,
                             MOD_START_TIME as dun_start_time,
                             MOD_END_TIME as dun_end_time,
							 MOD_CLOSE_TIME as dun_close_time,
							 MOD_STATUS AS dun_status
                 FROM idw.FACT_BORROWS_DUNNING WHERE IS_LAST_DUNNING=1) t2
    on t1.bo_id = t2.bo_id
	LEFT JOIN(select bo_id,max(overdue_price_b_max) as overdue_price_b_max 
                    from(
                            select a.br_id,a.bo_id
                                     ,sum(b.br_price_b) as overdue_price_b_max
                            from idw.fact_borrows_repayment a
                            inner join idw.fact_borrows_repayment b
                            on a.bo_id = b.bo_id 
                            where b.br_expect_num >= a.br_expect_num - a.br_overdue_terms + 1
                            AND b.br_expect_num <= a.br_expect_num 
                            and a.br_overdue_terms>0 and b.br_overdue_terms>0
							and a.br_time < FROM_UNIXTIME(UNIX_TIMESTAMP() , 'yyyy-MM-dd')
							and b.br_time < FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd')
                            group by a.br_id,a.bo_id
                 ) tt group by bo_id) t3
	on t1.bo_id = t3.bo_id
	;