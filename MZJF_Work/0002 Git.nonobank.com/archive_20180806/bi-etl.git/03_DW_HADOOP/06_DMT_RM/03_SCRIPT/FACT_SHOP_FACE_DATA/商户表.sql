
-- 1.建表
set mapreduce.job.name=DMT_RM_FACT_SHOP_FACE_DATA; 
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

drop table if exists dmt_rm.FACT_SHOP_FACE_DATA;
create table if not exists dmt_rm.FACT_SHOP_FACE_DATA
( SHOP_ID STRING   COMMENT '商户ID',
  FACE_ID STRING   COMMENT '门店ID', 
  FACE_NAME STRING  COMMENT '门店',
  SHOP_NAME STRING  COMMENT '商户名称',
  SHOP_PROVICE STRING COMMENT '商户所在省份',
  REG_PROVICE STRING  COMMENT '商户注册所在省份',
  REG_CITY STRING  COMMENT '商户注册所在城市',
  SHOP_CITY STRING  COMMENT '商户所在城市',
  SHOP_START_DATE STRING   COMMENT '商户成立时间',
  LEGAL_IDCARD STRING   COMMENT '法定代表人身份证号',
  SHOP_ADDRESS STRING   COMMENT '商户经营地址',
  FACE_ADDRESS STRING   COMMENT '门店经营地址',
  SHOP_SCORE STRING   COMMENT '商户评分表得分',
  REPORT_RESULT STRING   COMMENT '商户最近巡检结果',
  SHOP_STATUS STRING   COMMENT '商户状态',
  FACE_STATUS STRING   COMMENT '门店状态',
  DW_CREATE_BY     STRING COMMENT '系统字段-创建者',
   DW_CREATE_TIME   STRING COMMENT '系统字段-创建时间',
   DW_UPDATE_BY     STRING COMMENT '系统字段-修改者',
   DW_UPDATE_TIME   STRING COMMENT '系统字段-修改时间'
) COMMENT '风控商户门店表'
   PARTITIONED BY (STAT_DATE STRING COMMENT '分区键:统计日期')
    STORED AS PARQUET TBLPROPERTIES ("parquet.compression"="SNAPPY");







-- 2.写入数据

set mapreduce.job.name=DMT_RM_FACT_SHOP_FACE_DATA_01_01; 
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



INSERT OVERWRITE TABLE dmt_rm.FACT_SHOP_FACE_DATA  partition (STAT_DATE)
SELECT DISTINCT
ss.id AS SHOP_ID
,nvl(ssf.id,-9999999) as FACE_ID
,nvl(ssf.name,'未知') AS FACE_NAME
,ss.name AS SHOP_NAME
,c.name AS SHOP_PROVICE
,d.name AS REG_PROVICE
,e.name AS REG_CITY
,b.name AS SHOP_CITY
,ss.shop_start_date AS SHOP_START_DATE
,ss.legal_id_card AS LEGAL_IDCARD
,ss.address AS SHOP_ADDRESS
,ssf.address AS FACE_ADDRESS
,ssr.shop_score AS SHOP_SCORE
-- ,sscr.report_result AS REPORT_RESULT
,sdi2.dic_item_name AS REPORT_RESULT
-- ,ss.shop_status as SHOP_STATUS
,sdi.dic_item_name AS SHOP_STATUS
,CASE WHEN ssf.status=0 THEN '无效'
 WHEN ssf.status=1 THEN '有效'
 ELSE '未知' END AS FACE_STATUS
 ,ssfr.deal_amount --门店单笔放款上限(额度) 
 ,'SYS' as DW_CREATE_BY
 ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
 ,'SYS' AS DW_UPDATE_BY
 ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
