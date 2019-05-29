drop table if exists idw.user_tag_legacy;
create table if not exists idw.user_tag_legacy
(
   dw_create_by         string comment '系统字段-创建者',
   dw_create_time       string comment '系统字段-创建时间',
   dw_update_by         string comment '系统字段-修改者',
   dw_update_time       string comment '系统字段-修改时间',
   user_id              bigint comment '用户id',
   csyy_first_recharge_time string comment '财神爷爷首次充值时间',
   csyy_first_recharge_amt decimal(38,10) comment '财神爷爷首次充值金额',
   csyy_first_recharge_bank string comment '财神爷爷首次充值银行',
   csyy_first_recharge_type string comment '财神爷爷首次充值类型',
   csyy_last_recharge_time string comment '财神爷爷最近充值时间',
   csyy_last_recharge_amt decimal(38,10) comment '财神爷爷最近充值金额',
   csyy_last_recharge_bank string comment '财神爷爷最近充值银行',
   csyy_last_recharge_type string comment '财神爷爷最近充值类型',
   nono_is_loss_before_2017 int comment '是否诺诺2017年之前流失用户'
)
COMMENT '归档用户标签表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");