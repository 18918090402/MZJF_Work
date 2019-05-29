insert overwrite table DMT_CRM.FACT_USER_PROFILE_SNAPSHOT partition (STAT_DATE)
 select t.user_id
           ,t.status_desc
           ,t.register_biz
           ,t.gender
           ,cast(t.age as int)
           ,case when cast(t.age as int) <= 20 then '(0, 20]'
                 when cast(t.age as int) >20 and cast(t.age as int) <= 30 then '(20, 30]'
                 when cast(t.age as int) >30 and cast(t.age as int) <= 40 then '(30, 40]'
                 when cast(t.age as int) >40 and cast(t.age as int) <= 50 then '(40, 50]'
                 when cast(t.age as int) >50 and cast(t.age as int) <= 60 then '(50, 60]'
                 when cast(t.age as int) >60 then '(60, +]'
                 else '未知'
           end as age_category
           ,case when t.USER_RANK_DESC = 'VIP1' then '白银会员'
                 when t.USER_RANK_DESC = 'VIP2' then '黄金会员'
                 when t.USER_RANK_DESC = 'VIP3' then '白金会员'
                 when t.USER_RANK_DESC = 'VIP4' then '黑金会员'
                 when t.USER_RANK_DESC = 'VIP5' then '钻石会员'
                 when t.USER_RANK_DESC = 'VIP6' then '至尊会员'
                 when t.USER_RANK_DESC = '普通会员' then '普通会员'
                 when t.USER_RANK_DESC is null  then '无会员等级'
            end as user_rank_desc 
            ,t.is_register
            ,t.register_time
            ,t.is_bind_card
            ,t.bind_card_time
            ,cast(t.is_deposit as string)
            ,t.is_recharge
            ,t.recharge_time
            ,t.is_invest
            ,t.invest_amt
            ,cast(t.invest_num as int)
            ,t.aum
            ,t.r1y_max_aum
            ,t.login_os
            ,t.phone_brand
            ,t.login_ip
            ,cast(t.login_ip_decimal as bigint)
            ,t.aum_date
            ,t.city_time
            ,t.city_category
            ,t.is_r15d_login
            ,t.is_r3m_invest
            ,case when t.nono_bbs_active_7 > 0 or t.nono_shop_active_7 > 0 or t.nono_sign_active_7 > 0 or t.invite_num_7 > 0 then '1' else '0' end    as is_r7d_interact             
            ,cast(t.nono_bbs_active_7 as int)
            ,cast(t.nono_shop_active_7 as int)
            ,cast(t.nono_sign_active_7 as int)
            ,cast(t.invite_num_7 as int)
            
            ,case when t.is_register = '1' and t.invest_num = 0 then '1' else '0' end                                               as ttl_register_no_invest
            ,case when t.is_register = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) > 0 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) <= 7 then '注册未投资-7天内'
                  when t.is_register = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) > 7 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) <= 15 then '注册未投资-7-15天'
                  when t.is_register = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) > 15 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) <= 30 then '注册未投资-15-30天'
                  when t.is_register = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) > 30 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) <= 60 then '注册未投资-30-60天'
                  when t.is_register = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) > 60 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) <= 90 then '注册未投资-60-90天'
                  when t.is_register = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) > 90 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) <= 180 then '注册未投资-90-180天'
                  when t.is_register = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) > 180 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) <= 365 then '注册未投资-180-365天'
                  when t.is_register = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.register_time, '2010-07-31'))) > 365 then '注册未投资-365天以上'
            end                                                                                                                     as ttl_register_no_invest_lev2             
            
            ,case when t.is_bind_card = '1' and t.invest_num = 0 then '1' else '0' end                                              as ttl_bind_card_no_invest
            ,case when t.is_bind_card = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) > 0 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) <= 7 then '绑卡未投资-7天内'
                  when t.is_bind_card = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) > 7 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) <= 15 then '绑卡未投资-7-15天'
                  when t.is_bind_card = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) > 15 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) <= 30 then '绑卡未投资-15-30天'
                  when t.is_bind_card = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) > 30 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) <= 60 then '绑卡未投资-30-60天'
                  when t.is_bind_card = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) > 60 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) <= 90 then '绑卡未投资-60-90天'
                  when t.is_bind_card = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) > 90 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) <= 180 then '绑卡未投资-90-180天'
                  when t.is_bind_card = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) > 180 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) <= 365 then '绑卡未投资-180-365天'
                  when t.is_bind_card = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.bind_card_time, '2010-07-31'))) > 365 then '绑卡未投资-365天以上'
            end                                                                                                                     as ttl_bind_card_no_invest_lev2              
            
            ,case when t.is_deposit = 1 and t.invest_num = 0 then '1' else '0' end                                                  as ttl_deposit_no_invest
            ,case when t.is_recharge = '1' and t.invest_num = 0 then '1' else '0' end                                               as ttl_recharge_no_invest
            ,case when t.is_recharge = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) > 0 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) <= 7 then '充值未投资-7天内'
                  when t.is_recharge = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) > 7 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) <= 15 then '充值未投资-7-15天'
                  when t.is_recharge = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) > 15 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) <= 30 then '充值未投资-15-30天'
                  when t.is_recharge = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) > 30 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) <= 60 then '充值未投资-30-60天'
                  when t.is_recharge = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) > 60 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) <= 90 then '充值未投资-60-90天'
                  when t.is_recharge = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) > 90 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) <= 180 then '充值未投资-90-180天'
                  when t.is_recharge = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) > 180 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) <= 365 then '充值未投资-180-365天'
                  when t.is_recharge = '1' and t.invest_num = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.recharge_time, '2010-07-31'))) > 365 then '充值未投资-365天以上'
            end                                                                                                                     as ttl_recharge_no_invest_lev2                           
            
            ,case when t.invest_num > 0 and t.invest_num <= 2 then '1' else '0' end                                                 as ttl_rookie_user_lev1
            ,case when t.invest_num > 0 and t.invest_num <= 2 and t.user_rank_desc = '普通会员' then '新手期-普通会员'
                  when t.invest_num > 0 and t.invest_num <= 2 and t.user_rank_desc = '白银会员' then '新手期-白银会员'
                  when t.invest_num > 0 and t.invest_num <= 2 and t.user_rank_desc = '黄金会员' then '新手期-黄金会员'
                  when t.invest_num > 0 and t.invest_num <= 2 and t.user_rank_desc = '白金会员' then '新手期-白金会员'
                  when t.invest_num > 0 and t.invest_num <= 2 and t.user_rank_desc = '黑金会员' then '新手期-黑金会员'
                  when t.invest_num > 0 and t.invest_num <= 2 and t.user_rank_desc = '钻石会员' then '新手期-钻石会员'
                  when t.invest_num > 0 and t.invest_num <= 2 and t.user_rank_desc = '至尊会员' then '新手期-至尊会员'
                  when t.invest_num > 0 and t.invest_num <= 2 and t.user_rank_desc = '无会员等级' then '新手期-无会员等级'
             end                                                                                                                    as ttl_rookie_user_lev2
            ,case when t.invest_num >= 3 and t.invest_num <= 5 then '1' else '0' end                                                as ttl_grow_user_lev1
            ,case when t.invest_num >= 3 and t.invest_num <= 5 and t.user_rank_desc = '普通会员' then '成长期-普通会员'
                  when t.invest_num >= 3 and t.invest_num <= 5 and t.user_rank_desc = '白银会员' then '成长期-白银会员'
                  when t.invest_num >= 3 and t.invest_num <= 5 and t.user_rank_desc = '黄金会员' then '成长期-黄金会员'
                  when t.invest_num >= 3 and t.invest_num <= 5 and t.user_rank_desc = '白金会员' then '成长期-白金会员'
                  when t.invest_num >= 3 and t.invest_num <= 5 and t.user_rank_desc = '黑金会员' then '成长期-黑金会员'
                  when t.invest_num >= 3 and t.invest_num <= 5 and t.user_rank_desc = '钻石会员' then '成长期-钻石会员'
                  when t.invest_num >= 3 and t.invest_num <= 5 and t.user_rank_desc = '至尊会员' then '成长期-至尊会员'
                  when t.invest_num >= 3 and t.invest_num <= 5 and t.user_rank_desc = '无会员等级' then '成长期-无会员等级'
             end                                                                                                                    as ttl_grow_user_lev2              
            ,case when t.invest_num >= 6 then '1' else '0' end                                                                      as ttl_mature_user_lev1
            ,case when t.invest_num >= 6 and t.user_rank_desc = '普通会员' then '成熟期-普通会员'
                  when t.invest_num >= 6 and t.user_rank_desc = '白银会员' then '成熟期-白银会员'
                  when t.invest_num >= 6 and t.user_rank_desc = '黄金会员' then '成熟期-黄金会员'
                  when t.invest_num >= 6 and t.user_rank_desc = '白金会员' then '成熟期-白金会员'
                  when t.invest_num >= 6 and t.user_rank_desc = '黑金会员' then '成熟期-黑金会员'
                  when t.invest_num >= 6 and t.user_rank_desc = '钻石会员' then '成熟期-钻石会员'
                  when t.invest_num >= 6 and t.user_rank_desc = '至尊会员' then '成熟期-至尊会员'
                  when t.invest_num >= 6 and t.user_rank_desc = '无会员等级' then '成熟期-无会员等级'
             end                                                                                                                    as ttl_mature_user_lev2
             ,case when t.invest_num >= 1 and t.aum = 0 then '1' else '0' end                                                       as ttl_empty_user_lev1
             ,case when t.invest_num >= 1 and t.aum = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.aum_date, '2010-07-31'))) <= 7 then '空仓期-7天内空仓'
                   when t.invest_num >= 1 and t.aum = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.aum_date, '2010-07-31'))) > 7 and datediff('${T_SUB_1}', to_date(t.aum_date)) <= 15 then '空仓期-7-15天空仓'
                   when t.invest_num >= 1 and t.aum = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.aum_date, '2010-07-31'))) > 15 and datediff('${T_SUB_1}', to_date(t.aum_date)) <= 30 then '空仓期-15-30天空仓'
                   when t.invest_num >= 1 and t.aum = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.aum_date, '2010-07-31'))) > 30 and datediff('${T_SUB_1}', to_date(t.aum_date)) <= 60 then '空仓期-30-60天空仓'
                   when t.invest_num >= 1 and t.aum = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.aum_date, '2010-07-31'))) > 60 and datediff('${T_SUB_1}', to_date(t.aum_date)) <= 90 then '空仓期-60-90天空仓'
                   when t.invest_num >= 1 and t.aum = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.aum_date, '2010-07-31'))) > 90 and datediff('${T_SUB_1}', to_date(t.aum_date)) <= 180 then '空仓期-90-180天空仓'
                   when t.invest_num >= 1 and t.aum = 0 and datediff('${T_SUB_1}', to_date(ifnull(t.aum_date, '2010-07-31'))) > 180 then '空仓期-180天以上空仓'
             end                                                                                                                    as ttl_empty_user_lev2
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
              end                                                                                                                                     as invest_ratio 
            ,'${T_SUB_1}'                                                                                                                             as stat_date
