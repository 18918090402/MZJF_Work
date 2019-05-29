drop table if exists dmt_rm.fact_maiya_order_hor_static  ;
CREATE TABLE dmt_rm.fact_maiya_order_hor_static 
(
    order_no STRING COMMENT '订单号'
    ,bo_id bigint COMMENT 'nonobank订单id'
    ,status bigint COMMENT '订单状态：未提交、审核中、审批未通过、审批成功、回退初审、回退复审、待放款、已放款、还款中、还款完毕'
    ,principal decimal(20,2) COMMENT '本金'
    ,year_rate decimal(20,2) COMMENT '年利率'
    ,service_money decimal(20,2) COMMENT '服务费'
    ,total_parts bigint COMMENT '订单总期数'
    ,zm_score DECIMAL(5,2) COMMENT '芝麻分'
    ,zm_real_name STRING COMMENT '芝麻姓名认证是否成功,sucess成功,fail失败'
    ,td_finalscore DECIMAL(5,2) COMMENT '同盾,风险分数'
    ,td_mul_invest_7d INT COMMENT '7天内申请人在多个平台申请借款次数(同盾)'
    ,td_mul_invest_1m INT COMMENT '1个月内申请人在多个平台申请借款次数(同盾)'
    ,td_mul_invest_3m INT COMMENT '3个月内申请人在多个平台申请借款次数(同盾)'
    ,td_mul_invest_6m INT COMMENT '6个月内申请人在多个平台申请借款次数(同盾)'
    ,td_mul_invest_12m INT COMMENT '12个月内申请人在多个平台申请借款次数(同盾)'
    ,td_mul_invest_18m INT COMMENT '18个月内申请人在多个平台申请借款次数(同盾)'    
    ,td_sfzh_black_list STRING COMMENT '身份证号命中的黑名单类型'
    ,td_mobile_black_list STRING COMMENT '手机号命中的黑名单类型'
    ,jxl_online_duration INT COMMENT '聚信立在网时长(手机号码聚信立显示总使用月份)'
    ,tx_online_duration INT COMMENT '天行数科-在网时长'
    ,jd_score DECIMAL(5,2) COMMENT '京东信用分数'
    ,zzc_num INT COMMENT '中智诚命中数'
    ,tx_score DECIMAL(5,2) COMMENT '腾讯反欺诈分数'
    ,dw_create_by STRING COMMENT '系统字段-创建者'
    ,dw_create_time STRING COMMENT '系统字段-创建时间'
    ,dw_update_by STRING COMMENT '系统字段-修改者'
    ,dw_update_time STRING COMMENT '系统字段-修改时间' 
)
COMMENT '麦芽订单征信宽表'
PARTITIONED BY (STAT_DATE INT COMMENT '统计日期 年月日')
ROW FORMAT DELIMITED NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;


insert overwrite table dmt_rm.fact_maiya_order_hor_static partition (stat_date)
select  oo.order_no                                                                                            order_no                --订单号
        ,oo.bo_id                                                                                              bo_id                   --标的
        ,oo.status                                                                                             status                  --状态
        ,oo.principal                                                                                          principal               --本金
        ,oo.year_rate                                                                                          year_rate               --年利率
        ,oo.service_money                                                                                      service_money           --服务费
        ,oo.total_parts                                                                                        total_parts             --订单总期数
        ,max(case when zm.success = 'true' then zm.zmScore end)                                                ZM_SCORE                --芝麻分
        ,max(case when zm.success = 'true' then zm.isRealName end)                                             ZM_Real_name            --芝麻姓名认证
        ,max(case when td.success = 'true' then td.finalScore end)                                             TD_FINALSCORE           --同盾风险分
        ,sum(case when td2.item_name = '7天内申请人在多个平台申请借款' then td2.platform_count end)            td_mul_invest_7d        --7天内申请人在多个平台申请借款次数(同盾)
        ,sum(case when td2.item_name = '1个月内申请人在多个平台申请借款' then td2.platform_count end)          td_mul_invest_1m        --1个月内申请人在多个平台申请借款次数(同盾)
        ,sum(case when td2.item_name = '3个月内申请人在多个平台申请借款' then td2.platform_count end)          td_mul_invest_3m        --3个月内申请人在多个平台申请借款次数(同盾)
        ,sum(case when td2.item_name = '6个月内申请人在多个平台申请借款' then td2.platform_count end)          td_mul_invest_6m        --6个月内申请人在多个平台申请借款次数(同盾)
        ,sum(case when td2.item_name = '12个月内申请人在多个平台申请借款' then td2.platform_count end)         td_mul_invest_12m       --12个月内申请人在多个平台申请借款次数(同盾)
        ,sum(case when td2.item_name = '18个月内申请人在多个平台申请借款' then td2.platform_count end)         td_mul_invest_18m       --18个月内申请人在多个平台申请借款次数(同盾)
        ,max(case when td2.item_name = '身份证命中同盾欺诈低级灰名单' then td2.risk_level end)                 td_sfzh_black_list      --身份证命中同盾欺诈低级灰名单-风险等级
        ,max(case when td2.item_name = '手机号命中同盾欺诈低级灰名单' then td2.risk_level end)                 td_mobile_black_list    --手机号命中同盾欺诈低级灰名单-风险等级
        ,NULL                                                                                                  jxl_online_duration     --聚信立在网时长(手机号码聚信立显示使用月份)
        ,max(txsc.onlineTime)                                                                                  TX_ONLINE_DURATION      --天行在网时长
        ,max(jd.score)                                                                                         jd_score                --京东信用
        ,max(zzc.countx)                                                                                       zzc_num                 --中智诚命中数
        ,max(tx.riskScore)                                                                                     tx_score                --腾讯反欺诈
        ,'SYS'                                                                                                 DW_CREATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss')                                                DW_CREATE_TIME
        ,'SYS'                                                                                                 DW_UPDATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss')                                                DW_UPDATE_TIME
        ,FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyyMMdd')                                        STAT_DATE
