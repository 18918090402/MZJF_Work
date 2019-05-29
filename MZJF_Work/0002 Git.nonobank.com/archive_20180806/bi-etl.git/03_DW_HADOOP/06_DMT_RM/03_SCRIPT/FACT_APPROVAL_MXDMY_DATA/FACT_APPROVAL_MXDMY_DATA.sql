SET mapreduce.job.name=DMT_RM_FACT_APPROVAL_MXDMY_DATA_01; 
SET mapreduce.job.queuename = etl-dw;  

SET hive.exec.parallel=TRUE ;
SET hive.groupby.skewindata = TRUE ;
SET hive.map.aggr = TRUE ; 

SET hive.enforce.bucketing = TRUE;

set hive.exec.parallel=true;
SET hive.exec.dynamic.partition=TRUE;
SET hive.exec.dynamic.partition.mode=nonstrict; 
SET hive.exec.max.dynamic.partitions.pernode=100000000;
SET hive.exec.max.dynamic.partitions=100000000;
SET hive.exec.max.created.files=100000000;

DROP TABLE IF EXISTS TMP.DMT_RM_FACT_APPROVAL_MXDMY_DATA_01;
CREATE TABLE IF NOT EXISTS TMP.DMT_RM_FACT_APPROVAL_MXDMY_DATA_01
( ORDER_NO STRING   COMMENT '订单编号',
  APPLY_NO STRING  COMMENT '申请号',
  AUDIT_NAME STRING  COMMENT '审核人员',
  PRODUCT STRING COMMENT '产品',
  PROCESS_BEGIN_TIME STRING  COMMENT '流转环节-进入时间',
  PROCESS_NAME STRING  COMMENT '流转环节- 名称',
  PROCESS_END_TIME STRING  COMMENT '流转环节-完成时间',
  REASON STRING COMMENT '流转环节-原因',
  STAT_DATE STRING COMMENT '分区键:统计日期'
) COMMENT '风控审批表临时表'
;

