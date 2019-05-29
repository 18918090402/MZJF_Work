/* 特殊帐户 */
--nono特殊帐户


--csyy特殊帐户



--在投年化金额（计划类产品）
select a.user_id ,sum(a.aum * b.expect / 12) as nono_aum_yearly
from idw.fact_biz_nono_aum a 
left join odsopr.finance_plan b
on a.fp_id = b.id 
where a.stat_date = '{T_SUB_1}' 
and a.fp_id is NOT NULL
group by a.user_id


--近一年最高在投
select a.user_id,max(a.aum) as nono_max_aum_year
from (
    select user_id,stat_date,sum(aum) aum 
    from idw.fact_biz_nono_aum 
    where stat_date >= date_sub('{T_SUB_1}', 365) 
    group by user_id,stat_date 
) a group by a.user_id 


---近一月投资次数
select user_id,count(1) as nono_invet_cnt_month
from idw.fact_biz_nono_invest 
where invest_time >= date_sub(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'), 30)
group by user_id



/* 邀请信息 */
---总邀请投资金额    ok
select 
    cast(recommender as BIGINT) as user_id                        --recommender出自fact_user_info
    ,sum(nono_total_invest_amt) as nono_prolocutor_invite_amt     --nono_total_invest_amt  TAG=183
from idw.dim_user
where nono_total_invest_amt is NOT NULL
group by user_id


---最近邀请好友时间    ok
select 
    cast(recommender as BIGINT) as user_id                             --recommender出自fact_user_info
    ,max(register_time)         as nono_prolocutor_invite_last_time    --register_time出自fact_user_info
from idw.dim_user
group by user_id


/* 活跃度 */
--最近30天论坛登录活跃度  “源表需要引入 db_nono_oauth.oauth_user_action_log   oauth_user_open_info ”
select info.user_id,count(distinct(date(log.create_time))) as bbs_active_30 
from db_nono_oauth.oauth_user_action_log log
join db_nono_oauth.oauth_user_open_info info 
on log.open_id = info.open_id
where log.create_time > date_sub(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'), 30)
group by info.user_id


--最近90天商城兑换活跃度
select user_id, count(1) as shop_active_90 
from odsopr.activity_vip_physicalgoods
where cbp_time >= date_sub(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'), 90)
group by user_id


--最近90天投资活跃度
select user_id,count(invest_amt) as invest_active_90
from idw.fact_biz_nono_invest 
where invest_time >= date_sub(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'), 90)
group by user_id


--最近30天登录活跃度
SELECT user_id, count(distinct to_date(logon_time)) as login_active_30   --最近30天登录活跃度
FROM odsopr.user_login_detail_log_new
where login_biz = 'nono' 
and logon_time >= date_sub(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'), 30)
group by user_id

--最近登录时间    ok
select 
    user_id
    ,last_login_time      -- TAG_ID = 41        --last_login_time出自fact_user_info
from idw.dim_user
where last_login_time is not null


--最近登录间隔天数
select 
    t2.user_id
    ,min(t2.ldate)
    ,max(t2.ldate)
    ,case 
        when max(ldate) = min(ldate) then datediff(to_date(date_sub(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'), 1)) ,to_date(max(ldate))) 
        else datediff(max(ldate) ,min(ldate)) 
    end as login_interval
from 
(
    select t.user_id, t.ldate, RANK() OVER(PARTITION BY t.user_id ORDER BY t.ldate DESC) RK
    from  
    (
        select user_id, to_date(logon_time) ldate 
        from odsopr.user_login_detail_log_new
        where login_biz = 'nono'
        group by 1,2
    ) t 
) t2
where t2.RK <= 2 
group by t2.user_id


--当月累计签到次数
select user_id,count(distinct to_date(create_time)) as sign_m    --当月累计签到次数
from odsopr.coin_log
where remark like '%每日签到%' 
and substr(create_time,1,7) = substr(to_date(date_sub(from_unixtime(unix_timestamp(), 'yyyy-MM-dd'), 1)),1,7)
group by user_id



--最近一次签到时间
select user_id,max(create_time) as sign_last_time   --最近一次签到时间
from odsopr.coin_log
where remark like '%每日签到%' 
group by user_id



/* 潜在流失 */
--潜在流失系数
select user_id,sum(zaum),sum(ymaum),sum(zaum)/sum(ymaum) as lost_ratio    --潜在流失系数
from 
(   select user_id, sum(aum) zaum, 0 ymaum 
    from idw.fact_biz_nono_aum
    where stat_date = to_date(date_sub('{T_SUB_1}', 1))
    group by 1
    union all
    select user_id,0,max(daum) ymaum from 
    (   select user_id,stat_date,sum(aum) daum 
        from idw.fact_biz_nono_aum
        where stat_date >= to_date(date_sub('{T_SUB_1}', 365)) 
        group by 1,2
    ) c
    group by user_id
) t
group by user_id


--当日在投与前一日在投系数
select user_id,sum(zaum),sum(qaum),sum(zaum)/sum(qaum) as invest_ratio     --当日在投与前一日在投系数
from 
(   select user_id,sum(aum) zaum,0 qaum  from idw.fact_biz_nono_aum where stat_date = '{T_SUB_1}' group by 1
    union all
    select user_id,0,sum(aum) qaum from idw.fact_biz_nono_aum where stat_date = '{T_SUB_2}' group by 1 ) c
group by user_id


/* 流失 */
--流失用户等级
select t.user_id,datediff(to_date(date_sub('{T}',1)), to_date(t.ldaum)) as lost_rank   --流失用户等级 
from (select user_id, max(stat_date) ldaum from idw.fact_biz_nono_aum group by user_id ) t
where datediff(to_date(date_sub('{T}',1)), to_date(t.ldaum)) > 0



/* 客服CRM (预留)*/


/* 福利券信息 */
--可用补贴券数
select user_id, count(1) as bt_coupon_cnt   --可用补贴券数
from odsopr.db_nono_user_coupon a 
where a.is_used = 0 and a.stop_time >= to_date(date_sub('{T}',1)) and type = 1
group by user_id

--补贴券最近失效时间
select user_id, min(stop_time) as bt_coupon_lost_time    --补贴券最近失效时间
from odsopr.db_nono_user_coupon a 
where a.is_used = 0 and a.stop_time >= to_date(date_sub('{T}',1)) and type = 1
group by user_id

--可用抵用券金额
select user_id, sum(value) as dy_coupon_cnt    --可用抵用券金额
from odsopr.db_nono_user_coupon a 
where a.is_used = 0 and a.stop_time >= to_date(date_sub('{T}',1)) and type = 0
group by user_id

--抵用券最近失效时间
select user_id, min(stop_time) as dy_coupon_lost_time     --抵用券最近失效时间
from odsopr.db_nono_user_coupon a 
where a.is_used = 0 and a.stop_time >= to_date(date_sub('{T}',1)) and type = 0
group by user_id


--待激活现金红包金额
select user_id, sum(amount) as cash_packet_wait    --待激活现金红包金额
from odsopr.mkt_red_packet where status = 0  and type <> 3
group by user_id


--可用诺币
select a.user_id, sum(a.income)-sum(a.expend) as nono_money      --可用诺币
from odsopr.coin_log a group by a.user_id


--待激活特权本金金额
select user_id, sum(amount) as tqbj_wait_money    --待激活特权本金金额
from odsopr.mkt_experience_cash where status = 0 
group by user_id


--特权本金最近失效时间
select user_id, min(invalid_date) as tqbj_lost_time     --特权本金最近失效时间
from odsopr.mkt_experience_cash where status = 0
group by user_id


