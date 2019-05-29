
drop table if exists DMT_CRM.FACT_USER_PROFILE_SNAPSHOT;

create table DMT_CRM.FACT_USER_PROFILE_SNAPSHOT
(
     USER_ID                            BIGINT            COMMENT '用户ID'
    ,STATUS_DESC                        STRING            COMMENT '用户状态'
    ,REGISTER_BIZ                       STRING            COMMENT '注册业务线'
    ,GENDER                             STRING            COMMENT '性别'
    ,AGE                                INT               COMMENT '年龄'
    ,AGE_CATEGORY                       STRING            COMMENT '年龄分类'
    ,USER_RANK_DESC                     STRING            COMMENT '会员等级'
    ,IS_REGISTER                        STRING            COMMENT '是否注册'
    ,REGISTER_TIME                      STRING            COMMENT '注册时间'
    ,IS_BIND_CARD                       STRING            COMMENT '是否绑卡'
    ,BIND_CARD_TIME                     STRING            COMMENT '绑卡时间'
    ,IS_DEPOSIT                         STRING            COMMENT '是否存管'
    ,IS_RECHARGE                        STRING            COMMENT '是否充值'
    ,RECHARGE_TIME                      STRING            COMMENT '充值时间'
    ,IS_INVEST                          STRING            COMMENT '是否投资'
    ,INVEST_AMT                         DECIMAL(38,10)    COMMENT '投资时间'
    ,INVEST_NUM                         INT               COMMENT '投资次数'
    ,AUM                                DECIMAL(38,10)    COMMENT '在投金额'
    ,R1Y_MAX_AUM                        DECIMAL(38,10)    COMMENT '近1年最大在投金额'
    ,LOGIN_OS                           STRING            COMMENT '登录系统'
    ,PHONE_BRAND                        STRING            COMMENT '手机型号'
    ,LOGIN_IP                           STRING            COMMENT '登录IP'
    ,LOGIN_IP_DECIMAL                   BIGINT            COMMENT '登录IP(转10进制)'
    ,AUM_DATE                           STRING            COMMENT '最近在投日期'
    ,CITY_TIME                          STRING            COMMENT '城市名称'
    ,CITY_CATEGORY                      STRING            COMMENT '城市分类'
    ,IS_R15D_LOGIN                      STRING            COMMENT '是否近15天登录'
    ,IS_R3M_INVEST                      STRING            COMMENT '是否近3个月投资'
    ,IS_R7D_INTERACT                    STRING            COMMENT '是否近7天有互动'
    ,NONO_BBS_ACTIVE_7                  INT               COMMENT '近7天论坛登录次数'
    ,NONO_SHOP_ACTIVE_7                 INT               COMMENT '近7天商场兑换次数'
    ,NONO_SIGN_ACTIVE_7                 INT               COMMENT '近7天签到次数'
    ,INVITE_NUM_7                       INT               COMMENT '近7天邀请用户注册数'
    ,TTL_REGISTER_NO_INVEST             STRING            COMMENT '是否注册未投资'
    ,TTL_REGISTER_NO_INVEST_LEV2        STRING            COMMENT '注册未投资2级标签'
    ,TTL_BIND_CARD_NO_INVEST            STRING            COMMENT '是否绑卡未投资'
    ,TTL_BIND_CARD_NO_INVEST_LEV2       STRING            COMMENT '绑卡未投资2级标签'
    ,TTL_DEPOSIT_NO_INVEST              STRING            COMMENT '是否存管未投资'
    ,TTL_RECHARGE_NO_INVEST             STRING            COMMENT '是否充值未投资'
    ,TTL_RECHARGE_NO_INVEST_LEV2        STRING            COMMENT '充值未投资2级标签'
    ,TTL_ROOKIE_USER_LEV1               STRING            COMMENT '是否新手期用户'
    ,TTL_ROOKIE_USER_LEV2               STRING            COMMENT '新手期2级标签'
    ,TTL_GROW_USER_LEV1                 STRING            COMMENT '是否成长期用户'
    ,TTL_GROW_USER_LEV2                 STRING            COMMENT '成长期2级标签'
    ,TTL_MATURE_USER_LEV1               STRING            COMMENT '是否成熟期用户'
    ,TTL_MATURE_USER_LEV2               STRING            COMMENT '成熟期2级标签'
    ,TTL_EMPTY_USER_LEV1                STRING            COMMENT '是否空仓期用户'
    ,TTL_EMPTY_USER_LEV2                STRING            COMMENT '空仓期2级标签'
    ,INVEST_RATIO                       STRING            COMMENT '投资资金状态'
)
COMMENT '用户画像快照'
PARTITIONED BY (STAT_DATE STRING COMMENT '统计日期 年-月-日')
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET
TBLPROPERTIES ("parquet.compression"="SNAPPY")
;