from 
(    select us.user_id                                                                                                               as user_id
           ,ui.status_desc                                                                                                          as status_desc
           ,ui.register_biz                                                                                                         as register_biz
           ,case when ui.gender = 1 then '男'
                 when ui.gender = 2 then '女'
                 else '未知'
            end                                                                                                                     as gender
           ,ifnull(cast(ui.birthday_age as string), '未知')                                                                         as age
           ,case when ui.USER_RANK_DESC = 'VIP1' then '白银会员'
                 when ui.USER_RANK_DESC = 'VIP2' then '黄金会员'
                 when ui.USER_RANK_DESC = 'VIP3' then '白金会员'
                 when ui.USER_RANK_DESC = 'VIP4' then '黑金会员'
                 when ui.USER_RANK_DESC = 'VIP5' then '钻石会员'
                 when ui.USER_RANK_DESC = 'VIP6' then '至尊会员'
                 when ui.USER_RANK_DESC = '普通会员' then '普通会员'
                 when ui.USER_RANK_DESC is null  then '无会员等级'
            end                                                                                                                     as user_rank_desc 
            ,'1'                                                                                                                    as is_register
            ,ui.register_time                                                                                                       as register_time
            ,case when uba.user_id is not null then '1' else '0' end                                                                as is_bind_card
            ,uba.AUTH_TIME                                                                                                          as bind_card_time
            ,ui.is_deposit                                                                                                          as is_deposit
            ,case when recharge.user_id is not null then '1' else '0' end                                                           as is_recharge
            ,recharge.recharge_time                                                                                                 as recharge_time
            ,case when invest.user_id is not null then '1' else '0' end                                                             as is_invest
            ,ifnull(invest.invest_amt, 0)                                                                                           as invest_amt
            ,ifnull(invest.invest_num, 0)                                                                                           as invest_num
            ,ifnull(aum.aum, 0)                                                                                                     as aum
            ,ifnull(r1y_aum.r1y_max_aum, 0)                                                                                         as r1y_max_aum
            ,mo.login_os                                                                                                            as login_os
            ,mo.phone_brand                                                                                                         as phone_brand
            ,mo.ip                                                                                                                  as login_ip
            ,cast(regexp_extract(mo.ip, '([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)', 1) as int)*power(256, 3) +
             cast(regexp_extract(mo.ip, '([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)', 3) as int)*power(256, 2) +
             cast(regexp_extract(mo.ip, '([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)', 5) as int)*power(256, 1) +
             cast(regexp_extract(mo.ip, '([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)([^0-9]+)([0-9]+)', 7) as int)                   as login_ip_decimal
            ,ad.aum_date                                                                                                            as aum_date
            ,city.city_name                                                                                                         as city_time
            ,case when city.city_name in ('深圳','北京','上海','广州') then '1线城市'
                  when city.city_name in ('成都','南京','武汉','重庆','天津','杭州','郑州','长沙','苏州','西安','东莞','佛山','济南','厦门','青岛','合肥','无锡','宁波','福州','温州','大连') then '2线城市'
                  when city.city_name in ('石家庄','珠海','昆明','南昌','常州','太原','中山','贵阳','南通','哈尔滨','沈阳','泉州','兰州','徐州','南宁','嘉兴','烟台','长春','海口','金华'
                                         ,'绍兴','乌鲁木齐','镇江','唐山','潍坊','廊坊','扬州','台州','泰州','惠州','芜湖','呼和浩特','保定','威海','洛阳') then '3线城市'
                  else '其他4线城市及以下'
            end                                                                                                                     as city_category
            ,case when login.user_id is not null then '1' else '0' end                                                              as is_r15d_login
            ,case when inv.user_id is not null then '1' else '0' end                                                                as is_r3m_invest
            ,ba.nono_bbs_active_7                                                                                                   as nono_bbs_active_7
            ,sh.nono_shop_active_7                                                                                                  as nono_shop_active_7
            ,sign.nono_sign_active_7                                                                                                as nono_sign_active_7
            ,mgm.invite_num_7                                                                                                       as invite_num_7
            ,'${T_SUB_1}'                                                                                                            as stat_date
      from (
                    select ui.user_id
                      from idw.fact_user_info ui 
                     where ui.register_biz = 'nono'   -- 财富注册用户
                       and to_date(ui.register_time) <= '${T_SUB_1}'
                       and ui.status = 1   -- 有效用户
                     union
                    select user_id
                      from idw.fact_biz_nono_invest 
                     where to_date(invest_time) <= '${T_SUB_1}'
                  group by user_id
           ) us
           
 left join idw.fact_user_info ui 
        on ui.user_id = us.user_id
      
 left join (
              select A.user_id, A.AUTH_TIME
                from (
                
                      select uba.USER_ID,
                             uba.AUTH_TIME,
                             ROW_NUMBER() OVER(PARTITION BY uba.USER_ID ORDER BY uba.AUTH_TIME DESC) ID_DESC
                        from odsopr.USER_BANKCARD_AUTH uba
                       where uba.AUTH_STATUS IN (1, 2, 5)
                         and to_date(uba.AUTH_TIME) <= '${T_SUB_1}'
                     ) A
               where A.ID_DESC = 1 
           ) uba
        on uba.user_id = ui.user_id 
        
 left join (
                select a.user_id, a.recharge_time
                from (select user_id, recharge_time, row_number() over(partition by user_id order by recharge_time desc) rn_desc 
                    from IDW.FACT_BIZ_NONO_RECHARGE
                    where to_date(recharge_time) <= '${T_SUB_1}'
                ) a
                where a.rn_desc = 1 
           ) recharge
         on recharge.user_id = ui.user_id
         
 left join (
                select user_id, sum(invest_amt) invest_amt, count(1) invest_num
                  from idw.fact_biz_nono_invest 
                 where to_date(invest_time) <= '${T_SUB_1}'
              group by user_id
           ) invest
        on invest.user_id = ui.user_id 
        
 left join (
                select user_id, sum(aum) aum
                  from idw.fact_biz_nono_aum
                 where stat_date = '${T_SUB_1}'
              group by user_id
           ) aum 
        on aum.user_id = ui.user_id 
        
 left join (
                select a.user_id, max(a.aum) r1y_max_aum 
                  from (
                            select user_id, stat_date, sum(aum) aum
                              from idw.fact_biz_nono_aum
                             where stat_date >= to_date(date_sub('${T_SUB_1}', 366))
                               and to_date(stat_date) <= to_date(date_sub('${T_SUB_1}', 2))
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
                           and to_date(logon_time) <= '${T_SUB_1}' 
                       ) a
                 where a.rn = 1 
           ) mo        
        on mo.user_id = ui.user_id
        
 left join (
                    select user_id, max(stat_date) aum_date
                           ,sum(case when stat_date = '${T_SUB_1}' then aum else 0 end) as curr_aum   -- T-1 的 aum
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
                  FROM ODSOPR.USER_INFO_DETAIL uid
             LEFT JOIN odsopr.region r2
                    on uid.REGISTER_CITY = cast(r2.code as string)
             LEFT JOIN odsopr.region r4
                    on uid.CURRENT_CITY = cast(r4.code as string)
             left join odsopr.user_info ui 
                    on ui.id = uid.user_id
             left join msc.dim_mobile_site_201809 m 
                    on m.mobile_num = substr(ui.mobile_num,1,7)
           ) city 
        on city.user_id = ui.user_id 
        
 left join (
              select user_id 
                FROM odsopr.user_login_detail_log_new
                where login_biz = 'nono' 
                and to_date(date_sub('${T_SUB_1}', 15)) <= to_date(logon_time) 
                group by user_id
           ) login
        on login.user_id = ui.user_id     
        
 left join (
              select user_id
                from idw.fact_biz_nono_invest 
               where to_date(invest_time) >= to_date(date_sub('${T_SUB_1}', 90))
               group by user_id
           ) inv
        on inv.user_id = ui.user_id 
        
  left join (
                    select t2.user_id,count(distinct(to_date(t1.create_time))) as nono_bbs_active_7  --最近7天论坛登录活跃度
                      from odsopr.oauth_user_action_log t1
                      join odsopr.oauth_user_open_info t2 
                        on t1.open_id = t2.open_id
                     where t1.create_time >= to_date(date_sub('${T_SUB_1}', 7))
                  group by t2.user_id
            ) ba
         on ba.user_id = ui.user_id       

  left join (
                  select user_id, count(1) as nono_shop_active_7   --最近7天商城兑换活跃度
                    from odsopr.activity_vip_physicalgoods
                   where cbp_time >= to_date(date_sub('${T_SUB_1}', 7))
                group by user_id    
            ) sh         
         on sh.user_id = ui.user_id
         
  left join (
                  select user_id,count(distinct(to_date(create_time))) as nono_sign_active_7            --最近7天签到
                    from odsopr.coin_log
                   where remark like '%每日签到%' 
                     and create_time >= to_date(date_sub('${T_SUB_1}', 7))
                group by user_id
            ) sign
         on sign.user_id = ui.user_id
         
  left join (
                   select inviter_id user_id, count(1) invite_num_7
                     from odsopr.user_invite_relation_info 
                    where create_time >= to_date(date_sub('${T_SUB_1}', 7)) 
                 group by inviter_id 
            ) mgm         
         on mgm.user_id = ui.user_id 
         
       where not exists (select 1 from msc.v_nono_invest_special_user a where a.user_id = us.user_id)   --剔除special_user  
) t 
;


