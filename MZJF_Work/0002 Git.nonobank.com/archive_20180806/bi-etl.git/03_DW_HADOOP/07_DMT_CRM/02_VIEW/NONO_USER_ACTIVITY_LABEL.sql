CREATE VIEW IF NOT EXISTS DMT_CRM.NONO_USER_ACTIVITY_LABEL
as
select
  t1.user_id           as user_id,
  t1.user_category_cn  as current_user_active_status,
  t2.user_category_cn  as before30d_user_active_status,
  'sys' as dw_create_by,
  from_unixtime(unix_timestamp(),'yyyy-MM-dd HH:mm:ss') as dw_create_time,
  'sys' as dw_update_by,
  from_unixtime(unix_timestamp(),'yyyy-MM-dd HH:mm:ss') as dw_update_time
from
(
select
  stat_date,
  user_category,
  case
    when user_category = 1   then '普通用户'
    when user_category = 2   then '活跃用户'
    when user_category = 3   then '忠诚用户'
    when user_category = 4   then '沉默用户'
    when user_category = 5   then '僵尸用户'
    else '<未知>'  end user_category_cn,
  user_id
from dmt.fact_nono_user_activity_level
where stat_date = date_sub(from_unixtime(unix_timestamp(),'yyyy-MM-dd'),1)
) t1
left join
(
select
  stat_date,
  user_category,
  case
    when user_category = 1    then '普通用户'
    when user_category = 2    then '活跃用户'
    when user_category = 3    then '忠诚用户'
    when user_category = 4    then '沉默用户'
    when user_category = 5    then '僵尸用户'
    else '<未知>'  end user_category_cn,
  user_id
from dmt.fact_nono_user_activity_level
where stat_date = date_sub(from_unixtime(unix_timestamp(),'yyyy-MM-dd'),30)
) t2
on t1.user_id = t2.user_id;