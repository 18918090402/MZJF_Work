select 
b.user_id
,b.user_name
,case when ui.id = 772715 then null
      when ui.real_name not like '%&%' then ui.real_name
end real_name 
,b.gender
,b.email
,regexp_replace(trim(ui.mobile_num), \'\u0000\', \'\') mobile_num
,b.recommender
,b.register_time
,if(length(ui.id_num) = 15 or length(ui.id_num) = 18,substr(ui.id_num,-4,4),null) id_num
,b.qq
,b.marriage_status
,a.birthday_age
,b.hj_province
,b.hj_city
,b.birthday
,b.finance_advisor
,b.channel_name
,b.register_biz
,b.register_terminal
,a.is_deposit
,c.user_rank
,b.current_province
,b.current_city
,b.industry
,b.is_education_auth
,b.is_student_auth
,c.edu_graduate_date
,c.last_bind_card_bank 
from idw.fact_user_info a ,idw.user_info b ,idw.dim_user c , ods.t_user_info_hist ui
where a.user_id = b.user_id
and b.user_id = c.user_id
and c.user_id = ui.id
and b.stat_date = \'{T_SUB_1}\'
and b.user_id not in ( 772760, 772761, 772762, 772763, 772765 )   --手机号乱码, 且无效用户, 暂删除