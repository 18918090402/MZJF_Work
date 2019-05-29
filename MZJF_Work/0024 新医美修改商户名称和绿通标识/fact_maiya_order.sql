set mapreduce.job.name = IDW_FACT_MAIYA_ORDER;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table idw.FACT_MAIYA_ORDER
      select 'SYS'                                                   AS DW_CREATE_BY
             ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_CREATE_TIME
             ,'SYS'                                                  as DW_UPDATE_BY
             ,from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') as DW_UPDATE_TIME
             ,oo.ID                                                  as ORDER_ID
             ,oo.CREATE_USER
             ,oo.CREATE_TIME
             ,oo.UPDATE_USER
             ,oo.UPDATE_TIME
             ,oo.ORDER_NO
             ,oo.STATUS
             ,sdi1.dic_item_name STATUS_DESC
             ,oo.SHOP_ID
             --,oo.SHOP_NAME
             ,case 
                when sn.shop_id is null then oo.shop_name 
                else sn.current_shop_name 
             end as shop_name
             ,sdi2.dic_item_name SHOP_COMPANY_TYPE
             ,oo.FACE_ID
             ,ssf.name FACE_NAME
             ,oo.APPLY_AMOUNT
             ,oo.APPLY_PARTS
             ,oo.PRACTICAL_MONEY
             ,oo.PRINCIPAL
             ,oo.YEAR_RATE
             ,oo.SERVICE_MONEY
             ,oo.TOTAL_PARTS
             ,oc2.ORDER_BEGIN_DATE
             ,case when oo.ORDER_END_DATE > oo.create_time then oo.ORDER_END_DATE end as ORDER_END_DATE
             ,oc2.PASS_TIME
             ,oc2.USER_CONFIRM_TIME
             ,oc2.SHOP_CONFIRM_TIME
             ,case when oo.LENDING_TIME > oo.create_time then oo.LENDING_TIME end as LENDING_TIME
             ,oo.ORDER_TYPE
             ,oo.LBS_Y
             ,oo.LBS_X
             ,oo.EMPLOYEE_ID
             ,oo.GOODS_ID
             ,oo.CHANNEL_ID
             ,oo.IS_CALL
             ,oo.NONOBANK_USERID
             ,oo.SHOP_DEDUCTION
             ,oo.BO_ID
             ,oo.SHOP_BANKNO
             ,oo.SHOP_RATE
             ,oo.IS_ONLINE
             ,oo.CREDIT_LEVEL
             ,oo.REPAYMENT_TYPE
             ,oo.HILO_STR
             ,oo.APPLY_HILO_STR
             ,oo.PEND_FLAG
             ,oo.OLD_ORDER_ID
             ,oo.SOURCE
             ,oc1.reject_reason_1
             ,oc1.reject_reason_desc_1
             ,oc1.reject_reason_2
             ,oc1.reject_reason_desc_2
             ,oc1.return_reason
             ,oc1.return_reason_desc
             ,oc2.cancel_reason
             ,oc2.cancel_remark
             ,uh.tongdun_score
             ,ooe.credit_node
             ,ist.bd_name
             ,oc2.auto_reject_reason_desc
             --,oo.REVIEW_SOURCE
             ,case 
                when x.is_lt is null then oo.review_source 
                else case when x.is_lt = '是' then 1 else 0 end 
             end as review_source 
             ,oc2.QD_PASS
             ,oos.FACHANNEL_NAME
             ,oos.subchannel_name
        from ODSOPR.ORD_ORDER oo
        
   --left join idw.original_bo_xinyimei x
   left join msc.xinyimei x                                                   --20181213 资产窦欣桐, review_source 以提供的数据为准
          on cast(x.nono_id as bigint) = oo.nonobank_userid
         and cast(x.bo_id as bigint) = oo.bo_id
          
   left join idw.original_bo_xinyimei_shopname sn                             --20181213 资产窦欣桐, shop_name 以提供的数据为准
          on sn.shop_id = oo.shop_id
        
   left join ods.t_sys_dic_item_hist sdi1
          on sdi1.dic_id = 2
         and sdi1.disabled = '0'
         AND sdi1.dic_item_value = oo.status
   
   left join ods.t_sop_shop_hist ss
          on oo.SHOP_ID = ss.id
   
   left join ods.t_sys_dic_item_hist sdi2
          on sdi2.dic_id = 14
         and sdi2.disabled = '0'
         AND sdi2.dic_item_value = ss.company_type
   
   left join odsopr.SOP_SHOP_FACE ssf
          on oo.FACE_ID = ssf.id
   
   left join (
                    select o.order_id,
                           concat_ws(',',
                                    collect_set(case
                                                  when o.status = 15 then
                                                   o.reason
                                                end)) return_reason,
                           concat_ws(',', collect_set(sdi.dic_item_name)) return_reason_desc,
                           concat_ws(',',
                                    collect_set(case
                                                  when rr.level = 1 and o.status = 14 and
                                                       o.operator_type = 'SD_DECLINE' then
                                                   o.reason
                                                end)) reject_reason_1,
                           concat_ws(',',
                                    collect_set(case
                                                  when rr.level = 1 then
                                                   rr.reject_name
                                                end)) reject_reason_desc_1,
                           concat_ws(',',
                                    collect_set(case
                                                  when rr.level = 2 and o.status = 14 and
                                                       o.operator_type = 'SD_DECLINE' then
                                                   o.reason
                                                end)) reject_reason_2,
                           concat_ws(',',
                                    collect_set(case
                                                  when rr.level = 2 then
                                                   rr.reject_name
                                                end)) reject_reason_desc_2
                      from (
                                select t1.order_id,
                                       t1.status,
                                       t1.operator_type,
                                       t2.reason
                                  from (
                                                select order_id, 
                                                       status, 
                                                       operator_type, 
                                                       reason
                                                  from ods.t_ord_order_check_history_hist
                                                 where status in (14, 15)) t1 
                                          lateral view explode(split(t1.reason, ',')) t2 as reason
                                                 where t2.reason <> ''
                                       ) o
                     
                             left join ods.t_sys_reject_reason_hist rr
                                    on o.reason = rr.reject_code
                     
                             left join ods.t_sys_dic_item_hist sdi
                                    on o.reason = sdi.dic_item_value
                                   and sdi.dic_id = 7
                              group by o.order_id
             ) oc1
          on oo.id = oc1.order_id
          
   left join (
                    select order_id,
                           min(case
                                when status = 2 and operator_type = '' then
                                 pass_time
                              end) order_begin_date,
                           max(case
                                when status = 17 and
                                     operator_type in ('SA_PASS', 'RE_ORDER') then
                                 pass_time
                              end) pass_time,
                           max(case
                                when status = 6 and operator_type = 'SHOP_CONFIRM' then
                                 pass_time
                              end) shop_confirm_time,
                           max(case
                                when status = 5 and operator_type = 'USER_CONFIRM' then
                                 pass_time
                              end) user_confirm_time,
                           concat_ws(',',
                                    collect_set(case
                                                  when status = 9 then
                                                   reason
                                                end)) CANCEL_REASON,
                           concat_ws(',',
                                    collect_set(case
                                                  when status = 9 then
                                                   remark
                                                end)) CANCEL_REMARK,
                           max(case
                                when status = 14 and operator_type = '' then
                                 remark
                              end) AUTO_REJECT_REASON_DESC,
                           max(case when operator_type = 'QD_PASS' then 1 end) QD_PASS --担保成功的操作
                      from ods.t_ord_order_check_history_hist
                  group by order_id
             ) oc2
          on oo.id = oc2.order_id
          
   left join (
                   select order_id,
                          get_json_object(data, '$.finalScore') TONGDUN_SCORE,
                          row_number() over(partition by order_id order by honor_date desc) rn
                     from ods.t_ord_user_honor_hist
                    where honor_type = 'TONGDUN'
             ) uh
          on oo.id = uh.order_id
         and uh.rn = 1
         and uh.TONGDUN_SCORE <> ''
   
   left join ods.t_ord_order_extend_hist ooe
          on oo.id = ooe.order_id
         and ooe.disabled = 0
   
   left join (
                   select order_id,
                          bd_name,
                          row_number() over(partition by order_id order by id desc) rn
                     from ods.t_info_statistics_hist
                    where disabled = 0
             ) ist
          on oo.id = ist.order_id
         and ist.rn = 1
   
   left join odsopr.ORD_ORDER_SUBCHANNEL oos
          on oo.id = oos.order_id
         and oos.isdelete = 0
       where oo.DISABLED = 0
   ;
