select 
a.bo_id
,a.user_id
,a.bo_price
,date_format(a.bo_finish_time,\'yyyy-MM-dd HH:mm:ss\') as bo_finish_time
,date_format(a.bo_audit_time ,\'yyyy-MM-dd HH:mm:ss\') as bo_audit_time 
,a.confirm_pass_price as bo_audit_price
,a.bo_finish_price
,date_format(a.bo_sign_time ,\'yyyy-MM-dd HH:mm:ss\') as bo_sign_time 
,date_format(a.create_time ,\'yyyy-MM-dd HH:mm:ss\') as bo_create_time 
,a.bo_rate
,a.bo_sign_result
,(case when a.bo_is_success=1 then (row_number() over (partition by a.user_id,a.bo_is_success order by a.create_time asc ) ) else null end) as is_success_first
,a.p_name
,a.bo_expect
,a.bo_expect_cat
,a.is_video_audit
,a.bo_is_success
,a.total_amount
,a.base_amount
,a.bo_last_repayed_time as last_repayed_time
,a.all_repayed_time
,a.bo_all_repayed
,date_format(a.ml_time ,\'yyyy-MM-dd HH:mm:ss\') as ml_time
,date_format(a.bo_success_time ,\'yyyy-MM-dd HH:mm:ss\') as bo_success_time
,date_format(a.reject_time ,\'yyyy-MM-dd HH:mm:ss\') as reject_time
,date_format(a.fail_time ,\'yyyy-MM-dd HH:mm:ss\') as fail_time
,a.bo_purpose
,date_format(a.pass_time ,\'yyyy-MM-dd HH:mm:ss\') as pass_time
,b.unrepay_cnt as in_repay_expect
,b.is_overdue_unrepay
,c.create_time as bp_time
,d.biz_code biz_code_01
,d.biz_name biz_name_01
from idw.fact_borrows as a ,idw.fact_in_repay_borrows_snapshot b ,idw.fact_borrows_prepare c, odsopr.dim_bia_asset_product d
where a.bo_id = b.bo_id
and b.stat_date = \'{T_SUB_1}\'
and a.bp_id = c.bp_id
and a.p_key = d.p_key
and d.biz_code in ("mzjk","bld","mxd") 
