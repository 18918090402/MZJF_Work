set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_01; 
set mapreduce.job.queuename = etl-dw;

drop table if exists tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01;
create table if not exists tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01
( 
  NONO_PROLOCUTOR_ID  bigint   COMMENT '磅客大使ID', 
  NONO_PROLOCUTOR_NAME STRING   COMMENT '磅客大使名称', 
  NONO_PROLOCUTOR_REAL_NAME STRING   COMMENT '磅客大使真实姓名',
  NONO_PROLOCUTOR_CREATE_TIME STRING   COMMENT '成为镑客大使时间', 
  NONO_PROLOCUTOR_REGISTER_TIME STRING   COMMENT '镑客大使注册时间', 
  NONO_PROLOCUTOR_LAST_PAY_TIME STRING  COMMENT '最近收益支付时间',
  INVITED_USER_ID  bigint   COMMENT '被邀请用户ID', 
  INVITED_USER_NAME STRING   COMMENT '被邀请用户名称', 
  INVITED_REGISTER_TIME STRING   COMMENT '被邀请用户注册时间', 
  INVITED_REGISTER_TIME_1YEAR STRING   COMMENT '被推荐人注册时间_1年', 
  TYPE STRING   COMMENT '类型 1:镑客大使 3:被推荐人',
  DW_CREATE_BY     STRING COMMENT '系统字段-创建者',
  DW_CREATE_TIME   STRING COMMENT '系统字段-创建时间',
  DW_UPDATE_BY     STRING COMMENT '系统字段-修改者',
  DW_UPDATE_TIME   STRING COMMENT '系统字段-修改时间'
) COMMENT '镑客大使信息临时表'
    STORED AS PARQUET TBLPROPERTIES ("parquet.compression"="SNAPPY");

