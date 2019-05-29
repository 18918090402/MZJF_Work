--table DDL

use dw_srm;

drop table if exists dw_srm.dim_overdue_m6p_cat ;

CREATE TABLE dw_srm.dim_overdue_m6p_cat 
(
     m6p_type            int             comment '是否逾期M6+'
    ,m6p_type_desc       string          comment '是否逾期M6+说明'
)
comment '逾期M6+'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_overdue_m6p_cat ;

create view dw_srmopr.dim_overdue_m6p_cat
(
     m6p_type               comment '是否逾期M6+'
    ,m6p_type_desc          comment '是否逾期M6+说明'
)
comment '逾期M6+'
as
select 
     m6p_type
    ,m6p_type_desc
from dw_srm.dim_overdue_m6p_cat
;

