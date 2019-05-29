--table DDL

use dw_srm;

drop table if exists dw_srm.dim_td_score_cat ;

CREATE TABLE dw_srm.dim_td_score_cat 
(
     td_score_type            int             comment '同盾分'
    ,td_score_type_desc       string          comment '同盾分说明'
)
comment '同盾分'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_td_score_cat ;

create view dw_srmopr.dim_td_score_cat
(
     td_score_type               comment '同盾分'
    ,td_score_type_desc          comment '同盾分说明'
)
comment '同盾分'
as
select 
     td_score_type
    ,td_score_type_desc
from dw_srm.dim_td_score_cat
;