drop table if exists tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_02;
create table if not exists tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_02
(
   INVITED_USER_ID      bigint comment '被邀请用户ID',
   INVITED_USER_NAME    string comment '被邀请用户名称',
   NONO_PROLOCUTOR_ID   bigint comment '磅客大使ID',
   NONO_PROLOCUTOR_NAME  string comment '磅客大使用户名称',
   YESTERDAY_EARNINGS   decimal(38,10) comment '昨日收益',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '镑客大使昨日收益详情临时表'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");

DROP TABLE IF EXISTS DMT_BF.NONO_PROLOCUTOR_EARNINGS_DETAIL;
CREATE TABLE IF NOT EXISTS DMT_BF.NONO_PROLOCUTOR_EARNINGS_DETAIL
(
   INVITED_USER_ID      bigint comment '被邀请用户ID',
   INVITED_USER_NAME    string comment '被邀请用户名称',
   NONO_PROLOCUTOR_ID   bigint comment '磅客大使ID',
   NONO_PROLOCUTOR_NAME string comment '磅客大使名称',
   CURDATE_EARNINGS     decimal(38,10) comment '当日收益',
   ACCUMULATED_EARNINGS decimal(38,10) comment '累计收益',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '镑客大使收益详情'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");

DROP TABLE IF EXISTS DMT_BF.NONO_PROLOCUTOR_EARNINGS;
CREATE TABLE IF NOT EXISTS DMT_BF.NONO_PROLOCUTOR_EARNINGS
(
   NONO_PROLOCUTOR_ID   bigint comment '磅客大使ID',
   NONO_PROLOCUTOR_NAME string comment '磅客大使名称',
   NONO_PROLOCUTOR_REAL_NAME string comment '磅客大使真实姓名',
   CURDATE_EARNINGS     decimal(38,10) comment '当日收益',
   ACCUMULATED_EARNINGS decimal(38,10) comment '累计收益',
   OTHER_EARNINGS       decimal(38,10) comment '其他收益',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '镑客大使收益'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_02; 
set mapreduce.job.queuename = etl-dw;

INSERT into tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01
  SELECT ui.recommender AS NONO_PROLOCUTOR_ID,
         ui2.user_name AS NONO_PROLOCUTOR_NAME,
         ui2.real_name AS NONO_PROLOCUTOR_REAL_NAME,
         ap.create_time AS NONO_PROLOCUTOR_CREATE_TIME,
         ui2.register_time AS NONO_PROLOCUTOR_REGISTER_TIME,
         ap.last_pay_time AS NONO_PROLOCUTOR_LAST_PAY_TIME,
         ui.id AS INVITED_USER_ID,
         ui.user_name AS INVITED_USER_NAME,
         ui.register_time AS INVITED_REGISTER_TIME,
         ADD_MONTHS(ui.register_time, 12) as INVITED_REGISTER_TIME_1YEAR,
         1 TYPE,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM (SELECT ap.user_id,
                 MAX(ap.last_pay_time) AS last_pay_time,
                 MAX(ap.create_time) AS create_time
            FROM ods.t_activity_prolocutor_hist ap
           where ap.type = 1
             and ap.user_id > 0
           GROUP BY ap.user_id) ap
    JOIN ods.t_user_info_hist ui
      ON ap.user_id = ui.recommender
    LEFT JOIN ods.t_user_approach_info_hist uai
      ON uai.user_id = ui.id
    JOIN ods.t_user_info_hist ui2
      ON ui2.id = ap.user_id
   WHERE ui.register_time >= ap.create_time
     AND (uai.landing_page <> '房东特使' OR uai.landing_page IS NULL);
     
INSERT into tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01
  SELECT ui.id AS NONO_PROLOCUTOR_ID,
         ui.user_name AS NONO_PROLOCUTOR_NAME,
         ui.real_name AS NONO_PROLOCUTOR_REAL_NAME,
         ap.create_time AS NONO_PROLOCUTOR_CREATE_TIME,
         ui.register_time AS NONO_PROLOCUTOR_REGISTER_TIME,
         ap.last_pay_time AS NONO_PROLOCUTOR_LAST_PAY_TIME,
         ui.id AS INVITED_USER_ID,
         ui.user_name AS INVITED_USER_NAME,
         ui.register_time AS INVITED_REGISTER_TIME,
         ADD_MONTHS(ui.register_time, 12) as INVITED_REGISTER_TIME_1YEAR,
         3 TYPE,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM (SELECT ap.user_id,
                 MAX(ap.last_pay_time) AS last_pay_time,
                 MAX(ap.create_time) AS create_time
            FROM ods.t_activity_prolocutor_hist ap
           where ap.type = 3
             and ap.user_id > 0
           GROUP BY ap.user_id) ap
    JOIN ods.t_user_info_hist ui
      ON ap.user_id = ui.id
    LEFT JOIN tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 tmp1
      ON ap.user_id = tmp1.NONO_PROLOCUTOR_ID
   WHERE ap.create_time < '2016-03-16'
     and tmp1.NONO_PROLOCUTOR_ID is null;

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_03; 
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE DMT_BF.NONO_BAK_PROLOCUTOR_EARNINGS_DETAIL partition
  (STAT_DATE)
  SELECT da.NONO_PROLOCUTOR_ID,
         da.NONO_PROLOCUTOR_NAME,
         da.INVITED_USER_ID,
         da.INVITED_USER_NAME,
         '4.0之前' VERSION,
         CAST(SUM(CASE
                    WHEN expect_unit = 0 THEN
                     (vf.amount_payed * fp.expect / 12 * 0.005)
                    WHEN expect_unit = 1 THEN
                     (vf.amount_payed * fp.expect / 365 * 0.005)
                  END) AS decimal(38, 10)) AS PAYED,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 2 * 24 * 60 * 60, 'yyyy-MM-dd') AS STAT_DATE
    FROM tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 da
    JOIN ods.t_vip_form_hist vf
      ON vf.user_id = da.INVITED_USER_ID
    JOIN ods.t_finance_plan_hist fp
      ON fp.id = vf.fp_id
     AND fp.scope <> 15
   WHERE 1 = 1
     and da.type = 1
     AND vf.service_time < '2016-03-16' -- 4.0固化时间
     AND vf.service_time <= da.INVITED_REGISTER_TIME_1YEAR
     AND vf.service_time < da.NONO_PROLOCUTOR_LAST_PAY_TIME
   GROUP BY da.NONO_PROLOCUTOR_ID,
            da.NONO_PROLOCUTOR_NAME,
            da.INVITED_USER_ID,
            da.INVITED_USER_NAME
  UNION ALL
  SELECT da.NONO_PROLOCUTOR_ID,
         da.NONO_PROLOCUTOR_NAME,
         da.INVITED_USER_ID,
         da.INVITED_USER_NAME,
         '4.0' VERSION,
         CAST(SUM(CASE
                    WHEN expect_unit = 0 THEN
                     (vf.amount_payed * fp.expect / 12 * 0.01)
                    WHEN expect_unit = 1 THEN
                     (vf.amount_payed * fp.expect / 365 * 0.01)
                  END) AS decimal(38, 10)) AS PAYED,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 2 * 24 * 60 * 60, 'yyyy-MM-dd') AS STAT_DATE
    FROM tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 da
    JOIN ods.t_vip_form_hist vf
      ON vf.user_id = da.INVITED_USER_ID
    JOIN ods.t_finance_plan_hist fp
      ON fp.id = vf.fp_id
     AND fp.scope <> 15
   WHERE 1 = 1
     and da.type = 1
     AND vf.service_time >= '2016-03-16'
     AND vf.service_time < '2016-11-15' -- 5.0固化时间
     AND vf.service_time <= da.INVITED_REGISTER_TIME_1YEAR
     AND vf.service_time < da.NONO_PROLOCUTOR_LAST_PAY_TIME
   GROUP BY da.NONO_PROLOCUTOR_ID,
            da.NONO_PROLOCUTOR_NAME,
            da.INVITED_USER_ID,
            da.INVITED_USER_NAME
  UNION ALL
  SELECT da.NONO_PROLOCUTOR_ID,
         da.NONO_PROLOCUTOR_NAME,
         da.INVITED_USER_ID,
         da.INVITED_USER_NAME,
         '5.0' VERSION,
         CAST(SUM(pay) AS decimal(38, 10)) AS PAYED,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 2 * 24 * 60 * 60, 'yyyy-MM-dd') AS STAT_DATE
    FROM ods.t_activity_prolocutor_friends_hist apf
    JOIN tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 da
      ON apf.user_id = da.INVITED_USER_ID
     and da.type = 1
   GROUP BY da.NONO_PROLOCUTOR_ID,
            da.NONO_PROLOCUTOR_NAME,
            da.INVITED_USER_ID,
            da.INVITED_USER_NAME;


