--查询真实标
select * from
idw.fact_biz_nono_invest
where
user_id in (
select id from odsopr.user_info
where mobile_num='17521162553');



--截至2017-06-30放款金额
SELECT
    sum(bo.bo_finish_price)
from idw.fact_borrows bo
where 1=1
    and bo.bo_is_success = 1
    and to_date(bo.bo_finish_time) <= '2017-06-30';




--截至2017-06-30贷余
SELECT
    sum(br.br_price_b)
from idw.fact_borrows_repayment br
left join idw.fact_borrows bo
on bo.bo_id = br.bo_id
where 1=1
    and to_date(bo.bo_finish_time) <= '2017-06-30'
    and (br.br_is_repay = 0 or to_date(br.br_repay_time) > '2017-06-30')



--截至2018-08-31贷余
SELECT
    sum(bo.bo_finish_price)
from idw.fact_borrows bo
where 1=1
    and bo.bo_is_success = 1
    and to_date(bo.bo_finish_time) <= '2018-08-31';



--截至2018-08-31贷余
SELECT
    sum(br.br_price_b)
from idw.fact_borrows_repayment br
left join idw.fact_borrows bo
on bo.bo_id = br.bo_id
where 1=1
    and to_date(bo.bo_finish_time) <= '2018-08-31'
    and (br.br_is_repay = 0 or to_date(br.br_repay_time) > '2018-08-31')




--超额：大房东
SELECT sum(br.br_price_b)
from idw.fact_borrows_repayment br
left join idw.fact_borrows bo
on bo.bo_id = br.bo_id
where 1=1
    and br.p_key = 13
    and to_date(bo.bo_finish_time) <= '2017-06-30'
    and (br.br_is_repay = 0 or to_date(br.br_repay_time) > '2017-06-30')


--超额：大房东
SELECT sum(br.br_price_b)
from idw.fact_borrows_repayment br
left join idw.fact_borrows bo
on bo.bo_id = br.bo_id
where 1=1
    and br.p_key = 13
    and bo_is_success=1
    and to_date(bo.bo_finish_time) <= '2017-06-30'
    and (br.br_is_repay = 0 or to_date(br.br_repay_time) > '2017-06-30')


SELECT * from  idw.fact_borrows bo
 where
  1=1
    and bo.p_key = 13
    and bo_is_success=1
order by rand()


--超额明细检查
select * from idw.fact_borrows
where 1=1
and bo_is_success = 1
and bo_finish_time >= '2016-08-24'
and bo_finish_price > 200000
and bo_all_repayed = 0
and p_key not in (16,13,19)


--校园贷：
SELECT sum(br.br_price_b)
from idw.fact_borrows_repayment br
left join idw.fact_borrows bo
on bo.bo_id = br.bo_id
left join
    (SELECT * from msc.v_user_edu_record4 er
    where 1=1
        and er.h_ctime = 1) er
on er.user_id = br.user_id
where 1=1
    and br.p_key in (5,6,7,8,18)
    and (br.br_is_repay = 0)
    and bo.bo_finish_time >= '2017-06-30'
    and er.graduate_date > to_date(now())

--<2017-06-30
SELECT sum(br.br_price_b)
from idw.fact_borrows_repayment br
left join idw.fact_borrows bo
on bo.bo_id = br.bo_id
where 1=1
    and br.p_key in (5,6,7,8,18)
    and (br.br_is_repay = 0 or to_date(br.br_repay_time) > '2017-06-30')
    and to_date(bo.bo_finish_time) <= '2017-06-30'



--next
--校园贷：
SELECT bo.*
from idw.fact_borrows_repayment br
left join idw.fact_borrows bo
on bo.bo_id = br.bo_id
left join
    (SELECT * from msc.v_user_edu_record4 er
    where 1=1
        and er.h_ctime = 1) er
on er.user_id = br.user_id
where 1=1
    and br.p_key in (5,6,7,8,18)
    and (br.br_is_repay = 0)
    and bo.bo_finish_time >= '2017-06-30'
    and er.graduate_date > to_date(now())
order by bo.create_time

--在投产品
select distinct  product_category
from  idw.fact_biz_csyy_aum
where  stat_date='2018-10-08'  and  aum>0
union
select distinct  product_category
from  idw.fact_biz_nono_aum
where  stat_date='2018-10-08'  and  aum>0


SELECT  useR_id,product_category
FROM(
SELECT user_id   useR_id,product_category
FROM idw.fact_biz_csyy_aum
WHERE stat_date='2018-10-08' AND aum>0
union all
SELECT user_id   user_id,product_category
FROM idw.fact_biz_nono_aum
WHERE stat_date='2018-10-08' AND aum>0
)a
--order  by  sum(aum)  desc
where  product_category  in  ( '月月升智投')

--招牌财神
SELECT  useR_id,product_category
FROM(
SELECT user_id   useR_id,product_category
FROM idw.fact_biz_csyy_aum
WHERE stat_date='2018-10-08' AND aum>0
union all
SELECT user_id   user_id,product_category
FROM idw.fact_biz_nono_aum
WHERE stat_date='2018-10-08' AND aum>0
)a
--order  by  sum(aum)  desc
where  product_category  in  ( '招牌财神')
and user_id = 2017954


