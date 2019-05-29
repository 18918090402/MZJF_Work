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
