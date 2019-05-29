--DMT_CRM_SEC.products
DROP TABLE IF EXISTS DMT_CRM_SEC.products
;
CREATE TABLE DMT_CRM_SEC.products 
(   
    id                          BIGINT not null COMMENT '主键ID'
    ,p_code                     varchar(20)     COMMENT '产品编号'
    ,p_type                     INT             COMMENT '产品类型'
    ,p_name                     varchar(60)     COMMENT '产品名称'
    ,p_pay_type                 varchar(10)     COMMENT '还款方式'
    ,p_accept_type              varchar(10)     COMMENT '收款方式'
    ,p_expect                   INT             COMMENT '期限'
    ,p_delay_month              INT             COMMENT '推迟还款月份'
    ,p_assure_type              varchar(30)     COMMENT '担保类型'
    ,p_approach                 varchar(60)     COMMENT '渠道'
    ,p_price_min                DECIMAL(38,10)  COMMENT '最低借款金额'
    ,p_price_max                DECIMAL(38,10)  COMMENT '最高借款金额'
    ,p_compensation             INT             COMMENT '是否允许代偿'
    ,p_compensation_overdue     INT             COMMENT '逾期多少天启动代偿'
    ,p_enabled                  INT             COMMENT '是否启用'
    ,p_creator                  BIGINT          COMMENT '创建人'
    ,p_updator                  BIGINT          COMMENT '更新人'
    ,version                    INT             COMMENT '版本'
    ,create_time            timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
    ,update_time            timestamp       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
    ,PRIMARY KEY (id) 
) 
comment='产品表' 
;

--DMT_CRM_SEC.bank
DROP TABLE IF EXISTS DMT_CRM_SEC.bank
;
CREATE TABLE DMT_CRM_SEC.bank
(
    id bigint(20)                  NOT NULL                COMMENT 'ID主键'
    ,name varchar(200)             DEFAULT NULL            COMMENT '银行名'
    ,short_code varchar(10)        DEFAULT NULL            COMMENT '银行简码'
    ,city_id bigint(20)            DEFAULT NULL            COMMENT '城市名'
    ,province_id bigint(20)        DEFAULT NULL            COMMENT '省份ID'
    ,parent_id bigint(20)          DEFAULT NULL            COMMENT '父ID'
    ,is_delete tinyint(1)          DEFAULT '0'             COMMENT '是否删除1已删除0启用'
    ,use_type int(2)               DEFAULT '0'             COMMENT '0:普通，1:块钱使用'
    ,band_card_type int(2)         DEFAULT '0'             COMMENT '0:普通，1:绑定并支付，2：单独绑定'
    ,fast_payment_channel int(2)   DEFAULT '0'             COMMENT '快捷支付使用通道：0:快钱，1:连连'
    ,version int(11) NOT NULL      DEFAULT '1'             COMMENT '版本'
    ,is_pay_public tinyint(1)      DEFAULT NULL            COMMENT '是否支持对公打款 1:支持，0:不支持'
    ,sort_field int(2)             NOT NULL DEFAULT '0'    COMMENT '排序字段'
    ,create_time timestamp         NULL DEFAULT NULL       COMMENT '创建时间'
    ,update_time timestamp         NULL DEFAULT NULL
    ,PRIMARY KEY (id)
) 
COMMENT='银行省份关联表'
;

