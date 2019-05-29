drop table if exists tmp.bo_repay_detail 
;

create table tmp.bo_repay_detail 
as 
        select a.bo_success_month
               ,a.ind
               ,a.user_id
               ,a.bo_id
               ,a.level_type
               ,a.product_cd
               ,a.expect_type
               ,a.p_key
               ,a.bo_success_time
               ,a.mob
               ,a.bo_finish_price
               --1 FPD
               ,sum(case when a.br_expect_num = 1 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_first_repay_overdue      --是否首期还款逾期
               ,sum(case when a.br_expect_num = 1 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as first_repay_overdue_days   --首期还款逾期天数
               ,sum(case when a.br_expect_num >= 1 then a.br_price_b else 0 end )                                                                                             as first_unrepay_price_b      --首期还款逾期未还本金
               ,max(case when a.br_expect_num = 1 then to_date(a.br_time) else '' end)                                                                                        as first_br_date              --首期应还款日期
               --,max(case when a.br_expect_num = 1 then to_date(a.br_repay_time) else '' end)                                                                                  as first_br_repay_date
               
               --2 SPD
               ,sum(case when a.br_expect_num = 2 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_second_repay_overdue
               ,sum(case when a.br_expect_num = 2 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as second_repay_overdue_days
               ,sum(case when a.br_expect_num >= 2 then a.br_price_b else 0 end )                                                                                             as second_unrepay_price_b
               ,max(case when a.br_expect_num = 2 then to_date(a.br_time) else '' end)                                                                                        as second_br_date
               --,max(case when a.br_expect_num = 2 then to_date(a.br_repay_time) else '' end)                                                                                  as second_br_repay_date
               
               --3 TPD
               ,sum(case when a.br_expect_num = 3 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_third_repay_overdue
               ,sum(case when a.br_expect_num = 3 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as third_repay_overdue_days
               ,sum(case when a.br_expect_num >= 3 then a.br_price_b else 0 end )                                                                                             as third_unrepay_price_b
               ,max(case when a.br_expect_num = 3 then to_date(a.br_time) else '' end)                                                                                        as third_br_date
               --,max(case when a.br_expect_num = 3 then to_date(a.br_repay_time) else '' end)                                                                                  as third_br_repay_date
               
               --4 PD
               ,sum(case when a.br_expect_num = 4 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_fourth_repay_overdue
               ,sum(case when a.br_expect_num = 4 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as fourth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 4 then a.br_price_b else 0 end )                                                                                             as fourth_unrepay_price_b
               ,max(case when a.br_expect_num = 4 then to_date(a.br_time) else '' end)                                                                                        as fourth_br_date
               --,max(case when a.br_expect_num = 4 then to_date(a.br_repay_time) else '' end)                                                                                  as fourth_br_repay_date

               --5 PD
               ,sum(case when a.br_expect_num = 5 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_fifth_repay_overdue
               ,sum(case when a.br_expect_num = 5 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as fifth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 5 then a.br_price_b else 0 end )                                                                                             as fifth_unrepay_price_b
               ,max(case when a.br_expect_num = 5 then to_date(a.br_time) else '' end)                                                                                        as fifth_br_date
               --,max(case when a.br_expect_num = 5 then to_date(a.br_repay_time) else '' end)                                                                                  as fifth_br_repay_date

               --6 PD
               ,sum(case when a.br_expect_num = 6 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_sixth_repay_overdue
               ,sum(case when a.br_expect_num = 6 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as sixth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 6 then a.br_price_b else 0 end )                                                                                             as sixth_unrepay_price_b
               ,max(case when a.br_expect_num = 6 then to_date(a.br_time) else '' end)                                                                                        as sixth_br_date
               --,max(case when a.br_expect_num = 6 then to_date(a.br_repay_time) else '' end)                                                                                  as sixth_br_repay_date

               --7 PD
               ,sum(case when a.br_expect_num = 7 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_seventh_repay_overdue
               ,sum(case when a.br_expect_num = 7 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as seventh_repay_overdue_days
               ,sum(case when a.br_expect_num >= 7 then a.br_price_b else 0 end )                                                                                             as seventh_unrepay_price_b
               ,max(case when a.br_expect_num = 7 then to_date(a.br_time) else '' end)                                                                                        as seventh_br_date
               --,max(case when a.br_expect_num = 7 then to_date(a.br_repay_time) else '' end)                                                                                  as seventh_br_repay_date

               --8 PD
               ,sum(case when a.br_expect_num = 8 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_eighth_repay_overdue
               ,sum(case when a.br_expect_num = 8 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as eighth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 8 then a.br_price_b else 0 end )                                                                                             as eighth_unrepay_price_b
               ,max(case when a.br_expect_num = 8 then to_date(a.br_time) else '' end)                                                                                        as eighth_br_date
               --,max(case when a.br_expect_num = 8 then to_date(a.br_repay_time) else '' end)                                                                                  as eighth_br_repay_date

               --9 PD
               ,sum(case when a.br_expect_num = 9 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_ninth_repay_overdue
               ,sum(case when a.br_expect_num = 9 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                              as ninth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 9 then a.br_price_b else 0 end )                                                                                             as ninth_unrepay_price_b
               ,max(case when a.br_expect_num = 9 then to_date(a.br_time) else '' end)                                                                                        as ninth_br_date
               --,max(case when a.br_expect_num = 9 then to_date(a.br_repay_time) else '' end)                                                                                  as ninth_br_repay_date

               --10 PD
               ,sum(case when a.br_expect_num = 10 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_tenth_repay_overdue
               ,sum(case when a.br_expect_num = 10 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as tenth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 10 then a.br_price_b else 0 end )                                                                                             as tenth_unrepay_price_b
               ,max(case when a.br_expect_num = 10 then to_date(a.br_time) else '' end)                                                                                        as tenth_br_date
               --,max(case when a.br_expect_num = 10 then to_date(a.br_repay_time) else '' end)                                                                                  as tenth_br_repay_date

               --11 PD
               ,sum(case when a.br_expect_num = 11 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_eleventh_repay_overdue
               ,sum(case when a.br_expect_num = 11 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as eleventh_repay_overdue_days
               ,sum(case when a.br_expect_num >= 11 then a.br_price_b else 0 end )                                                                                             as eleventh_unrepay_price_b
               ,max(case when a.br_expect_num = 11 then to_date(a.br_time) else '' end)                                                                                        as eleventh_br_date
               --,max(case when a.br_expect_num = 11 then to_date(a.br_repay_time) else '' end)                                                                                  as eleventh_br_repay_date

               --12 PD
               ,sum(case when a.br_expect_num = 12 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twelfth_repay_overdue
               ,sum(case when a.br_expect_num = 12 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twelfth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 12 then a.br_price_b else 0 end )                                                                                             as twelfth_unrepay_price_b
               ,max(case when a.br_expect_num = 12 then to_date(a.br_time) else '' end)                                                                                        as twelfth_br_date
               --,max(case when a.br_expect_num = 12 then to_date(a.br_repay_time) else '' end)                                                                                  as twelfth_br_repay_date

               --13 PD
               ,sum(case when a.br_expect_num = 13 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_thirteenth_repay_overdue
               ,sum(case when a.br_expect_num = 13 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as thirteenth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 13 then a.br_price_b else 0 end )                                                                                             as thirteenth_unrepay_price_b
               ,max(case when a.br_expect_num = 13 then to_date(a.br_time) else '' end)                                                                                        as thirteenth_br_date
               --,max(case when a.br_expect_num = 13 then to_date(a.br_repay_time) else '' end)                                                                                  as thirteenth_br_repay_date

               --14 PD
               ,sum(case when a.br_expect_num = 14 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_fourteenth_repay_overdue
               ,sum(case when a.br_expect_num = 14 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as fourteenth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 14 then a.br_price_b else 0 end )                                                                                             as fourteenth_unrepay_price_b
               ,max(case when a.br_expect_num = 14 then to_date(a.br_time) else '' end)                                                                                        as fourteenth_br_date
               --,max(case when a.br_expect_num = 14 then to_date(a.br_repay_time) else '' end)                                                                                  as fourteenth_br_repay_date

               --15 PD
               ,sum(case when a.br_expect_num = 15 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_fifteenth_repay_overdue
               ,sum(case when a.br_expect_num = 15 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as fifteenth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 15 then a.br_price_b else 0 end )                                                                                             as fifteenth_unrepay_price_b
               ,max(case when a.br_expect_num = 15 then to_date(a.br_time) else '' end)                                                                                        as fifteenth_br_date
               --,max(case when a.br_expect_num = 15 then to_date(a.br_repay_time) else '' end)                                                                                  as fifteenth_br_repay_date

               --16 PD
               ,sum(case when a.br_expect_num = 16 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_sixteenth_repay_overdue
               ,sum(case when a.br_expect_num = 16 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as sixteenth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 16 then a.br_price_b else 0 end )                                                                                             as sixteenth_unrepay_price_b
               ,max(case when a.br_expect_num = 16 then to_date(a.br_time) else '' end)                                                                                        as sixteenth_br_date
               --,max(case when a.br_expect_num = 16 then to_date(a.br_repay_time) else '' end)                                                                                  as sixteenth_br_repay_date

               --17 PD
               ,sum(case when a.br_expect_num = 17 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_seventeenth_repay_overdue
               ,sum(case when a.br_expect_num = 17 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as seventeenth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 17 then a.br_price_b else 0 end )                                                                                             as seventeenth_unrepay_price_b
               ,max(case when a.br_expect_num = 17 then to_date(a.br_time) else '' end)                                                                                        as seventeenth_br_date
               --,max(case when a.br_expect_num = 17 then to_date(a.br_repay_time) else '' end)                                                                                  as seventeenth_br_repay_date

               --18 PD
               ,sum(case when a.br_expect_num = 18 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_eighteenth_repay_overdue
               ,sum(case when a.br_expect_num = 18 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as eighteenth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 18 then a.br_price_b else 0 end )                                                                                             as eighteenth_unrepay_price_b
               ,max(case when a.br_expect_num = 18 then to_date(a.br_time) else '' end)                                                                                        as eighteenth_br_date
               --,max(case when a.br_expect_num = 18 then to_date(a.br_repay_time) else '' end)                                                                                  as eighteenth_br_repay_date

               --19 PD
               ,sum(case when a.br_expect_num = 19 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_nineteenth_repay_overdue
               ,sum(case when a.br_expect_num = 19 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as nineteenth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 19 then a.br_price_b else 0 end )                                                                                             as nineteenth_unrepay_price_b
               ,max(case when a.br_expect_num = 19 then to_date(a.br_time) else '' end)                                                                                        as nineteenth_br_date
               --,max(case when a.br_expect_num = 19 then to_date(a.br_repay_time) else '' end)                                                                                  as nineteenth_br_repay_date

               --20 PD
               ,sum(case when a.br_expect_num = 20 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twentieth_repay_overdue
               ,sum(case when a.br_expect_num = 20 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twentieth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 20 then a.br_price_b else 0 end )                                                                                             as twentieth_unrepay_price_b
               ,max(case when a.br_expect_num = 20 then to_date(a.br_time) else '' end)                                                                                        as twentieth_br_date
               --,max(case when a.br_expect_num = 20 then to_date(a.br_repay_time) else '' end)                                                                                  as twentieth_br_repay_date

               --21 PD
               ,sum(case when a.br_expect_num = 21 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twenty_first_repay_overdue
               ,sum(case when a.br_expect_num = 21 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twenty_first_repay_overdue_days
               ,sum(case when a.br_expect_num >= 21 then a.br_price_b else 0 end )                                                                                             as twenty_first_unrepay_price_b
               ,max(case when a.br_expect_num = 21 then to_date(a.br_time) else '' end)                                                                                        as twenty_first_br_date
               --,max(case when a.br_expect_num = 21 then to_date(a.br_repay_time) else '' end)                                                                                  as twenty_first_br_repay_date

               --22 PD
               ,sum(case when a.br_expect_num = 22 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twenty_second_repay_overdue
               ,sum(case when a.br_expect_num = 22 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twenty_second_repay_overdue_days
               ,sum(case when a.br_expect_num >= 22 then a.br_price_b else 0 end )                                                                                             as twenty_second_unrepay_price_b
               ,max(case when a.br_expect_num = 22 then to_date(a.br_time) else '' end)                                                                                        as twenty_second_br_date
               --,max(case when a.br_expect_num = 22 then to_date(a.br_repay_time) else '' end)                                                                                  as twenty_second_br_repay_date

               --23 PD
               ,sum(case when a.br_expect_num = 23 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twenty_third_repay_overdue
               ,sum(case when a.br_expect_num = 23 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twenty_third_repay_overdue_days
               ,sum(case when a.br_expect_num >= 23 then a.br_price_b else 0 end )                                                                                             as twenty_third_unrepay_price_b
               ,max(case when a.br_expect_num = 23 then to_date(a.br_time) else '' end)                                                                                        as twenty_third_br_date
               --,max(case when a.br_expect_num = 23 then to_date(a.br_repay_time) else '' end)                                                                                  as twenty_third_br_repay_date

               --24 PD
               ,sum(case when a.br_expect_num = 24 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twenty_fourth_repay_overdue
               ,sum(case when a.br_expect_num = 24 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twenty_fourth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 24 then a.br_price_b else 0 end )                                                                                             as twenty_fourth_unrepay_price_b
               ,max(case when a.br_expect_num = 24 then to_date(a.br_time) else '' end)                                                                                        as twenty_fourth_br_date
               --,max(case when a.br_expect_num = 24 then to_date(a.br_repay_time) else '' end)                                                                                  as twenty_fourth_br_repay_date

               --25 PD
               ,sum(case when a.br_expect_num = 25 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twenty_fifth_repay_overdue
               ,sum(case when a.br_expect_num = 25 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twenty_fifth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 25 then a.br_price_b else 0 end )                                                                                             as twenty_fifth_unrepay_price_b
               ,max(case when a.br_expect_num = 25 then to_date(a.br_time) else '' end)                                                                                        as twenty_fifth_br_date
               --,max(case when a.br_expect_num = 25 then to_date(a.br_repay_time) else '' end)                                                                                  as twenty_fifth_br_repay_date

               --26 PD
               ,sum(case when a.br_expect_num = 26 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twenty_sixth_repay_overdue
               ,sum(case when a.br_expect_num = 26 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twenty_sixth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 26 then a.br_price_b else 0 end )                                                                                             as twenty_sixth_unrepay_price_b
               ,max(case when a.br_expect_num = 26 then to_date(a.br_time) else '' end)                                                                                        as twenty_sixth_br_date
               --,max(case when a.br_expect_num = 26 then to_date(a.br_repay_time) else '' end)                                                                                  as twenty_sixth_br_repay_date

               --27 PD
               ,sum(case when a.br_expect_num = 27 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twenty_seventh_repay_overdue
               ,sum(case when a.br_expect_num = 27 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twenty_seventh_repay_overdue_days
               ,sum(case when a.br_expect_num >= 27 then a.br_price_b else 0 end )                                                                                             as twenty_seventh_unrepay_price_b
               ,max(case when a.br_expect_num = 27 then to_date(a.br_time) else '' end)                                                                                        as twenty_seventh_br_date
               --,max(case when a.br_expect_num = 27 then to_date(a.br_repay_time) else '' end)                                                                                  as twenty_seventh_br_repay_date

               --28 PD
               ,sum(case when a.br_expect_num = 28 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twenty_eighth_repay_overdue
               ,sum(case when a.br_expect_num = 28 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twenty_eighth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 28 then a.br_price_b else 0 end )                                                                                             as twenty_eighth_unrepay_price_b
               ,max(case when a.br_expect_num = 28 then to_date(a.br_time) else '' end)                                                                                        as twenty_eighth_br_date
               --,max(case when a.br_expect_num = 28 then to_date(a.br_repay_time) else '' end)                                                                                  as twenty_eighth_br_repay_date

               --29 PD
               ,sum(case when a.br_expect_num = 29 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_twenty_ninth_repay_overdue
               ,sum(case when a.br_expect_num = 29 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as twenty_ninth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 29 then a.br_price_b else 0 end )                                                                                             as twenty_ninth_unrepay_price_b
               ,max(case when a.br_expect_num = 29 then to_date(a.br_time) else '' end)                                                                                        as twenty_ninth_br_date
               --,max(case when a.br_expect_num = 29 then to_date(a.br_repay_time) else '' end)                                                                                  as twenty_ninth_br_repay_date

               --30 PD
               ,sum(case when a.br_expect_num = 30 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_thirtieth_repay_overdue
               ,sum(case when a.br_expect_num = 30 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as thirtieth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 30 then a.br_price_b else 0 end )                                                                                             as thirtieth_unrepay_price_b
               ,max(case when a.br_expect_num = 30 then to_date(a.br_time) else '' end)                                                                                        as thirtieth_br_date
               --,max(case when a.br_expect_num = 30 then to_date(a.br_repay_time) else '' end)                                                                                  as thirtieth_br_repay_date

               --31 PD
               ,sum(case when a.br_expect_num = 31 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_thirty_first_repay_overdue
               ,sum(case when a.br_expect_num = 31 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as thirty_first_repay_overdue_days
               ,sum(case when a.br_expect_num >= 31 then a.br_price_b else 0 end )                                                                                             as thirty_first_unrepay_price_b
               ,max(case when a.br_expect_num = 31 then to_date(a.br_time) else '' end)                                                                                        as thirty_first_br_date
               --,max(case when a.br_expect_num = 31 then to_date(a.br_repay_time) else '' end)                                                                                  as thirty_first_br_repay_date

               --32 PD
               ,sum(case when a.br_expect_num = 32 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_thirty_second_repay_overdue
               ,sum(case when a.br_expect_num = 32 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as thirty_second_repay_overdue_days
               ,sum(case when a.br_expect_num >= 32 then a.br_price_b else 0 end )                                                                                             as thirty_second_unrepay_price_b
               ,max(case when a.br_expect_num = 32 then to_date(a.br_time) else '' end)                                                                                        as thirty_second_br_date
               --,max(case when a.br_expect_num = 32 then to_date(a.br_repay_time) else '' end)                                                                                  as thirty_second_br_repay_date

               --33 PD
               ,sum(case when a.br_expect_num = 33 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_thirty_third_repay_overdue
               ,sum(case when a.br_expect_num = 33 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as thirty_third_repay_overdue_days
               ,sum(case when a.br_expect_num >= 33 then a.br_price_b else 0 end )                                                                                             as thirty_third_unrepay_price_b
               ,max(case when a.br_expect_num = 33 then to_date(a.br_time) else '' end)                                                                                        as thirty_third_br_date
               --,max(case when a.br_expect_num = 33 then to_date(a.br_repay_time) else '' end)                                                                                  as thirty_third_br_repay_date

               --34 PD
               ,sum(case when a.br_expect_num = 34 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_thirty_fourth_repay_overdue
               ,sum(case when a.br_expect_num = 34 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as thirty_fourth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 34 then a.br_price_b else 0 end )                                                                                             as thirty_fourth_unrepay_price_b
               ,max(case when a.br_expect_num = 34 then to_date(a.br_time) else '' end)                                                                                        as thirty_fourth_br_date
               --,max(case when a.br_expect_num = 34 then to_date(a.br_repay_time) else '' end)                                                                                  as thirty_fourth_br_repay_date

               --35 PD
               ,sum(case when a.br_expect_num = 35 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_thirty_fifth_repay_overdue
               ,sum(case when a.br_expect_num = 35 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as thirty_fifth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 35 then a.br_price_b else 0 end )                                                                                             as thirty_fifth_unrepay_price_b
               ,max(case when a.br_expect_num = 35 then to_date(a.br_time) else '' end)                                                                                        as thirty_fifth_br_date
               --,max(case when a.br_expect_num = 35 then to_date(a.br_repay_time) else '' end)                                                                                  as thirty_fifth_br_repay_date

               --36 PD
               ,sum(case when a.br_expect_num = 36 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) then 1 else 0 end)                                                                                as is_thirty_sixth_repay_overdue
               ,sum(case when a.br_expect_num = 36 and (to_date('{T_SUB_1}') > to_date(a.br_time)) and (a.br_overdue_terms > 0 or a.br_overdue_terms = 0 and 
                                  datediff(case 
                                                when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                                else to_date(a.br_repay_time) 
                                            end , to_date(a.br_time)) > 0 ) 
                             then datediff(case 
                                            when to_date(a.br_repay_time) is null or to_date(a.br_repay_time)> to_date('{T_SUB_1}') then to_date('{T_SUB_1}')
                                            else to_date(a.br_repay_time) 
                                           end , to_date(a.br_time)) else 0 end)                                                                                               as thirty_sixth_repay_overdue_days
               ,sum(case when a.br_expect_num >= 36 then a.br_price_b else 0 end )                                                                                             as thirty_sixth_unrepay_price_b
               ,max(case when a.br_expect_num = 36 then to_date(a.br_time) else '' end)                                                                                        as thirty_sixth_br_date
               --,max(case when a.br_expect_num = 36 then to_date(a.br_repay_time) else '' end)                                                                                  as thirty_sixth_br_repay_date               

          from (
                    select substr(to_date(bo.bo_success_time),1,7) as bo_success_month
                           ,'线上' ind
                           ,bo.user_id
                           ,bo.bo_id
                            ,case 
                                when bo1.score is not null and bo1.level in ('A') then 'A'
                                when bo1.score is not null and bo1.level in ('B') then 'B'
                                when bo1.score is not null and bo1.level in ('C') then 'C'
                                when bo1.score is not null and bo1.level in ('D') then 'D'
                                when bo1.score is not null and bo1.level in ('E') then 'E'
                                when bo1.score is not null and bo1.level in ('F') then 'F'
                                else '其他'
                            end as level_type
                            ,case 
                                when bo1.product = '信用贷（专）'           then '010101'
                                when bo1.product = '信用贷（本）'           then '010102'
                                when bo1.product = '名校贷应急包'           then '010103'
                                when bo1.product = '大额借'                 then '010201'
                                when bo1.product = '高学历贷'               then '010202'
                                when bo1.product = '消费能力贷'             then '010203'
                                when bo1.product = '白领包'                 then '010301'
                                when bo1.product = '社保贷'                 then '010302'
                                when bo1.product = '应届贷'                 then '010303'
                                when bo1.product = '金卡-信用贷'            then '010401'
                                when bo1.product = '金卡-麦子借款'          then '010402'
                                when bo1.product = '极速金卡-信用贷'        then '010501'
                                when bo1.product = '极速金卡-麦子借款'      then '010502'
                                else '000000'
                            end as product_cd
                            ,case 
                                when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36) then 0
                                else bo.bo_expect
                            end as expect_type 
                           ,bo.p_key
                           ,to_date(bo.bo_success_time) as bo_success_time
                           ,cast(months_between(to_date('{T_SUB_1}'),last_day(bo.bo_success_time)) as int ) as mob
                           ,bo.bo_finish_price
                           ,br.br_expect_num
                           ,br.br_price_b
                           ,br.br_repay_time
                           ,br.br_time
                           ,br.br_overdue_terms
                           ,'{T_SUB_1}' stat_date
                      from idw.fact_borrows bo
                      join idw.fact_borrows_repayment br
                        on bo.bo_id = br.bo_id
                 left join (
                                          select bo.user_id,
                                                 bo.bo_id ,
                                                 bo.bo_success_time,
                                                 case
                                                   when bo.p_id = 87 and bp.bp_channel = 5   then '社保贷'
                                                   when bo.p_id = 87 and bp.bp_channel = 6   then '应届贷'
                                                   when bo.p_id = 87 and bp.bp_channel = 7   then '按揭贷'
                                                   when bo.p_id = 110 and bo.credit_type = 2 then '高学历贷'
                                                   when bo.p_id = 110 and bo.credit_type = 3 then '消费能力贷'
                                                   when bo.p_id = 140 and (mp.external_channel = '3' or mp.external_channel is null ) then '金卡-麦子借款'
                                                   when bo.p_id = 140 and mp.external_channel = '4' then '金卡-信用贷'
                                                   when bo.p_id = 148 and (mp.external_channel = '3' or mp.external_channel is null ) then '极速金卡-麦子借款'
                                                   when bo.p_id = 148 and mp.external_channel = '4' then '极速金卡-信用贷'                               
                                                   else bo.p_name
                                                 end PRODUCT,
                                                 bo.p_id,
                                                 bo.p_key,
                                                 bo.p_name,
                                                 bo.bo_finish_price,
                                                 bo.bo_is_success,
                                                 dm.SCORE_LEVEL LEVEL,
                                                 dm.SCORE_RESULT SCORE
                                            from idw.fact_borrows bo
                                            left join odsopr.borrows_prepare bp
                                              on bo.bp_id = bp.id
                                            left join 
                                                    (
                                                        select bp_id,
                                                               user_id,
                                                               max(case when data_no = 'scoreLevel' then data_value end) SCORE_LEVEL,
                                                               max(case when data_no = 'scoreResult' then data_value end) SCORE_RESULT
                                                          from (select bp_id,user_id,data_value,data_no,
                                                                       row_number() over(partition by bp_id, data_no order by id desc) rn
                                                                  from odsopr.des_main 
                                                                  where data_no in ( 'scoreLevel','scoreResult' ) ) s
                                                         where s.rn = 1
                                                         group by bp_id, user_id
                                                    ) dm
                                              on bo.bp_id = dm.bp_id
                                             and bo.user_id = dm.user_id
                                       left join odsopr.borrows_external_mapping mp 
                                              on mp.bo_id = bo.bo_id
                            ) bo1 
                         on bo1.bo_id = bo.bo_id
                      where 1 = 1
                        and bo.bo_is_success = 1
                        and to_date(bo.bo_success_time) <= '{T_SUB_1}'
                        and bo.p_name not like '%麦芽%' and bo.p_name not like '%美呗%'              --排除麦芽、医美产品
                  
                      union all
                  
                    select substr(to_date(bo.bo_success_time),1,7)
                           ,'线下' ind       --剔除测试和退款的数据  
                           ,bo.user_id
                           ,bo.bo_id
                           ,mo.LEVEL              as level_type
                           ,case 
                               when mo.flag = '老医美' and mo.dic_item in ('教育',  '婚庆')             then '020101'
                               when mo.flag = '老医美' and mo.dic_item =  '医疗美容'                    then '020102'
                               when mo.flag = '新医美' and (mo.qd_pass <> '1' or  mo.qd_pass is null)   then '020201'
                               when mo.flag = '新医美' and mo.qd_pass = '1'                             then '020202'
                               else '000000'
                            end as product_cd
                            ,case 
                                when bo.bo_expect_cat <> 2 or (bo.bo_expect_cat = 2 and bo.bo_expect > 36) then 0
                                else bo.bo_expect
                            end as expect_type               
                           ,bo.p_key
                           ,to_date(bo.bo_success_time) as bo_success_time
                           ,cast(months_between(to_date('{T_SUB_1}'),last_day(bo.bo_success_time)) as int ) as mob
                           ,bo.bo_finish_price
                           ,br.br_expect_num
                           ,br.br_price_b
                           ,br.br_repay_time
                           ,br.br_time
                           ,br.br_overdue_terms                           
                           ,'{T_SUB_1}' stat_date
                      from idw.fact_borrows bo
                      join idw.fact_borrows_repayment br
                        on bo.bo_id = br.bo_id
                 left join (
                                     SELECT t.order_no, 
                                            t.bo_id,
                                            t.qd_pass,
                                            t.SHOP_COMPANY_TYPE dic_item,
                                            case 
                                                when to_date(t.create_time) >= '2018-04-03' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海迪蔻医疗美容门诊部有限公司'     then '新医美'
                                                when to_date(t.create_time) >= '2018-04-03' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海雅尚医疗美容门诊部有限公司'     then '新医美'
                                                when to_date(t.create_time) >= '2018-04-12' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海容妍医院管理有限公司'           then '新医美'
                                                when to_date(t.create_time) >= '2018-04-21' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海纽赛医疗美容门诊部有限公司'     then '新医美'
                                                when to_date(t.create_time) >= '2018-04-21' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海韩镜医疗美容医院有限公司'       then '新医美'
                                                when to_date(t.create_time) >= '2018-04-24' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海南山医院有限公司'               then '新医美'
                                                when to_date(t.create_time) >= '2018-04-25' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海历思医疗美容门诊部有限公司'     then '新医美'
                                                when to_date(t.create_time) >= '2018-05-11' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海名媛医疗美容门诊部有限公司'     then '新医美'
                                                when to_date(t.create_time) >= '2018-05-11' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海明桥医疗美容门诊部有限公司'     then '新医美'
                                                when to_date(t.create_time) >= '2018-05-19' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海翔茂医疗美容门诊部有限公司'     then '新医美'
                                                when to_date(t.create_time) >= '2018-05-31' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海翡立思医疗美容门诊部有限公司'   then '新医美'
                                                when to_date(t.create_time) >= '2018-06-22' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '广州艾美医疗美容门诊有限公司'       then '新医美'
                                                when to_date(t.create_time) >= '2018-06-22' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '特壹美（广州）健康管理有限公司'     then '新医美'
                                                when to_date(t.create_time) >= '2018-06-22' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '广州新颜医疗美容门诊有限公司'       then '新医美'
                                                when to_date(t.create_time) >= '2018-06-22' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '深圳恒丽医疗美容门诊部有限公司'     then '新医美'
                                                when to_date(t.create_time) >= '2018-06-26' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海复美医疗美容门诊部有限公司'     then '新医美'
                                                when to_date(t.create_time) >= '2018-06-25' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '深圳臻希美医疗美容门诊部'           then '新医美'
                                                when to_date(t.create_time) >= '2018-06-22' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '深圳市八福贸易有限公司盛美佳门诊部' then '新医美'
                                                when to_date(t.create_time) >= '2018-07-04' and to_date(t.create_time) <= '2018-09-01' and SHOP_NAME = '上海铭悦医疗美容门诊部有限公司'     then '新医美'
                                                else '老医美'
                                            end as flag,
                                            t.shop_name,
                                            ll.LEVEL
                                       from idw.fact_maiya_order t 
                                  left join (
                                                select order_no,
                                                       max(CREDIT_LEVEL) AS LEVEL 
                                                  from ODSOPR.ORD_ORDER 
                                                 where DISABLED = 0
                                                 group by order_no
                                            ) ll
                                         on ll.order_no = t.order_no
                           ) mo 
                        on mo.bo_id = bo.bo_id
                     where 1 = 1
                       and bo.bo_is_success = 1
                       and to_date(bo.bo_success_time) <= '{T_SUB_1}'
                       and mo.SHOP_NAME not LIKE '%测试%' and mo.SHOP_NAME not LIKE '%退款%'    --剔除测试和退款的数据
                       and ( bo.p_name like '%麦芽%' or bo.p_name like '%美呗%' )
                ) a 
       group by 1,2,3,4,5,6,7,8,9,10,11
       ;
       
       
       
drop table if exists tmp.bo_repay_le29_flag 
;

create table tmp.bo_repay_le29_flag 
as 
select b.bo_id, b.bo_overdue_days, b.bo_expect, b.le29, min(b.le29) over(partition by b.bo_id order by b.bo_expect) as le29_flag
from 
(    
    select  bo_id, bo_overdue_days, bo_expect, case when t.bo_overdue_days <= 29 then 1 else 0 end le29
    from (
        select bo_id, first_repay_overdue_days as bo_overdue_days, 1 as bo_expect from tmp.bo_repay_detail union all 
        select bo_id, second_repay_overdue_days, 2 from tmp.bo_repay_detail union all 
        select bo_id, third_repay_overdue_days, 3 from tmp.bo_repay_detail union all 
        select bo_id, fourth_repay_overdue_days, 4 from tmp.bo_repay_detail union all 
        select bo_id, fifth_repay_overdue_days, 5 from tmp.bo_repay_detail union all 
        select bo_id, sixth_repay_overdue_days, 6 from tmp.bo_repay_detail union all 
        select bo_id, seventh_repay_overdue_days, 7 from tmp.bo_repay_detail union all 
        select bo_id, eighth_repay_overdue_days, 8 from tmp.bo_repay_detail union all 
        select bo_id, ninth_repay_overdue_days, 9 from tmp.bo_repay_detail union all 
        select bo_id, tenth_repay_overdue_days, 10 from tmp.bo_repay_detail union all 
        select bo_id, eleventh_repay_overdue_days, 11 from tmp.bo_repay_detail union all 
        select bo_id, twelfth_repay_overdue_days, 12 from tmp.bo_repay_detail union all 
        select bo_id, thirteenth_repay_overdue_days, 13 from tmp.bo_repay_detail union all 
        select bo_id, fourteenth_repay_overdue_days, 14 from tmp.bo_repay_detail union all 
        select bo_id, fifteenth_repay_overdue_days, 15 from tmp.bo_repay_detail union all 
        select bo_id, sixteenth_repay_overdue_days, 16 from tmp.bo_repay_detail union all 
        select bo_id, seventeenth_repay_overdue_days, 17 from tmp.bo_repay_detail union all 
        select bo_id, eighteenth_repay_overdue_days, 18 from tmp.bo_repay_detail union all 
        select bo_id, nineteenth_repay_overdue_days, 19 from tmp.bo_repay_detail union all 
        select bo_id, twentieth_repay_overdue_days, 20 from tmp.bo_repay_detail union all 
        select bo_id, twenty_first_repay_overdue_days, 21 from tmp.bo_repay_detail union all 
        select bo_id, twenty_second_repay_overdue_days, 22 from tmp.bo_repay_detail union all 
        select bo_id, twenty_third_repay_overdue_days, 23 from tmp.bo_repay_detail union all 
        select bo_id, twenty_fourth_repay_overdue_days, 24 from tmp.bo_repay_detail union all 
        select bo_id, twenty_fifth_repay_overdue_days, 25 from tmp.bo_repay_detail union all 
        select bo_id, twenty_sixth_repay_overdue_days, 26 from tmp.bo_repay_detail union all 
        select bo_id, twenty_seventh_repay_overdue_days, 27 from tmp.bo_repay_detail union all 
        select bo_id, twenty_eighth_repay_overdue_days, 28 from tmp.bo_repay_detail union all 
        select bo_id, twenty_ninth_repay_overdue_days, 29 from tmp.bo_repay_detail union all 
        select bo_id, thirtieth_repay_overdue_days, 30 from tmp.bo_repay_detail union all 
        select bo_id, thirty_first_repay_overdue_days, 31 from tmp.bo_repay_detail union all 
        select bo_id, thirty_second_repay_overdue_days, 32 from tmp.bo_repay_detail union all 
        select bo_id, thirty_third_repay_overdue_days, 33 from tmp.bo_repay_detail union all 
        select bo_id, thirty_fourth_repay_overdue_days, 34 from tmp.bo_repay_detail union all 
        select bo_id, thirty_fifth_repay_overdue_days, 35 from tmp.bo_repay_detail union all 
        select bo_id, thirty_sixth_repay_overdue_days, 36 from tmp.bo_repay_detail
    ) t 
    order by t.bo_id, t.bo_expect
) b 
;



INSERT OVERWRITE TABLE dw_srm.fact_risk_payment_delay_d partition (STAT_DATE)
     select t.bo_id
            ,t.ind
            ,t.user_id
            ,'{T_SUB_1}' as statis_dt
            ,t.level_type
            ,t.product_cd
            ,p.product_line_name
            ,p.product_type_name
            ,p.product_name
            ,t.expect_type
            ,t.p_key
            ,t.bo_success_time
            ,t.bo_finish_price
            --1
            ,max(case when t.first_repay_overdue_days  >= 1  then 1  else 0 end)                                                as fpd_1_flag
            ,max(case when t.first_repay_overdue_days  >= 1  then to_date(date_add(t.first_br_date, 1))  else '' end)           as fpd_1_time
            ,max(case when t.first_repay_overdue_days  >= 1  then t.first_unrepay_price_b  else 0 end)                          as fpd_1_outstanding                                                                                                                          
            ,max(case when t.first_repay_overdue_days  >= 3  then 1  else 0 end)                                                as fpd_3_flag
            ,max(case when t.first_repay_overdue_days  >= 3  then to_date(date_add(t.first_br_date, 3))  else '' end)           as fpd_3_time
            ,max(case when t.first_repay_overdue_days  >= 3  then t.first_unrepay_price_b  else 0 end)                          as fpd_3_outstanding                                                                                                                           
            ,max(case when t.first_repay_overdue_days  >= 7  then 1  else 0 end)                                                as fpd_7_flag
            ,max(case when t.first_repay_overdue_days  >= 7  then to_date(date_add(t.first_br_date, 7))  else '' end)           as fpd_7_time
            ,max(case when t.first_repay_overdue_days  >= 7  then t.first_unrepay_price_b  else 0 end)                          as fpd_7_outstanding
            ,max(case when t.first_repay_overdue_days  >= 15  then 1  else 0 end)                                               as fpd_15_flag
            ,max(case when t.first_repay_overdue_days  >= 15  then to_date(date_add(t.first_br_date, 15))  else '' end)         as fpd_15_time
            ,max(case when t.first_repay_overdue_days  >= 15  then t.first_unrepay_price_b  else 0 end)                         as fpd_15_outstanding
            ,max(case when t.first_repay_overdue_days  >= 30  then 1  else 0 end)                                               as fpd_30_flag
            ,max(case when t.first_repay_overdue_days  >= 30  then to_date(date_add(t.first_br_date, 30))  else '' end)         as fpd_30_time
            ,max(case when t.first_repay_overdue_days  >= 30  then t.first_unrepay_price_b  else 0 end)                         as fpd_30_outstanding
            
            --2
            ,max(case when b.bo_id is not null and b.bo_expect = 1 and b.le29_flag = 1 
                   and t.second_repay_overdue_days >= 30 then 1 else 0 end)                                                 as spd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 1 and b.le29_flag = 1 
                   and t.second_repay_overdue_days >= 30 then to_date(date_add(t.second_br_date, 30)) else '' end)          as spd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 1 and b.le29_flag = 1 
                   and t.second_repay_overdue_days >= 30 then t.second_unrepay_price_b else 0 end)                          as spd_30_outstanding
                   
            --3
            ,max(case when b.bo_id is not null and b.bo_expect = 2 and b.le29_flag = 1 
                   and t.third_repay_overdue_days >= 30 then 1 else 0 end)                                                 as tpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 2 and b.le29_flag = 1 
                   and t.third_repay_overdue_days >= 30 then to_date(date_add(t.third_br_date, 30)) else '' end)          as tpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 2 and b.le29_flag = 1 
                   and t.third_repay_overdue_days >= 30 then t.third_unrepay_price_b else 0 end)                          as tpd_30_outstanding

            --4
            ,max(case when b.bo_id is not null and b.bo_expect = 3 and b.le29_flag = 1 
                   and t.fourth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as qpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 3 and b.le29_flag = 1 
                   and t.fourth_repay_overdue_days >= 30 then to_date(date_add(t.fourth_br_date, 30)) else '' end)          as qpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 3 and b.le29_flag = 1 
                   and t.fourth_repay_overdue_days >= 30 then t.fourth_unrepay_price_b else 0 end)                          as qpd_30_outstanding
                   
            --5
            ,max(case when b.bo_id is not null and b.bo_expect = 4 and b.le29_flag = 1 
                   and t.fifth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as fifthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 4 and b.le29_flag = 1 
                   and t.fifth_repay_overdue_days >= 30 then to_date(date_add(t.fifth_br_date, 30)) else '' end)          as fifthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 4 and b.le29_flag = 1 
                   and t.fifth_repay_overdue_days >= 30 then t.fifth_unrepay_price_b else 0 end)                          as fifthpd_30_outstanding            
            --6
            ,max(case when b.bo_id is not null and b.bo_expect = 5 and b.le29_flag = 1 
                   and t.sixth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as sixthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 5 and b.le29_flag = 1 
                   and t.sixth_repay_overdue_days >= 30 then to_date(date_add(t.sixth_br_date, 30)) else '' end)          as sixthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 5 and b.le29_flag = 1 
                   and t.sixth_repay_overdue_days >= 30 then t.sixth_unrepay_price_b else 0 end)                          as sixthpd_30_outstanding            
            --7 
            ,max(case when b.bo_id is not null and b.bo_expect = 6 and b.le29_flag = 1 
                   and t.seventh_repay_overdue_days >= 30 then 1 else 0 end)                                                 as seventhpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 6 and b.le29_flag = 1 
                   and t.seventh_repay_overdue_days >= 30 then to_date(date_add(t.seventh_br_date, 30)) else '' end)          as seventhpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 6 and b.le29_flag = 1 
                   and t.seventh_repay_overdue_days >= 30 then t.seventh_unrepay_price_b else 0 end)                          as seventhpd_30_outstanding            
            --8
            ,max(case when b.bo_id is not null and b.bo_expect = 7 and b.le29_flag = 1 
                   and t.eighth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as eighthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 7 and b.le29_flag = 1 
                   and t.eighth_repay_overdue_days >= 30 then to_date(date_add(t.eighth_br_date, 30)) else '' end)          as eighthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 7 and b.le29_flag = 1 
                   and t.eighth_repay_overdue_days >= 30 then t.eighth_unrepay_price_b else 0 end)                          as eighthpd_30_outstanding            
            --9
            ,max(case when b.bo_id is not null and b.bo_expect = 8 and b.le29_flag = 1 
                   and t.ninth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as ninthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 8 and b.le29_flag = 1 
                   and t.ninth_repay_overdue_days >= 30 then to_date(date_add(t.ninth_br_date, 30)) else '' end)          as ninthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 8 and b.le29_flag = 1 
                   and t.ninth_repay_overdue_days >= 30 then t.ninth_unrepay_price_b else 0 end)                          as ninthpd_30_outstanding            
            --10
            ,max(case when b.bo_id is not null and b.bo_expect = 9 and b.le29_flag = 1 
                   and t.tenth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as tenthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 9 and b.le29_flag = 1 
                   and t.tenth_repay_overdue_days >= 30 then to_date(date_add(t.tenth_br_date, 30)) else '' end)          as tenthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 9 and b.le29_flag = 1 
                   and t.tenth_repay_overdue_days >= 30 then t.tenth_unrepay_price_b else 0 end)                          as tenthpd_30_outstanding            
            --11
            ,max(case when b.bo_id is not null and b.bo_expect = 10 and b.le29_flag = 1 
                   and t.eleventh_repay_overdue_days >= 30 then 1 else 0 end)                                                 as eleventhpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 10 and b.le29_flag = 1 
                   and t.eleventh_repay_overdue_days >= 30 then to_date(date_add(t.eleventh_br_date, 30)) else '' end)          as eleventhpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 10 and b.le29_flag = 1 
                   and t.eleventh_repay_overdue_days >= 30 then t.eleventh_unrepay_price_b else 0 end)                          as eleventhpd_30_outstanding            
            --12
            ,max(case when b.bo_id is not null and b.bo_expect = 11 and b.le29_flag = 1 
                   and t.twelfth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twelfthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 11 and b.le29_flag = 1 
                   and t.twelfth_repay_overdue_days >= 30 then to_date(date_add(t.twelfth_br_date, 30)) else '' end)          as twelfthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 11 and b.le29_flag = 1 
                   and t.twelfth_repay_overdue_days >= 30 then t.twelfth_unrepay_price_b else 0 end)                          as twelfthpd_30_outstanding            
            --13
            ,max(case when b.bo_id is not null and b.bo_expect = 12 and b.le29_flag = 1 
                   and t.thirteenth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as thirteenthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 12 and b.le29_flag = 1 
                   and t.thirteenth_repay_overdue_days >= 30 then to_date(date_add(t.thirteenth_br_date, 30)) else '' end)          as thirteenthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 12 and b.le29_flag = 1 
                   and t.thirteenth_repay_overdue_days >= 30 then t.thirteenth_unrepay_price_b else 0 end)                          as thirteenthpd_30_outstanding            
            --14
            ,max(case when b.bo_id is not null and b.bo_expect = 13 and b.le29_flag = 1 
                   and t.fourteenth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as fourteenthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 13 and b.le29_flag = 1 
                   and t.fourteenth_repay_overdue_days >= 30 then to_date(date_add(t.fourteenth_br_date, 30)) else '' end)          as fourteenthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 13 and b.le29_flag = 1 
                   and t.fourteenth_repay_overdue_days >= 30 then t.fourteenth_unrepay_price_b else 0 end)                          as fourteenthpd_30_outstanding            
            --15
            ,max(case when b.bo_id is not null and b.bo_expect = 14 and b.le29_flag = 1 
                   and t.fifteenth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as fifteenthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 14 and b.le29_flag = 1 
                   and t.fifteenth_repay_overdue_days >= 30 then to_date(date_add(t.fifteenth_br_date, 30)) else '' end)          as fifteenthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 14 and b.le29_flag = 1 
                   and t.fifteenth_repay_overdue_days >= 30 then t.fifteenth_unrepay_price_b else 0 end)                          as fifteenthpd_30_outstanding            
            --16
            ,max(case when b.bo_id is not null and b.bo_expect = 15 and b.le29_flag = 1 
                   and t.sixteenth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as sixteenthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 15 and b.le29_flag = 1 
                   and t.sixteenth_repay_overdue_days >= 30 then to_date(date_add(t.sixteenth_br_date, 30)) else '' end)          as sixteenthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 15 and b.le29_flag = 1 
                   and t.sixteenth_repay_overdue_days >= 30 then t.sixteenth_unrepay_price_b else 0 end)                          as sixteenthpd_30_outstanding            
            --17
            ,max(case when b.bo_id is not null and b.bo_expect = 16 and b.le29_flag = 1 
                   and t.seventeenth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as seventeenthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 16 and b.le29_flag = 1 
                   and t.seventeenth_repay_overdue_days >= 30 then to_date(date_add(t.seventeenth_br_date, 30)) else '' end)          as seventeenthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 16 and b.le29_flag = 1 
                   and t.seventeenth_repay_overdue_days >= 30 then t.seventeenth_unrepay_price_b else 0 end)                          as seventeenthpd_30_outstanding            
            --18
            ,max(case when b.bo_id is not null and b.bo_expect = 17 and b.le29_flag = 1 
                   and t.eighteenth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as eighteenthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 17 and b.le29_flag = 1 
                   and t.eighteenth_repay_overdue_days >= 30 then to_date(date_add(t.eighteenth_br_date, 30)) else '' end)          as eighteenthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 17 and b.le29_flag = 1 
                   and t.eighteenth_repay_overdue_days >= 30 then t.eighteenth_unrepay_price_b else 0 end)                          as eighteenthpd_30_outstanding            
            --19
            ,max(case when b.bo_id is not null and b.bo_expect = 18 and b.le29_flag = 1 
                   and t.nineteenth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as nineteenthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 18 and b.le29_flag = 1 
                   and t.nineteenth_repay_overdue_days >= 30 then to_date(date_add(t.nineteenth_br_date, 30)) else '' end)          as nineteenthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 18 and b.le29_flag = 1 
                   and t.nineteenth_repay_overdue_days >= 30 then t.nineteenth_unrepay_price_b else 0 end)                          as nineteenthpd_30_outstanding            
            --20
            ,max(case when b.bo_id is not null and b.bo_expect = 19 and b.le29_flag = 1 
                   and t.twentieth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twentiethpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 19 and b.le29_flag = 1 
                   and t.twentieth_repay_overdue_days >= 30 then to_date(date_add(t.twentieth_br_date, 30)) else '' end)          as twentiethpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 19 and b.le29_flag = 1 
                   and t.twentieth_repay_overdue_days >= 30 then t.twentieth_unrepay_price_b else 0 end)                          as twentiethpd_30_outstanding            
            --21
            ,max(case when b.bo_id is not null and b.bo_expect = 20 and b.le29_flag = 1 
                   and t.twenty_first_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twenty_firstpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 20 and b.le29_flag = 1 
                   and t.twenty_first_repay_overdue_days >= 30 then to_date(date_add(t.twenty_first_br_date, 30)) else '' end)          as twenty_firstpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 20 and b.le29_flag = 1 
                   and t.twenty_first_repay_overdue_days >= 30 then t.twenty_first_unrepay_price_b else 0 end)                          as twenty_firstpd_30_outstanding            
            --22
            ,max(case when b.bo_id is not null and b.bo_expect = 21 and b.le29_flag = 1 
                   and t.twenty_second_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twenty_secondpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 21 and b.le29_flag = 1 
                   and t.twenty_second_repay_overdue_days >= 30 then to_date(date_add(t.twenty_second_br_date, 30)) else '' end)          as twenty_secondpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 21 and b.le29_flag = 1 
                   and t.twenty_second_repay_overdue_days >= 30 then t.twenty_second_unrepay_price_b else 0 end)                          as twenty_secondpd_30_outstanding            
            --23
            ,max(case when b.bo_id is not null and b.bo_expect = 22 and b.le29_flag = 1 
                   and t.twenty_third_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twenty_thirdpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 22 and b.le29_flag = 1 
                   and t.twenty_third_repay_overdue_days >= 30 then to_date(date_add(t.twenty_third_br_date, 30)) else '' end)          as twenty_thirdpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 22 and b.le29_flag = 1 
                   and t.twenty_third_repay_overdue_days >= 30 then t.twenty_third_unrepay_price_b else 0 end)                          as twenty_thirdpd_30_outstanding            
            --24
            ,max(case when b.bo_id is not null and b.bo_expect = 23 and b.le29_flag = 1 
                   and t.twenty_fourth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twenty_fourthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 23 and b.le29_flag = 1 
                   and t.twenty_fourth_repay_overdue_days >= 30 then to_date(date_add(t.twenty_fourth_br_date, 30)) else '' end)          as twenty_fourthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 23 and b.le29_flag = 1 
                   and t.twenty_fourth_repay_overdue_days >= 30 then t.twenty_fourth_unrepay_price_b else 0 end)                          as twenty_fourthpd_30_outstanding            
            --25
            ,max(case when b.bo_id is not null and b.bo_expect = 24 and b.le29_flag = 1 
                   and t.twenty_fifth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twenty_fifthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 24 and b.le29_flag = 1 
                   and t.twenty_fifth_repay_overdue_days >= 30 then to_date(date_add(t.twenty_fifth_br_date, 30)) else '' end)          as twenty_fifthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 24 and b.le29_flag = 1 
                   and t.twenty_fifth_repay_overdue_days >= 30 then t.twenty_fifth_unrepay_price_b else 0 end)                          as twenty_fifthpd_30_outstanding            
            --26
            ,max(case when b.bo_id is not null and b.bo_expect = 25 and b.le29_flag = 1 
                   and t.twenty_sixth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twenty_sixthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 25 and b.le29_flag = 1 
                   and t.twenty_sixth_repay_overdue_days >= 30 then to_date(date_add(t.twenty_sixth_br_date, 30)) else '' end)          as twenty_sixthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 25 and b.le29_flag = 1 
                   and t.twenty_sixth_repay_overdue_days >= 30 then t.twenty_sixth_unrepay_price_b else 0 end)                          as twenty_sixthpd_30_outstanding            
            --27
            ,max(case when b.bo_id is not null and b.bo_expect = 26 and b.le29_flag = 1 
                   and t.twenty_seventh_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twenty_seventhpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 26 and b.le29_flag = 1 
                   and t.twenty_seventh_repay_overdue_days >= 30 then to_date(date_add(t.twenty_seventh_br_date, 30)) else '' end)          as twenty_seventhpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 26 and b.le29_flag = 1 
                   and t.twenty_seventh_repay_overdue_days >= 30 then t.twenty_seventh_unrepay_price_b else 0 end)                          as twenty_seventhpd_30_outstanding            
            --28
            ,max(case when b.bo_id is not null and b.bo_expect = 27 and b.le29_flag = 1 
                   and t.twenty_eighth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twenty_eighthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 27 and b.le29_flag = 1 
                   and t.twenty_eighth_repay_overdue_days >= 30 then to_date(date_add(t.twenty_eighth_br_date, 30)) else '' end)          as twenty_eighthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 27 and b.le29_flag = 1 
                   and t.twenty_eighth_repay_overdue_days >= 30 then t.twenty_eighth_unrepay_price_b else 0 end)                          as twenty_eighthpd_30_outstanding            
            --29
            ,max(case when b.bo_id is not null and b.bo_expect = 28 and b.le29_flag = 1 
                   and t.twenty_ninth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as twenty_ninthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 28 and b.le29_flag = 1 
                   and t.twenty_ninth_repay_overdue_days >= 30 then to_date(date_add(t.twenty_ninth_br_date, 30)) else '' end)          as twenty_ninthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 28 and b.le29_flag = 1 
                   and t.twenty_ninth_repay_overdue_days >= 30 then t.twenty_ninth_unrepay_price_b else 0 end)                          as twenty_ninthpd_30_outstanding            
            --30
            ,max(case when b.bo_id is not null and b.bo_expect = 29 and b.le29_flag = 1 
                   and t.thirtieth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as thirtiethpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 29 and b.le29_flag = 1 
                   and t.thirtieth_repay_overdue_days >= 30 then to_date(date_add(t.thirtieth_br_date, 30)) else '' end)          as thirtiethpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 29 and b.le29_flag = 1 
                   and t.thirtieth_repay_overdue_days >= 30 then t.thirtieth_unrepay_price_b else 0 end)                          as thirtiethpd_30_outstanding            
            --31
            ,max(case when b.bo_id is not null and b.bo_expect = 30 and b.le29_flag = 1 
                   and t.thirty_first_repay_overdue_days >= 30 then 1 else 0 end)                                                 as thirty_firstpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 30 and b.le29_flag = 1 
                   and t.thirty_first_repay_overdue_days >= 30 then to_date(date_add(t.thirty_first_br_date, 30)) else '' end)          as thirty_firstpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 30 and b.le29_flag = 1 
                   and t.thirty_first_repay_overdue_days >= 30 then t.thirty_first_unrepay_price_b else 0 end)                          as thirty_firstpd_30_outstanding            
            --32
            ,max(case when b.bo_id is not null and b.bo_expect = 31 and b.le29_flag = 1 
                   and t.thirty_second_repay_overdue_days >= 30 then 1 else 0 end)                                                 as thirty_secondpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 31 and b.le29_flag = 1 
                   and t.thirty_second_repay_overdue_days >= 30 then to_date(date_add(t.thirty_second_br_date, 30)) else '' end)          as thirty_secondpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 31 and b.le29_flag = 1 
                   and t.thirty_second_repay_overdue_days >= 30 then t.thirty_second_unrepay_price_b else 0 end)                          as thirty_secondpd_30_outstanding            
            --33
            ,max(case when b.bo_id is not null and b.bo_expect = 32 and b.le29_flag = 1 
                   and t.thirty_third_repay_overdue_days >= 30 then 1 else 0 end)                                                 as thirty_thirdpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 32 and b.le29_flag = 1 
                   and t.thirty_third_repay_overdue_days >= 30 then to_date(date_add(t.thirty_third_br_date, 30)) else '' end)          as thirty_thirdpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 32 and b.le29_flag = 1 
                   and t.thirty_third_repay_overdue_days >= 30 then t.thirty_third_unrepay_price_b else 0 end)                          as thirty_thirdpd_30_outstanding            
            --34
            ,max(case when b.bo_id is not null and b.bo_expect = 33 and b.le29_flag = 1 
                   and t.thirty_fourth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as thirty_fourthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 33 and b.le29_flag = 1 
                   and t.thirty_fourth_repay_overdue_days >= 30 then to_date(date_add(t.thirty_fourth_br_date, 30)) else '' end)          as thirty_fourthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 33 and b.le29_flag = 1 
                   and t.thirty_fourth_repay_overdue_days >= 30 then t.thirty_fourth_unrepay_price_b else 0 end)                          as thirty_fourthpd_30_outstanding            
            --35
            ,max(case when b.bo_id is not null and b.bo_expect = 34 and b.le29_flag = 1 
                   and t.thirty_fifth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as thirty_fifthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 34 and b.le29_flag = 1 
                   and t.thirty_fifth_repay_overdue_days >= 30 then to_date(date_add(t.thirty_fifth_br_date, 30)) else '' end)          as thirty_fifthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 34 and b.le29_flag = 1 
                   and t.thirty_fifth_repay_overdue_days >= 30 then t.thirty_fifth_unrepay_price_b else 0 end)                          as thirty_fifthpd_30_outstanding
            --36
            ,max(case when b.bo_id is not null and b.bo_expect = 35 and b.le29_flag = 1 
                   and t.thirty_sixth_repay_overdue_days >= 30 then 1 else 0 end)                                                 as thirty_sixthpd_30_flag
            ,max(case when b.bo_id is not null and b.bo_expect = 35 and b.le29_flag = 1 
                   and t.thirty_sixth_repay_overdue_days >= 30 then to_date(date_add(t.thirty_sixth_br_date, 30)) else '' end)          as thirty_sixthpd_30_time                   
            ,max(case when b.bo_id is not null and b.bo_expect = 35 and b.le29_flag = 1 
                   and t.thirty_sixth_repay_overdue_days >= 30 then t.thirty_sixth_unrepay_price_b else 0 end)                          as thirty_sixthpd_30_outstanding            
            ,'{T_SUB_1}' as stat_date
       from tmp.bo_repay_detail t 
  left join tmp.bo_repay_le29_flag b 
         on b.bo_id = t.bo_id 
  left join dw_srmopr.dim_product_cat p 
         on p.product_cd = t.product_cd
   group by t.bo_id 
            ,t.ind
            ,t.user_id
            ,t.level_type
            ,t.product_cd
            ,p.product_line_name
            ,p.product_type_name
            ,p.product_name            
            ,t.expect_type
            ,t.p_key
            ,t.bo_success_time
            ,t.bo_finish_price
;
       