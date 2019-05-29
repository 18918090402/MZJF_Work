set mapreduce.job.name = idw_fact_nono_invest_order_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

insert overwrite table IDW.FACT_NONO_INVEST_ORDER partition (DATA_STATE)
-- 精选
SELECT  vf.id INVEST_SRC_ID                                                                                 --投资源表ID
        ,'vip_form' INVEST_SRC_TAB                                                                          --投资源表名
        ,vf.user_id USER_ID                                                                                 --用户ID
        ,vf.fp_id FP_KEY                                                                                    --计划代理键
        ,vf.fp_id FP_ID                                                                                     --计划ID
        ,NULL BO_ID                                                                                         --借款ID
        ,NULL DT_ID                                                                                         --债权ID
        ,fp.scope CATEGORY_CODE_02                                                                          --计划分类02 0:精选计划 11:贴心计划 15:月月升计划
        ,fps.label CATEGORY_NAME_02                                                                         --计划分类名称02
        ,vf.service_time INVEST_TIME                                                                        --投资时间
        ,vf.amount_payed INVEST_AMT                                                                         --投资金额
        ,case when fp.scope = 28 then ict.locking_expect else fp.expect end EXPECT                          --订单期限
        ,CASE
            WHEN fp.expect_unit = 0 THEN 2      
            WHEN fp.expect_unit = 1 THEN 1      
        END EXPECT_UNIT_CODE                                                                                --期限单位 1:日 2:月 3:年
        ,fp.start_date LOCK_BEGIN_TIME                                                                      --锁定生效时间
        ,IF (fp.expect_unit = 0,     --expect_unit:  0 月   1 日
             if (date_add(add_months(concat(substr(fp.start_date,1,8),'01'), fp.expect), (cast(substr(fp.start_date,9) as int)-1)) <= add_months(fp.start_date, fp.expect),
                 date_add(add_months(concat(substr(fp.start_date,1,8),'01'), fp.expect), (cast(substr(fp.start_date,9) as int)-1)),
                 add_months(fp.start_date, fp.expect)
                ),  
             if(fp.scope = 28, DATE_ADD(fp.start_date, ict.locking_expect), DATE_ADD(fp.start_date, fp.expect))
            ) LOCK_END_TIME                                                                                 --锁定结束时间
        ,case 
            when fp.scope = 28 then ict.locking_expect_rate+ict.vip_rate+ict.invest_rate 
            else fp.rate_min 
        end MIN_RATE                                                                                        --最低利率
        ,case 
            when fp.scope = 28 then ict.locking_expect_rate+ict.vip_rate+ict.invest_rate 
            else fp.rate_max 
        end MAX_RATE                                                                                        --最高利率
        ,cp.add_rate ADD_RATE                                                                               --加息
        ,cp.deductible_amt DEDUCTIBLE_AMT                                                                   --现金券抵扣金额
        ,CAST(vf.terminal AS STRING) TERMINAL_CODE                                                          --终端类型 0:PC 1:名校贷 2:诺诺镑客app 3:诺诺镑客微站 4:诺诺镑客IOS 5:诺诺镑客Andriod 6:Ipad 7:微信
        ,CASE
            WHEN vf.service_status = 1 THEN 2
            WHEN vf.service_status = 2 THEN 4
            ELSE vf.service_status
        END STATUS                                                                                          --状态 0:不成功 1:部分成功 2:成功 3:进行中 4:终止
        ,3 INVEST_TYPE_CODE                                                                                 --投资类型 1:散投 2:债转 3:精选  （4:e诺千金 5:活期 99:未知）
        ,NULL REMARK                                                                                        --备注
        ,CONCAT_WS('_', '02', CAST(vf.user_id AS STRING), CAST(vf.fp_id AS STRING)) INVEST_RELATION_NO      --投资关联编号 散投、债转:前置_(USER_ID)_(BO_ID)  精选:前置_(USER_ID)_(FP_ID)  e诺千金:前置_(USER_ID)_(DT_ID)     前置规则为01:散投、债转 02:精选 03:e诺千金
        ,'SYS' DW_CREATE_BY                                                                                 --系统字段-创建者
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME                              --系统字段-创建时间
        ,'SYS' DW_UPDATE_BY                                                                                 --系统字段-修改者
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME                              --系统字段-修改时间
        ,case
            when fp.scope in (15, 26) then vf.amount_payed * 1 / 12
            when fp.expect_unit = 1 and fp.scope = 28 then vf.amount_payed * ict.locking_expect / 365
            when fp.expect_unit = 1 then vf.amount_payed * fp.expect / 365
            when fp.expect_unit = 0 then vf.amount_payed * fp.expect / 12
        end INVEST_AMT_YEARLY                                                                               --年化投资金额
        ,case when ito.trans_id = '' or ito.trans_id is null then 'NA' else ito.trans_id end TRANS_ID       --交易凭证id
        ,case when ito.seri_no = '' or ito.seri_no is null then 'NA' else ito.seri_no end SERI_NO           --交易流水号
        ,vf.PLATFORM                                                                                        --投资端 1:诺诺 2:财神
        ,'current' DATA_STATE                                                                               --分区键
     FROM ods.t_vip_form_hist vf