--DMT_CRM_SEC.borrows_order
DROP TABLE IF EXISTS DMT_CRM_SEC.borrows_order
;
CREATE TABLE DMT_CRM_SEC.borrows_order
(
    id bigint(20)                            NOT NULL AUTO_INCREMENT
    ,bo_id bigint(32)                        NOT NULL                           COMMENT '标的号'
    ,user_id bigint(32)                      NOT NULL                           COMMENT 'user id'
    ,bo_price decimal(32,8)                  DEFAULT NULL                       COMMENT '借款金额'
    ,bo_finish_time datetime                 DEFAULT NULL                       COMMENT '完成时间'
    ,bo_audit_time datetime                  DEFAULT NULL                       COMMENT '审核时间'
    ,bp_time datetime                        DEFAULT NULL                       COMMENT '借款申请时间/预发标时间'
    ,bo_audit_price decimal(32,8)            DEFAULT NULL                       COMMENT '完成金额/审核金额'
    ,bo_finish_price decimal(32,8)           DEFAULT NULL                       COMMENT '放款金额/撮合金额'
    ,bo_sign_time datetime                   DEFAULT NULL                       COMMENT '签约时间'
    ,bo_create_time datetime                 DEFAULT NULL                       COMMENT '订单创建时间'
    ,bo_rate decimal(32,8)                   DEFAULT NULL                       COMMENT '借款年利率'
    ,bo_sign_result int(2)                   DEFAULT NULL                       COMMENT '签约结果:1表示通过，2表示拒绝，0表示未处理,3表示待处理,4/5/null'
    ,is_success_first int(2)                 DEFAULT NULL                       COMMENT '是否首次借款,借款成功次数：1、2、3、null'
    ,p_name varchar(32)                      DEFAULT NULL                       COMMENT '借款产品'
    ,bo_expect int(11)                       DEFAULT NULL                       COMMENT '借款期限'
    ,bo_expect_cat int(2)                    DEFAULT NULL                       COMMENT '借款期限单位 1:日 2:月 3:年'
    ,is_video_audit int(2)                   DEFAULT NULL                       COMMENT '视频认证,是否提交视频认证,1:是，0：否'
    ,bo_is_success int(2)                    DEFAULT NULL                       COMMENT '审核结果 1:通过 2:拒绝 3:超时流标 4:回退 0'
    ,total_amount decimal(32,8)              DEFAULT NULL                       COMMENT '总额度'
    ,base_amount decimal(32,8)               DEFAULT NULL                       COMMENT '基础额度'
    ,last_repayed_time datetime              DEFAULT NULL                       COMMENT '在途还款时间	最近还款时间'
    ,all_repayed_time datetime               DEFAULT NULL                       COMMENT '结清时间 用户还完时间(订单结清的最后一次还款时间）'
    ,bo_all_repayed int(2)                   DEFAULT NULL                       COMMENT '是否结清'
    ,in_repay_expect int(11)                 DEFAULT NULL                       COMMENT '距离还完期限，借款期数-已还期数'
    ,ml_time datetime                        DEFAULT NULL                       COMMENT '进件时间'
    ,bo_success_time datetime                DEFAULT NULL                       COMMENT '放款时间'
    ,reject_time datetime                    DEFAULT NULL                       COMMENT '审核被拒时间'
    ,fail_time datetime                      DEFAULT NULL                       COMMENT '流标时间'
    ,bo_purpose varchar(128)                 DEFAULT NULL                       COMMENT '贷款类型	借款用途'
    ,pass_time datetime                      DEFAULT NULL                       COMMENT '审核通过时间'
    ,is_overdue_unrepay int(2)               DEFAULT NULL                       COMMENT '是否逾期	0:否 1:是'
    ,biz_code_01 varchar(32)                 DEFAULT NULL                       COMMENT '业务线代码'
    ,biz_name_01 varchar(32)                 DEFAULT NULL                       COMMENT '业务线名称'
    ,etl_create_time timestamp               NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
    ,etl_update_time timestamp               NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
    ,PRIMARY KEY (id)
    ,UNIQUE KEY uk_u_bo (user_id,bo_id)
) 
COMMENT='借款订单表'
;

--DMT_CRM_SEC.nono_invest_order
DROP TABLE IF EXISTS DMT_CRM_SEC.nono_invest_order
;
CREATE TABLE DMT_CRM_SEC.nono_invest_order
(
    id bigint(20)                           NOT NULL AUTO_INCREMENT
    ,user_id bigint(32)                     NOT NULL                COMMENT 'user id'
    ,invest_src_id bigint(32)               NOT NULL                COMMENT '源表ID'
    ,invest_src_tab varchar(20)             NOT NULL DEFAULT ''     COMMENT '源表'
    ,invest_type_code int(3)                DEFAULT NULL            COMMENT '投资类型 1:散投 2:债转 3:精选 4:e诺千金 5:活期 99:未知'
    ,terminal_code varchar(20)              DEFAULT NULL            COMMENT '终端类型,0:PC 1:名校贷 2:诺诺镑客app 3:诺诺镑客微站 4:诺诺镑客IOS 5:诺诺镑客Andriod 6:Ipad 7:微信,null、12、13、2016、2017'
    ,invest_amt decimal(38,10)              DEFAULT NULL            COMMENT '投资金额'
    ,status int(2)                          DEFAULT NULL            COMMENT '0:不成功 1:部分成功 2:成功 3:进行中 4:终止  5待满标 6待放款'
    ,category_name_02 varchar(128)          DEFAULT NULL            COMMENT '品类:月月升，贴心计划，0元计划...,'
    ,expect int(10)                         DEFAULT NULL            COMMENT '锁定期限'
    ,expect_unit_code int(2)                DEFAULT NULL            COMMENT '期限单位 1:日 2:月 3:年'
    ,invest_time timestamp                  NULL DEFAULT NULL       COMMENT '投资时间'
    ,lock_end_time timestamp                NULL DEFAULT NULL       COMMENT '到期时间'
    ,invest_amt_yearly decimal(38,10)       DEFAULT NULL            COMMENT '年化投资金额'
    ,etl_create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP   COMMENT '创建时间'
    ,etl_update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
    ,PRIMARY KEY (id)
    ,UNIQUE KEY uk_src (user_id,invest_src_id,invest_src_tab)
) 
COMMENT='诺诺投资订单表'
;

