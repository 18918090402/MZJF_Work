--table DDL

use dw_srm;

drop table if exists dw_srm.dim_td_platform_7d_cat ;

CREATE TABLE dw_srm.dim_td_platform_7d_cat 
(
     td_platform_type            int             comment '同盾7天多头'
    ,td_platform_type_desc       string          comment '同盾7天多头说明'
)
comment '同盾7天多头'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_td_platform_7d_cat ;

create view dw_srmopr.dim_td_platform_7d_cat
(
     td_platform_type               comment '同盾7天多头'
    ,td_platform_type_desc          comment '同盾7天多头说明'
)
comment '同盾7天多头'
as
select 
     td_platform_type
    ,td_platform_type_desc
from dw_srm.dim_td_platform_7d_cat
;


