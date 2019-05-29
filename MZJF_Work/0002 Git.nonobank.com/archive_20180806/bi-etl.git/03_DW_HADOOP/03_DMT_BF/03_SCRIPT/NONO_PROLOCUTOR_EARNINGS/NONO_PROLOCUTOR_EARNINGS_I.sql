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
  ACCOUNT_STATUS  int COMMENT '帐户状态：1：己开通电子帐户；0：未开通电子帐户',
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
         if(accp.id is null,0,1) as ACCOUNT_STATUS,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
    FROM (
          select ui.id user_id
          ,ap.last_pay_time
          ,ui.register_time create_time
          ,uir.user_id user_id2  -- 被邀请人
          from ods.t_user_invite_relation_info_hist uir
          join ods.t_user_info_hist ui on ui.id=uir.inviter_id -- 邀请人
          join ods.t_user_info_hist ui2 on ui2.id=uir.user_id -- 被邀请人
          left join (SELECT ap.user_id,
                 MAX(ap.last_pay_time) AS last_pay_time,
                 MAX(ap.create_time) AS create_time
            FROM ods.t_activity_prolocutor_hist ap
           where ap.type = 1
             and ap.user_id > 0
           GROUP BY ap.user_id)ap on ui.id=ap.user_id
          where (uir.biz_code ='nono' or ui2.register_time<'2018-01-24')
           ) ap
    JOIN ods.t_user_info_hist ui ON ui.id=ap.user_id2 -- 被邀请人信息
    LEFT JOIN ods.t_user_approach_info_hist uai ON uai.user_id = ui.id
    JOIN ods.t_user_info_hist ui2 ON ui2.id = ap.user_id -- 邀请人信息
    LEFT JOIN ods.t_acc_p2p_hist accp ON ap.user_id = accp.owner_id AND accp.account_type='user'
   WHERE ui.register_time >= ui2.register_time  -- new
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
         if(accp.id is null,0,1) as ACCOUNT_STATUS,
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
    LEFT JOIN ods.t_acc_p2p_hist accp
      ON ap.user_id = accp.owner_id
     AND accp.account_type='user'
   WHERE ap.create_time < '2016-03-16'
     and tmp1.NONO_PROLOCUTOR_ID is null;

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_03; 
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

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_04; 
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;

INSERT OVERWRITE TABLE DMT_BF.NONO_PROLOCUTOR_EARNINGS_DETAIL partition
  (STAT_DATE)
  select t.invited_user_id,
         t.invited_user_name,
         t.nono_prolocutor_id,
         t.NONO_PROLOCUTOR_NAME,
         nvl(n.yesterday_earnings, 0) as CURDATE_EARNINGS,
         nvl(b.ACCUMULATED_EARNINGS, 0) + nvl(n.yesterday_earnings, 0) as ACCUMULATED_EARNINGS,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') AS STAT_DATE
    from tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01 t
    left join DMT_BF.NONO_PROLOCUTOR_EARNINGS_DETAIL b
      on t.invited_user_id = b.invited_user_id
     and t.nono_prolocutor_id = b.nono_prolocutor_id
     and b.stat_date =
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 2 * 24 * 60 * 60, 'yyyy-MM-dd')
    left join tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_02 n
      on t.invited_user_id = n.invited_user_id
     and t.nono_prolocutor_id = n.nono_prolocutor_id
   where t.type = 1;

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_05; 
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
         t.ACCOUNT_STATUS,
         'SYS' as DW_CREATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
         'SYS' AS DW_UPDATE_BY,
         FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
         FROM_UNIXTIME(UNIX_TIMESTAMP() - 1 * 24 * 60 * 60, 'yyyy-MM-dd') AS STAT_DATE
    from (select nono_prolocutor_id,
                 nono_prolocutor_name,
                 nono_prolocutor_real_name,
                 ACCOUNT_STATUS
            from tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01
           group by nono_prolocutor_id,
                    nono_prolocutor_name,
                    nono_prolocutor_real_name,
                    ACCOUNT_STATUS) t
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

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_06; 
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

set mapreduce.job.name=DMT_BF_NONO_PROLOCUTOR_EARNINGS_07; 
set mapreduce.job.queuename = etl-dw;

drop table if exists tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_01;
drop table if exists tmp.TMP_DMT_BF_NONO_PROLOCUTOR_EARNINGS_02;