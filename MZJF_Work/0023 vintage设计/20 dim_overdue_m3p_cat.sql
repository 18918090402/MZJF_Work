--table DDL

use dw_srm;

drop table if exists dw_srm.dim_overdue_m3p_cat ;

CREATE TABLE dw_srm.dim_overdue_m3p_cat 
(
     m3p_type            int             comment '是否逾期M3+'
    ,m3p_type_desc       string          comment '是否逾期M3+说明'
)
comment '逾期M3+'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_overdue_m3p_cat ;

create view dw_srmopr.dim_overdue_m3p_cat
(
     m3p_type               comment '是否逾期M3+'
    ,m3p_type_desc          comment '是否逾期M3+说明'
)
comment '逾期M3+'
as
select 
     m3p_type
    ,m3p_type_desc
from dw_srm.dim_overdue_m3p_cat
;
