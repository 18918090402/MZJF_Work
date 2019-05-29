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
select recommender,max(register_time)  from dim_user
group by 1

---最近90天商城兑换活跃度
select recommender,max(register_time)  from dim_user
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