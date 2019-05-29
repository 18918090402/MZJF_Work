--table DDL

use dw_srm;

drop table if exists dw_srm.dim_level_cat ;

CREATE TABLE dw_srm.dim_level_cat 
(
     level_type            string          comment '客户等级'
    ,level_type_desc       string          comment '客户等级说明'
)
comment '客户等级表'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_level_cat ;

create view dw_srmopr.dim_level_cat
(
     level_type               comment '客户等级'
    ,level_type_desc          comment '客户等级说明'
)
comment '客户等级表'
as
select 
     level_type
    ,level_type_desc
from dw_srm.dim_level_cat
;
