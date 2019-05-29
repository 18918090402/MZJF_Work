drop table if exists DMT_BF.NONO_BAK_PROLOCUTOR_EARNINGS_DETAIL;
create table if not exists DMT_BF.NONO_BAK_PROLOCUTOR_EARNINGS_DETAIL
( 
   NONO_PROLOCUTOR_ID  bigint   COMMENT '磅客大使ID', 
   NONO_PROLOCUTOR_NAME string comment '磅客大使名称',
   INVITED_USER_ID  bigint   COMMENT '被邀请用户ID', 
   INVITED_USER_NAME    string comment '被邀请用户名称', 
   VERSION          STRING   COMMENT '版本',
   PAYED          decimal(38,10)   COMMENT '累积已支付收益',
   DW_CREATE_BY     STRING COMMENT '系统字段-创建者',
   DW_CREATE_TIME   STRING COMMENT '系统字段-创建时间',
   DW_UPDATE_BY     STRING COMMENT '系统字段-修改者',
   DW_UPDATE_TIME   STRING COMMENT '系统字段-修改时间'
)COMMENT '镑客大使被推荐人累积收益明细固化表'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");