--DMT_CRM_SEC.region
DROP TABLE IF EXISTS DMT_CRM_SEC.region
;
CREATE TABLE DMT_CRM_SEC.region
(
    code int(10)                NOT NULL                COMMENT '行政区划代码'
    ,name varchar(150)          DEFAULT NULL            COMMENT '行政区划名称'
    ,level tinyint(1)           NOT NULL                COMMENT '行政区划等级  1：省级；2：市级；3：县区级；'
    ,parent_code int(10)        DEFAULT NULL            COMMENT '上级行政区划  0代表中国'
    ,creator bigint(20)         DEFAULT NULL            COMMENT '创建人'
    ,updator bigint(20)         DEFAULT NULL            COMMENT '更新人'
    ,version int(11)            NOT NULL DEFAULT '1'    COMMENT '版本'
    ,create_time datetime       DEFAULT NULL            COMMENT '创建时间'
    ,update_time datetime       DEFAULT NULL
    ,PRIMARY KEY (code)
    ,KEY name (name)
    ,KEY parent_code (parent_code)
    ,KEY LEVEL (level)
) 
COMMENT='行政区划'
;

--DMT_CRM_SEC.user
DROP TABLE IF EXISTS DMT_CRM_SEC.user
;
CREATE TABLE DMT_CRM_SEC.user
(
    id bigint(20)                           NOT NULL AUTO_INCREMENT
    ,user_id bigint(32)                     NOT NULL     COMMENT 'user id'
    ,user_name varchar(50)                  DEFAULT NULL COMMENT '用户名'
    ,real_name varchar(20)                  DEFAULT NULL COMMENT '真实姓名'
    ,gender int(2)                          DEFAULT NULL COMMENT '性别1.男2.女, 0/null'
    ,email varchar(100)                     DEFAULT NULL COMMENT '邮箱'
    ,mobile_num varchar(20)                 DEFAULT NULL COMMENT '手机号'
    ,register_time datetime                 DEFAULT NULL COMMENT '注册时间'
    ,birthday varchar(32)                   DEFAULT NULL COMMENT '生日'
    ,birthday_age int(4)                    DEFAULT NULL COMMENT '年龄'
    ,id_num varchar(64)                     DEFAULT NULL COMMENT '身份证号'
    ,is_education_auth int(2)               DEFAULT NULL COMMENT '学历认证：0:否，1:是，2:拒绝'
    ,is_student_auth int(2)                 DEFAULT NULL COMMENT '学籍认证：0:否，1:是，2:拒绝'
    ,is_deposit int(2)                      DEFAULT NULL COMMENT '是否通过存管认证：0:否，1:是'
    ,user_rank int(2)                       DEFAULT NULL COMMENT '会员等级 0:普通会员 1:VIP1 2:VIP2 3:VIP3'
    ,marriage_status int(2)                 DEFAULT NULL COMMENT '婚姻状态 , null,0:未知，1已婚，2未婚，3,已婚已育，4已婚未育，5未婚已育，6丧偶，7离婚'
    ,finance_advisor int(11)                DEFAULT NULL COMMENT '理财顾问'
    ,recommender int(11)                    DEFAULT NULL COMMENT '推荐人'
    ,hj_province int(11)                    DEFAULT NULL COMMENT '户籍省份'
    ,hj_city int(11)                        DEFAULT NULL COMMENT '户籍城市'
    ,current_province int(11)               DEFAULT NULL COMMENT '当前所在省'
    ,current_city int(11)                   DEFAULT NULL COMMENT '当前所在市'
    ,channel_name varchar(64)               DEFAULT NULL COMMENT '注册来源的媒体渠道'
    ,register_terminal varchar(64)          DEFAULT NULL COMMENT '注册终端设备，null、admin、ios、h5、pc、weixin、weizhan'
    ,last_bind_card_bank varchar(64)        DEFAULT NULL COMMENT '已绑定银行卡 (最后绑定银行卡)'
    ,industry varchar(64)                   DEFAULT NULL COMMENT '职业（所属行业)'
    ,edu_graduate_date varchar(32)          DEFAULT NULL COMMENT '毕业时间'
    ,derive_model varchar(64)               DEFAULT NULL COMMENT '设备机型'
    ,network varchar(32)                    DEFAULT NULL COMMENT '网络环境'
    ,qq varchar(32)                         DEFAULT NULL COMMENT 'QQ'
    ,register_biz varchar(56)               DEFAULT NULL COMMENT '注册平台:unifi,maiya,dfd,cdd,nono,bld,csyy,mzlc,mld'
    ,etl_create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
    ,etl_update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
    ,PRIMARY KEY (id)
    ,UNIQUE KEY uk_user_id (user_id)
) 
COMMENT='用户信息表'
;