INSERT OVERWRITE TABLE TMP.DMT_RM_FACT_APPROVAL_MXDMY_DATA_01
  SELECT a.ORDER_NO,
         a.APPLY_NO,
         MAX(a.AUDIT_NAME) AS AUDIT_NAME,
         MAX(a.PRODUCT) AS PRODUCT,
         a.PROCESS_BEGIN_TIME,
         a.PROCESS_NAME,
         MAX(a.PROCESS_END_TIME) AS PROCESS_END_TIME,
         MAX(REASON) AS REASON,
         a.STAT_DATE
    FROM (SELECT oo.order_no AS ORDER_NO,
                 nvl(oo.bo_id, -1) AS APPLY_NO,
                 su.realname AS AUDIT_NAME,
                 '麦芽分期' AS PRODUCT,
                 ooch.pass_time AS PROCESS_BEGIN_TIME,
                 sdi.dic_item_name AS PROCESS_NAME,
                 NULL AS PROCESS_END_TIME,
                 ooch.remark as REASON,
                 FROM_UNIXTIME(UNIX_TIMESTAMP(ooch.pass_time), 'yyyyMMdd') AS STAT_DATE
            FROM ods.t_ORD_ORDER_CHECK_HISTORY_hist ooch
            JOIN ods.t_ORD_ORDER_hist oo
              ON ooch.order_id = oo.id
             AND oo.disabled = '0'
            LEFT JOIN ods.t_SYS_DIC_ITEM_hist sdi
              ON CAST(ooch.status AS STRING) = sdi.dic_item_value
             AND sdi.dic_id = '2'
            LEFT JOIN ods.t_SYS_USER_hist su
              ON ooch. create_user = su.id
             AND su. disabled = '0'
           WHERE ooch.order_id IS NOT NULL
             AND ooch.status <> '0'
             AND ooch.disabled = '0'
             AND ooch.pass_time >= DATE_SUB('{LAST_DATA_TIME}', 10)
          UNION ALL
          SELECT '-1' AS order_no,
                 bo.id apply_no,
                 a.am_name audit_name,
                 p.p_name product,
                 bo.publish_time process_begin_time,
                 "提交申请" process_name,
                 NULL process_end_time,
                 awr.audit_code as REASON,
                 FROM_UNIXTIME(UNIX_TIMESTAMP(bo.publish_time), 'yyyyMMdd') AS STAT_DATE
            FROM ods.t_borrows_hist bo
            LEFT JOIN ods.t_products_hist p
              ON p.id = bo.p_id
            LEFT JOIN ods.t_admin_work_remark_hist awr
              ON bo.id = awr.bo_id
            LEFT JOIN ods.t_admin_hist a
              ON awr.am_id = a.id
           WHERE 1 = 1
             AND bo.publish_time >= DATE_SUB('{LAST_DATA_TIME}', 10)          
          UNION ALL
          SELECT '-1' AS order_no,
                 ba.bo_id apply_no,
                 a.am_name audit_name,
                 p.p_name product,
                 ba.create_time process_begin_time,
                 "提交视频" process_name,
                 NULL process_end_time,
                 awr.audit_code as REASON,
                 FROM_UNIXTIME(UNIX_TIMESTAMP(ba.create_time), 'yyyyMMdd') AS STAT_DATE
            FROM ods.t_borrows_archive_hist ba
            JOIN ods.t_borrows_hist bo
              ON bo.id = ba.bo_id
            LEFT JOIN ods.t_products_hist p
              ON p.id = bo.p_id
            LEFT JOIN ods.t_admin_work_remark_hist awr
              ON bo.id = awr.bo_id
            LEFT JOIN ods.t_admin_hist a
              ON awr.am_id = a.id
           WHERE 1 = 1
             AND ba.create_time >= DATE_SUB('{LAST_DATA_TIME}', 10)          
          UNION ALL
          SELECT '-1' AS order_no,
                 ba.bo_id apply_no,
                 a.am_name audit_name,
                 p.p_name product,
                 am_audit_time process_begin_time,
                 "初审分配" process_name,
                 NULL process_end_time,
                 awr.audit_code as REASON,
                 FROM_UNIXTIME(UNIX_TIMESTAMP(am_audit_time), 'yyyyMMdd') AS STAT_DATE
            FROM ods.t_borrows_archive_hist ba
            JOIN ods.t_borrows_hist bo
              ON bo.id = ba.bo_id
            LEFT JOIN ods.t_products_hist p
              ON p.id = bo.p_id
            LEFT JOIN ods.t_admin_work_remark_hist awr
              ON bo.id = awr.bo_id
            LEFT JOIN ods.t_admin_hist a
              ON awr.am_id = a.id
           WHERE 1 = 1
             AND ba.create_time >= DATE_SUB('{LAST_DATA_TIME}', 13)
             AND am_audit_time >= DATE_SUB('{LAST_DATA_TIME}', 10)          
          UNION ALL
          SELECT '-1' AS order_no,
                 bo.id apply_no,
                 a.am_name audit_name,
                 p.p_name product,
                 awr.create_time process_begin_time,
                 awr.title process_name,
                 NULL process_end_time,
                 awr.audit_code as REASON,
                 FROM_UNIXTIME(UNIX_TIMESTAMP(awr.create_time), 'yyyyMMdd') AS STAT_DATE
            FROM ods.t_admin_work_remark_hist awr
            JOIN ods.t_borrows_hist bo
              ON bo.id = awr.bo_id
            LEFT JOIN ods.t_products_hist p
              ON p.id = bo.p_id
            LEFT JOIN ods.t_admin_hist a
              ON awr.am_id = a.id
           WHERE 1 = 1
             AND awr.create_time >= DATE_SUB('{LAST_DATA_TIME}', 10)          
          UNION ALL
          SELECT '-1' AS order_no,
                 bo.id apply_no,
                 a.am_name audit_name,
                 p.p_name product,
                 bo.bo_agree_time process_begin_time,
                 "签约完成" process_name,
                 NULL process_end_time,
                 awr.audit_code as REASON,
                 FROM_UNIXTIME(UNIX_TIMESTAMP(bo.bo_agree_time), 'yyyyMMdd') AS STAT_DATE
            FROM ods.t_borrows_hist bo
            LEFT JOIN ods.t_products_hist p
              ON p.id = bo.p_id
            LEFT JOIN ods.t_admin_work_remark_hist awr
              ON bo.id = awr.bo_id
            LEFT JOIN ods.t_admin_hist a
              ON awr.am_id = a.id
           WHERE 1 = 1
             AND bo.bo_agree_time >= DATE_SUB('{LAST_DATA_TIME}', 10)          
          UNION ALL
          SELECT '-1' AS order_no,
                 bo.id apply_no,
                 a.am_name audit_name,
                 p.p_name product,
                 bo.bo_finish_time process_begin_time,
                 CASE
                   WHEN bo.bo_is_success = 2 THEN
                    "拒绝"
                   WHEN bo.bo_is_success = 3 THEN
                    "超时流标"
                 END process_name,
                 NULL process_end_time,
                 awr.audit_code as REASON,
                 FROM_UNIXTIME(UNIX_TIMESTAMP(bo.bo_finish_time), 'yyyyMMdd') AS STAT_DATE
            FROM ods.t_borrows_hist bo
            LEFT JOIN ods.t_products_hist p
              ON p.id = bo.p_id
            LEFT JOIN ods.t_admin_work_remark_hist awr
              ON bo.id = awr.bo_id
            LEFT JOIN ods.t_admin_hist a
              ON awr.am_id = a.id
           WHERE 1 = 1
             AND bo.bo_is_success IN (2, 3)
             AND bo.bo_finish_time >= DATE_SUB('{LAST_DATA_TIME}', 10)          
          UNION ALL
          SELECT '-1' AS order_no,
                 bo. id as apply_no,
                 null audit_name,
                 p.p_name product,
                 bp.bp_publish_time process_begin_time,
                 "预发标时间" process_name,
                 NULL process_end_time,
                 NULL as REASON,
                 FROM_UNIXTIME(UNIX_TIMESTAMP(bp.bp_publish_time),
                               'yyyyMMdd') AS STAT_DATE
            FROM ods.t_borrows_hist bo
            LEFT JOIN ods.t_borrows_prepare_hist AS bp
              ON bo. bp_id = bp.id
            LEFT JOIN ods.t_products_hist p
              ON p.id = bo.p_id
           WHERE bp.bp_publish_time >= DATE_SUB('{LAST_DATA_TIME}', 10)) a
   WHERE a.STAT_DATE IS NOT NULL
     AND a.PROCESS_BEGIN_TIME IS NOT NULL
   GROUP BY a.ORDER_NO,
            a.APPLY_NO,
            a.PROCESS_BEGIN_TIME,
            a.PROCESS_NAME,
            a.STAT_DATE;

