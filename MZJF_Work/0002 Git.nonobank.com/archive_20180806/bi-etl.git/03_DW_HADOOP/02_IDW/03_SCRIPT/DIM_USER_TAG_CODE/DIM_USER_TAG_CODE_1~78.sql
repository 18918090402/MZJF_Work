INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        1,'USER_ID','用户ID',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'BIGINT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        2,'USER_NAME','用户名',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        3,'REAL_NAME','姓名',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        4,'GENDER','性别','性别1.男2.女','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        5,'MOBILE_NUM','手机号','手机号','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        6,'EMAIL','电子邮箱','电子邮箱','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        7,'IS_EMAIL','是否电子邮件认证','邮箱认证：0:否，1:是','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        8,'REGISTER_TIME','注册时间',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        9,'IS_AUTHENTICATION','是否身份认证','身份认证：0:否，1:是','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        10,'IS_PHOTO','是否图像认证','0:否，1:是','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        11,'IS_EDUCATION_AUTH','是否学历认证','学历认证：0:否，1:是，2:拒绝','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        12,'IS_STUDENT_AUTH','是否学籍认证','学籍认证：0:否，1:是','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        13,'IS_SPECIAL','是否特殊用户','是否特殊用户:0:否，1:是','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        14,'IS_CHEAT','是否诈骗','是否欺诈: 0:否，1:是','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        15,'STATUS','状态','0:无效用户，1:有效用户，2:锁定用户','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        16,'STATUS_DESC','状态描述','0:无效用户，1:有效用户，2:锁定用户','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        17,'PC_ID','所属业务线ID','所属公司（1，4，5，6）','事实标签','用户基本属性',NULL,NULL,NULL,'BIGINT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        18,'PC_ID_DESC','所属业务线说明','诺诺，名校贷，财神，麦芽，UNIFI，科来贷，其他','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        19,'ENGLISH_NAME','英文名',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        20,'BIRTHDAY','生日',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        21,'AGE','年龄',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        22,'CONSTELLATION','星座','星座','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        23,'QQ','QQ号码','QQ号码','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        24,'CURRENT_MOBILE_NO','当前手机号','当前手机号','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        25,'HJ_PROVINCE','户籍省',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        26,'HJ_CITY','户籍市',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        27,'HJ_ADDREss','户籍地址',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        28,'CURRENT_PROVINCE','当前所在省',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        29,'CURRENT_CITY','当前所在市',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        30,'BIRTH_PROVINCE','出生省份',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        31,'CONTACT_ADDREss','联系地址','联系地址','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        32,'MARRIAGE_STATUS','婚姻状态','婚姻状况(0:未知，1已婚，2未婚，3,已婚已育，4已婚未育，5未婚已育，6丧偶，7离婚)','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        33,'MARRIAGE_STATUS_DESC','婚姻状态描述',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        34,'IS_HAVE_PASSPORT','是否持有护照','是否持有护照（0：未知，1：有，2无）','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        35,'IS_SOCIAL_SECURITY','是否有社保','是否有社保（0：未知，1：有，2无）','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        36,'IS_DRIVING_LICENSE','是否有驾照','是否有驾照（0：未知，1：有，2无）','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        37,'HOUSE_STATUS','现居住地状况','现居住地状况(0：未知，1：自购房(无房贷)，2：自购房(有按揭)，3：自建房，4：亲属房产，5：租房，6：其他)','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        38,'EDUCATION','学历',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')


INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        39,'SOURCE','注册渠道','用户渠道来源','事实标签','用户基本属性',NULL,NULL,NULL,'BIGINT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        40,'SOURCE_DESC','注册渠道描述','用户渠道来源描述？','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')


INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        41,'LAST_LOGON_TIME','最近登录时间','最近登录时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        42,'REGISTER_SOURCE','注册来源终端',NULL,'事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')


INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        43,'USER_RANK','用户等级','会员等级 0:普通会员 1:VIP1 2:VIP2 3:VIP3','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        44,'USER_RANK_DESC','用户等级描述','会员等级 0:普通会员 1:VIP1 2:VIP2 3:VIP3','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')

INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        45,'AUTHENTICATION_TIME','认证时间','认证时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')

INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        46,'RECOMMENDER','推荐人','推荐人','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
  
 INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        47,'FISRT_RECHARGE_TIME','首次充值时间','首次充值时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        48,'FISRT_RECHARGE_AMOUNT','首次充值金额','首次充值金额','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        49,'FISRT_RECHARGE_BANKCARD','首次充值银行','首次充值银行','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        50,'FISRT_RECHARGE_TYPE','首次充值类型','首次充值类型','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        51,'FISRT_RECHARGE_SOURCE','首次充值渠道','首次充值渠道','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        52,'LAST_RECHARGE_TIME','最近充值时间','最近充值时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        53,'LAST_RECHARGE_AMOUNT','最近充值金额','最近充值金额','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        54,'LAST_RECHARGE_BANKCARD','最近充值银行','最近充值银行','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        55,'LAST_RECHARGE_TYPE','最近充值类型','最近充值类型','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        56,'LAST_RECHARGE_SOURCE','最近充值渠道','最近充值渠道','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')

 INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        47,'FISRT_RECHARGE_TIME','首次充值时间','首次充值时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        48,'FISRT_RECHARGE_AMOUNT','首次充值金额','首次充值金额','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        49,'FISRT_RECHARGE_BANKCARD','首次充值银行','首次充值银行','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        50,'FISRT_RECHARGE_TYPE','首次充值类型','首次充值类型','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        51,'FISRT_RECHARGE_SOURCE','首次充值渠道','首次充值渠道','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        52,'LAST_RECHARGE_TIME','最近充值时间','最近充值时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        53,'LAST_RECHARGE_AMOUNT','最近充值金额','最近充值金额','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        54,'LAST_RECHARGE_BANKCARD','最近充值银行','最近充值银行','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        55,'LAST_RECHARGE_TYPE','最近充值类型','最近充值类型','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        56,'LAST_RECHARGE_SOURCE','最近充值渠道','最近充值渠道','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')

 INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        57,'FIRST_BIND_CARD_TIME','首次绑卡时间','首次绑卡时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        58,'FIRST_BIND_CARD_ACCOUNT','首次绑卡账户','首次绑卡账户','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        59,'FIRST_BIND_CARD_BANK','首次绑卡银行','首次绑卡银行','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        60,'BINDCARD_COUNT','绑卡次数','绑卡次数','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        61,'LAST_BIND_CARD_TIME','最近绑卡时间','最近绑卡时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        62,'LAST_BIND_CARD_ACCOUNT','最近绑卡账户','最近绑卡账户','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        63,'LAST_BIND_CARD_BANK','最近绑卡银行','最近绑卡银行','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')

 INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        64,'FIRST_INVEST_TIME','首次投资时间','首次投资时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        65,'FIRST_INVEST_AMOUNT','首次投资金额','首次投资金额','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        66,'FIRST_INVEST_PRODUCT_SCOPE','首次投资产品','首次投资产品','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        67,'SECOND_INVEST_TIME','2次投资时间','2次投资时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        68,'SECOND_INVEST_AMOUNT','2次投资金额','2次投资金额','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        69,'SECOND_INVEST_PRODUCT_SCOPE','2次投资产品','2次投资产品','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        70,'THIRD_INVEST_TIME','3次投资时间','3次投资时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        71,'THIRD_INVEST_AMOUNT','3次投资金额','3次投资金额','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        72,'THIRD_INVEST_PRODUCT_SCOPE','3次投资产品','3次投资产品','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        73,'LAST_INVEST_TIME','最近投资时间','最近投资时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        74,'LAST_INVEST_AMOUNT','最近投资金额','最近投资金额','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        75,'LAST_INVEST_PRODUCT_SCOPE','最近投资产品','最近投资产品','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        76,'LAST_CASH_TIME','最近兑付时间','最近兑付时间','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        77,'LAST_CASH_AMOUNT','最近兑付金额','最近兑付金额','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        78,'LAST_CASH_PRODUCT_SCOPE','最近兑付产品','最近兑付产品','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')


 INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        79,'AUM','当前AUM','当前AUM','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        80,'MAX_AUM','历史最大AUM','历史最大AUM','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        81,'MAX_AUM_DATE','历史最大AUM日期','历史最大AUM日期','事实标签','用户基本属性',NULL,NULL,NULL,'STRING','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')
UNION ALL SELECT        82,'BALANCE_AMT','账户余额','账户余额','事实标签','用户基本属性',NULL,NULL,NULL,'DECIMAL(38,10)','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')

 INSERT INTO IDW.DIM_USER_TAG_CODE
          SELECT        83,'USER_TYPE','用户类型','用户类型:0未知，1理财，2贷款，3白领，4微企业主，5学生，6企业主，7vip企业主 8 企业','事实标签','用户基本属性',NULL,NULL,NULL,'INT','SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') ,'SYS' ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')


DROP table IDW.DIM_USER_TAG_CODE_tmp;
create table IDW.DIM_USER_TAG_CODE_tmp
AS
select 
ID             
,TAG_NAME       
,TAG_NAME_CN    
,NVL(TAG_DESC,TAG_NAME_CN) AS TAG_DESC       
,TAG_CLASS      
,TAG_CATEGORY_01
,TAG_CATEGORY_02
,TAG_CATEGORY_03
,NULL_VALUE     
,case when TAG_DATA_TYPE='DATETIME' then 'STRING' ELSE TAG_DATA_TYPE END AS TAG_DATA_TYPE
,DW_CREATE_BY   
,DW_CREATE_TIME 
,DW_UPDATE_BY   
,DW_UPDATE_TIME 
from IDW.DIM_USER_TAG_CODE
order by cast(id as int )
;
INSERT overwrite TABLE IDW.DIM_USER_TAG_CODE
SELECT * FROM IDW.DIM_USER_TAG_CODE_tmp;
 