--1
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_62_01;

set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;

set hive.exec.parallel=true ;
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;


FROM
(
    select
        t.user_id
        ,t1.nono_aum_yearly
        ,t2.nono_max_aum_year
        ,t3.nono_invet_cnt_month
        ,t4.nono_bbs_active_30
        ,t5.nono_shop_active_90
        ,t6.nono_invest_active_90
        ,t7.nono_login_active_30
        ,t8.nono_login_interval
        ,t9.nono_sign_m
        ,t10.nono_sign_last_time
        ,NULL as nono_no_invest_reason
        ,NULL as nono_tel_cnt
    from idw.user_info t    --用户基础信息表
    left join (
        select a.user_id ,sum(a.aum * b.expect / 12) as nono_aum_yearly  --在投年化金额（计划类产品）
        from idw.fact_biz_nono_aum a 
        left join odsopr.finance_plan b
        on a.fp_id = b.id 
        where a.stat_date = '{T_SUB_1}' 
        and a.fp_id is NOT NULL
        group by a.user_id
    ) t1 on t.user_id = t1.user_id
    left join (
        select a.user_id,max(a.aum) as nono_max_aum_year  --近一年最高在投
        from (
            select user_id,stat_date,sum(aum) aum 
            from idw.fact_biz_nono_aum 
            where stat_date >= date_sub('{T_SUB_1}', 365) 
            group by user_id,stat_date 
        ) a group by a.user_id     
    ) t2 on t.user_id = t2.user_id
    left join (
        select user_id,count(1) as nono_invet_cnt_month   --近一月投资次数
        from idw.fact_biz_nono_invest 
        where invest_time >= date_sub('{T}', 30)
        group by user_id
    ) t3 on t.user_id = t3.user_id
    left join (
        select t2.user_id,count(distinct(to_date(t1.create_time))) as nono_bbs_active_30  --最近30天论坛登录活跃度
        from odsopr.oauth_user_action_log t1
        inner join odsopr.oauth_user_open_info t2 
        on t1.open_id = t2.open_id
        where t1.create_time > date_sub('{T}', 30)
        group by t2.user_id        
    ) t4 on t.user_id = t4.user_id
    left join (
        select user_id, count(1) as nono_shop_active_90   --最近90天商城兑换活跃度
        from odsopr.activity_vip_physicalgoods
        where cbp_time >= date_sub('{T}', 90)
        group by user_id    
    ) t5 on t.user_id = t5.user_id
    left join (
        select user_id,count(invest_amt) as nono_invest_active_90   --最近90天投资活跃度
        from idw.fact_biz_nono_invest 
        where invest_time >= date_sub('{T}', 90)
        group by user_id    
    ) t6 on t.user_id = t6.user_id
    left join (
        SELECT user_id, count(distinct to_date(logon_time)) as nono_login_active_30   --最近30天登录活跃度
        FROM odsopr.user_login_detail_log_new
        where login_biz = 'nono' 
        and logon_time >= date_sub('{T}', 30)
        group by user_id    
    ) t7 on t.user_id = t7.user_id
    left join (
        select t2.user_id
            ,case when max(ldate) = min(ldate) then datediff(to_date(date_sub('2018-08-21', 1)) ,to_date(max(ldate))) 
             else datediff(max(ldate) ,min(ldate)) end as nono_login_interval      
        from 
        (   select t.user_id, t.ldate, RANK() OVER(PARTITION BY t.user_id ORDER BY t.ldate DESC) RK
            from ( select distinct user_id, to_date(logon_time) ldate from odsopr.user_login_detail_log_new where login_biz = 'nono'  ) t ) t2 
            where t2.RK <= 2 group by t2.user_id
    )t8 on t.user_id = t8.user_id
    left join (
        select user_id,count(distinct to_date(create_time)) as nono_sign_m         --当月累计签到次数
        from odsopr.coin_log
        where remark like '%每日签到%' 
        and substr(create_time,1,7) = substr(to_date(date_sub('{T}', 1)),1,7)
        group by user_id    
    ) t9 on t.user_id = t9.user_id
    left join (
        select user_id,max(create_time) as nono_sign_last_time            --最近一次签到时间
        from odsopr.coin_log
        where remark like '%每日签到%' 
        group by user_id    
    ) t10 on t.user_id = t10.user_id   
    --left join (
    --
    --) t11 on t.user_id = t11.user_id  
    --left join (
    --
    --) t12 on t.user_id = t12.user_id      
    where t.stat_date = '{T_SUB_1}' 
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=299) SELECT USER_ID, NONO_AUM_YEARLY, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=300) SELECT USER_ID, NONO_MAX_AUM_YEAR, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=301) SELECT USER_ID, NONO_INVET_CNT_MONTH, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=304) SELECT USER_ID, NONO_BBS_ACTIVE_30, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=305) SELECT USER_ID, NONO_SHOP_ACTIVE_90, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=306) SELECT USER_ID, NONO_INVEST_ACTIVE_90, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=307) SELECT USER_ID, NONO_LOGIN_ACTIVE_30, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=309) SELECT USER_ID, NONO_LOGIN_INTERVAL, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=310) SELECT USER_ID, NONO_SIGN_M, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=311) SELECT USER_ID, NONO_SIGN_LAST_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=312) SELECT USER_ID, NONO_NO_INVEST_REASON, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=313) SELECT USER_ID, NONO_TEL_CNT, 4
;

--2
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_62_02;

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.auto.convert.join=true;
set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

INSERT OVERWRITE TABLE   IDW.USER_TAG_HIST  PARTITION(TAG_ID,HASH_PARTITION_ID)
SELECT   USER_ID       
        ,TAG_VALUE
        ,'SYS' AS DW_CREATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
        ,'SYS' AS DW_UPDATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
        ,TAG_ID
        ,CAST(PMOD(USER_ID,10) AS INT) HASH_PARTITION_ID 
FROM    IDW.USER_TAG_TMP_01  
WHERE TAG_ID in (299,300,301,304,305,306,307,309,310,311,312,313)
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
;
  
--3
invalidate metadata IDW.USER_TAG_HIST
