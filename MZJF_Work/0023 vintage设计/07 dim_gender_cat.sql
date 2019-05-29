--table DDL

use dw_srm;

drop table if exists dw_srm.dim_gender_cat ;

CREATE TABLE dw_srm.dim_gender_cat 
(
     gender_type            int             comment '性别'
    ,gender_type_desc       string          comment '性别说明'
)
comment '用户性别'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_gender_cat ;

create view dw_srmopr.dim_gender_cat
(
     gender_type               comment '性别'
    ,gender_type_desc          comment '性别说明'
)
comment '用户性别'
as
select 
     gender_type
    ,gender_type_desc
from dw_srm.dim_gender_cat
;
