--table DDL

use dw_srm;

drop table if exists dw_srm.dim_product_cat ;

CREATE TABLE dw_srm.dim_product_cat 
(
     product_cd              string          comment '产品小类编码'
    ,product_name            string          comment '产品小类'
    ,product_type_cd         string          comment '产品大类编码'
    ,product_type_name       string          comment '产品大类'
    ,product_line_cd         string          comment '产品线编码'
    ,product_line_name       string          comment '产品线'
)
comment '风控产品分类表'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;






--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_product_cat ;

create view dw_srmopr.dim_product_cat
(
     product_cd              comment '产品小类编码'
    ,product_name            comment '产品小类'
    ,product_type_cd         comment '产品大类编码'
    ,product_type_name       comment '产品大类'
    ,product_line_cd         comment '产品线编码'
    ,product_line_name       comment '产品线'
)
comment '风控产品分类表'
as
select 
     product_cd
    ,product_name
    ,product_type_cd         
    ,product_type_name       
    ,product_line_cd         
    ,product_line_name                   
from dw_srm.dim_product_cat
;

