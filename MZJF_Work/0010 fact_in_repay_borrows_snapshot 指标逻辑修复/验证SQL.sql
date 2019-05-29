SELECT
    --substr(to_date(br.br_time),1,7) 月份,
    sum(br.br_price_b),count(DISTINCT br.bo_id)
from idw.fact_borrows_repayment br 
inner join idw.fact_borrows bo
on br.bo_id = bo.bo_id 
and to_date(bo.bo_finish_time) <= '2018-06-30'
where 1=1
and (br.br_is_repay = 0 or (br.br_is_repay = 1 and to_date(br.br_repay_time) > '2018-06-30'))   --4436758911.4500000000	407561
and br.p_key in (1,2,3,4,5,6,7,8,9,10,12,14,15,26,27,28,29);
--GROUP BY 1;



SELECT
    --substr(to_date(br.br_time),1,7) 月份,
    sum(bs.unrepay_price_b), count(distinct bs.bo_id)
from idw.fact_in_repay_borrows_snapshot bs
where 1=1
and bs.stat_date = '2018-06-30'
and bs.p_key in (1,2,3,4,5,6,7,8,9,10,12,14,15,26,27,28,29)    --4430753839.5900000000	407135


