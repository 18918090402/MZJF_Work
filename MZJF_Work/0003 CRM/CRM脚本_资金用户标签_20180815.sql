--用户在投年化，计划类产品
select a.*,b.expect,b.expect_unit,a.aum/12*b.expect from fact_biz_nono_aum a left join odsopr.finance_plan b
on  a.fp_id=b.id
where stat_date='2018-07-17' and a.user_id=7771243
limit 10;


--近一年用户最高在投
select user_id,max(saum) from (
select user_id,stat_date,sum(aum) saum from fact_biz_nono_aum 
where stat_date>=date_add(current_timestamp(),-365)  --'2017-07-17' 
group by user_id,stat_date) a
group by 1


---最近一月投资次数
select user_id,count(invest_amt) from idw.fact_biz_nono_invest 
where invest_time>=to_date(date_add(now(),-30))
group by 1
LIMIT 10 

---总邀请投资金额

select recommender,sum(nono_total_invest_amt)  from dim_user
group by 1

---最近邀请好友时间
select recommender,max(register_time)  from dim_user
group by 1

---最近30天论坛登录活跃度
select info.user_id,count(distinct(date(log.create_time))) 登录天数 from db_nono_oauth.oauth_user_action_log log
join oauth_user_open_info info on log.open_id = info.open_id
where log.create_time > to_date(date_add(now(),-30))
group by 1


---最近90天商城兑换活跃度
select user_id,count(1) 兑换次数 from activity_vip_physicalgoods
where cbp_time>=to_date(date_add(now(),-90))
group by 1

---最近90天投资活跃度
select user_id,count(invest_amt) from idw.fact_biz_nono_invest 
where invest_time>=to_date(date_add(now(),-90))
group by 1

---最近登录时间
select user_id,last_login_time  from dim_user
where last_login_time is not null

---最近登录间隔天数
select user_id,min(ldate),max(ldate),case when max(ldate)=min(ldate) then datediff(to_date(date_add(now(),-1)),to_date(max(ldate))) else datediff(max(ldate),min(ldate)) end daydif
from (
select *,RANK() OVER(PARTITION BY user_id ORDER BY ldate DESC) RK
from  
(select user_id,to_date(logon_time) ldate from odsopr.user_login_detail_log_new
where login_biz='nono'
group by 1,2) t 
limit 100 ) t2
where RK<=2 
group by 1

---当月累计签到次数
select user_id,count(distinct to_date(create_time)) from odsopr.coin_log
where remark like '%每日签到%' and substr(create_time,1,7)=substr(to_date(date_add(now(),-1)),1,7)
group by 1


---最近一次签到时间
select user_id,max(create_time) from odsopr.coin_log
where remark like '%每日签到%' 
group by 1

---潜在流失系数
select user_id,sum(zaum),sum(ymaum),sum(zaum)/sum(ymaum) '昨日在投/近一年最高在投'
from 
(select user_id,sum(aum) zaum,0 ymaum from idw.fact_biz_nono_aum
where stat_date=to_date(date_add(now(),-1))
group by 1
union all
select user_id,0,max(daum) ymaum from 
(select user_id,stat_date,sum(aum) daum from idw.fact_biz_nono_aum
where stat_date>=to_date(date_add(now(),-365))
group by 1,2) c
group by 1
) t
group by 1

---流失用户等级
select *,datediff(to_date(date_add(now(),-1)),to_date(ldaum)) 流失天数 from 
(select user_id,max(stat_date) ldaum from idw.fact_biz_nono_aum
group by 1
) t
where datediff(to_date(date_add(now(),-1)),to_date(ldaum))>0
limit 10

---当日在投与前一日在投系数
select user_id,sum(zaum),sum(qaum),sum(zaum)/sum(qaum) 昨日在投/前日在投
from 
(select user_id,sum(aum) zaum,0 qaum from idw.fact_biz_nono_aum
where stat_date=to_date(date_add(now(),-1))
group by 1
union all
select user_id,0,sum(aum) qaum from idw.fact_biz_nono_aum
where stat_date=to_date(date_add(now(),-2))
group by 1) c
group by 1

---可用补贴券数
select user_id,count(1) from odsopr.db_nono_user_coupon a 
where a.is_used =0 and a.stop_time>=to_date(date_add(now(),-1)) and type=1
group by 1

---补贴券最近失效时间
select user_id,min(stop_time) from odsopr.db_nono_user_coupon a 
where a.is_used =0 and a.stop_time>=to_date(date_add(now(),-1)) and type=1
group by 1

---可用抵用券金额
select user_id,sum(value) from odsopr.db_nono_user_coupon a 
where a.is_used =0 and a.stop_time>=to_date(date_add(now(),-1)) and type=0
group by 1

---抵用券最近失效时间
select user_id,min(stop_time) from odsopr.db_nono_user_coupon a 
where a.is_used =0 and a.stop_time>=to_date(date_add(now(),-1)) and type=0
group by 1


---待激活现金红包金额
select user_id,sum(amount) from mkt_red_packet
where status=0  and type!=3
group by 1


---可用诺币
select a.user_id,sum(a.income)-sum(a.expend) jiey from odsopr.coin_log cl group by 1


---待激活特权本金金额
select user_id,sum(amount) from  odsopr.mkt_experience_cash
where status=0
group by 1


---待激活特权本金金额
select user_id,min(invalid_date) from  odsopr.mkt_experience_cash
where status=0
group by 1


