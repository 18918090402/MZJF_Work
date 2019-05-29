drop table if exists idw.fact_borrows_repayment_plus ;

CREATE TABLE idw.fact_borrows_repayment_plus
(	
  br_id bigint COMMENT '还款ID', 	
  p_id bigint COMMENT '产品ID', 	
  busi_line string COMMENT '所属业务线', 	
  user_id bigint COMMENT '用户ID', 	
  bo_id bigint COMMENT '借款ID', 	
  br_price decimal(38,10) COMMENT '还款金额', 	
  br_price_b decimal(38,10) COMMENT '本金', 	
  br_price_l decimal(38,10) COMMENT '利息', 	
  br_price_punish decimal(38,10) COMMENT '罚息和违约金', 	
  br_service_fee decimal(38,10) COMMENT '平台服务费', 	
  price_return decimal(38,10) COMMENT '使用减息券之后平台返回给借入者的资金', 	
  br_price_punish_lender decimal(38,10) COMMENT '罚金借出者收取', 	
  br_price_punish_pc decimal(38,10) COMMENT '罚金机构收取', 	
  br_time string COMMENT '计划还款时间', 	
  br_repay_time string COMMENT '实际还款时间', 	
  br_is_repay int COMMENT '是否还款', 	
  br_repay_status int COMMENT '还款状态', 	
  br_transfer_fa_id bigint COMMENT '债转对应的fa_id', 	
  br_call_record string COMMENT '电话记录', 	
  br_repayed_tech_fee decimal(38,10) COMMENT '当期归还的技术的服务费', 	
  dunning_way string COMMENT '催收方式', 	
  br_locked int COMMENT '是否锁定', 	
  br_overdue_terms int COMMENT '当前逾期总数', 	
  br_is_hnapay_deduct int COMMENT '是否代划扣', 	
  br_is_send_sms int COMMENT '是否已发送短信通知', 	
  br_expect_num int COMMENT '当前标的第几期还款数据', 	
  is_first_repay_overdue int COMMENT '是否首还逾期', 	
  is_first_overdue int COMMENT '是否首次逾期', 	
  is_compensate int COMMENT '是否代偿', 	
  compensate_time string COMMENT '代偿时间', 	
  is_compensate_returned int COMMENT '是否归还代偿', 	
  compensate_returned_time string COMMENT '代偿归还时间', 	
  creator bigint COMMENT '创建人', 	
  updator bigint COMMENT '更新人', 	
  create_time string COMMENT '创建时间', 	
  update_time string COMMENT '更新时间', 	
  dw_create_by string COMMENT '系统字段-创建者', 	
  dw_create_time string COMMENT '系统字段-创建时间', 	
  dw_update_by string COMMENT '系统字段-修改者', 	
  dw_update_time string COMMENT '系统字段-修改时间', 	
  bo_agree_time string COMMENT '协议生成时间', 	
  category_name_01 string COMMENT '产品分类01', 	
  biz_code_01 string COMMENT '业务线编码01', 	
  biz_name_01 string COMMENT '业务线名称01', 	
  depository_flag int COMMENT '存管标记 0:初始 1:走存管 2:不走存管', 	
  transfer_account_time string COMMENT '实际划转成功时间', 	
  p_name string COMMENT '产品名称', 	
  p_key int COMMENT '产品代理键',
  bia_product string COMMENT '大一统产品名称',
  biz_name string COMMENT '大一统产品线',
  br_extra_fee decimal(38,10) COMMENT '额外费用', 	
  br_service_fee_other decimal(38,10) COMMENT '其他服务费(星河服务费)', 	
  br_post_consult_fee decimal(38,10) COMMENT '后置咨询费', 	
  is_graduate string COMMENT '是否已毕业'
)	
COMMENT '借款还款表'
ROW FORMAT DELIMITED
NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;






set mapreduce.job.name = idw_fact_borrows_repayment_plus_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.parallel=true;

insert overwrite table IDW.FACT_BORROWS_REPAYMENT_PLUS
  select br.ID BR_ID,
         bo.p_id,
         bo.busi_line,
         br.USER_ID,
         br.BO_ID,
         br.BR_PRICE,
         br.BR_PRICE_B,
         br.BR_PRICE_L,
         br.BR_PRICE_PUNISH,
         br.BR_SERVICE_FEE,
         br.PRICE_RETURN,
         br.BR_PRICE_PUNISH_LENDER,
         br.BR_PRICE_PUNISH_PC,
         br.BR_TIME,
         br.BR_REPAY_TIME,
         br.BR_IS_REPAY,
         br.BR_REPAY_STATUS,
         br.BR_TRANSFER_FA_ID,
         br.BR_CALL_RECORD,
         br.BR_REPAYED_TECH_FEE,
         br.DUNNING_WAY,
         br.BR_LOCKED,
         br.BR_OVERDUE_TERMS,
         br.BR_IS_HNAPAY_DEDUCT,
         br.BR_IS_SEND_SMS,
         br.BR_EXPECT_NUM,
         CASE
           WHEN br.BR_OVERDUE_TERMS > 0 AND br.BR_EXPECT_NUM = 1 THEN
            1
           WHEN br.BR_EXPECT_NUM = 1 THEN
            0
           ELSE
            null
         END IS_FIRST_REPAY_OVERDUE,
         case
           when br.BR_EXPECT_NUM = bo.FIRST_OVERDUE_EXPECT_NUM then
            1
           else
            0
         end IS_FIRST_OVERDUE,
         case
           when bg.br_id is not null then
            1
           else
            0
         end IS_COMPENSATE,
         bg.bg_time COMPENSATE_TIME,
         bg.bg_returned IS_COMPENSATE_RETURNED,
         bg.bg_returned_time COMPENSATE_RETURNED_TIME,
         br.CREATOR,
         br.UPDATOR,
         br.CREATE_TIME,
         br.UPDATE_TIME,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         bo.BO_AGREE_TIME,
         bo.CATEGORY_NAME_01,
         bo.BIZ_CODE_01,
         bo.BIZ_NAME_01,
         bo.DEPOSITORY_FLAG,
         bo.TRANSFER_ACCOUNT_TIME,
         bo.P_NAME,
         bo.P_KEY,
         bo.bia_product,
         bo.biz_name,
         br.BR_EXTRA_FEE,
         br.BR_SERVICE_FEE_OTHER,
         br.BR_POST_CONSULT_FEE,
         bo.IS_GRADUATE 
    from odsopr.borrows_repayment br
    JOIN idw.fact_borrows_plus bo
      ON br.bo_id = bo.bo_id
     and bo.bo_is_success = 1
    left join (select br_id,
                      bg_time,
                      bg_returned,
                      bg_returned_time,
                      row_number() over(partition by br_id order by id desc) as rn
                 from odsopr.borrows_guarantee) bg
      on br.id = bg.br_id
     and bg.rn = 1;