--
SELECT  useR_id,product_category
FROM(
SELECT user_id   useR_id,product_category
FROM idw.fact_biz_csyy_aum
WHERE stat_date='2018-10-08' AND aum>0
union all
SELECT user_id   user_id,product_category
FROM idw.fact_biz_nono_aum
WHERE stat_date='2018-10-08' AND aum>0
)a
--order  by  sum(aum)  desc
where  product_category  in  ( '散投');



--
SELECT  useR_id,product_category
FROM(
SELECT user_id   useR_id,product_category
FROM idw.fact_biz_csyy_aum
WHERE stat_date='2018-10-08' AND aum>0
union all
SELECT user_id   user_id,product_category
FROM idw.fact_biz_nono_aum
WHERE stat_date='2018-10-08' AND aum>0
)a
--order  by  sum(aum)  desc
where  product_category  in  ( '开心财神');




--全量2017-07-07
SELECT *
from idw.fact_borrows
where 1=1
and to_date(bo_finish_time) = '2017-07-07'
and bo_is_success = 1;

--全量2017-09-01
SELECT *
from idw.fact_borrows
where 1=1
and to_date(bo_finish_time) = '2017-09-01';

--全量2018-01-01
SELECT *
from idw.fact_borrows
where 1=1
and to_date(bo_finish_time) = '2018-01-01';



--全量2017-07-18
SELECT *
from idw.fact_borrows
where 1=1
and to_date(bo_finish_time) = '2017-07-18';




--完成结算：招牌财神
SELECT * FROM idw.fact_biz_csyy_invest_cash
where  product_category='招牌财神'
and actual_cash_time is not null;






--

select a.user_id as 债权持有人

,b.id
,b.amount
,dea.trans_id

,b.create_time

,c.expect

,c.expect_unit

,a.price 持有债权

,c.title as 投资产品

,a.bo_id  as  借款标的

,d.user_id   债务持有人

FROM odsopr.debt_exchange_account a
left join odsopr.debt_buy_log   dea
  on a.va_id = dea.va_id and a.user_id = dea.user_id and a.bo_id = dea.bo_id


    ,odsopr.vip_account b
    ,odsopr.finance_plan c
     ,idw.fact_borrows d

WHERE a.va_id=b.id

AND a.bo_id=d.bo_id

AND a.va_id>0

AND a.price>0

AND b.fp_id=c.id

AND a.user_id=89645
order  by b.id  ;


--2005135:7~9
--2055270:15~17
--2025244:10~12
--2076325:300,310,320
--2055829:all
--2118075:50,55,60
--2041334:0?
--2092582:0?
--91595:100,140,145
--91936:23,97,200
--92377:6,296,489
--92535:14,20,30
--92838:10,180,240
--415186:1,12,194
--415191:3,5,6
--415290:2,12,30
--415381:6,176,200
--415949:5,193,379
--2143998:1,10,50
--2113356:3,149,279
--2139791:12,293,355
--1024453:40,80,84
--2060946:10,89,235
--2095428:5,92,150
--2160904:18,193,268
--2048689:10,31,40
--2017954:0?
--2013236:10,114,197
--2013236:?
--1076104:789
--补
--2058438:7,102,180
--2064414:10,90,99
--1256491:0
--1071919:11,26,27




--950017:散标没有记录
--77421:散标没有记录

--2)确认四个一手标债权，是否债转
--bo_id:2519011,2654657,3098258,2535105

select * from odsopr.borrows_bidding
where bo_id = 2519011
order by rand();

select * from odsopr.borrows_bidding
where bo_id = 2654657
order by rand();


select * from odsopr.borrows_bidding
where bo_id = 3098258
order by rand();


select * from odsopr.borrows_bidding
where bo_id = 2535105
order by rand();


--89645:120
--93197:3



----5个指定借款人抽标
--王连科,bo_id:1580878
select * from idw.fact_borrows
where user_id in
(
select id from odsopr.user_info
where real_name = '王连科'
)
and bo_is_success=1;

select * from odsopr.borrows_bidding where bo_id=1580878
order by rand();
--php7642870

select va.*
from odsopr.borrows_accept ba,odsopr.vip_account va
where ba.bo_id =1580878 and ba.is_pay=0
and ba.va_id=va.id
and va.trans_id not like 'php%';

--曹泽坤bo_id:2157635
select * from idw.fact_borrows
where user_id in
(
select id from odsopr.user_info
where real_name = '曹泽坤'
)
and bo_is_success=1;
select * from odsopr.borrows_bidding where bo_id=2157635
order by rand();

--邓望彬bo_id:1590899,1142274
select * from idw.fact_borrows
where user_id in
(
select id from odsopr.user_info
where real_name = '邓望彬'
)
and bo_is_success=1;
select * from odsopr.borrows_bidding where bo_id=1590899
order by rand();
select * from odsopr.borrows_bidding where bo_id=1142274
order by rand();


--蔡钢毅bo_id:2438945
select * from idw.fact_borrows
where user_id in
(
select id from odsopr.user_info
where real_name = '蔡钢毅'
)
and bo_is_success=1;
select * from odsopr.borrows_bidding where bo_id=2438945
order by rand();

--卢颖bo_id:1154473,1820067,1719714
select * from idw.fact_borrows
where user_id in
(
select id from odsopr.user_info
where real_name = '卢颖'
)
and bo_is_success=1;
select * from odsopr.borrows_bidding where bo_id=1154473
order by rand();
select * from odsopr.borrows_bidding where bo_id=1820067
order by rand();
select * from odsopr.borrows_bidding where bo_id=1719714
order by rand();
