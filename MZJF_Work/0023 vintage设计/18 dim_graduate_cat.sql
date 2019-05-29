--table DDL

use dw_srm;

drop table if exists dw_srm.dim_graduate_cat ;

CREATE TABLE dw_srm.dim_graduate_cat 
(
     graduate_type            int             comment '是否毕业'
    ,graduate_type_desc       string          comment '是否毕业说明'
)
comment '毕业情况'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_graduate_cat ;

create view dw_srmopr.dim_graduate_cat
(
     graduate_type               comment '是否毕业'
    ,graduate_type_desc          comment '是否毕业说明'
)
comment '毕业情况'
as
select 
     graduate_type
    ,graduate_type_desc
from dw_srm.dim_graduate_cat
;
