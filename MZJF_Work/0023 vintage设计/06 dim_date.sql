--table DDL

drop table if exists dw_srm.dim_date;

create table dw_srm.dim_date comment '日期维表'
as 
select day_short_desc,
       day_long_desc,
       month_short_desc,
       month_long_desc,
       concat(substr(quarter_id,1,4), 'Q', substr(quarter_id,5,1)) quarter_short_desc,
       quater_long_desc,
       year_long_desc
from idw.dim_date_new ;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_date ;

create view dw_srmopr.dim_date
(
     day_short_desc           comment '日期'
    ,day_long_desc            comment '日期说明'
    ,month_short_desc         comment '月份'
    ,month_long_desc          comment '月份说明'
    ,quarter_short_desc       comment '季度'
    ,quater_long_desc         comment '季度说明'
    ,year_long_desc           comment '年度'
)
comment '日期维表'
as
select day_short_desc,
       day_long_desc,
       month_short_desc,
       month_long_desc,
       quarter_short_desc,
       quater_long_desc,
       year_long_desc
from dw_srm.dim_date ;
;

