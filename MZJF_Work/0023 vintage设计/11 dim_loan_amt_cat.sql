--table DDL

use dw_srm;

drop table if exists dw_srm.dim_loan_amt_cat ;

CREATE TABLE dw_srm.dim_loan_amt_cat 
(
     loan_amt_type            int             comment '放款金额分类'
    ,loan_amt_type_desc       string          comment '放款金额说明'
)
comment '用户放款金额分类'
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





--VIEW DDL
use dw_srmopr;

drop view if exists dw_srmopr.dim_loan_amt_cat ;

create view dw_srmopr.dim_loan_amt_cat
(
     loan_amt_type               comment '放款金额分类'
    ,loan_amt_type_desc          comment '放款金额说明'
)
comment '用户放款金额分类'
as
select 
     loan_amt_type
    ,loan_amt_type_desc
from dw_srm.dim_loan_amt_cat
;
