--table DDL

use dw_srm;

drop table if exists dw_srm.dim_region_cat ;

CREATE TABLE dw_srm.dim_region_cat 
(
     province_cd              string          comment '省份编码'
    ,province_name            string          comment '省份名称'
    ,region_cd                string          comment '区域编码'
    ,region_name              string          comment '区域名称'
)
comment '区域'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;






--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_region_cat ;

create view dw_srmopr.dim_region_cat
(
     province_cd              comment '省份编码'
    ,province_name            comment '省份名称'
    ,region_cd                comment '区域编码'
    ,region_name              comment '区域名称'
)
comment '区域'
as
select 
     province_cd              
    ,province_name            
    ,region_cd                
    ,region_name              
from dw_srm.dim_region_cat
;

