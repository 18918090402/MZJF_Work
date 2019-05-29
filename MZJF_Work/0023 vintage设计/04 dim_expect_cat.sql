--table DDL

use dw_srm;

drop table if exists dw_srm.dim_expect_cat ;

CREATE TABLE dw_srm.dim_expect_cat 
(
     expect_type            int             comment '产品期限'
    ,expect_type_desc       string          comment '产品期限说明'
)
comment '产品期限表'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_expect_cat ;

create view dw_srmopr.dim_expect_cat
(
     expect_type               comment '产品期限'
    ,expect_type_desc          comment '产品期限说明'
)
comment '产品期限表'
as
select 
     expect_type
    ,expect_type_desc
from dw_srm.dim_expect_cat
;