--DMT_CRM_SEC.user_finance_tags
DROP TABLE IF EXISTS DMT_CRM_SEC.user_finance_tags
;
CREATE TABLE DMT_CRM_SEC.user_finance_tags
(
    id bigint(20)                                       NOT NULL AUTO_INCREMENT COMMENT 'ID主键'
    ,user_id bigint(11)                                 DEFAULT NULL            COMMENT '用户ID'
    ,register_biz varchar(10)                           DEFAULT NULL            COMMENT '业务线代码'
    ,nono_total_invest_amt decimal(38,8)                DEFAULT NULL            COMMENT '总投资额'
    ,nono_total_invest_amt_yearly decimal(38,8)         DEFAULT NULL            COMMENT '总年化投资额'
    ,nono_invest_cnt int(11)                            DEFAULT NULL            COMMENT '总投资次数'
    ,nono_aum decimal(38,8)                             DEFAULT NULL            COMMENT '在投金额'
    ,nono_aum_yearly decimal(38,8)                      DEFAULT NULL            COMMENT '在投年化金额'
    ,nono_max_aum decimal(38,8)                         DEFAULT NULL            COMMENT '历史最高在投'
    ,nono_max_aum_year decimal(38,8)                    DEFAULT NULL            COMMENT '近一年最高在投'
    ,nono_invet_cnt_month int(11)                       DEFAULT NULL            COMMENT '本月投资次数'
    ,nono_last_invest_time datetime                     DEFAULT NULL            COMMENT '最近投资时间'
    ,csyy_aum decimal(38,8)                             DEFAULT NULL            COMMENT '财神在投金额'
    ,nono_prolocutor_invite_register_cnt int(11)        DEFAULT NULL            COMMENT '总邀请人数'
    ,nono_prolocutor_invite_amt decimal(38,8)           DEFAULT NULL            COMMENT '总邀请投资金额'
    ,nono_prolocutor_invite_last_time datetime          DEFAULT NULL            COMMENT '最近邀请好友时间'
    ,nono_balance_amt decimal(38,8)                     DEFAULT NULL            COMMENT '账户余额'
    ,bbs_active_30 decimal(38,8)                        DEFAULT NULL            COMMENT '最近30天论坛登录活跃度'
    ,shop_active_90 decimal(38,8)                       DEFAULT NULL            COMMENT '最近90天商城兑换活跃度'
    ,invest_active_90 decimal(38,8)                     DEFAULT NULL            COMMENT '最近90天投资活跃度'
    ,login_active_30 decimal(38,8)                      DEFAULT NULL            COMMENT '最近30天登录活跃度'
    ,last_login_time datetime                           DEFAULT NULL            COMMENT '最近登录时间'
    ,login_interval int(11)                             DEFAULT NULL            COMMENT '最近登录间隔天数'
    ,sign_m int(11)                                     DEFAULT NULL            COMMENT '当月累计签到次数'
    ,sign_last_time datetime                            DEFAULT NULL            COMMENT '最近一次签到时间'
    ,lost_ratio decimal(38,8)                           DEFAULT NULL            COMMENT '潜在流失系数'
    ,invest_ratio decimal(38,8)                         DEFAULT NULL            COMMENT '当日在投与前一日在投系数'
    ,lost_rank int(11)                                  DEFAULT NULL            COMMENT '流失用户等级'
    ,nono_last_recharge_time datetime                   DEFAULT NULL            COMMENT '最近充值时间'
    ,nono_last_withdraw_time datetime                   DEFAULT NULL            COMMENT '最近提现时间'
    ,no_invest_reason varchar(128)                      DEFAULT NULL            COMMENT '未投资原因'
    ,tel_cnt int(11)                                    DEFAULT NULL            COMMENT '电话咨询次数'
    ,bt_coupon_cnt int(11)                              DEFAULT NULL            COMMENT '可用补贴券数'
    ,bt_coupon_lost_time datetime                       DEFAULT NULL            COMMENT '补贴券最近失效时间'
    ,dy_coupon_cnt int(11)                              DEFAULT NULL            COMMENT '可用抵用券金额'
    ,dy_coupon_lost_time datetime                       DEFAULT NULL            COMMENT '抵用券最近失效时间'
    ,cash_packet_wait decimal(38,8)                     DEFAULT NULL            COMMENT '待激活现金红包金额'
    ,nono_money decimal(38,8)                           DEFAULT NULL            COMMENT '可用诺币'
    ,tqbj_wait_money decimal(38,8)                      DEFAULT NULL            COMMENT '待激活特权本金金额'
    ,tqbj_lost_time datetime                            DEFAULT NULL            COMMENT '特权本金最近失效时间'
    ,etl_create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
    ,etl_update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
    ,PRIMARY KEY (id)
    ,UNIQUE KEY uk_lt (user_id,register_biz)
) 
COMMENT='资产端用户标签'
;

