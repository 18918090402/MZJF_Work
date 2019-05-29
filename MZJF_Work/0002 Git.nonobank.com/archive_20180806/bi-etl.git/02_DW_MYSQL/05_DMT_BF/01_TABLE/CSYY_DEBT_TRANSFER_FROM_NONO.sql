CREATE TABLE  CSYY_DEBT_TRANSFER_FROM_NONO
(   
    STAT_DATE           VARCHAR(20)       COMMENT '数据所属日期',
    BO_ID               BIGINT            COMMENT '标的号',
    BA_PRICE            DECIMAL(18,6)     COMMENT '金额',
    DEBTER_NAME         VARCHAR(60)       COMMENT '借款人姓名',
    SEX                 VARCHAR(30)       COMMENT '性别',
    SCHOOL              VARCHAR(300)      COMMENT '学校',
    ADDRESS             VARCHAR(300)      COMMENT '地址',
    CERTIFICATE_NUMBER  VARCHAR(60)       COMMENT '身份证',
    DEBT_DETAIL_DESC    VARCHAR(999)      COMMENT '借款目的',
    MOBILE_NUM          VARCHAR(60)       COMMENT '手机号',
    TYPE                INT               COMMENT '类型：0 新增，1 历史变更 ，2 删除',
   DW_CREATE_BY         VARCHAR(64)       COMMENT '系统字段-创建者',
   DW_CREATE_TIME       DATETIME          COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         VARCHAR(64)       COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       DATETIME          COMMENT '系统字段-修改时间',
   PRIMARY KEY (ID)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='诺诺转让债权到财神';

CREATE UNIQUE INDEX IDX_CSYY_DEBT_TRANSFER_FROM_NONO_1 ON CSYY_DEBT_TRANSFER_FROM_NONO (STAT_DATE,BO_ID);
