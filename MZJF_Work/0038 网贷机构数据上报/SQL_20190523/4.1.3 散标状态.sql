set mapreduce.job.name = pdw_report_03_status; 
set mapreduce.job.queuename = etl-dw;  
set hive.exec.parallel = true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict; 
set hive.exec.max.dynamic.partitions.pernode = 100000000;
set hive.exec.max.dynamic.partitions = 100000000;
set hive.exec.max.created.files = 100000000;


insert overwrite table pdw.report_03_status 


SELECT
    ""                                                                                      version,            --1.接口版本号
    'CERT20190411026'                                                                       sourceCode,         --2.平台编号
    t.bo_id                                                                                 sourceProductCode,  --3.散标信息编号
    '6'                                                                                     productStatus,      --4.状态编码
    date_format(coalesce(bar.create_time,bo.bo_audit_time),'yyyy-MM-dd HH:mm:ss')           productDate,        --5.状态更新时间
    "",
    ""
from 
    (
	select distinct t.bo_id from odsopr.debt_exchange_account_20190430 t
	where 1=1
		and bank_flag = 1 
		and price >= 0.01 
        and status in (1,2,3)
		and not exists (select 1 from idw.fact_borrows bo where bo.all_repayed_time < '2019-05-01' and t.bo_id = bo.bo_id)
	) t
left join odsopr.borrows_audit_record bar
on t.bo_id = bar.bo_id
left join idw.fact_borrows bo
on t.bo_id = bo.bo_id

UNION ALL

SELECT
    ""                                                                                      version,            --1.接口版本号
    'CERT20190411026'                                                                       sourceCode,         --2.平台编号
    t.bo_id                                                                                 sourceProductCode,  --3.散标信息编号
    '1'                                                                                     productStatus,      --4.状态编码
    date_format(bo.bo_finish_time,'yyyy-MM-dd HH:mm:ss')                                    productDate,        --5.状态更新时间
    "",
    ""
from 
    (
	select distinct t.bo_id from odsopr.debt_exchange_account_20190430 t
	where 1=1
		and bank_flag = 1 
		and price >= 0.01 
        and status in (1,2,3)
		and not exists (select 1 from idw.fact_borrows bo where bo.all_repayed_time < '2019-05-01' and t.bo_id = bo.bo_id)
	) t
left join idw.fact_borrows bo
on t.bo_id = bo.bo_id

UNION ALL

SELECT
    ""                                                                                      version,            --1.接口版本号
    'CERT20190411026'                                                                       sourceCode,         --2.平台编号
    t.bo_id                                                                                 sourceProductCode,  --3.散标信息编号
    '9'                                                                                     productStatus,      --4.状态编码
    date_format(bo.bo_success_time,'yyyy-MM-dd HH:mm:ss')                                   productDate,        --5.状态更新时间
    "",
    ""
from 
    (
	select distinct t.bo_id from odsopr.debt_exchange_account_20190430 t
	where 1=1
		and bank_flag = 1 
		and price >= 0.01 
        and status in (1,2,3)
		and not exists (select 1 from idw.fact_borrows bo where bo.all_repayed_time < '2019-05-01' and t.bo_id = bo.bo_id)
	) t
left join idw.fact_borrows bo
on t.bo_id = bo.bo_id

UNION ALL

select
    ""                                                                                      version,            --1.接口版本号
    'CERT20190411026'                                                                       sourceCode,         --2.平台编号
    t.bo_id                                                                                 sourceProductCode,  --3.散标信息编号
    c.productStatus                                                                         productStatus,      --4.状态编码
    c.productDate                                                                           productDate,        --5.状态更新时间
    "",
    ""
from 
    (
	select distinct t.bo_id from odsopr.debt_exchange_account_20190430 t
	where 1=1
		and bank_flag = 1 
		and price >= 0.01 
        and status in (1,2,3)
		and not exists (select 1 from idw.fact_borrows bo where bo.all_repayed_time < '2019-05-01' and t.bo_id = bo.bo_id)
	) t