set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_04; 
set mapreduce.job.queuename = etl-dw;

INSERT OVERWRITE TABLE DMT_BF.NONO_PROLOCUTOR_EARNINGS_TYPE3
  SELECT da.NONO_PROLOCUTOR_ID,
         da.NONO_PROLOCUTOR_NAME,
         CAST(SUM(CASE
                    WHEN expect_unit = 0 THEN
                     (vf.amount_payed * fp.expect / 12 * 0.005)
                    WHEN expect_unit = 1 THEN
                     (vf.amount_payed * fp.expect / 365 * 0.005)
                  END) AS decimal(38, 10)) AS payed,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM (SELECT ap.create_time   AS NONO_PROLOCUTOR_CREATE_TIME,
                 ap.last_pay_time AS NONO_PROLOCUTOR_LAST_PAY_TIME,
                 ui.id            AS NONO_PROLOCUTOR_ID,
                 ui.user_name     AS NONO_PROLOCUTOR_NAME,
                 ui.register_time AS NONO_PROLOCUTOR_REGISTER_TIME
            FROM (SELECT ap.user_id,
                         MAX(ap.last_pay_time) AS last_pay_time,
                         MAX(ap.create_time) AS create_time
                    FROM ods.t_activity_prolocutor_hist ap
                   where ap.type = 3
                     and ap.user_id > 0
                   GROUP BY ap.user_id) ap
            JOIN ods.t_user_info_hist ui
              ON ap.user_id = ui.id
           WHERE ap.create_time < '2016-03-16') da
    LEFT JOIN ods.t_user_approach_info_hist uai
      ON uai.user_id = da.NONO_PROLOCUTOR_ID
    JOIN ods.t_vip_form_hist vf
      ON vf.user_id = da.NONO_PROLOCUTOR_ID
    JOIN ods.t_finance_plan_hist fp
      ON fp.id = vf.fp_id
   WHERE 1 = 1
     AND vf.service_time < DATE_ADD('2016-03-16', 29)
     AND vf.service_time <= DATE_ADD(da.NONO_PROLOCUTOR_REGISTER_TIME, 30)
     AND vf.service_time < da.NONO_PROLOCUTOR_LAST_PAY_TIME
     AND fp.scope <> 15
     AND (uai.landing_page <> '房东特使' OR uai.landing_page IS NULL)
   GROUP BY da.NONO_PROLOCUTOR_ID, da.NONO_PROLOCUTOR_NAME;

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_05; 
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE DMT_BF.NONO_BAK_PROLOCUTOR_EARNINGS partition
  (STAT_DATE)
  select b.NONO_PROLOCUTOR_ID,
         b.NONO_PROLOCUTOR_NAME,
         nvl(c.ACCUMULATED_EARNINGS, 0) as ACCUMULATED_EARNINGS,
         nvl(d.PAYED, 0) AS OTHER_EARNINGS,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 2 * 24 * 60 * 60, 'yyyy-MM-dd') AS STAT_DATE
    from (select a.NONO_PROLOCUTOR_ID, a.NONO_PROLOCUTOR_NAME
            from tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 a
           group by a.NONO_PROLOCUTOR_ID, a.NONO_PROLOCUTOR_NAME) b
    left JOIN (select nist.NONO_PROLOCUTOR_ID,
                      nist.NONO_PROLOCUTOR_NAME,
                      sum(PAYED) as ACCUMULATED_EARNINGS
                 from DMT_BF.NONO_BAK_PROLOCUTOR_EARNINGS_DETAIL nist
                where nist.stat_date =
                      FROM_UNIXTIME(UNIX_TIMESTAMP() - 2 * 24 * 60 * 60,
                                    'yyyy-MM-dd')
                group by nist.NONO_PROLOCUTOR_ID, nist.NONO_PROLOCUTOR_NAME) c
      on b.NONO_PROLOCUTOR_ID = c.NONO_PROLOCUTOR_ID
    left join dmt_bf.NONO_PROLOCUTOR_EARNINGS_TYPE3 d
      on b.NONO_PROLOCUTOR_ID = d.NONO_PROLOCUTOR_ID;

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_06; 
set mapreduce.job.queuename = etl-dw;
 