--DMT_CRM_SEC.user_loan_tags
DROP TABLE IF EXISTS DMT_CRM_SEC.user_loan_tags
;
CREATE TABLE DMT_CRM_SEC.user_loan_tags
(
    id bigint(20)                               NOT NULL AUTO_INCREMENT COMMENT 'ID主键'
    ,user_id bigint(11)                         NOT NULL                COMMENT '用户ID'
    ,biz_code_01 varchar(64)                    DEFAULT NULL            COMMENT '业务线代码'
    ,biz_name_01 varchar(64)                    DEFAULT NULL            COMMENT '业务线名称'
    ,apply_channel varchar(32)                  DEFAULT NULL            COMMENT '申请渠道'
    ,credit double(32,4)                        DEFAULT NULL            COMMENT '注册授信情况	首贷授信结果，预发标授信情况'
    ,is_reject_credit int(2)                    DEFAULT NULL            COMMENT '是否授信被拒'
    ,is_reject_apply int(2)                     DEFAULT NULL            COMMENT '是否申请被拒'
    ,is_apply int(2)                            DEFAULT NULL            COMMENT '授信成功是否申请'
    ,bp_time timestamp                          NULL DEFAULT NULL       COMMENT '申请时间'
    ,ml_time timestamp                          NULL DEFAULT NULL       COMMENT '进件时间'
    ,is_ml int(2)                               DEFAULT NULL            COMMENT '申请是否进件'
    ,audit int(2)                               DEFAULT NULL            COMMENT '进件审核是否被拒(1,被拒,0 未被拒,null)，终审是否被拒'
    ,reject_reason varchar(512)                 DEFAULT NULL            COMMENT '审核被拒原因'
    ,bo_all_repayed int(2)                      DEFAULT NULL            COMMENT '是否结清. 1结清 0未结清'
    ,all_repayed_apply_sec int(2)               DEFAULT NULL            COMMENT '结清是否申请 首贷结清后有没有进项第二次申请'
    ,all_repayed_ml_sec int(2)                  DEFAULT NULL            COMMENT '结清申请是否进件 首次结清有没有第二次进件'
    ,all_repayed_reject_sec varchar(512)        DEFAULT NULL            COMMENT '结清申请后被拒（同步被拒原因）首贷结清后第二次被拒原因'
    ,is_overdue varchar(64)                     DEFAULT NULL            COMMENT '首贷是否逾期'
    ,success_cnt int(11)                        DEFAULT NULL            COMMENT '已成功借款次数'
    ,is_follow_wp int(2)                        DEFAULT NULL            COMMENT '是否关注服务号'
    ,etl_create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
    ,etl_update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
    ,PRIMARY KEY (id)
    ,UNIQUE KEY uk_lt (user_id,biz_code_01)
) 
COMMENT='资产端用户标签'
;
