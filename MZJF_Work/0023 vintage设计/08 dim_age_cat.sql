--table DDL

use dw_srm;

drop table if exists dw_srm.dim_age_cat ;

CREATE TABLE dw_srm.dim_age_cat 
(
     age_type            int             comment '年龄'
    ,age_type_desc       string          comment '年龄说明'
)
comment '用户年龄'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_age_cat ;

create view dw_srmopr.dim_age_cat
(
     age_type               comment '年龄'
    ,age_type_desc          comment '年龄说明'
)
comment '用户年龄'
as
select 
     age_type
    ,age_type_desc
from dw_srm.dim_age_cat
;
