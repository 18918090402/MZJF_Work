--1
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_63_01;

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
        ,t1.nono_lost_ratio
        ,t2.nono_invest_ratio
        ,t3.nono_lost_rank
        ,t4.nono_bt_coupon_cnt
        ,t4.nono_bt_coupon_lost_time
        ,t5.nono_dy_coupon_cnt
        ,t5.nono_dy_coupon_lost_time
        ,t6.nono_cash_packet_wait
        ,t7.nono_money
        ,t8.nono_tqbj_wait_money
        ,t8.nono_tqbj_lost_time
    from idw.user_info t    --用户基础信息表
    left join (
        select user_id,sum(zaum)/sum(ymaum) as nono_lost_ratio    --潜在流失系数
        from 
        (   select user_id, sum(aum) zaum, 0 ymaum from idw.fact_biz_nono_aum
            where stat_date = to_date(date_sub('{T_SUB_1}', 1)) group by 1
            union all
            select user_id,0,max(daum) ymaum from 
            (   select user_id,stat_date,sum(aum) daum from idw.fact_biz_nono_aum
                where stat_date >= to_date(date_sub('{T_SUB_1}', 365)) group by 1,2 ) c
            group by user_id ) t
        group by user_id    
    ) t1 on t.user_id = t1.user_id
    left join (
        select user_id,sum(zaum),sum(qaum),sum(zaum)/sum(qaum) as nono_invest_ratio     --当日在投与前一日在投系数
        from 
        (   select user_id,sum(aum) zaum,0 qaum  from idw.fact_biz_nono_aum where stat_date = '{T_SUB_1}' group by 1
            union all
            select user_id,0,sum(aum) qaum from idw.fact_biz_nono_aum where stat_date = date_sub('{T_SUB_1}',1) group by 1 ) c
        group by user_id    
    ) t2 on t.user_id = t2.user_id
    left join (
        select t.user_id,datediff(to_date(date_sub('{T}',1)), to_date(t.ldaum)) as nono_lost_rank   --流失用户等级 
        from (select user_id, max(stat_date) ldaum from idw.fact_biz_nono_aum group by user_id ) t
        where datediff(to_date(date_sub('{T}',1)), to_date(t.ldaum)) > 0     
    ) t3 on t.user_id = t3.user_id
    left join (
        select user_id, count(1) as nono_bt_coupon_cnt        --可用补贴券数
               ,min(stop_time) as nono_bt_coupon_lost_time    --补贴券最近失效时间
        from odsopr.db_nono_user_coupon a 
        where a.is_used = 0 and a.stop_time >= to_date(date_sub('{T}',1)) and type = 1
        group by user_id
    ) t4 on t.user_id = t4.user_id
    left join (
        select user_id, sum(value) as nono_dy_coupon_cnt      --可用抵用券金额
               ,min(stop_time) as nono_dy_coupon_lost_time    --抵用券最近失效时间
        from odsopr.db_nono_user_coupon a 
        where a.is_used = 0 and a.stop_time >= to_date(date_sub('{T}',1)) and type = 0
        group by user_id
    ) t5 on t.user_id = t5.user_id
    left join (
        select user_id, sum(amount) as nono_cash_packet_wait    --待激活现金红包金额
        from odsopr.mkt_red_packet where status = 0  and type <> 3
        group by user_id
    ) t6 on t.user_id = t6.user_id
    left join (
        select a.user_id, sum(a.income)-sum(a.expend) as nono_money      --可用诺币
        from odsopr.coin_log a group by a.user_id
    ) t7 on t.user_id = t7.user_id
    left join (
        select user_id, sum(amount) as nono_tqbj_wait_money    --待激活特权本金金额
               , min(invalid_date) as nono_tqbj_lost_time      --特权本金最近失效时间
        from odsopr.mkt_experience_cash where status = 0 
        group by user_id
    )t8 on t.user_id = t8.user_id
    where t.stat_date = '{T_SUB_1}' 
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=314) SELECT USER_ID, NONO_LOST_RATIO, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=315) SELECT USER_ID, NONO_INVEST_RATIO, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=316) SELECT USER_ID, NONO_LOST_RANK, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=317) SELECT USER_ID, NONO_BT_COUPON_CNT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=318) SELECT USER_ID, NONO_BT_COUPON_LOST_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=319) SELECT USER_ID, NONO_DY_COUPON_CNT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=320) SELECT USER_ID, NONO_DY_COUPON_LOST_TIME, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=321) SELECT USER_ID, NONO_CASH_PACKET_WAIT, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=322) SELECT USER_ID, NONO_MONEY, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=323) SELECT USER_ID, NONO_TQBJ_WAIT_MONEY, 4
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=324) SELECT USER_ID, NONO_TQBJ_LOST_TIME, 4
;


--2
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_63_02;

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
WHERE TAG_ID in (314,315,316,317,318,319,320,321,322,323,324)
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
;
  
--3
invalidate metadata IDW.USER_TAG_HIST
