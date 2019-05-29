
--nono_user_profile
drop table if exists msc.nono_user_ttl  ;

create table msc.nono_user_ttl
as 
    select ui.user_id
           ,to_date(date_sub('${dt}', 1)) as statis_dt
           ,ui.status_desc
           ,ui.register_biz
           ,case when ui.gender = 1 then '男'
                 when ui.gender = 2 then '女'
                 else '未知'
            end as gender
           ,ifnull(cast(ui.birthday_age as string), '未知') as age
           ,case when ui.USER_RANK_DESC = 'VIP1' then '1白银会员'
                 when ui.USER_RANK_DESC = 'VIP2' then '2黄金会员'
                 when ui.USER_RANK_DESC = 'VIP3' then '3白金会员'
                 when ui.USER_RANK_DESC = 'VIP4' then '4黑金会员'
                 when ui.USER_RANK_DESC = 'VIP5' then '5钻石会员'
                 when ui.USER_RANK_DESC = 'VIP6' then '6至尊会员'
                 when ui.USER_RANK_DESC = '普通会员' then '0普通会员'
                 when ui.USER_RANK_DESC is null  then '无会员等级'
            end as USER_RANK_DESC
            ,'1' as is_register     --是否注册
            ,ui.register_time            
            ,case when uba.user_id is not null then '1' else '0' end as is_bind_card    --是否绑卡
            ,uba.AUTH_TIME as bind_card_time      --绑卡时间
            ,ui.is_deposit  --是否存管
            ,case when recharge.user_id is not null then '1' else '0' end as is_recharge    --是否充值
            ,recharge.recharge_time     --充值时间
            ,case when invest.user_id is not null then '1' else '0' end as is_invest    --是否出借
            ,ifnull(invest.invest_amt, 0) as invest_amt  --出借金额
            ,ifnull(invest.invest_num, 0) as invest_num  --出借次数
            ,ifnull(aum.aum, 0) as aum   --当前在投金额
            ,ifnull(r1y_aum.r1y_max_aum, 0) as r1y_max_aum   --近1年最高在投金额
            ,mo.login_os        --登录系统
            ,mo.phone_brand     --手机品牌
            ,mo.ip              --登录IP
            ,cast(regexp_extract(mo.ip, '([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)', 1) as int)*power(256, 3) +
             cast(regexp_extract(mo.ip, '([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)', 3) as int)*power(256, 2) +
             cast(regexp_extract(mo.ip, '([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)', 5) as int)*power(256, 1) +
             cast(regexp_extract(mo.ip, '([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)', 7) as int) as ip_decimal      --IP转10进制数, 用于匹配城市
            ,ad.aum_date        --最近有在投的日期
            ,city.city_name
            ,case when city.city_name in ('北京','上海','广州','深圳') then '1线城市'
                  when city.city_name in ('成都','杭州','重庆','武汉','苏州','西安','天津','南京','郑州','长沙','沈阳','青岛','宁波','东莞','无锡','合肥','南昌','南宁','昆明','温州','唐山') then '2线城市'
                  when city.city_name in ('乌鲁木齐','贵阳','海口','兰州','银川','西宁','呼和浩特','泉州','包头','南通','大庆','徐州','潍坊','常州','鄂尔多斯','绍兴',
                      '济宁','盐城','邯郸','临沂','洛阳','东营','扬州','台州','嘉兴','沧州','榆林','泰州','镇江','昆山','江阴','张家港','义乌',
                      '金华','保定','吉林','鞍山','泰安','宜昌','襄阳','中山','惠州','南阳','威海','德州','岳阳','聊城','常德','漳州','滨州',
                      '茂名','淮安','江门','芜湖','湛江','廊坊','菏泽','柳州','宝鸡','珠海','绵阳') then '3线城市'
                  else '其他城市'
            end as city_category   
            ,case when login.user_id is not null then '1' else '0' end as is_r15d_login
            ,case when inv.user_id is not null then '1' else '0' end as is_r3m_invest
            ,ba.nono_bbs_active_7
            ,sh.nono_shop_active_7
            ,sign.nono_sign_active_7
            ,ifnull(ad.curr_aum, 0) curr_aum
      from (
                    select ui.user_id
                      from idw.fact_user_info ui 
                     where ui.register_biz = 'nono'   -- 财富注册用户
                       and to_date(ui.register_time) <= to_date(date_sub('${dt}', 1))
                       and ui.status = 1   -- 有效用户
                     union
                    select user_id
                      from idw.fact_biz_nono_invest 
                     where to_date(invest_time) <= to_date(date_sub('${dt}', 1))
                  group by user_id
           ) ui
      
 left join (
              select A.user_id, A.AUTH_TIME
                from (
                
                      select uba.USER_ID,
                             uba.AUTH_TIME,
                             ROW_NUMBER() OVER(PARTITION BY uba.USER_ID ORDER BY uba.AUTH_TIME DESC) ID_DESC
                        from odsopr.USER_BANKCARD_AUTH uba
                       where uba.AUTH_STATUS IN (1, 2, 5)
                     ) A
               where A.ID_DESC = 1 
           ) uba
        on uba.user_id = ui.user_id 
        
 left join (
                select a.user_id, a.recharge_time
                from (select user_id, recharge_time, row_number() over(partition by user_id order by recharge_time desc) rn_desc 
                    from IDW.FACT_BIZ_NONO_RECHARGE
                    where to_date(recharge_time) <= to_date(date_sub('${dt}', 1))
                ) a
                where a.rn_desc = 1 
           ) recharge
         on recharge.user_id = ui.user_id
         
 left join (
                select user_id, sum(invest_amt) invest_amt, count(1) invest_num
                  from idw.fact_biz_nono_invest 
                 where to_date(invest_time) <= to_date(date_sub('${dt}', 1))
              group by user_id
           ) invest
        on invest.user_id = ui.user_id 
        
 left join (
                select user_id, sum(aum) aum
                  from idw.fact_biz_nono_aum
                 where stat_date = to_date(date_sub('${dt}', 1))
              group by user_id
           ) aum 
        on aum.user_id = ui.user_id 
        
 left join (
                select a.user_id, max(a.aum) r1y_max_aum 
                  from (
                            select user_id, stat_date, sum(aum) aum
                              from idw.fact_biz_nono_aum
                             where stat_date >= to_date(date_sub('${dt}', 366))
                               and to_date(stat_date) <= to_date(date_sub('${dt}', 2))
                          group by user_id, stat_date 
                       ) a
              group by a.user_id
           ) r1y_aum 
        on r1y_aum.user_id = ui.user_id 
        
 left join (
                select a.user_id
                       ,case when length(client_version) = 0 then 'H5'
                             when client_version is not null and phone_brand in ('apple','iPhone') then 'IOS'
                             when client_version is not null and phone_brand <> 'apple' and phone_brand is not null then 'Anroid'
                             else '其他'
                        end as login_os, a.phone_brand, a.ip
                        ,client_version 
                  from
                       (
                          select user_id, client_type, client_version, phone_brand, logon_time, ip
                                 ,row_number() over(partition by user_id order by logon_time desc) rn
                          from odsopr.user_login_detail_log_new
                         where logon_status = '0000000'
                           and login_biz = 'nono'
                           and to_date(logon_time) <= to_date(date_sub('${dt}', 1)) 
                       ) a
                 where a.rn = 1 
           ) mo        
        on mo.user_id = ui.user_id
        
 left join (
                    select user_id, max(stat_date) aum_date
                           ,sum(case when stat_date = to_date(date_sub('${dt}', 1)) then aum else 0 end) as curr_aum   -- T-1 的 aum
                      from idw.fact_biz_nono_aum
                  group by user_id
           ) ad        
        on ad.user_id = ui.user_id
        
 left join (
                SELECT uid.USER_ID,
                       r2.name AS HJ_CITY_NAME,
                       r4.name AS CURRENT_CITY_NAME,
                       m.city_desc as mobile_city_name,
                       coalesce(m.city_desc, regexp_replace(r4.name,'[市地区]+',''), regexp_replace(r4.name,'[市地区]+','')) city_name
                  FROM ODS.T_USER_INFO_DETAIL_HIST uid
             LEFT JOIN ods.t_region_hist r2
                    on uid.REGISTER_CITY = cast(r2.code as string)
             LEFT JOIN ods.t_region_hist r4
                    on uid.CURRENT_CITY = cast(r4.code as string)
             left join ods.t_user_info_hist ui 
                    on ui.id = uid.user_id
             left join msc.dim_mobile_site_201809 m 
                    on m.mobile_num = substr(ui.mobile_num,1,7)
           ) city 
        on city.user_id = ui.user_id 
        
 left join (
              select user_id 
                FROM odsopr.user_login_detail_log_new
                where login_biz = 'nono' 
                and to_date(date_sub('${dt}', 15)) <= to_date(logon_time) 
                group by user_id
           ) login
        on login.user_id = ui.user_id     
        
 left join (
              select user_id
                from idw.fact_biz_nono_invest 
               where to_date(invest_time) >= to_date(date_sub('${dt}', 90))
               group by user_id
           ) inv
        on inv.user_id = ui.user_id 
        
  left join (
                    select t2.user_id,count(distinct(to_date(t1.create_time))) as nono_bbs_active_7  --最近7天论坛登录活跃度
                      from odsopr.oauth_user_action_log t1
                      join odsopr.oauth_user_open_info t2 
                        on t1.open_id = t2.open_id
                     where t1.create_time >= to_date(date_sub('${dt}', 7))
                  group by t2.user_id
            ) ba
         on ba.user_id = ui.user_id       

  left join (
                  select user_id, count(1) as nono_shop_active_7   --最近7天商城兑换活跃度
                    from odsopr.activity_vip_physicalgoods
                   where cbp_time >= to_date(date_sub('${dt}', 7))
                group by user_id    
            ) sh         
         on sh.user_id = ui.user_id
         
  left join (
                  select user_id,count(distinct(to_date(create_time))) as nono_sign_active_7            --最近7天签到
                    from odsopr.coin_log
                   where remark like '%每日签到%' 
                     and create_time >= to_date(date_sub('${dt}', 7))
                group by user_id
            ) sign
         on sign.user_id = ui.user_id
         
     --where ui.register_biz = 'nono'   -- 财富注册用户
       --and to_date(ui.register_time) <= to_date(date_sub('${dt}', 1))
       --and ui.USER_RANK_DESC = 'VIP5'
       --and ui.status = 1   -- 有效用户
       where not exists (select 1 from msc.v_nono_invest_special_user a where a.user_id = ui.user_id)   --剔除special_user  
    ;
    