INSERT INTO tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_02
  select INVITED_USER_ID,
         INVITED_USER_NAME,
         NONO_PROLOCUTOR_ID,
         NONO_PROLOCUTOR_NAME,
         sum(AMOUNT) * 0.01 / 365 YESTERDAY_EARNINGS,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    from (SELECT amount.va_id as VA_BO_ID,
                 amount.user_id AS INVITED_USER_ID,
                 amount.INVITED_USER_NAME,
                 amount.NONO_PROLOCUTOR_ID,
                 amount.NONO_PROLOCUTOR_NAME,
                 CAST(CASE
                        WHEN NVL(ds.YZC, 0) > amount.amount THEN
                         0
                        ELSE
                         (amount.amount - NVL(ds.YZC, 0))
                      END AS decimal(38, 10)) AS AMOUNT
            FROM (SELECT va.fp_id,
                         va.create_time,
                         va.user_id,
                         va.amount,
                         va.id AS va_id,
                         fp.title,
                         sbtt.INVITED_USER_NAME,
                         sbtt.NONO_PROLOCUTOR_ID,
                         sbtt.NONO_PROLOCUTOR_NAME
                    FROM ods.t_vip_account_hist va
                    JOIN tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 sbtt
                      ON sbtt.INVITED_USER_ID = va.user_id
                     and sbtt.type = 1
                    JOIN ods.t_finance_plan_hist fp
                      ON fp.id = va.fp_id
                   WHERE va.is_cash = 0
                     AND va.fp_id IS NOT NULL
                     AND va.create_time >= '2016-11-15'
                     AND va.create_time < sbtt.INVITED_REGISTER_TIME_1YEAR
                     AND va.create_time < CURRENT_DATE()
                     AND fp.scope <> 15) amount
            LEFT JOIN (SELECT ds.user_id,
                             ds.va_id,
                             SUM((ds.transfer_num - ds.residue_num) * price) YZC,
                             COUNT(1) COUNT
                        FROM ods.t_debt_sale_hist ds
                        JOIN tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 sbtt
                          ON sbtt.INVITED_USER_ID = ds.user_id
                         and sbtt.type = 1
                       WHERE 1 = 1
                         AND ds.op_type = 1
                       GROUP BY ds.va_id, ds.user_id) ds
              ON ds.user_id = amount.user_id
             AND ds.va_id = amount.va_id
          UNION ALL
          SELECT va.id as VA_BO_ID,
                 va.user_id AS INVITED_USER_ID,
                 sbtt.INVITED_USER_NAME,
                 sbtt.NONO_PROLOCUTOR_ID,
                 sbtt.NONO_PROLOCUTOR_NAME,
                 CAST(va.amount AS decimal(38, 10)) AS AMOUNT
            FROM ods.t_vip_account_hist va
            LEFT JOIN ods.t_finance_plan_hist fp
              ON fp.id = va.fp_id
            JOIN tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 sbtt
              ON sbtt.INVITED_USER_ID = va.user_id
             and sbtt.type = 1 -- 找出所有被邀请人信息
           WHERE fp.scope = 15
             AND va.is_cash = 0
             AND va.create_time < sbtt.INVITED_REGISTER_TIME_1YEAR
             AND va.create_time < CURRENT_DATE()
          UNION ALL
          SELECT dbl0.bo_id AS VA_BO_ID,
                 dbl0.user_id AS INVITED_USER_ID,
                 dbl0.INVITED_USER_NAME,
                 dbl0.NONO_PROLOCUTOR_ID,
                 dbl0.NONO_PROLOCUTOR_NAME,
                 CAST(CASE
                        WHEN dbl2.sum_buy_num > dbl0.sum_num THEN
                         dbl0.sum_num / dbl2.sum_buy_num * ba.price
                        ELSE
                         ba.price
                      END AS decimal(38, 10)) AS AMOUNT
            FROM (SELECT dbl.user_id,
                         dbl.bo_id,
                         sbtt.INVITED_USER_NAME,
                         sbtt.NONO_PROLOCUTOR_ID,
                         sbtt.NONO_PROLOCUTOR_NAME,
                         COUNT(bo_id) AS cnt,
                         MIN(dbl.pay_time) AS min_pay_time,
                         SUM(buy_num) AS sum_num
                    FROM ods.t_debt_buy_log_hist dbl
                    JOIN ods.t_user_info_hist ui
                      ON ui.id = dbl.user_id
                    JOIN tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 sbtt
                      ON sbtt.INVITED_USER_ID = ui.id
                     and sbtt.type = 1
                   WHERE dbl.va_id = 0
                     AND dbl.p_type > 0
                     AND dbl.status = 1
                     AND dbl.pay_time < sbtt.INVITED_REGISTER_TIME_1YEAR
                     AND dbl.pay_time >= "2016-11-15"
                     AND dbl.pay_time < CURRENT_DATE()
                   GROUP BY dbl.user_id,
                            dbl.bo_id,
                            sbtt.INVITED_USER_NAME,
                            sbtt.NONO_PROLOCUTOR_ID,
                            sbtt.NONO_PROLOCUTOR_NAME
                  HAVING cnt > 0) dbl0
            LEFT JOIN (SELECT ba2.bo_id,
                             ba2.user_id,
                             SUM(ba2.price_principal) AS price
                        FROM ods.t_borrows_accept_hist ba2
                       WHERE ba2.is_pay = 0
                         AND ba2.va_id = 0
                       GROUP BY ba2.bo_id, ba2.user_id) ba
              ON dbl0.user_id = ba.user_id
             AND dbl0.bo_id = ba.bo_id
            LEFT JOIN (SELECT dbl.user_id,
                             dbl.bo_id,
                             SUM(buy_num) AS sum_buy_num
                        FROM ods.t_debt_buy_log_hist dbl
                        JOIN ods.t_user_info_hist ui
                          ON ui.id = dbl.user_id
                        JOIN tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 sbtt
                          ON sbtt.INVITED_USER_ID = ui.id
                         and sbtt.type = 1
                       WHERE dbl.va_id = 0
                         AND dbl.p_type > 0
                         AND dbl.status = 1
                       GROUP BY dbl.user_id, dbl.bo_id) dbl2
              ON dbl0.user_id = dbl2.user_id
             AND dbl0.bo_id = dbl2.bo_id) s
   group by INVITED_USER_ID,
            INVITED_USER_NAME,
            NONO_PROLOCUTOR_ID,
            NONO_PROLOCUTOR_NAME;

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_07; 
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE DMT_BF.NONO_PROLOCUTOR_EARNINGS_DETAIL partition
  (STAT_DATE)
  select t.invited_user_id,
         t.invited_user_name,
         t.nono_prolocutor_id,
         t.NONO_PROLOCUTOR_NAME,
         nvl(n.yesterday_earnings, 0) as CURDATE_EARNINGS,
         nvl(m.payed, 0) + nvl(n.yesterday_earnings, 0) as ACCUMULATED_EARNINGS,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') AS STAT_DATE
    from tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 t
    left join (select a.invited_user_id,
                      a.invited_user_name,
                      a.nono_prolocutor_id,
                      cast(sum(payed) as decimal(38, 10)) as payed
                 from DMT_BF.NONO_BAK_PROLOCUTOR_EARNINGS_DETAIL a
                where a.stat_date =
                      FROM_UNIXTIME(UNIX_TIMESTAMP() - 2 * 24 * 60 * 60,
                                    'yyyy-MM-dd')
                group by a.invited_user_id,
                         a.invited_user_name,
                         a.nono_prolocutor_id) m
      on t.invited_user_id = m.invited_user_id
     and t.nono_prolocutor_id = m.nono_prolocutor_id
    left join tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_02 n
      on t.invited_user_id = n.invited_user_id
     and t.nono_prolocutor_id = n.nono_prolocutor_id
   where t.type = 1;

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_08; 
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE DMT_BF.NONO_PROLOCUTOR_EARNINGS partition
  (STAT_DATE)
  select t.nono_prolocutor_id,
         t.nono_prolocutor_name,
         t.nono_prolocutor_real_name,
         nvl(a.CURDATE_EARNINGS, 0) as CURDATE_EARNINGS,
         nvl(a.ACCUMULATED_EARNINGS, 0) as ACCUMULATED_EARNINGS,
         nvl(d.PAYED, 0) AS OTHER_EARNINGS,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') AS STAT_DATE
    from (select nono_prolocutor_id,
                 nono_prolocutor_name,
                 nono_prolocutor_real_name
            from tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01
           group by nono_prolocutor_id,
                    nono_prolocutor_name,
                    nono_prolocutor_real_name) t
    left join (select m.nono_prolocutor_id,
                      m.nono_prolocutor_name,
                      sum(m.CURDATE_EARNINGS) as CURDATE_EARNINGS,
                      sum(m.ACCUMULATED_EARNINGS) as ACCUMULATED_EARNINGS
                 from DMT_BF.NONO_PROLOCUTOR_EARNINGS_DETAIL m
                where m.stat_date =
                      FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60,
                                    'yyyy-MM-dd')
                group by m.nono_prolocutor_id, m.nono_prolocutor_name) a
      on t.nono_prolocutor_id = a.nono_prolocutor_id
    left join dmt_bf.NONO_PROLOCUTOR_EARNINGS_TYPE3 d
      on t.NONO_PROLOCUTOR_ID = d.NONO_PROLOCUTOR_ID;

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_09; 
set mapreduce.job.queuename = etl-dw;

INSERT OVERWRITE TABLE DMT_BF.NONO_INVIT_OVER50_PROLOCUTOR
  select nono_prolocutor_id,
         nono_prolocutor_name,
         nono_prolocutor_real_name,
         count(1) INVIT_CNT,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    from tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01
   where type = '1'
   group by nono_prolocutor_id,
            nono_prolocutor_name,
            nono_prolocutor_real_name
  HAVING count(1) > 50;

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_10; 
set mapreduce.job.queuename = etl-dw;

drop table if exists tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01;
drop table if exists tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_02;