left join
    (select
        b.*,
        lag(b.productStatus,1,null)over(partition by bo_id order by bo_id,productDate) before_productStatus    --找前一条记录的状态
    from 
        (--放款后首次还款中状态
        select
            date_format(date_add(coalesce(bo_success_time,bo_finish_time),1),'yyyy-MM-dd HH:mm:ss') productDate,
            bo_id,
            '' br_time,
            '' br_repay_time,
            '5' productStatus,
            1 sq
        from idw.fact_borrows
        where 1=1
            and create_time < '2019-05-01' 
            and (all_repayed_time is null or all_repayed_time > '2019-05-01') 
            and bo_is_success = 1
        union all
        --之后每期还款、逾期状态
        select
            a.*,
            if(a.br_repay_time is null,'4','5') productStatus,
            row_number() OVER(partition by a.bo_id,a.productDate order by a.br_time desc) sq 
        from
            (--正常或提前还款，取实还时间为上报时间，状态还款中
            select 
                date_format(date_add(br.br_repay_time,1),'yyyy-MM-dd HH:mm:ss') productDate,
                br.bo_id,
                br.br_time,
                to_date(br.br_repay_time) br_repay_time
            from idw.fact_borrows_repayment br
            left join idw.fact_borrows bo
            on br.bo_id = bo.bo_id
            where 1=1
                and br_time <= '2019-04-30' 
                and to_date(br.br_repay_time) <= br_time 
                and bo.create_time < '2019-05-01' 
                and (all_repayed_time is null or all_repayed_time > '2019-05-01')
            union all 
            --逾期时，取应还时间为上报时间，状态逾期
            select 
                date_format(date_add(br.br_time,1),'yyyy-MM-dd HH:mm:ss') productDate,
                br.bo_id, 
                br.br_time, 
                NULL br_repay_time
            from idw.fact_borrows_repayment br
            left join idw.fact_borrows bo
            on br.bo_id = bo.bo_id
            where 1=1
                and br_time <= '2019-04-30'
                and to_date(br.br_repay_time) > br_time
                and bo.create_time < '2019-05-01' 
                and (all_repayed_time is null or all_repayed_time > '2019-05-01')
            union all 
            --逾期后，有还款的，取实还时间在1个月内的，因为超2个月就到后面几期了，即使还了也可能逾期状态，不用推送了。状态还款中或逾期。
            select 
                date_format(date_add(coalesce(br_repay_time,br_time),1),'yyyy-MM-dd HH:mm:ss') productDate,
                br.bo_id, 
                br.br_time, 
                to_date(br.br_repay_time) br_repay_time
            from idw.fact_borrows_repayment br
            left join idw.fact_borrows bo
            on br.bo_id = bo.bo_id
            where 1=1
                and br_time <= '2019-04-30'
                and ((months_between(to_date(br.br_repay_time),br_time) <= 1) or br.br_repay_time is null)
                and bo.create_time < '2019-05-01' 
                and (all_repayed_time is null or all_repayed_time > '2019-05-01')
                and br.br_repay_time < '2019-05-01'
            ) a
        ) b
    where b.sq = 1
    ) c
on t.bo_id = c.bo_id
where c.before_productStatus is null or c.before_productStatus <> c.productStatus    --取第一条记录状态以及后续记录状态不等于前一条记录状态的
;
--2808333	261396




-- SELECT
                                                                                            -- 'version',          --1.接口版本号
                                                                                            -- sourceCode,         --2.平台编号
    -- bo_id                                                                                   sourceProductCode,  --3.散标信息编号
    -- '逾期'                                                                                  productStatus,      --4.状态编码
    -- stat_date                                                                               productDate         --5.状态更新时间
-- from idw.fact_in_repay_borrows_snapshot
-- where overdue_unrepay_days = 1
-- UNION ALL
-- SELECT
                                                                                            -- 'version',          --1.接口版本号
                                                                                            -- sourceCode,         --2.平台编号
    -- bs1.bo_id                                                                               sourceProductCode,  --3.散标信息编号
    -- '还款中'                                                                                productStatus,      --4.状态编码
    -- bs1.stat_date                                                                           productDate         --5.状态更新时间
-- from 
    -- (SELECT stat_date,bo_id,overdue_unrepay_days from idw.fact_in_repay_borrows_snapshot where overdue_unrepay_days is null) bs1
-- left join 
    -- (SELECT stat_date,bo_id,overdue_unrepay_days from idw.fact_in_repay_borrows_snapshot) bs2
-- on bs1.stat_date = date_add(bs2.stat_date,1) 
-- where bs2.overdue_unrepay_days is not null
-- UNION ALL
-- SELECT
    -- ''                                                                                      'version',          --1.接口版本号
    -- ''                                                                                      sourceCode,         --2.平台编号
    -- bo_id                                                                                   sourceProductCode,  --3.散标信息编号
    -- '还款中'                                                                                productStatus,      --4.状态编码
    -- date_add(to_date(bo_success_time),1)                                                    productDate         --5.状态更新时间
-- from idw.fact_borrows
-- where create_time < '2019-05-01' and (all_repayed_time is null or all_repayed_time > '2019-05-01')
--3123912




-- SELECT
                                                                                            -- 'version',          --1.接口版本号
                                                                                            -- sourceCode,         --2.平台编号
    -- bo_id                                                                                   sourceProductCode,  --3.散标信息编号
    -- '逾期'                                                                                  productStatus,      --4.状态编码
    -- stat_date                                                                               productDate         --5.状态更新时间
-- from idw.fact_in_repay_borrows_snapshot
-- where overdue_unrepay_days = 1
-- UNION ALL
-- SELECT
                                                                                            -- 'version',          --1.接口版本号
                                                                                            -- sourceCode,         --2.平台编号
    -- bs1.bo_id                                                                               sourceProductCode,  --3.散标信息编号
    -- '还款中'                                                                                productStatus,      --4.状态编码
    -- bs1.stat_date                                                                           productDate         --5.状态更新时间
-- from 
    -- (SELECT stat_date,bo_id,overdue_unrepay_days from idw.fact_in_repay_borrows_snapshot where overdue_unrepay_days is null) bs1
-- left join 
    -- (SELECT stat_date,bo_id,overdue_unrepay_days from idw.fact_in_repay_borrows_snapshot) bs2
-- on bs1.stat_date = date_add(bs2.stat_date,1) 
-- where bs2.overdue_unrepay_days is not null
-- UNION ALL
-- SELECT
    -- ''                                                                                      'version',          --1.接口版本号
    -- ''                                                                                      sourceCode,         --2.平台编号
    -- bo_id                                                                                   sourceProductCode,  --3.散标信息编号
    -- '还款中'                                                                                productStatus,      --4.状态编码
    -- date_add(to_date(bo_success_time),1)                                                    productDate         --5.状态更新时间
-- from idw.fact_borrows
-- where create_time < '2019-05-01' and (all_repayed_time is null or all_repayed_time > '2019-05-01')