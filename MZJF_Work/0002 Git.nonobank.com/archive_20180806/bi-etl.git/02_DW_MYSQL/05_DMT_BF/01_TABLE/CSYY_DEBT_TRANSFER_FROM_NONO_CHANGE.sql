CREATE TABLE  CSYY_DEBT_TRANSFER_FROM_NONO_CHANGE
(   ID                  INT            NOT NULL AUTO_INCREMENT           COMMENT '自增序号',
    STAT_DATE           VARCHAR(20)    NOT NULL DEFAULT ''               COMMENT '数据所属日期',
    BO_ID               BIGINT         NOT NULL DEFAULT -1               COMMENT '标的号',
    BA_PRICE            DECIMAL(18,6)  NOT NULL DEFAULT 0                COMMENT '金额',
    DEBTER_NAME         VARCHAR(60)    NOT NULL DEFAULT ''               COMMENT '借款人姓名',
    SEX                 VARCHAR(30)    NOT NULL DEFAULT ''               COMMENT '性别',
    SCHOOL              VARCHAR(300)   NOT NULL DEFAULT ''               COMMENT '学校',
    ADDRESS             VARCHAR(300)   NOT NULL DEFAULT ''               COMMENT '地址',
    CERTIFICATE_NUMBER  VARCHAR(60)    NOT NULL DEFAULT ''               COMMENT '身份证',
    DEBT_DETAIL_DESC    VARCHAR(999)   NOT NULL DEFAULT ''               COMMENT '借款目的',
    MOBILE_NUM          VARCHAR(60)    NOT NULL DEFAULT 0                COMMENT '手机号',
    TYPE                INT            NOT NULL DEFAULT 0                COMMENT '类型：0 新增，1 历史变更 ，2 删除',
   DW_CREATE_BY         VARCHAR(64)    NOT NULL DEFAULT 'SYS'            COMMENT '系统字段-创建者',
   DW_CREATE_TIME       DATETIME       NOT NULL DEFAULT '1900-01-01'     COMMENT '系统字段-创建时间',
   DW_UPDATE_BY         VARCHAR(64)    NOT NULL DEFAULT 'SYS'            COMMENT '系统字段-修改者',
   DW_UPDATE_TIME       DATETIME       NOT NULL DEFAULT '1900-01-01'     COMMENT '系统字段-修改时间',
   PRIMARY KEY (ID)
)ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='诺诺转让债权到财神';

CREATE UNIQUE INDEX IDX_CSYY_DEBT_TRANSFER_FROM_NONO_CHANGE_1 ON CSYY_DEBT_TRANSFER_FROM_NONO_CHANGE (STAT_DATE,BO_ID);
