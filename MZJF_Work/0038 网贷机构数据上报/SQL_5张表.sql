
--4.1.5 初始债权   42514790

drop table if exists msc.report_orignal_debt_info ;

create table msc.report_orignal_debt_info
as
        SELECT ''                                      as version,              --接口版本号
               'CERT20190411026'                       as sourceCode,           --平台编号
               t.id                                    as finClaimId,           --初始债权编号
               t.bo_id                                 as sourceProductCode,    --散标信息编号
               ui.id_num                               as userIdcardHash,       --出借用户证件号hash值
               t.price                                 as invAmount,            --出借金额(元)
               coalesce(bp.bp_rate_lender, bo.bo_rate) as invRate,              --出借预期年化利率
               ifnull(dbl.pay_time, t.create_time)     as invTime,              --出借计息时间
               0                                       as redpackage,           --出借红包（满减）（元）
               ifnull(dbl.pay_time, t.create_time)     as lockTime              --锁定截止时间
          FROM dmt.fact_debt_exchange_account_snapshot t 
          
     left join odsopr.debt_buy_log dbl 
            on dbl.user_id = t.user_id 
           and dbl.bo_id = t.bo_id 
           and dbl.va_id = t.va_id 
           and dbl.seri_no = t.seri_no 
           
     LEFT JOIN odsopr.borrows bo
            ON t.bo_id = bo.id
     
     left join odsopr.borrows_prepare bp
            on bo.bp_id = bp.id
            
     left join (
                      select a.user_id,
                             case when a.user_id = 19 then '43102219841206****'                    -- ZF user_id = 19 无id_num 设定为 '43102219841206****' 
                                  else concat(substr(a.id_num,1, length(a.id_num)-4), "****") 
                             end as id_num
                        from
                      (
                        SELECT a.ID AS USER_ID,
                               regexp_extract(regexp_replace(a.id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                          FROM ods.t_user_info_hist a
                         where a.status = 1 
                      ) a
               ) ui 
            on ui.user_id = t.user_id
         where t.stat_date = '2019-04-28'
;



--4.1.9 交易流水   42514790+4360679+4360679


      --2-出借（出借人购买散标产生的初始债权交易流水）   初始债权只有出借流水
      drop table if exists msc.report_trans_details ;

      create table msc.report_trans_details
      as 
      select ''                             as version,             --接口版本号
             'CERT20190411026'              as sourceCode,          --平台编号
             isa.trans_id                   as transId,             --网贷机构交易流水号
             t.bo_id                        as sourceProductCode,   --散标信息编号
             concat(bpc.loan_use_name,
                    "需",
                    bo_finish_price,
                    "元")                   as sourceProductName,   --散标名称
             t.id                           as finClaimId,          --债权编号
             -1                             as transferId,          --转让信息编号
             -1                             as replanId,            --还款计划编号
             "2-出借"                       as transType,           --交易类型
             t.price                        as transMoney,          --交易金额（元）
             ui.id_num                      as userIdcardHash,      --交易主体证件号hash 值
             t.create_time                  as transTime            --交易发生时间
        from dmt.fact_debt_exchange_account_snapshot t 
        
   left join odsopr.invt_seri_auth_link isa
          on isa.seri_no = t.seri_no    
     
   left join (
                  select a.user_id,
                         case when a.user_id = 19 then '43102219841206****'                    -- ZF user_id = 19 无id_num 设定为 '43102219841206****' 
                              else concat(substr(a.id_num,1, length(a.id_num)-4), "****") 
                         end as id_num
                    from
                  (
                    SELECT a.ID AS USER_ID,
                           regexp_extract(regexp_replace(a.id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                      FROM ods.t_user_info_hist a
                     where a.status = 1 
                  ) a
             ) ui 
          on ui.user_id = t.user_id
          
   left join (
                  select bo_id, bo_purpose, 
                         cast(cast(bo_finish_price as decimal(38,2)) as string) bo_finish_price
                    from idw.fact_borrows 
             ) bo 
          on bo.bo_id = t.bo_id 

   left join msc.bo_purpose_category bpc          --"借款用途"需“借款金额”元
          on bpc.bo_purpose = bo.bo_purpose   
          
       where t.stat_date = '2019-04-28' 
       
       union all 
             
      --1-放款
      select ''                             as version,
             'CERT20190411026'              as sourceCode,
             br.id                          as transId,     -- ?? 待确认
             br.bo_id                       as sourceProductCode,
             concat(bpc.loan_use_name,
                    "需",
                    bo_finish_price,
                    "元")                   as sourceProductName,   --散标名称
             -1                             as finClaimId,
             -1                             as transferId,
             br.id                          as replanId,
             "1-放款"                       as transType,
             br.br_price_b                  as transMoney,
             ui.id_num                      as userIdcardHash,
             br.create_time                 as transTime   --??待确认
        from odsopr.borrows_repayment br 
        
   left join (
                  select bo_id, bo_purpose, user_id, bo_success_time,
                         cast(cast(bo_finish_price as decimal(38,2)) as string) bo_finish_price
                    from idw.fact_borrows 
             ) bo 
          on bo.bo_id = br.bo_id 

   left join msc.bo_purpose_category bpc          --"借款用途"需“借款金额”元
          on bpc.bo_purpose = bo.bo_purpose
          
   left join (
                  select a.user_id,
                         case when a.user_id = 19 then '43102219841206****'                    -- ZF user_id = 19 无id_num 设定为 '43102219841206****' 
                              else concat(substr(a.id_num,1, length(a.id_num)-4), "****") 
                         end as id_num
                    from
                  (
                    SELECT a.ID AS USER_ID,
                           regexp_extract(regexp_replace(a.id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                      FROM ods.t_user_info_hist a
                     where a.status = 1 
                  ) a
             ) ui 
          on ui.user_id = bo.user_id
        
       where br.br_repay_time is null 
         and exists(select 1 from msc.report_trans_details t where br.bo_id = t.sourceProductCode) 
         --and br.bo_id = 2797272
    order by br.id 
    
    union all 
       
      --4-借款服务费    br_price + price_return - br_price_b 
      select ''                             as version,
             'CERT20190411026'              as sourceCode,
             br.id                          as transId,     -- ?? 待确认
             br.bo_id                       as sourceProductCode,
             concat(bpc.loan_use_name,
                    "需",
                    bo_finish_price,
                    "元")                   as sourceProductName,   --散标名称
             -1                             as finClaimId,
             -1                             as transferId,
             br.id                          as replanId,
             "4-借款服务费"                 as transType,
             br.br_price +
             br.price_return -
             br.br_price_b                  as transMoney,  --??待确认
             ui.id_num                      as userIdcardHash,
             br.br_time                     as transTime  --??待确认
        from odsopr.borrows_repayment br 
        
   left join (
                  select bo_id, bo_purpose, user_id, bo_success_time,
                         cast(cast(bo_finish_price as decimal(38,2)) as string) bo_finish_price
                    from idw.fact_borrows 
             ) bo 
          on bo.bo_id = br.bo_id 

   left join msc.bo_purpose_category bpc          --"借款用途"需“借款金额”元
          on bpc.bo_purpose = bo.bo_purpose
          
   left join (
                  select a.user_id,
                         case when a.user_id = 19 then '43102219841206****'                    -- ZF user_id = 19 无id_num 设定为 '43102219841206****' 
                              else concat(substr(a.id_num,1, length(a.id_num)-4), "****") 
                         end as id_num
                    from
                  (
                    SELECT a.ID AS USER_ID,
                           regexp_extract(regexp_replace(a.id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                      FROM ods.t_user_info_hist a
                     where a.status = 1 
                  ) a
             ) ui 
          on ui.user_id = bo.user_id
        
       where br.br_repay_time is null
         and exists(select 1 from msc.report_trans_details t where br.bo_id = t.sourceProductCode) 
         --and br.bo_id = 2797272
    order by br.id ;
    




--4.1.10 产品信息  120832283

      --计划类
      select ''                             as version,
             'CERT20190411026'              as sourceCode,
             fp.id                          as sourceFinancingCode,
             fp.publish_date                as financingStartTime,
             fp.title                       as productName,
             fp.rate_min                    as rate,
             fp.rate_min                    as minRate,
             fp.rate_max                    as maxRate,
             case when fp.expect_unit = 0 then fp.expect * 30 else fp.expect end as term
        from odsopr.finance_plan fp
        
        union all 
        
      --诺诺盈
      select ''                              as version,
             'CERT20190411026'               as sourceCode,
             bo.id                           as sourceFinancingCode,
             bo.publish_time                 as financingStartTime,
             concat("诺诺盈", 
                    cast(bo.id as string))   as productName,
             bp.bp_rate_lender               as rate,
             bp.bp_rate_lender               as minRate,
             bp.bp_rate_lender               as maxRate,
             case when bo.bo_expect_cat = 2 then bo.bo_expect * 30 else bo.bo_expect end as term
        from odsopr.borrows bo 
   left join odsopr.borrows_prepare bp
          on bo.bp_id = bp.id        
          
        union all 

      --债转类
      select ''                              as version,
             'CERT20190411026'               as sourceCode,
             ds.id                           as sourceFinancingCode,
             ds.create_time                  as financingStartTime,
             concat("项目编号", 
                    cast(ds.id as string))   as productName,
             ds.yield_rate                   as rate,
             ds.yield_rate                   as minRate,
             ds.yield_rate                   as maxRate,
             ds.expect as term
        from odsopr.debt_sale ds ; 
        

--4.1.11 产品配置   42514790

      --计划类
      select '' as version,
             'CERT20190411026' as sourcecode,
             t.id as configId,   --?待确认
             t.id as finclaimid,
             fp.id as sourceFinancingCode,
             ui.id_num as useridcardhash
        from dmt.fact_debt_exchange_account_snapshot t 
   left join odsopr.vip_account va 
          on va.id = t.va_id
   left join odsopr.finance_plan fp 
          on fp.id = va.fp_id 
   left join (
                  select a.user_id,
                         case when a.user_id = 19 then '43102219841206****'                    -- ZF user_id = 19 无id_num 设定为 '43102219841206****' 
                              else concat(substr(a.id_num,1, length(a.id_num)-4), "****") 
                         end as id_num
                    from
                  (
                    SELECT a.ID AS USER_ID,
                           regexp_extract(regexp_replace(a.id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                      FROM ods.t_user_info_hist a
                     where a.status = 1 
                  ) a
             ) ui 
          on ui.user_id = t.user_id          
       where t.stat_date = '2019-04-28'
         and t.va_id > 0 
       
       union all 
      
      --诺诺盈
      select '' as version,
             'CERT20190411026' as sourcecode,
             t.id as configId,   --?待确认
             t.id as finclaimid,
             bo.id as sourceFinancingCode,
             ui.id_num as useridcardhash
        from dmt.fact_debt_exchange_account_snapshot t 
   left join odsopr.borrows bo 
          on bo.id = t.bo_id
   left join (
                  select a.user_id,
                         case when a.user_id = 19 then '43102219841206****'                    -- ZF user_id = 19 无id_num 设定为 '43102219841206****' 
                              else concat(substr(a.id_num,1, length(a.id_num)-4), "****") 
                         end as id_num
                    from
                  (
                    SELECT a.ID AS USER_ID,
                           regexp_extract(regexp_replace(a.id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                      FROM ods.t_user_info_hist a
                     where a.status = 1 
                  ) a
             ) ui 
          on ui.user_id = t.user_id          
       where t.stat_date = '2019-04-28'
         and t.va_id = 0 ; 


       

--4.1.12 投资明细    42514790

      select ''                             as version,             --接口版本号
             'CERT20190411026'              as sourceCode,          --平台编号
             isa.trans_id                   as transId,             --网贷机构交易流水号
             fp.id                          as sourceFinancingCode, --产品信息编号
             "2-成功出借金额"               as transType,           --交易类型
             t.price                        as transMoney,          --交易金额（元）
             ui.id_num                      as userIdcardHash,      --交易主体证件号hash 值
             t.create_time                  as transTime            --交易发生时间
        from dmt.fact_debt_exchange_account_snapshot t 
   left join odsopr.invt_seri_auth_link isa
          on isa.seri_no = t.seri_no    
   left join (
                  select a.user_id,
                         case when a.user_id = 19 then '43102219841206****'                    -- ZF user_id = 19 无id_num 设定为 '43102219841206****' 
                              else concat(substr(a.id_num,1, length(a.id_num)-4), "****") 
                         end as id_num
                    from
                  (
                    SELECT a.ID AS USER_ID,
                           regexp_extract(regexp_replace(a.id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                      FROM ods.t_user_info_hist a
                     where a.status = 1 
                  ) a
             ) ui 
          on ui.user_id = t.user_id
   left join odsopr.vip_account va 
          on va.id = t.va_id
   left join odsopr.finance_plan fp 
          on fp.id = va.fp_id 
       where t.stat_date = '2019-04-28' 
         and t.va_id > 0 
         
         union all 

      select ''                             as version,             --接口版本号
             'CERT20190411026'              as sourceCode,          --平台编号
             isa.trans_id                   as transId,             --网贷机构交易流水号
             bo.id                          as sourceFinancingCode, --产品信息编号
             "2-成功出借金额"               as transType,           --交易类型
             t.price                        as transMoney,          --交易金额（元）
             ui.id_num                      as userIdcardHash,      --交易主体证件号hash 值
             t.create_time                  as transTime            --交易发生时间
        from dmt.fact_debt_exchange_account_snapshot t 
   left join odsopr.invt_seri_auth_link isa
          on isa.seri_no = t.seri_no    
   left join (
                  select a.user_id,
                         case when a.user_id = 19 then '43102219841206****'                    -- ZF user_id = 19 无id_num 设定为 '43102219841206****' 
                              else concat(substr(a.id_num,1, length(a.id_num)-4), "****") 
                         end as id_num
                    from
                  (
                    SELECT a.ID AS USER_ID,
                           regexp_extract(regexp_replace(a.id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
                      FROM ods.t_user_info_hist a
                     where a.status = 1 
                  ) a
             ) ui 
          on ui.user_id = t.user_id
   left join odsopr.borrows bo 
          on bo.id = t.bo_id
       where t.stat_date = '2019-04-28' 
         and t.va_id = 0 
         ;
         
         