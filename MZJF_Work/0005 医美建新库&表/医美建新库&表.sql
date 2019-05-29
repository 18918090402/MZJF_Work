消费场景（信用贷）

老医美     麦芽
新医美     爱美呗分期

去年10月~12月，渠道欺诈       -->   剔除此段时间内，逾期90天以上     


缺少资金   ->   外部合作   （晋消机构  关注  风险/逾期率）



产出：
    1. 新数据库  
    2. 新表  -- excel 中的表
    3. 日常用到的表
    
主要用到3张表：
idw.fact_borrows bo 借款表 有bo_id
odsopr.dim_bia_asset_product pr 产品线表
idw.fact_borrows_repayment br 还款表 有bo_id
idw.fact_in_repay_borrows_snapshot 还款快照表 有bo_id
odsopr.ord_order_check_history 医美订单历史状态表
odsopr.ord_order 医美订单表 有bo_id
idw.dim_user 用户表
    
    源表                                           目标表                             DDL
1. idw.fact_borrows                      ->   yimei.t04_borrows                       create table yimei.t04_borrows like idw.fact_borrows;
2. idw.fact_borrows_repayment            ->   yimei.t04_borrows_repayment             create table yimei.t04_borrows_repayment like idw.fact_borrows_repayment;
3. idw.fact_in_repay_borrows_snapshot    ->   yimei.t04_in_repay_borrows_snapshot     create table yimei.t04_in_repay_borrows_snapshot like idw.fact_in_repay_borrows_snapshot;
4. idw.dim_user                          ->   yimei.t01_user_info                     create table yimei.t01_user_info like idw.dim_user;
5. odsopr.dim_bia_asset_product          ->   yimei.t02_asset_products                create table yimei.t02_asset_products like odsopr.dim_bia_asset_product;
6. odsopr.ord_order_check_history        ->   yimei.t03_order_check_history           create table yimei.t03_order_check_history like odsopr.ord_order_check_history;
7. odsopr.ord_order                      ->   yimei.t03_orders                        create table yimei.t03_orders like odsopr.ord_order;



    
交付：
    明天下午    