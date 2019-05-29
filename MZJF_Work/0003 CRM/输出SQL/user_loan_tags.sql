select 
user_id,
biz_code_01,
biz_name_01,
credit,
is_apply,
bp_time,
ml_time,
is_ml,
audit,
reject_reason,
bo_all_repayed,
all_repayed_apply_sec,
all_repayed_ml_sec,
all_repayed_reject_sec,
is_overdue,
success_cnt,
is_follow_wp 
from dmt_crm.user_loan_tags
limit 10240
