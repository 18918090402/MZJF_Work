--table DDL

use dw_srm;

drop table if exists dw_srm.dim_rm_user_type ;

CREATE TABLE dw_srm.dim_rm_user_type 
(
     dw_create_by            string          comment '数据创建者'
    ,dw_create_time          string          comment '数据创建时间'
    ,user_type_cd            string          comment '风控用户分类编码'
    ,user_type_name          string          comment '风控用户分类名称'
)
comment '风控用户分类表'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;

--insert 
insert into dw_srm.dim_rm_user_type values ('SYS', '2018-11-26 12:00:00', '0', '新客户');

insert into dw_srm.dim_rm_user_type values ('SYS', '2018-11-26 12:00:00', '1', '老客户');

--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_rm_user_type ;

create view dw_srmopr.dim_rm_user_type
(
     dw_create_by            comment '数据创建者'
    ,dw_create_time          comment '数据创建时间'
    ,user_type_cd            comment '风控用户分类编码'
    ,user_type_name          comment '风控用户分类名称'
)
comment '风控用户分类表'
as
select 
     dw_create_by
    ,dw_create_time
    ,user_type_cd
    ,user_type_name
from dw_srm.dim_rm_user_type
;
