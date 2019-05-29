create database yimei;

create table yimei.t04_borrows like idw.fact_borrows;                                     
create table yimei.t04_borrows_repayment like idw.fact_borrows_repayment;                 
create table yimei.t04_in_repay_borrows_snapshot like idw.fact_in_repay_borrows_snapshot; 
create table yimei.t01_user_info like idw.dim_user;                                       
create table yimei.t02_asset_products like odsopr.dim_bia_asset_product;                  
create table yimei.t03_order_check_history like odsopr.ord_order_check_history;           
create table yimei.t03_orders like odsopr.ord_order;                                      


create table msc.bos_drop (drop_id string);

1. idw.fact_borrows                      ->   yimei.t04_borrows        (bo_id)    210000347
insert overwrite table yimei.t04_borrows
select * from idw.fact_borrows t1
where not exists (select 1 from msc.bos_drop t2 where t1.bo_id = cast(t2.drop_id as bigint))
and t1.p_key in (10,28,29) 
;

            
2. idw.fact_borrows_repayment            ->   yimei.t04_borrows_repayment     (bo_id)    210000348
insert overwrite table yimei.t04_borrows_repayment
select * from idw.fact_borrows_repayment t1
where not exists (select 1 from msc.bos_drop t2 where t1.bo_id = cast(t2.drop_id as bigint))
and t1.p_key in (10,28,29) 
;

3. idw.fact_in_repay_borrows_snapshot    ->   yimei.t04_in_repay_borrows_snapshot     (bo_id)    210000349
insert overwrite table yimei.t04_in_repay_borrows_snapshot partition (STAT_DATE)
select 
    bo_id
    ,p_id
    ,busi_line
    ,user_id
    ,bo_rate
    ,interest_rate_cut
    ,bo_audit_time
    ,bo_agree_time
    ,should_repay_cnt
    ,repayed_cnt
    ,unrepay_cnt
    ,repayed_cnt_this_month
    ,should_repay_price
    ,repayed_price
    ,unrepay_price
    ,repayed_price_this_month
    ,should_repay_price_b
    ,repayed_price_b
    ,unrepay_price_b
    ,repayed_price_b_this_month
    ,should_repay_price_l
    ,repayed_price_l
    ,unrepay_price_l
    ,repayed_price_l_this_month
    ,should_repay_price_punish
    ,repayed_price_punish
    ,unrepay_price_punish
    ,repayed_price_punish_this_month
    ,should_repay_service_fee
    ,repayed_service_fee
    ,unrepay_service_fee
    ,repayed_service_fee_this_month
    ,repay_begin_day
    ,last_repayed_time
    ,compensate_amt
    ,repayed_compensate_amt
    ,is_first_repay_overdue
    ,first_repay_overdue_days
    ,is_overdue
    ,max_overdue_days
    ,is_overdue_unrepay
    ,is_dunning
    ,dun_type
    ,dun_company
    ,dun_company_name
    ,dun_start_time
    ,dun_end_time
    ,overdue_expect_cnt
    ,overdue_repayed_price
    ,overdue_unrepay_expect_cnt
    ,overdue_unrepay_days
    ,aging
    ,overdue_unrepay_price
    ,overdue_unrepay_price_b
    ,overdue_unrepay_price_l
    ,overdue_unrepay_price_punish
    ,overdue_unrepay_service_fee
    ,dw_create_by
    ,dw_create_time
    ,dw_update_by
    ,dw_update_time
    ,repay_end_day
    ,compensate_price_b
    ,repayed_compensate_price_b
    ,bo_finish_price
    ,bo_expect
    ,bo_expect_cat
    ,cur_price
    ,cur_price_b
    ,cur_price_l
    ,cur_service_fee
    ,first_repay_time
    ,should_return_price
    ,returned_price
    ,unreturned_price
    ,returned_price_this_month
    ,overdue_returned_price
    ,overdue_unreturned_price
    ,overdue_unrepay_earliest_br_time
    ,max_continuous_overdue_price_b
    ,max_continuous_overdue_cnt
    ,category_name_01
    ,biz_code_01
    ,biz_name_01
    ,depository_flag
    ,first_overdue_expect_num
    ,first_overdue_br_time
    ,transfer_account_time
    ,p_name
    ,monthly_repayment_amt
    ,settlement_should_repay_amt
    ,posted_bill_num
    ,should_repay_extra_fee
    ,repayed_extra_fee
    ,unrepay_extra_fee
    ,repayed_extra_fee_this_month
    ,p_key
    ,stat_date  
from idw.fact_in_repay_borrows_snapshot t1
where t1.stat_date >= date_sub('{LAST_DATA_TIME}', 2)
and t1.stat_date < '{T}' 
and t1.p_key in (10,28,29) 
and not exists (select 1 from msc.bos_drop t2 where t1.bo_id = cast(t2.drop_id as bigint))
;


4. idw.dim_user                          ->   yimei.t01_user_info          210000350
INSERT OVERWRITE TABLE yimei.t01_user_info
select * from idw.dim_user
;
          
5. odsopr.dim_bia_asset_product          ->   yimei.t02_asset_products        210000351
INSERT OVERWRITE TABLE yimei.t02_asset_products
select * from odsopr.dim_bia_asset_product
;
      
6. odsopr.ord_order_check_history        ->   yimei.t03_order_check_history         210000352
INSERT OVERWRITE TABLE yimei.t03_order_check_history
select * from odsopr.ord_order_check_history
;

7. odsopr.ord_order                      ->   yimei.t03_orders            (bo_id)    210000353
INSERT OVERWRITE TABLE yimei.t03_orders
select * from odsopr.ord_order t1
where not exists (select 1 from msc.bos_drop t2 where t1.bo_id = cast(t2.drop_id as bigint))
;