LEFT JOIN ods.t_finance_plan_hist fp
       ON vf.fp_id = fp.id
LEFT JOIN ods.t_finance_plan_scope_hist fps
       ON fp.scope = fps.id
LEFT JOIN (
              SELECT cu.bb_id id
                    ,SUM(CASE WHEN uc.type = 1 THEN uc.value ELSE 0 END) add_rate
                    ,SUM(CASE WHEN uc.type = 0 THEN uc.value ELSE 0 END) deductible_amt
                FROM ods.t_coupon_use_hist cu
                JOIN ods.t_db_nono_user_coupon_hist uc
                  ON cu.uv_id = uc.id
                 AND uc.is_used = 1
            GROUP BY cu.bb_id
          ) cp
       ON vf.id = cp.id
left join ods.t_invt_trd_order_hist ito
       on vf.trans_id = ito.trans_id
left join odsopr.invt_custom_trans_info ict  --20180921新增'贵宾定制'
       on ict.trans_id = vf.trans_id
    where vf.fp_id is not null

union all

-- 散投
SELECT  bd.id INVEST_SRC_ID
        ,'borrows_bidding' INVEST_SRC_TAB
        ,bd.user_id USER_ID
        ,NULL FP_KEY
        ,NULL FP_ID
        ,bd.bo_id BO_ID
        ,NULL DT_ID
        ,NULL CATEGORY_CODE_02
        ,NULL CATEGORY_NAME_02
        ,bd.pay_time INVEST_TIME
        ,bd.price_in INVEST_AMT
        ,bo.bo_expect EXPECT
        ,bo.bo_expect_cat EXPECT_UNIT_CODE
        ,to_date(bo.bo_agree_time) LOCK_BEGIN_TIME
        ,CASE
            WHEN bo_expect_cat = 1 THEN to_date(DATE_ADD(bo.bo_agree_time, bo.bo_expect))
            WHEN bo_expect_cat = 2 THEN to_date(add_months(bo.bo_agree_time, bo.bo_expect))
            ELSE to_date(add_months(bo.bo_agree_time, bo.bo_expect * 12))
        END LOCK_END_TIME
        ,coalesce(bp.bp_rate_lender, bo.bo_rate) MIN_RATE
        ,coalesce(bp.bp_rate_lender, bo.bo_rate) MAX_RATE
        ,null ADD_RATE
        ,null DEDUCTIBLE_AMT
        ,cast(bd.terminal as string) TERMINAL_CODE
        ,bd.status STATUS
        ,1 INVEST_TYPE_CODE
        ,bd.reason REMARK
        ,concat_ws('_', '01', cast(bd.user_id as string), cast(bd.bo_id as string)) INVEST_RELATION_NO
        ,'SYS' DW_CREATE_BY
        ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME
        ,'SYS' DW_UPDATE_BY
        ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
        ,case
            when bo.bo_expect_cat = 1 then bd.price_in * bo.bo_expect / 365   -- 日
            when bo.bo_expect_cat = 2 then bd.price_in * bo.bo_expect / 12    -- 月
            when bo.bo_expect_cat = 3 then bd.price_in * bo.bo_expect         -- 年
        end INVEST_AMT_YEARLY
        ,case when ito.trans_id = '' or ito.trans_id is null then 'NA' else ito.trans_id end TRANS_ID
        ,case when ito.seri_no = '' or ito.seri_no is null then 'NA' else ito.seri_no end SERI_NO
        ,1 PLATFORM
        ,'current' DATA_STATE
     FROM ods.t_borrows_bidding_hist bd