from dmt_rm.fact_apply_maiya_data amd

left join odsopr.ORD_ORDER oo 
on oo.order_no = amd.order_no

left join odsopr.ORD_USER_HONOR ouh
on ouh.order_id = oo.id

left join (
    select t.id,t.order_id,t1.zmScore,t1.isRealName,t1.success 
    from odsopr.ORD_USER_HONOR t 
    lateral view json_tuple(t.data, 'zmScore', 'isRealName', 'success') t1 as zmScore, isRealName, success 
    where t.honor_type = 'ZHIMA' 
) zm 
on zm.id = ouh.id

left join (
    select t.id,t.order_id,t1.finalScore,t1.success 
    from odsopr.ORD_USER_HONOR t 
    lateral view json_tuple(t.data, 'finalScore', 'success') t1 as finalScore, success 
    where t.honor_type = 'TONGDUN' 
) td 
on td.id = ouh.id

left join (
    select t.id,t.order_id,t2.onlineTime
    from odsopr.ORD_USER_HONOR t 
    lateral view json_tuple(t.data, 'TXSK_ONLINETIME') t1 as TXSK_ONLINETIME 
    lateral view json_tuple(t1.TXSK_ONLINETIME, 'onlineTime') t2 as onlineTime        
    where t.honor_type = 'TXSK_ONLINETIME' 
) txsc 
on txsc.id = ouh.id

left join (
    select t.id,t.order_id,t2.score
    from odsopr.ORD_USER_HONOR t 
    lateral view json_tuple(t.data, 'panguData') t1 as panguData
    lateral view json_tuple(t1.panguData, 'score') t2 as score    
    where t.honor_type = 'ZROBOT_PANGU' 
) jd 
on jd.id = ouh.id

left join (
    select t.id,t.order_id,t1.countx
    from odsopr.ORD_USER_HONOR t 
    lateral view json_tuple(t.data, 'count') t1 as countx
    where t.honor_type = 'ZHONGZHICHENG' 
) zzc 
on zzc.id = ouh.id

left join (
    select t.id,t.order_id,t1.riskScore
    from odsopr.ORD_USER_HONOR t 
    lateral view json_tuple(t.data, 'riskScore') t1 as riskScore
    where t.honor_type = 'TXFQZ' 
) tx 
on tx.id = ouh.id

left join (
    select c.id,t1.item_name,t1.risk_level,t2.platform_count
    from 
    (
        select t.id,t.order_id,t2.tongDunInfo 
        from odsopr.ORD_USER_HONOR t 
        lateral view json_tuple(t.data, 'tongDunInfo', 'success') t1 as tongDunInfo, success 
        lateral view explode(split(regexp_replace(regexp_extract(t1.tongDunInfo, '^\\[(.+)\\]$', 1), '\\}\\,\\{', '\\}\\|\\|\\{'), '\\|\\|')) t2 as tongDunInfo
        where t.honor_type = 'TONGDUN'
    ) c
    lateral view json_tuple(c.tongDunInfo, 'item_id', 'item_name', 'risk_level', 'item_detail') t1 as item_id,item_name,risk_level,item_detail
    lateral view json_tuple(t1.item_detail, 'platform_count') t2 as platform_count
) td2
on td2.id = ouh.id

where amd.stat_date = FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyyMMdd') 
group by oo.order_no,oo.bo_id,oo.status,oo.principal,oo.year_rate,oo.service_money,oo.total_parts, 24,25,26,27,28 
;


