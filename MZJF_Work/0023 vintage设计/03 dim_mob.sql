--table DDL

use dw_srm;

drop table if exists dw_srm.dim_mob ;

CREATE TABLE dw_srm.dim_mob 
(
     mob            int             comment 'MOB'
    ,mob_desc       string          comment 'MOB说明'
)
comment 'MOB表'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_mob ;

create view dw_srmopr.dim_mob
(
     mob               comment 'MOB'
    ,mob_desc          comment 'MOB说明'
)
comment 'MOB表'
as
select 
     mob
    ,mob_desc
from dw_srm.dim_mob
;
