mob：当月放款是mob0，第二个月是mob1，依次类推，表现期的概念

放款金额，是当月的放款总金额

DPD1+  10+  30+   90+  

mob1: >= 1
mob2: >= 2 

db_nono.borrows_credit_amount_assess_log
risk.des_access_dcin_detail




产品   product      p_id     p_key  
期限   bo_expect_num
等级   level 
客群   新客户  老客户  
    data apply(keep=apply_no product score customer apply_Date );
    set risk.apply_&day ;
    if NEWUSER_FLAG=1 
        then customer="新客户";
    else 
        if NEWUSER_FLAG=0 
            then customer="老客户";
    where product in ("白领包","应届贷" ,"社保贷" ,"其他大额贷" ,"消费贷" ,"学历贷" ,"本科包","名校贷应急包","专科包");

         to_DATE(mr.bo_agree_time) as DISBURSED_DATE, -- 借款同意时间    
    

175961 175961
219781 219781




-- 1     2013-12-31  开始




--dim_vintage_20181204
drop table if exists msc.dim_vintage_20181204 ;

CREATE TABLE msc.dim_vintage_20181204 
(
    user_id                 bigint,
    bo_id                   bigint,
    bo_agree_time           string,
    bo_finish_time          string,    
    bo_finish_price         decimal(38,10),
    bo_expect               int,
    bo_expect_cat           int,
    bo_expect_type          int,
    product_type            string,
    product_cat             string,
    PRODUCT                 string,
    p_name                  string,
    p_key                   int,
    level                   string,
    score                   string,
    level_cat               string,
    user_cat                string,
    province_cd             string,
    gender_type             int,
    age_type                int,
    education_type          int,
    school_type             int,
    loan_amt_type           int,
    td_score_type           int,
    td_platform_7d_type     int,
    td_platform_1m_type     int,
    td_platform_3m_type     int,
    td_platform_6m_type     int
)
comment '2016年始每月放款标信息'
partitioned by (stat_date string comment '统计日期 年-月')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;



     insert overwrite table msc.dim_vintage_20181204 partition (stat_date)
     select bo.user_id                                                                                               -- "用户ID",
            ,bo.bo_id                                                                                                -- "借款ID",
            ,bo.bo_agree_time                                                                                        -- "借款协议生成时间",
            ,bo.bo_finish_time                                                                                       -- "借款完成时间",
            ,bo.bo_finish_price                                                                                      -- "借款完成金额",
            ,bo.bo_expect                                                                                            -- "借款期限",
            ,bo.bo_expect_cat                                                                                        -- "借款期限单位",
            ,case 
                when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36)    then 0
                else bo.bo_expect
            end as bo_expect_type                                                                                    -- "借款期限分类",
            ,case 
                when bo1.PRODUCT in ("白领包","应届贷" ,"社保贷")      then "白领贷"
                when bo1.PRODUCT in ("其他大额贷" ,
                                     "大额借", 
                                     "大额借（测试）",
                                     "消费贷" ,
                                     "消费能力贷",
                                     "学历贷",
                                     "高学历贷")                       then "麦子借款"
                when bo1.PRODUCT in ("信用贷（本）", 
                                     "名校贷",
                                     "本科包",
                                     "名校贷应急包",
                                     "信用贷（专）",
                                     "专科包")                         then "信用贷"
                when bo1.PRODUCT in ("麦芽分期")                       then "麦芽分期"                
            end as product_type                                                                                      -- "产品大类",
            ,case 
                when bo1.PRODUCT in ("信用贷（本）", "名校贷")         then "本科包"
                when bo1.PRODUCT in ("信用贷（专）", "专科包")         then "专科包"
                when bo1.PRODUCT in ("大额借", "大额借（测试）")       then "其他大额贷"
                when bo1.PRODUCT = "高学历贷"                          then "学历贷"
                when bo1.PRODUCT = "消费能力贷"                        then "消费贷"
                else bo1.PRODUCT
            end as product_cat                                                                                       -- "产品小类",
            ,bo1.PRODUCT                                                                                             -- "产品名称",
            ,bo1.p_name
            ,bo1.p_key
            ,bo1.level                                                                                               -- "用户等级",
            ,bo1.score                                                                                               -- "用户得分",
            ,case 
                when bo1.score is not null and bo1.level in ("A") then "A"
                when bo1.score is not null and bo1.level in ("B") then "B"
                when bo1.score is not null and bo1.level in ("C") then "C"
                when bo1.score is not null and bo1.level in ("D") then "D"
                when bo1.score is not null and bo1.level in ("E") then "E"
                when bo1.score is not null and bo1.level in ("F") then "F"
                else "其他"
            end as level_cat                                                                                        -- "用户等级分类",
            ,case when bo2.user_id is null then "新客" else "老客" end as user_cat                                  -- "用户客群"
            ,uix.province_cd
            ,uix.gender_type
            ,case 
                when uix.age = 0                    then 0 
                when uix.age >= 0  and uix.age <= 25 then 1
                when uix.age >= 26 and uix.age <= 30 then 2
                when uix.age >= 31 and uix.age <= 35 then 3
                when uix.age >= 36                  then 4
            end age_type
            ,uix.education as education_type
            ,case 
                when uix.SCHOOL_TYPE_DESC = '专科' then 4 
                when uix.SCHOOL_TYPE_DESC = '3本'  then 3
                when uix.SCHOOL_TYPE_DESC = '2本'  then 2
                when uix.SCHOOL_TYPE_DESC = '1本'  then 1
                when uix.SCHOOL_TYPE_DESC = '缺失' then 0
                else 9
            end school_type
            ,case 
                when bo.bo_finish_price >= 0      and bo.bo_finish_price <= 1000               then 1
                when bo.bo_finish_price > 1000    and bo.bo_finish_price <= 2000               then 2
                when bo.bo_finish_price > 2000    and bo.bo_finish_price <= 3000               then 3
                when bo.bo_finish_price > 3000    and bo.bo_finish_price <= 4000               then 4
                when bo.bo_finish_price > 4000    and bo.bo_finish_price <= 5000               then 5
                when bo.bo_finish_price > 5000    and bo.bo_finish_price <= 10000              then 6
                when bo.bo_finish_price > 10000   and bo.bo_finish_price <= 20000              then 7
                when bo.bo_finish_price > 20000   and bo.bo_finish_price <= 30000              then 8
                when bo.bo_finish_price > 30000   and bo.bo_finish_price <= 40000              then 9
                when bo.bo_finish_price > 40000   and bo.bo_finish_price <= 50000              then 10
                when bo.bo_finish_price > 50000   and bo.bo_finish_price <= 60000              then 11
                when bo.bo_finish_price > 60000                                                then 12
            end loan_amt_type
            ,case 
                when crd.td_final_score is null                             then 0
                when crd.td_final_score >= 0  and crd.td_final_score <= 10  then 1
                when crd.td_final_score >= 11 and crd.td_final_score <= 20  then 2
                when crd.td_final_score >= 21 and crd.td_final_score <= 30  then 3
                when crd.td_final_score >= 31 and crd.td_final_score <= 40  then 4
                when crd.td_final_score >= 41 and crd.td_final_score <= 50  then 5
                when crd.td_final_score >= 51 and crd.td_final_score <= 60  then 6
                when crd.td_final_score >= 61 and crd.td_final_score <= 70  then 7
                when crd.td_final_score >= 71 and crd.td_final_score <= 80  then 8
                when crd.td_final_score >= 81 and crd.td_final_score <= 90  then 9
                when crd.td_final_score >= 91 and crd.td_final_score <= 100 then 10
            end td_score_type
            ,case 
                when crd.td_platform_count_7d is null                                   then 0
                when crd.td_platform_count_7d >= 1  and crd.td_platform_count_7d <= 5   then 1
                when crd.td_platform_count_7d >= 6  and crd.td_platform_count_7d <= 10  then 2
                when crd.td_platform_count_7d >= 11 and crd.td_platform_count_7d <= 20  then 3
                when crd.td_platform_count_7d >= 21 and crd.td_platform_count_7d <= 30  then 4
                when crd.td_platform_count_7d >= 26 and crd.td_platform_count_7d <= 30  then 5
                when crd.td_platform_count_7d >= 31                                     then 6
            end td_platform_7d_type
            ,case 
                when crd.td_platform_count_1m is null                                   then 0
                when crd.td_platform_count_1m >= 1  and crd.td_platform_count_1m <= 5   then 1
                when crd.td_platform_count_1m >= 6  and crd.td_platform_count_1m <= 10  then 2
                when crd.td_platform_count_1m >= 11 and crd.td_platform_count_1m <= 20  then 3
                when crd.td_platform_count_1m >= 21 and crd.td_platform_count_1m <= 30  then 4
                when crd.td_platform_count_1m >= 26 and crd.td_platform_count_1m <= 30  then 5
                when crd.td_platform_count_1m >= 31                                     then 6
            end td_platform_1m_type
            ,case 
                when crd.td_platform_count_3m is null                                   then 0
                when crd.td_platform_count_3m >= 1  and crd.td_platform_count_3m <= 5   then 1
                when crd.td_platform_count_3m >= 6  and crd.td_platform_count_3m <= 10  then 2
                when crd.td_platform_count_3m >= 11 and crd.td_platform_count_3m <= 20  then 3
                when crd.td_platform_count_3m >= 21 and crd.td_platform_count_3m <= 30  then 4
                when crd.td_platform_count_3m >= 26 and crd.td_platform_count_3m <= 30  then 5
                when crd.td_platform_count_3m >= 31                                     then 6
            end td_platform_3m_type
            ,case 
                when crd.td_platform_count_6m is null                                   then 0
                when crd.td_platform_count_6m >= 1  and crd.td_platform_count_6m <= 5   then 1
                when crd.td_platform_count_6m >= 6  and crd.td_platform_count_6m <= 10  then 2
                when crd.td_platform_count_6m >= 11 and crd.td_platform_count_6m <= 20  then 3
                when crd.td_platform_count_6m >= 21 and crd.td_platform_count_6m <= 30  then 4
                when crd.td_platform_count_6m >= 26 and crd.td_platform_count_6m <= 30  then 5
                when crd.td_platform_count_6m >= 31                                     then 6
            end td_platform_6m_type
            ,'${dt}' as stat_date
       from idw.fact_borrows bo 
 inner join
          (
                      select bo.user_id,
                             bo.bo_id ,
                             case
                               when bo.p_id = 87 and bp.bp_channel = 5   then '社保贷'
                               when bo.p_id = 87 and bp.bp_channel = 6   then '应届贷'
                               when bo.p_id = 87 and bp.bp_channel = 7   then '按揭贷'
                               when bo.p_id = 110 and bo.credit_type = 2 then '高学历贷'
                               when bo.p_id = 110 and bo.credit_type = 3 then '消费能力贷'
                               when bo.p_id = 140 and (mp.external_channel = '3' or mp.external_channel is null ) then '金卡-麦子借款'
                               when bo.p_id = 140 and mp.external_channel = '4' then '金卡-信用贷'                               
                               else bo.p_name
                             end PRODUCT,
                             bo.p_id,
                             bo.p_key,
                             bo.p_name,
                             dm.SCORE_LEVEL LEVEL,
                             dm.SCORE_RESULT SCORE
                        from idw.fact_borrows bo
                        left join odsopr.borrows_prepare bp
                          on bo.bp_id = bp.id
                   left join odsopr.borrows_external_mapping mp 
                          on mp.bo_id = bo.bo_id                          
                        left join 
                                (
                                    select bp_id,
                                           user_id,
                                           max(case when data_no = "scoreLevel" then data_value end) SCORE_LEVEL,
                                           max(case when data_no = "scoreResult" then data_value end) SCORE_RESULT
                                      from (select bp_id,user_id,data_value,data_no,
                                                   row_number() over(partition by bp_id, data_no order by id desc) rn
                                              from ods.t_des_main_hist 
                                              where data_no in ( "scoreLevel","scoreResult" ) ) s
                                     where s.rn = 1
                                     group by bp_id, user_id
                                ) dm
                          on bo.bp_id = dm.bp_id
                         and bo.user_id = dm.user_id
                       where bo.bo_is_success = 1 
          ) bo1 
         on bo1.bo_id = bo.bo_id 
        and bo1.user_id = bo.user_id
  left join
          (
                    select distinct bo.user_id
                      from odsopr.borrows bo 
                     where bo.bo_is_success = 1
                       and to_date(bo.bo_agree_time) <= to_date(date_add(date_sub(trunc('${dt}','MONTH'),2),1))  --上月底
          ) bo2 
         on bo2.user_id = bo.user_id
  left join
          (
                     select ui.id user_id, 
                            ui2.id_num,
                            case when ui2.id_num is null then '00' else substr(ui2.id_num,1,2) end province_cd,
                            case when ui2.gender is null then 0 else ui2.gender end gender_type, 
                            case when ui2.birth_dt is null then 0 else year('${dt}') - year(ui2.birth_dt) end age,
                            edu.college,
                            CASE 
                                WHEN ss.type = '4' THEN '专科'
                                WHEN ss.type < '4' THEN CONCAT(ss.type, '本')
                                when ss.type is null or trim(ss.type) = '' then '缺失'
                                ELSE ss.type
                            END SCHOOL_TYPE_DESC,
                            case 
                                when edu.education like '%博士%'                                                                                                        then 1 --'博士'
                                when edu.education like '%硕士%' or edu.education like '%研究生%'                                                                       then 2 --'硕士'
                                when edu.education = '本科' or edu.education like '%第二学士学位%' or edu.education like '%高升本%' or edu.education like '%专升本%'    then 3 --'本科'
                                when edu.education = '专科' or edu.education like '%大专%' or edu.education like '%第二专科%' or edu.education like '%专科(高职%'       then 4 --'专科'
                                when edu.education = '专科以下' or edu.education like '%中专及高中%' or edu.education like '%中专%' or edu.education like '%高中以下%'
                                     or edu.education like '%夜大电大函大普通班%' or edu.education like '%初中及以下%'                                                  then 5 --'专科以下'
                                when edu.education is null or trim(edu.education) = ''                                                                                  then 0 --'缺失'
                                else                                                                                                                                         9 --'其他'
                            end as education
                      from ods.t_user_info_hist ui 
                 left join 
                         (      
                              select ui.id user_id,
                                     coalesce(b.college, c.college) college,
                                     coalesce(b.degree, c.degree) education
                                from ods.t_user_info_hist ui
                                left join (select t1.user_id, t2.degree, t2.auth_time, t2.graduate_date, t2.college
                                             from odsopr.user_loan_auth_info_hist t1
                                             join odsopr.user_edu_auth_log_hist t2
                                               on t1.auth_code = 1
                                              and t1.auth_id = t2.id) b
                                  on ui.id = b.user_id
                                left join idw.user_pengyuan_edu_legacy c
                                  on ui.id = c.user_id
                               where coalesce(b.user_id, c.user_id) is not null 
                         ) edu
                        on ui.id = edu.user_id
                 left join 
                         (
                            select name,
                                   type,
                                   row_number() over(partition by name order by id desc) rn
                              from odsopr.student_school_hist
                         ) ss
                        on edu.college = ss.name
                       and ss.rn = 1
                 left join 
                         (
                                select ui2.id, 
                                       ui2.id_num,
                                       case 
                                            when length(ui2.id_num) = 18 and substr(ui2.id_num,-2,1) in ('1','3','5','7','9') then 1     --18位 男
                                            when length(ui2.id_num) = 18 and substr(ui2.id_num,-2,1) in ('2','4','6','8','0') then 2     --18位 女
                                            when length(ui2.id_num) = 15 and substr(ui2.id_num,-1,1) in ('1','3','5','7','9') then 1     --15位 男
                                            when length(ui2.id_num) = 15 and substr(ui2.id_num,-1,1) in ('2','4','6','8','0') then 2     --15位 女
                                        end gender,
                                        from_unixtime(unix_timestamp(case when length(ui2.id_num) = 15 then concat('19', substr(ui2.id_num, 7, 6)) 
                                                                          when length(ui2.id_num) = 18 then substr(ui2.id_num, 7, 8)
                                                                     end,
                                                           'yyyyMMdd'),
                                            'yyyy-MM-dd') as birth_dt
                                from 
                                (select id , 
                                       case when ui.is_card = 1 then regexp_extract(regexp_replace(ui.id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) end  id_num
                                  from ods.t_user_info_hist ui ) ui2 
                         ) ui2
                        on ui2.id = ui.id           
          ) uix
         on uix.user_id = bo.user_id
  left join 
          ( 
               select user_id, bo_id, cast(td_final_score as int) td_final_score, cast(td_platform_count_7d as int) td_platform_count_7d, 
                      cast(td_platform_count_1m as int) td_platform_count_1m,  cast(td_platform_count_3m as int) td_platform_count_3m, cast(td_platform_count_6m as int) td_platform_count_6m 
                 from odsopr.borrows_credit_info_merge_hist
          ) crd
         on crd.user_id = bo.user_id 
        and crd.bo_id = bo.bo_id 
      where bo.bo_is_success = 1 
        and bo.p_key not in (9,10,19,28,29)
        and to_date(bo.bo_agree_time) >= to_date(date_add(date_sub(trunc('${dt}','MONTH'),1),1))             --月初 
        and to_date(bo.bo_agree_time) <= '${dt}'                                                             --月底
   order by bo.bo_agree_time
   ;

   
   
2017-03-31
2017-04-30
2017-05-31
2017-06-30
2017-07-31
2017-08-31
2017-09-30
2017-10-31
2017-11-30
2017-12-31

2018-01-31
2018-02-28
2018-03-31
2018-04-30
2018-05-31
2018-06-30
2018-07-31
2018-08-31
2018-09-30
2018-10-31
2018-11-30   

   msc.v_dim_vintage     视图     整合线上和线下的所有产品
   
--20170331~20181130 的数据
drop table if exists msc.fact_vintage_20181205 ;


CREATE TABLE msc.fact_vintage_20181205 
(
     user_id                bigint
    ,bo_id                  bigint
    ,bo_agree_time          string
    ,bo_expect              int
    ,bo_expect_cat          int
    ,is_overdue             int
    ,is_overdue_unrepay     int
    ,unrepay_price_b        decimal(38,10)
    ,overdue_unrepay_days   int
    ,mob_n                  int
    ,bo_finish_price        decimal(38,10)
    ,product_type           string
    ,product_cat            string
    ,PRODUCT                string
    ,p_name                 string
    ,p_key                  int
    ,bo_expect_type         string
    ,level                  string
    ,score                  string
    ,level_cat              string
    ,user_cat               string
    ,province_cd            string
    ,gender_type            int
    ,age_type               int
    ,education_type         int
    ,school_type            int
    ,loan_amt_type          int
    ,td_score_type          int
    ,td_platform_7d_type    int
    ,td_platform_1m_type    int
    ,td_platform_3m_type    int
    ,td_platform_6m_type    int
)
comment '2016年始标的mob'
partitioned by (stat_date string comment '统计日期 年-月')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;



insert overwrite table msc.fact_vintage_20181205 partition (stat_date) 
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-1  as overdue_unrepay_days,
            --trunc(months_between(to_date('2018-05-31'),to_date(t.bo_agree_time))) as MOB_N,            
            months_between(to_date('2018-05-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,
            '2018-05-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t 
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-05-31'        
      where t.stat_date = '2018-06-01'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2018-05-31' 
      
      union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-8,
            --trunc(months_between(to_date('2018-06-30'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2018-06-30'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,   
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2018-06-30' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT  t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-06-30'
      where t.stat_date = '2018-07-08'              ----历史快照数据与dim_vintage表有差异，取数时快照时间手工调整
        and to_date(t.bo_agree_time) <= '2018-06-30'  
      
      union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-1,
            --trunc(months_between(to_date('2018-07-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2018-07-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2018-07-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-07-31'
      where t.stat_date = '2018-08-01' 
        and to_date(t.bo_agree_time) <= '2018-07-31'
      
        union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days,
            --trunc(months_between(to_date('2018-08-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2018-08-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2018-08-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-08-31'
      where t.stat_date = '2018-08-31' 
        and to_date(t.bo_agree_time) <= '2018-08-31'  
      
          union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days,
            --trunc(months_between(to_date('2018-09-30'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2018-09-30'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2018-09-30' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-09-30'       
      where t.stat_date = '2018-09-30' 
        and to_date(t.bo_agree_time) <= '2018-09-30'  
      
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days,
            --trunc(months_between(to_date('2018-10-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2018-10-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2018-10-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-10-31'       
      where t.stat_date = '2018-10-31' 
        and to_date(t.bo_agree_time) <= '2018-10-31'  
        
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-3,
            --trunc(months_between(to_date('2018-10-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2018-11-30'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2018-11-30' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-11-30'       
      where t.stat_date = '2018-12-03' 
        and to_date(t.bo_agree_time) <= '2018-11-30'
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-10,
            --trunc(months_between(to_date('2018-04-30'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2018-04-30'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2018-04-30' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-04-30'        
      where t.stat_date = '2018-05-10'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2018-04-30'

            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-10,
            --trunc(months_between(to_date('2018-03-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2018-03-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2018-03-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-03-31'        
      where t.stat_date = '2018-04-10'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2018-03-31'
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-10,
            --trunc(months_between(to_date('2018-02-28'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2018-02-28'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2018-02-28' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-02-28'        
      where t.stat_date = '2018-03-10'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2018-02-28'

            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-10,
            --trunc(months_between(to_date('2018-01-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2018-01-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2018-01-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2018-01-31'        
      where t.stat_date = '2018-02-10'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2018-01-31'
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-10,
            --trunc(months_between(to_date('2017-12-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2017-12-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2017-12-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2017-12-31'        
      where t.stat_date = '2018-01-10'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2017-12-31'     
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-10,
            --trunc(months_between(to_date('2017-11-30'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2017-11-30'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2017-11-30' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2017-11-30'        
      where t.stat_date = '2017-12-10'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2017-11-30'  
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-10,
            --trunc(months_between(to_date('2017-10-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2017-10-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2017-10-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2017-10-31'        
      where t.stat_date = '2017-11-10'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2017-10-31'
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-15,
            --trunc(months_between(to_date('2017-09-30'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2017-09-30'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2017-09-30' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2017-09-30'        
      where t.stat_date = '2017-10-15'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2017-09-30' 
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-15,
            --trunc(months_between(to_date('2017-08-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2017-08-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2017-08-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2017-08-31'        
      where t.stat_date = '2017-09-15'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2017-08-31'    
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-15,
            --trunc(months_between(to_date('2017-07-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2017-07-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2017-07-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2017-07-31'        
      where t.stat_date = '2017-08-15'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2017-07-31'            
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-15,
            --trunc(months_between(to_date('2017-06-30'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2017-06-30'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2017-06-30' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2017-06-30'        
      where t.stat_date = '2017-07-15'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2017-06-30'                    
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-15,
            --trunc(months_between(to_date('2017-05-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2017-05-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2017-05-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2017-05-31'        
      where t.stat_date = '2017-06-15'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2017-05-31'
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-15,
            --trunc(months_between(to_date('2017-04-30'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2017-04-30'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,            
            '2017-04-30' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2017-04-30'        
      where t.stat_date = '2017-05-15'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2017-04-30'        
        
        
            union all
      
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            t.bo_expect,
            t.bo_expect_cat,
            t.is_overdue, 
            t.is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days-15,
            --trunc(months_between(to_date('2017-03-31'),to_date(t.bo_agree_time))) as MOB_N,
            months_between(to_date('2017-03-31'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,
            '2017-03-31' as stat_date
       from DMT.FACT_REPAY_BORROWS_SNAPSHOT t
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '2017-03-31'        
      where t.stat_date = '2017-04-15'                    --历史快照数据与dim_vintage表有差异，取数时快照时间手工调整    
        and to_date(t.bo_agree_time) <= '2017-03-31'        
;






-- 20160131~20170228 的数据    此处补数据用 ${dt} 
insert overwrite table msc.fact_vintage_20181205 partition (stat_date) 
     select t.user_id, 
            t.bo_id, 
            t.bo_agree_time, 
            dim.bo_expect,
            dim.bo_expect_cat,
            null is_overdue, 
            null is_overdue_unrepay,
            t.unrepay_price_b, 
            t.overdue_unrepay_days,
            months_between(to_date('${dt}'),last_day(t.bo_agree_time)) as MOB_N,
            dim.bo_finish_price,
            dim.product_type,
            dim.product_cat,
            dim.PRODUCT,
            dim.p_name,
            dim.p_key,
            dim.bo_expect_type,
            dim.level,
            dim.score,
            dim.level_cat,
            dim.user_cat,
            dim.province_cd,
            dim.gender_type,
            dim.age_type,
            dim.education_type,
            dim.school_type,
            dim.loan_amt_type,
            dim.td_score_type,
            dim.td_platform_7d_type,
            dim.td_platform_1m_type,
            dim.td_platform_3m_type,
            dim.td_platform_6m_type,
            '${dt}' as stat_date
       from msc.fact_borrows_unrepay_h_20181205 t 
       join msc.v_dim_vintage dim 
         on dim.user_id = t.user_id 
        and dim.bo_id = t.bo_id 
        and dim.stat_date <= '${dt}'        
      where t.stat_date = '${dt}'    
        and to_date(t.bo_agree_time) <= '${dt}' 
;





--把数据插入到 dw_srm.fact_vintage_snapshot_m      20181205
insert overwrite table dw_srm.fact_vintage_snapshot_m partition (stat_month)
     select fact.bo_id,
            fact.user_id,
            to_date(fact.bo_agree_time),
            fact.bo_finish_price,
            case when fact.user_cat = '新客' then '0' else '1' end,
            fact.level_cat,
            cast(fact.mob_n as int) ,
            fact.bo_expect_type,
            fact.p_key,
            case 
                when fact.product = '信用贷（专）'           then '010101'
                when fact.product = '信用贷（本）'           then '010102'
                when fact.product = '名校贷应急包'           then '010103'
                when fact.product = '大额借'                 then '010201'
                when fact.product = '高学历贷'               then '010202'
                when fact.product = '消费能力贷'             then '010203'
                when fact.product = '白领包'                 then '010301'
                when fact.product = '社保贷'                 then '010302'
                when fact.product = '应届贷'                 then '010303'
                when fact.product = '金卡-信用贷'            then '010401'
                when fact.product = '金卡-麦子借款'          then '010402'
                when fact.product = '极速金卡-信用贷'        then '010501'
                when fact.product = '极速金卡-麦子借款'      then '010502'
                when fact.product = '教育分期'               then '020101'
                when fact.product = '医美分期'               then '020102'
                when fact.product = '爱美呗分期(非担保)'     then '020201'
                when fact.product = '爱美呗分期(担保)'       then '020202'
                else '000000'
            end as product_cd,
            fact.gender_type,
            fact.age_type,
            fact.education_type,
            fact.school_type,
            fact.loan_amt_type,
            fact.province_cd,            
            fact.td_score_type,
            fact.td_platform_7d_type,
            fact.td_platform_1m_type,
            fact.td_platform_3m_type,
            fact.td_platform_6m_type,
            case when fact.overdue_unrepay_days >= 1  then fact.unrepay_price_b else 0 end,
            case when fact.overdue_unrepay_days >= 10 then fact.unrepay_price_b else 0 end,
            case when fact.overdue_unrepay_days >= 30 then fact.unrepay_price_b else 0 end,
            case when fact.overdue_unrepay_days >= 60 then fact.unrepay_price_b else 0 end,
            case when fact.overdue_unrepay_days >= 90 then fact.unrepay_price_b else 0 end,
            fact.stat_date
       from msc.fact_vintage_20181205 fact
  left join idw.fact_borrows bo
         on bo.bo_id = fact.bo_id
      --where 1 = 1
        --and fact.p_key not in (9,10,19,28,29)            --先排除 消费金融类
        --and fact.stat_date = '2018-10-31'
    ;
      



--

select * 
from msc.fact_vintage_20181122 fact_vin 
inner join msc.dim_vintage_20181122 dim_vin 
on fact_vin.user_id = dim_vin.user_id 
and fact_vin.bo_id = dim_vin.bo_id 
and dim_vin.product_type in ('白领贷', '麦子借款', '信用贷')
where 1 = 1 
and fact_vin.mob_n >= 0 
and fact_vin.mob_n <= 20



--核对
select  substr(to_date(bo_agree_time),1,7),
        product_type,
        bo_expect_type,
        mob_n,
        sum(unrepay_price_b)
from msc.fact_vintage_20181122
where 1 = 1 
and product_type = '白领贷'
and bo_expect_type = '12'
and overdue_unrepay_days >= 90
--and is_overdue_unrepay = 1
group by 1,2,3,4
--having overdue_unrepay_days >= 90
order by 1,4 
;




--比例计算

     select a.data_dt,
            a.product_type,
            a.bo_expect_type,
            a.mob_n,
            round(a.unrepay_price_b,2) as unrepay_price_b,
            round(b.bo_finish_price,2) as bo_finish_price,
            round(a.unrepay_price_b / b.bo_finish_price * 100,2) as vintage
    from 
    (
            select  substr(to_date(t.bo_agree_time),1,7) data_dt,
                    t.product_type,
                    t.bo_expect_type,
                    t.mob_n,
                    sum(case when t.overdue_unrepay_days >= 90 then t.unrepay_price_b else 0 end) unrepay_price_b
            from msc.fact_vintage_20181122 t 
            where 1 = 1 
            and product_type = '白领贷'
            and bo_expect_type = '12'
            group by 1,2,3,4
            order by 1,4 
    ) a 
    left join 
    (
            select substr(stat_date,1,7) data_dt, sum(bo_finish_price) bo_finish_price
              from msc.dim_vintage_20181122 
             where 1 = 1 
               and product_type = '白领贷'
               and bo_expect_type = '12'
               and stat_date >= '2018-05-31'
               and stat_date <= '2018-10-31'
          group by 1 
    ) b 
    on b.data_dt = a.data_dt 
order by 1,4
;




--新表比率计算 


     select a.bo_finish_month,
            a.product_type_name,
            a.expect_type,
            a.mob,
            round(a.dpd90_unrepay_price_b,2) as dpd90_unrepay_price_b,
            round(b.bo_finish_price,2) as bo_finish_price,
            round(a.dpd90_unrepay_price_b / b.bo_finish_price * 100,2) as vintage
    from 
    (
            select  t.bo_finish_month,
                    p.product_type_name,
                    t.expect_type,
                    t.mob,
                    sum(t.dpd90_unrepay_price_b) dpd90_unrepay_price_b
            from dw_srm.fact_vintage_snapshot_m t 
      inner join dw_srm.dim_product_cat p
              on p.product_cd = t.product_cd
             and p.product_type_name = '白领贷'
       left join dw_srm.dim_user_cat u 
              on u.user_type = t.user_type
            where 1 = 1 
            and t.expect_type = 12
            group by 1,2,3,4
            order by 1,4 
    ) a 
    left join 
    (
            select t.bo_finish_month, 
                   sum(t.bo_finish_price) bo_finish_price
              from dw_srm.fact_vintage_snapshot_m t
        inner join dw_srm.dim_product_cat p
                on p.product_cd = t.product_cd
               and p.product_type_name = '白领贷'              
             where 1 = 1 
               and t.expect_type = 12
               and t.stat_month = '2018-10'   --截至到2018-10
          group by 1 
          order by 1
    ) b 
    on b.bo_finish_month = a.bo_finish_month 
 where a.bo_finish_month = '2018-03'          --查询2018-03放款时间
order by a.bo_finish_month,cast(a.mob as int)
;



--cube
  SELECT vin.stat_month,
           dt.month_short_desc,
           ex.expect_type_desc,
           vin.mob,
           pro.product_type_name,
           sum(vin.bo_finish_price) bo_finish_price,
           sum(vin.dpd90_unrepay_price_b)/sum(vin.bo_finish_price)*100 dpd90,
           sum(vin.dpd1_unrepay_price_b) dpd1_unrepay_price_b,
           sum(vin.dpd10_unrepay_price_b) dpd10_unrepay_price_b,
           sum(vin.dpd30_unrepay_price_b) dpd30_unrepay_price_b,
           sum(vin.dpd60_unrepay_price_b) dpd60_unrepay_price_b,
           sum(vin.dpd90_unrepay_price_b) dpd90_unrepay_price_b
      from dw_srm.fact_vintage_snapshot_m_20181205 vin 
 left join dw_srmopr.dim_expect_cat ex 
        on ex.expect_type = vin.expect_type
 left join dw_srmopr.dim_level_cat lv 
        on lv.level_type = vin.level_type 
 left join dw_srmopr.dim_mob mob 
        on mob.mob = vin.mob 
 left join dw_srmopr.dim_product_cat pro
        on pro.product_cd = vin.product_cd
 left join dw_srmopr.dim_user_cat u 
        on u.user_type = vin.user_type
 left join dw_srmopr.dim_date dt 
        on dt.day_short_desc = vin.bo_finish_date
        
     where pro.product_type_name = '信用贷'
       and ex.expect_type = 12
       --and vin.stat_month = '2018-11-30'
       and dt.month_short_desc = '2018-01'
       
  group by vin.stat_month,
           dt.month_short_desc,
           ex.expect_type_desc,
           vin.mob,
           pro.product_type_name
  order by vin.stat_month,
           dt.month_short_desc,
           ex.expect_type_desc,
           vin.mob,
           pro.product_type_name
           ;
           



--还原历史数据    从20160131  ~  20170228      14个月 

drop table if exists msc.fact_borrows_unrepay_h_20181205;


CREATE TABLE msc.fact_borrows_unrepay_h_20181205 
(
    user_id                 bigint,
    bo_id                   bigint,
    bo_finish_price         decimal(38,10),
    bo_agree_time           string,
    overdue_unrepay_days    int,
    unrepay_price_b         decimal(38,10)
)
comment '历史未还本金-补'
partitioned by (stat_date string comment '统计日期 年-月')
row format delimited
null defined as ''
stored as parquet
tblproperties ("parquet.compression"="snappy")
;





insert overwrite table msc.fact_borrows_unrepay_h_20181205 partition (stat_date)
 select br.user_id
        ,br.bo_id
        ,bo.bo_finish_price
        ,bo.bo_agree_time
        ,max(case 
                when br.BR_OVERDUE_TERMS > 0 and br.br_is_repay = 0 or to_date(br.br_repay_time) > '${dt}' 
                    then case 
                            when datediff('${dt}', br.br_time) > 0 
                                then datediff('${dt}', br.br_time) 
                         end 
            end) as overdue_unrepay_days
        ,sum(case when br.br_is_repay = 0 or to_date(br.br_repay_time) > '${dt}' then br.br_price_b else 0 end) as unrepay_price_b
        ,'${dt}' as stat_date
   from idw.fact_borrows_repayment br
   join idw.fact_borrows bo
     on br.bo_id = bo.bo_id
    and bo.bo_agree_time is not null 
    and to_date(bo.bo_agree_time) <= '${dt}'
  --where 1=1
    --and ( br.br_is_repay = 0 or to_date(br.br_repay_time) > '${dt}' )
    --and br.bo_id = 2538272
group by 1,2,3,4,7
;












