drop table msc.nono_user_ttl_final ;


create table msc.nono_user_ttl_final
as
      select t.user_id
              ,case when t.invest_num >= 1 and t.aum = 0 then '1' else '0' end as ttl_empty_user_lev1
              ,case when t.invest_num >= 1 and t.aum = 0 and datediff(to_date(date_sub('${dt}', 1)), to_date(ifnull(t.aum_date, '2010-07-31'))) <= 7 then '1空仓期-7天内空仓'
                    when t.invest_num >= 1 and t.aum = 0 and datediff(to_date(date_sub('${dt}', 1)), to_date(ifnull(t.aum_date, '2010-07-31'))) > 7 and datediff(to_date(date_sub('${dt}', 1)), to_date(t.aum_date)) <= 15 then '2空仓期-7-15天空仓'
                    when t.invest_num >= 1 and t.aum = 0 and datediff(to_date(date_sub('${dt}', 1)), to_date(ifnull(t.aum_date, '2010-07-31'))) > 15 and datediff(to_date(date_sub('${dt}', 1)), to_date(t.aum_date)) <= 30 then '3空仓期-15-30天空仓'
                    when t.invest_num >= 1 and t.aum = 0 and datediff(to_date(date_sub('${dt}', 1)), to_date(ifnull(t.aum_date, '2010-07-31'))) > 30 and datediff(to_date(date_sub('${dt}', 1)), to_date(t.aum_date)) <= 60 then '4空仓期-30-60天空仓'
                    when t.invest_num >= 1 and t.aum = 0 and datediff(to_date(date_sub('${dt}', 1)), to_date(ifnull(t.aum_date, '2010-07-31'))) > 60 and datediff(to_date(date_sub('${dt}', 1)), to_date(t.aum_date)) <= 90 then '5空仓期-60-90天空仓'
                    when t.invest_num >= 1 and t.aum = 0 and datediff(to_date(date_sub('${dt}', 1)), to_date(ifnull(t.aum_date, '2010-07-31'))) > 90 and datediff(to_date(date_sub('${dt}', 1)), to_date(t.aum_date)) <= 180 then '6空仓期-90-180天空仓'
                    when t.invest_num >= 1 and t.aum = 0 and datediff(to_date(date_sub('${dt}', 1)), to_date(ifnull(t.aum_date, '2010-07-31'))) > 180 then '7空仓期-180天以上空仓'
              end as ttl_empty_user_lev2      
              ,case when t.r1y_max_aum = 0 then '近1年无在投'
                    when t.aum / t.r1y_max_aum > 1.00                                   then '增持'
                    when t.aum / t.r1y_max_aum > 0.95 and t.aum / t.r1y_max_aum <= 1.00 then '正常'
                    when t.aum / t.r1y_max_aum > 0.90 and t.aum / t.r1y_max_aum <= 0.95 then '1级减持'
                    when t.aum / t.r1y_max_aum > 0.80 and t.aum / t.r1y_max_aum <= 0.90 then '2级减持'
                    when t.aum / t.r1y_max_aum > 0.70 and t.aum / t.r1y_max_aum <= 0.80 then '3级减持'
                    when t.aum / t.r1y_max_aum > 0.60 and t.aum / t.r1y_max_aum <= 0.70 then '4级减持'
                    when t.aum / t.r1y_max_aum > 0.50 and t.aum / t.r1y_max_aum <= 0.60 then '5级减持'
                    when t.aum / t.r1y_max_aum > 0.40 and t.aum / t.r1y_max_aum <= 0.50 then '6级减持'
                    when t.aum / t.r1y_max_aum > 0.30 and t.aum / t.r1y_max_aum <= 0.40 then '7级减持'
                    when t.aum / t.r1y_max_aum > 0.20 and t.aum / t.r1y_max_aum <= 0.30 then '8级减持'
                    when t.aum / t.r1y_max_aum <= 0.2                                   then '9级减持'
               end as invest_ratio
              ,t.invest_amt, t.invest_num, t.aum, t.r1y_max_aum
        from msc.nono_user_ttl t