set mapreduce.job.name=DMT_RM_FACT_APPROVAL_MXDMY_DATA_02; 
set mapreduce.job.queuename = etl-dw;  

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 

set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict; 
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

INSERT OVERWRITE TABLE DMT_RM.FACT_APPROVAL_MXDMY_DATA PARTITION
  (STAT_DATE)
  SELECT concat(b.ORDER_NO, '_', b.APPLY_NO) as id,
         b.ORDER_NO,
         b.APPLY_NO,
         b.AUDIT_NAME,
         case
           when bo.p_id = 87 and bo.bp_channel = 5 then
            '社保贷'
           when bo.p_id = 87 and bo.bp_channel = 6 then
            '应届贷'
           when bo.p_id = 87 and bo.bp_channel = 7 then
            '按揭贷'
           when bo.p_id = 110 and bo.credit_type = 2 then
            '高学历贷'
           when bo.p_id = 110 and bo.credit_type = 3 then
            '消费能力贷'
           else
            b.PRODUCT
         end PRODUCT,
         b.PROCESS_BEGIN_TIME,
         nvl(b.PROCESS_NAME, '') PROCESS_NAME,
         b.PROCESS_END_TIME,
         'SYS' AS DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         REASON,
         b.STAT_DATE
    from TMP.DMT_RM_FACT_APPROVAL_MXDMY_DATA_01 b
    left join IDW.FACT_BORROWS bo
      ON bo.BO_ID = b.APPLY_NO;