LEFT JOIN ods.t_borrows_hist bo
       ON bd.bo_id = bo.id
left join ods.t_borrows_prepare_hist bp
       on bo.bp_id = bp.id
left join ods.t_invt_trd_order_hist ito
       on bd.trans_id = ito.trans_id
    WHERE bd.is_vip = 0

union all

-- 债转
SELECT  dbl.id INVEST_SRC_ID
        ,'debt_buy_log' INVEST_SRC_TAB
        ,dbl.user_id USER_ID
        ,NULL FP_KEY
        ,NULL FP_ID
        ,dbl.bo_id BO_ID
        ,NULL DT_ID
        ,NULL CATEGORY_CODE_02
        ,NULL CATEGORY_NAME_02
        ,dbl.pay_time INVEST_TIME
        ,dbl.price INVEST_AMT
        ,ds.expect EXPECT
        ,bo.bo_expect_cat EXPECT_UNIT_CODE
        ,CASE         
            WHEN bo.bo_expect_cat = 1 THEN to_date(DATE_ADD(bo.bo_agree_time, bo.bo_expect - ds.expect))
            WHEN bo.bo_expect_cat = 2 THEN to_date(add_months(bo.bo_agree_time, bo.bo_expect - ds.expect))
            ELSE to_date(add_months(bo.bo_agree_time, (bo.bo_expect - ds.expect) * 12))
        END LOCK_BEGIN_TIME
        ,CASE
            WHEN bo.bo_expect_cat = 1 THEN to_date(DATE_ADD(bo.bo_agree_time, bo.bo_expect))
            WHEN bo.bo_expect_cat = 2 THEN to_date(add_months(bo.bo_agree_time, bo.bo_expect))
            ELSE to_date(add_months(bo.bo_agree_time, bo.bo_expect * 12))
        END LOCK_END_TIME
        ,coalesce(bp.bp_rate_lender, bo.bo_rate) MIN_RATE
        ,coalesce(bp.bp_rate_lender, bo.bo_rate) MAX_RATE
        ,null ADD_RATE
        ,null DEDUCTIBLE_AMT
        ,cast(dbl.terminal as string) TERMINAL_CODE
        ,case 
            when dbl.status = 1 then 2
            when dbl.status = 2 then 0
            else dbl.status
        end STATUS
        ,2 INVEST_TYPE_CODE
        ,null REMARK
        ,concat_ws('_','01',cast(dbl.user_id as string),cast(dbl.bo_id as string)) INVEST_RELATION_NO
        ,'SYS' DW_CREATE_BY
        ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME
        ,'SYS' DW_UPDATE_BY
        ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
        ,case
            when bo.bo_expect_cat = 1 then dbl.price * ds.expect / 365  -- 日
            when bo.bo_expect_cat = 2 then dbl.price * ds.expect / 12   -- 月
            when bo.bo_expect_cat = 3 then dbl.price * ds.expect        -- 年
        end INVEST_AMT_YEARLY 
        ,case when ito.trans_id = '' or ito.trans_id is null then 'NA' else ito.trans_id end TRANS_ID
        ,case when ito.seri_no = '' or ito.seri_no is null then 'NA' else ito.seri_no end SERI_NO
        ,1 PLATFORM
        ,'current' DATA_STATE
     FROM ods.t_debt_buy_log_hist dbl
LEFT JOIN ods.t_debt_sale_hist ds
       ON dbl.ds_id = ds.id
LEFT JOIN ods.t_borrows_hist bo
       ON dbl.bo_id = bo.id
left join ods.t_borrows_prepare_hist bp
       on bo.bp_id = bp.id
left join ods.t_invt_trd_order_hist ito
       on dbl.trans_id = ito.trans_id
    WHERE dbl.p_type = 3
      AND dbl.va_id = 0
;
