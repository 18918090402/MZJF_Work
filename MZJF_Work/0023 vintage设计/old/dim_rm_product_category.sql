--table DDL

use dw_srm;

drop table if exists dw_srm.dim_rm_product_category ;

CREATE TABLE dw_srm.dim_rm_product_category 
(
     dw_create_by            string          comment '数据创建者'
    ,dw_create_time          string          comment '数据创建时间'
    ,start_dt                string          comment '开始日期'
    ,product_cd              string          comment '产品编码'
    ,product_name            string          comment '产品名称'
    ,product_type_cd         string          comment '风控产品分类编码'
    ,product_type_name       string          comment '风控产品分类名称'
    ,product_line_cd         string          comment '风控产品线编码'
    ,product_line_name       string          comment '风控产品线名称'
    ,end_dt                  string          comment '结束日期'
)
comment '风控产品分类表'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;

--insert 
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','010101','专科包','0101','信用贷','01','信贷类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','010102','本科包','0101','信用贷','01','信贷类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','010103','名校贷应急包','0101','信用贷','01','信贷类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','010103','名校贷应急包','0101','信用贷','01','信贷类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','010201','大额借','0102','麦子借款','01','信贷类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','010202','学历贷','0102','麦子借款','01','信贷类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','010203','消费贷','0102','麦子借款','01','信贷类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','010301','白领包','0103','白领贷','01','信贷类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','010302','社保贷','0103','白领贷','01','信贷类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','010303','应届贷','0103','白领贷','01','信贷类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','020101','教育分期','0201','麦芽分期','02','消费金融类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','020102','医美分期','0201','麦芽分期','02','消费金融类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','020201','爱美呗分期(非担保)','0202','爱美呗分期','02','消费金融类','3000-12-31');
insert into dw_srm.dim_rm_product_category values ('SYS','2018-11-27 12:00:00','2018-11-26','020202','爱美呗分期(担保)','0202','爱美呗分期','02','消费金融类','3000-12-31');



--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_rm_product_category ;

create view dw_srmopr.dim_rm_product_category
(
     dw_create_by            comment '数据创建者'
    ,dw_create_time          comment '数据创建时间'
    ,start_dt                comment '开始日期'
    ,product_cd              comment '产品编码'
    ,product_name            comment '产品名称'
    ,product_type_cd         comment '风控产品分类编码'
    ,product_type_name       comment '风控产品分类名称'
    ,product_line_cd         comment '风控产品线编码'
    ,product_line_name       comment '风控产品线名称'
    ,end_dt                  comment '结束日期'
)
comment '风控产品分类表'
as
select 
     dw_create_by            
    ,dw_create_time          
    ,start_dt
    ,product_cd
    ,product_name
    ,product_type_cd         
    ,product_type_name       
    ,product_line_cd         
    ,product_line_name       
    ,end_dt                  
from dw_srm.dim_rm_product_category
;