;






select grow_lev2, invest_ratio, count(1) 
from (
select user_id 
       ,invest_ratio
       ,case when t.invest_num >= 3 and t.invest_num <= 5 and t.aum > 0 and t.aum <= 5000 then '1_grow' 
             when t.invest_num >= 3 and t.invest_num <= 5 and t.aum > 5000 and t.aum <= 20000 then '2_grow'
             when t.invest_num >= 3 and t.invest_num <= 5 and t.aum > 20000 and t.aum <= 50000 then '3_grow'
             when t.invest_num >= 3 and t.invest_num <= 5 and t.aum > 50000 and t.aum <= 200000 then '4_grow'
             when t.invest_num >= 3 and t.invest_num <= 5 and t.aum > 200000 and t.aum <= 1000000 then '5_grow'
             when t.invest_num >= 3 and t.invest_num <= 5 and t.aum > 1000000 then '6_grow'
       end as grow_lev2
       ,case when t.invest_num >= 6 and t.aum > 100 and t.aum <= 10000 then '1_mature'
             when t.invest_num >= 6 and t.aum > 10000 and t.aum <= 20000 then '2_mature'
             when t.invest_num >= 6 and t.aum > 20000 and t.aum <= 50000 then '3_mature'
             when t.invest_num >= 6 and t.aum > 50000 and t.aum <= 200000 then '4_mature'
             when t.invest_num >= 6 and t.aum > 200000 and t.aum <= 1000000 then '5_mature'
             when t.invest_num >= 6 and t.aum > 1000000 then '6_mature'
        end as mature_lev2, t.aum , t.invest_num
from msc.nono_user_ttl_final t
) t 
group by 1,2 order by 1,2
;


