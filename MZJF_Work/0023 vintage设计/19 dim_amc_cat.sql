--table DDL

use dw_srm;

drop table if exists dw_srm.dim_amc_cat ;

CREATE TABLE dw_srm.dim_amc_cat 
(
     amc_type            int             comment 'amc'
    ,amc_type_desc       string          comment 'amc说明'
)
comment 'amc'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_amc_cat ;

create view dw_srmopr.dim_amc_cat
(
     amc_type               comment 'amc'
    ,amc_type_desc          comment 'amc说明'
)
comment 'amc'
as
select 
     amc_type
    ,amc_type_desc
from dw_srm.dim_amc_cat
;
