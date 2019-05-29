CREATE TABLE CSYY_DEBT_TRANSFER_FROM_NONO_CHANGE(
  bo_id string COMMENT '标的号', 
  ba_price decimal(38,10) COMMENT '金额', 
  debter_name string COMMENT '借款人姓名', 
  sex string COMMENT '性别', 
  school string COMMENT '学校', 
  address string COMMENT '地址', 
  certificate_number string COMMENT '身份证', 
  debt_detail_desc string COMMENT '借款目的', 
  mobile_num string COMMENT '手机号', 
  type string COMMENT '类型:0 新增,1 历史变更,2 删除', 
  dw_create_by string COMMENT '系统字段-创建者', 
  dw_create_time string COMMENT '系统字段-创建时间', 
  dw_update_by string COMMENT '系统字段-修改者', 
  dw_update_time string COMMENT '系统字段-修改时间')
COMMENT '诺诺转让债权到财神'
PARTITIONED BY ( 
  stat_date string COMMENT '分区键:数据所属日期')
TBLPROPERTIES (
  'parquet.compression'='SNAPPY')