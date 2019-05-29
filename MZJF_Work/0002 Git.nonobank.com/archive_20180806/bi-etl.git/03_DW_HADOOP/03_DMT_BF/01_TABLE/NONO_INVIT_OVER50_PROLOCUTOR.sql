DROP TABLE IF EXISTS DMT_BF.NONO_INVIT_OVER50_PROLOCUTOR;
CREATE TABLE IF NOT EXISTS DMT_BF.NONO_INVIT_OVER50_PROLOCUTOR
(
   NONO_PROLOCUTOR_ID   bigint comment '磅客大使ID',
   NONO_PROLOCUTOR_NAME string comment '磅客大使名称',
   NONO_PROLOCUTOR_REAL_NAME string comment '磅客大使真实姓名',
   INVIT_CNT            int comment '邀请数量',
   DW_CREATE_BY         string comment '系统字段-创建者',
   DW_CREATE_TIME       string comment '系统字段-创建时间',
   DW_UPDATE_BY         string comment '系统字段-修改者',
   DW_UPDATE_TIME       string comment '系统字段-修改时间')
COMMENT '邀请超50镑客大使详单'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");
