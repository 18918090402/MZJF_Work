
--暂发现，历史数据中信用贷和麦芽分期，每个月的放款金额会有变动，是 DMT.FACT_REPAY_BORROWS_SNAPSHOT 表数据有误导致
--以下为验证逻辑
--未修复



--信用贷
SELECT sum(case when mob = 3 then v.bo_finish_price else 0 end)  
from dw_srmopr.fact_vintage_snapshot_m v 
where substr(v.product_cd,1,4) = '0101'
and substr(v.bo_finish_date,1,7) = '2016-12'
;





SELECT v.mob, count(1)
from dw_srmopr.fact_vintage_snapshot_m v 
where substr(v.product_cd,1,4) = '0101'
and substr(v.bo_finish_date,1,7) = '2016-12'
GROUP BY 1 ORDER BY 1 
;




SELECT * 
from dw_srmopr.fact_vintage_snapshot_m v 
where substr(v.product_cd,1,4) = '0101'
and substr(v.bo_finish_date,1,7) = '2016-12'
and v.mob = 2 
and bo_id not in (
SELECT bo_id
from dw_srmopr.fact_vintage_snapshot_m v 
where substr(v.product_cd,1,4) = '0101'
and substr(v.bo_finish_date,1,7) = '2016-12'
and v.mob = 3) 
;



SELECT * from msc.fact_vintage_20181205 where bo_id = 1610765 ;





--麦芽分期
SELECT sum(case when mob = 3 then v.bo_finish_price else 0 end)  
from dw_srmopr.fact_vintage_snapshot_m v 
where substr(v.product_cd,1,4) = '0201'
and substr(v.bo_finish_date,1,7) = '2017-06'
;





SELECT v.mob, count(1), sum(v.bo_finish_price)
from dw_srmopr.fact_vintage_snapshot_m v 
where substr(v.product_cd,1,4) = '0201'
and substr(v.bo_finish_date,1,7) = '2017-06'
GROUP BY 1 ORDER BY 1 
;



SELECT *
from dw_srmopr.fact_vintage_snapshot_m v 
where substr(v.product_cd,1,4) = '0201'
and substr(v.bo_finish_date,1,7) = '2017-06'
and v.mob = 1 
and bo_id not in (
    SELECT bo_id
    from dw_srmopr.fact_vintage_snapshot_m v 
    where substr(v.product_cd,1,4) = '0201'
    and substr(v.bo_finish_date,1,7) = '2017-06'
    and v.mob = 0
) 
;

2491918
2484071
2483623
2495685


SELECT * from msc.fact_vintage_20181205 where bo_id = 2495685 ;


select * from DMT.FACT_REPAY_BORROWS_SNAPSHOT where (stat_date = '2017-06-30' or stat_date = '2017-07-31') and bo_id = 2495685 ;


SELECT * from idw.fact_borrows where bo_id = 2495685 ;







