--table DDL

use dw_srm;

drop table if exists dw_srm.dim_education_cat ;

CREATE TABLE dw_srm.dim_education_cat 
(
     education_type            int             comment '学历'
    ,education_type_desc       string          comment '学历说明'
)
comment '用户学历'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_education_cat ;

create view dw_srmopr.dim_education_cat
(
     education_type               comment '学历'
    ,education_type_desc          comment '学历说明'
)
comment '用户学历'
as
select 
     education_type
    ,education_type_desc
from dw_srm.dim_education_cat
;