,FROM_UNIXTIME(UNIX_TIMESTAMP() -1*24*60*60,'yyyyMMdd') AS STAT_DATE 
FROM ods.T_SOP_SHOP_HIST ss 
LEFT JOIN ods.T_SOP_SHOP_RISK_HIST ssr ON ss.id=ssr.shop_id
LEFT JOIN ods.T_SOP_SHOP_FACE_HIST ssf ON ssf.shop_id=ss.id AND ssf.disabled=0
LEFT JOIN ods.T_SOP_SHOP_FACE_RISK_HIST ssfr ON ssfr.face_id=ssf.id  and ssfr.disabled=0
LEFT JOIN ods.T_SYS_DIC_ITEM_HIST sdi ON sdi.dic_id=39 AND sdi.dic_item_value=ss.shop_status
LEFT JOIN  ods.t_region_hist b 
ON substr(ss.county_code,1,4)=substr(b.code,1,4) AND b.level=2
LEFT JOIN   ods.t_region_hist c
ON substr(ss.county_code,1,3)=substr(c.code,1,3)  AND c.level=1
LEFT JOIN   ods.t_region_hist d
ON substr(ss.regist_county_code,1,3)=substr(d.code,1,3)  AND d.level=1
LEFT JOIN   ods.t_region_hist e
ON substr(ss.regist_county_code,1,4)=substr(e.code,1,4)  AND e.level=2
 LEFT JOIN 
 (SELECT sscr2.shop_id AS ID
,MAX(sscr2.create_time) AS max_create_time
 FROM ods.T_SOP_SHOP_CHECK_REPORT_HIST sscr2
 WHERE 1=1
 AND sscr2.disabled=0
 GROUP BY sscr2.shop_id) sscr1 ON ss.id=sscr1.ID
 LEFT JOIN ods.T_SOP_SHOP_CHECK_REPORT_HIST sscr ON sscr1.ID=sscr.shop_id AND sscr.create_time=sscr1.max_create_time
 LEFT JOIN ods.T_SYS_DIC_ITEM_HIST sdi2 ON sdi2.dic_id=22 AND sdi2.dic_item_value=sscr.report_result
;



 -- 3.从HIVE 同步到 MYSQL
 
CREATE TABLE FACT_SHOP_FACE_DATA (
  SHOP_ID BIGINT(20) DEFAULT NULL COMMENT '商户ID',
  FACE_ID BIGINT(20) DEFAULT NULL COMMENT '门店ID',
  FACE_NAME VARCHAR(100) DEFAULT NULL COMMENT '门店',
  SHOP_NAME VARCHAR(100) DEFAULT NULL COMMENT '商户名称',
  SHOP_PROVICE VARCHAR(64) DEFAULT NULL COMMENT '商户所在省份',
  REG_PROVICE VARCHAR(64) DEFAULT NULL COMMENT '商户注册所在省份',
  REG_CITY VARCHAR(64) DEFAULT NULL COMMENT '商户注册所在城市',
  SHOP_CITY VARCHAR(64) DEFAULT NULL COMMENT '商户所在城市',
  SHOP_START_DATE DATETIME DEFAULT NULL COMMENT '商户成立时间',
  LEGAL_IDCARD VARCHAR(64) DEFAULT NULL COMMENT '法定代表人身份证号',
  SHOP_ADDRESS VARCHAR(100) DEFAULT NULL COMMENT '商户经营地址',
  FACE_ADDRESS VARCHAR(100) DEFAULT NULL COMMENT '门店经营地址',
  SHOP_SCORE INT(11) DEFAULT NULL COMMENT '商户评分表得分',
  REPORT_RESULT VARCHAR(100) DEFAULT NULL COMMENT '商户最近巡检结果',
   SHOP_STATUS VARCHAR(64) DEFAULT NULL COMMENT '商户状态',
    FACE_STATUS VARCHAR(64) DEFAULT NULL COMMENT '门店状态',
  DW_CREATE_BY VARCHAR(64) DEFAULT 'SYS' COMMENT '系统字段-创建者',
  DW_CREATE_TIME DATETIME DEFAULT NULL COMMENT '系统字段-创建时间',
  DW_UPDATE_BY VARCHAR(64) DEFAULT 'SYS' COMMENT '系统字段-修改者',
  DW_UPDATE_TIME DATETIME DEFAULT NULL COMMENT '系统字段-修改时间',
  STAT_DATE INT(11) NOT NULL COMMENT '统计日期(20170208)',
  KEY INDEX_FACT_APPROVAL_STAT_DATE (STAT_DATE)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='商户门店数据表'
;