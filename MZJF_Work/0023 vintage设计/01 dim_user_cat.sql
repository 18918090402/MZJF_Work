--table DDL

use dw_srm;

drop table if exists dw_srm.dim_user_cat ;

CREATE TABLE dw_srm.dim_user_cat 
(
     user_type            string          comment '客户类型'
    ,user_type_desc       string          comment '客户类型说明'
)
comment '客户类型表'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_user_cat ;

create view dw_srmopr.dim_user_cat
(
     user_type               comment '客户类型'
    ,user_type_desc          comment '客户类型说明'
)
comment '客户类型表'
as
select 
     user_type
    ,user_type_desc
from dw_srm.dim_user_cat
;
