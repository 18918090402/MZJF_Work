--table DDL

use dw_srm;

drop table if exists dw_srm.dim_school_cat ;

CREATE TABLE dw_srm.dim_school_cat 
(
     school_type            int             comment '学校类型'
    ,school_type_desc       string          comment '学校类型说明'
)
comment '用户学校类型'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_school_cat ;

create view dw_srmopr.dim_school_cat
(
     school_type               comment '学校类型'
    ,school_type_desc          comment '学校类型说明'
)
comment '用户学校类型'
as
select 
     school_type
    ,school_type_desc
from dw_srm.dim_school_cat
;
