select 
invest_src_id
,invest_src_tab
,user_id
,invest_type_code
,terminal_code
,invest_amt
,status
,category_name_02
,expect
,expect_unit_code
,date_format(invest_time,\'yyyy-MM-dd HH:mm:ss\') as invest_time
,date_format(lock_end_time,\'yyyy-MM-dd HH:mm:ss\') as lock_end_time
,invest_amt_yearly
from idw.fact_nono_invest_order 
where platform = 1
limit 500000