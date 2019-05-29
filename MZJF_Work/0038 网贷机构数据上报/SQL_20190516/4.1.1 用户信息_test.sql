set mapreduce.job.name = pdw_report_01_userinfo; 
set mapreduce.job.queuename = etl-dw;  
set hive.exec.parallel = true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;
set hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode = nonstrict; 
set hive.exec.max.dynamic.partitions.pernode = 100000000;
set hive.exec.max.dynamic.partitions = 100000000;
set hive.exec.max.created.files = 100000000;

insert overwrite table pdw.report_01_userinfo

SELECT
    ""                                                                                                      version,                --1.接口版本号
    'CERT20190411026'                                                                                       sourceCode,             --2.平台编号
    if(p2p.account_type = 'user','1','2')                                                                   userType,               --3.用户类型
    '1'                                                                                                     userAttr,               --4.用户属性
    date_format(u.register_time,'yyyy-MM-dd HH:mm:ss')                                                      userCreateTime,         --5.用户注册时间
    if(length(u.real_name) = 2,concat(substr(u.real_name,1,1),"*"),concat(substr(u.real_name,1,1),"**"))    userName,               --6.用户姓名/名称
    '-1'                                                                                                    countries,              --7.国别
    case 
        when u.card_type = '01' then '1'
        when u.card_type = '04' then '4'
        when u.card_type in ('05','10') then '2'
        when u.card_type = '07' then '5'
        when u.card_type = '25' then '7'
        end                                                                                                 cardType,               --8.证件类型（01：1A.中国（18位证件号）； 02：身份证（15位）； 03：2.中国（军官证）； 04：中国（台胞证）； 05：3A.中国（护照）； 07：港澳居民通行证； 10：3B.外国（护照）； 20：中国（其他）； 25：社会信用代码； 26：营业执照编号； 27：税务登记证； 28：组织机构代码证； 29：户口簿；）
    concat(substr(p2p.id_card,1,length(p2p.id_card)-4),"****")                                              userIdcard,             --9.用户证件号
    if(length(p2p.id_card) = 18,certIdcardHash(p2p.id_card),'-1')                                           userIdcardHash,         --10.用户证件号hash值
    concat(substr(p2p.mobile,1,length(p2p.mobile)-4),"****")                                                userPhone,              --11.用户手机号
    p2p.mobile                                 userPhoneHash,          --12.手机号hash值
    p2p.mobile                                  userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    if(length(p2p.id_card) = 18,certIdcardSex(p2p.id_card),'-1')                                            userSex,                --19.用户性别
    p2p.bank_card                                                                                           userBankAccount,        --20.交易银行卡号
    "",
    ""
from 
    (select t.user_id from msc.tmp_report_01_invest_user t 
    where not exists (select 1 from msc.tmp_report_01_loan_user b where t.user_id = b.user_id)) t
left join 
    (select * from msc.tmp_acc_p2p_20190507 where account_type = 'user') p2p
on t.user_id = p2p.owner_id
left join ods.t_user_info_hist u
on t.user_id = u.id

UNION all

SELECT
    ""                                                                                                      version,                --1.接口版本号
    'CERT20190411026'                                                                                       sourceCode,             --2.平台编号
    if(p2p.account_type = 'user','1','2')                                                                   userType,               --3.用户类型
    '2'                                                                                                     userAttr,               --4.用户属性
    date_format(u.register_time,'yyyy-MM-dd HH:mm:ss')                                                      userCreateTime,         --5.用户注册时间
    u.real_name                                                                                             userName,               --6.用户姓名/名称
    '-1'                                                                                                    countries,              --7.国别
    case 
        when u.card_type = '01' then '1'
        when u.card_type = '04' then '4'
        when u.card_type in ('05','10') then '2'
        when u.card_type = '07' then '5'
        when u.card_type = '25' then '7'
        end                                                                                                 cardType,               --8.证件类型（01：1A.中国（18位证件号）； 02：身份证（15位）； 03：2.中国（军官证）； 04：中国（台胞证）； 05：3A.中国（护照）； 07：港澳居民通行证； 10：3B.外国（护照）； 20：中国（其他）； 25：社会信用代码； 26：营业执照编号； 27：税务登记证； 28：组织机构代码证； 29：户口簿；）
    concat(substr(p2p.id_card,1,length(p2p.id_card)-4),"****")                                              userIdcard,             --9.用户证件号
    if(length(p2p.id_card) = 18,certIdcardHash(p2p.id_card),'-1')                                           userIdcardHash,         --10.用户证件号hash值
    concat(substr(p2p.mobile,1,length(p2p.mobile)-4),"****")                                                userPhone,              --11.用户手机号
    p2p.mobile                                 userPhoneHash,          --12.手机号hash值
    p2p.mobile                                  userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    if(length(p2p.id_card) = 18,certIdcardSex(p2p.id_card),'-1')                                            userSex,                --19.用户性别
    p2p.bank_card                                                                                           userBankAccount,        --20.交易银行卡号
    "",
    ""
from 
    (select t.user_id from msc.tmp_report_01_loan_user t 
    where not exists (select 1 from msc.tmp_report_01_invest_user b where t.user_id = b.user_id)) t
left join
    (select * from msc.tmp_acc_p2p_20190507 where account_type = 'user') p2p
on t.user_id = p2p.owner_id
left join 
    (
    SELECT 
        id,
        register_time,
        real_name,
        card_type,
        regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num
    FROM ods.t_user_info_hist
    where status = 1
    ) u
on t.user_id = u.id

UNION all

SELECT
    ""                                                                                                      version,                --1.接口版本号
    'CERT20190411026'                                                                                       sourceCode,             --2.平台编号
    if(p2p.account_type = 'user','1','2')                                                                   userType,               --3.用户类型
    '3'                                                                                                     userAttr,               --4.用户属性
    date_format(u.register_time,'yyyy-MM-dd HH:mm:ss')                                                      userCreateTime,         --5.用户注册时间
    if(length(u.real_name) = 2,concat(substr(u.real_name,1,1),"*"),concat(substr(u.real_name,1,1),"**"))    userName,               --6.用户姓名/名称
    '-1'                                                                                                    countries,              --7.国别
    case 
        when u.card_type = '01' then '1'
        when u.card_type = '04' then '4'
        when u.card_type in ('05','10') then '2'
        when u.card_type = '07' then '5'
        when u.card_type = '25' then '7'
        end                                                                                                 cardType,               --8.证件类型（01：1A.中国（18位证件号）； 02：身份证（15位）； 03：2.中国（军官证）； 04：中国（台胞证）； 05：3A.中国（护照）； 07：港澳居民通行证； 10：3B.外国（护照）； 20：中国（其他）； 25：社会信用代码； 26：营业执照编号； 27：税务登记证； 28：组织机构代码证； 29：户口簿；）
    concat(substr(p2p.id_card,1,length(p2p.id_card)-4),"****")                                              userIdcard,             --9.用户证件号
    if(length(p2p.id_card) = 18,certIdcardHash(p2p.id_card),'-1')                                           userIdcardHash,         --10.用户证件号hash值
    concat(substr(p2p.mobile,1,length(p2p.mobile)-4),"****")                                                userPhone,              --11.用户手机号
    p2p.mobile                                 userPhoneHash,          --12.手机号hash值
    p2p.mobile                                  userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    if(length(p2p.id_card) = 18,certIdcardSex(p2p.id_card),'-1')                                            userSex,                --19.用户性别
    p2p.bank_card                                                                                           userBankAccount,        --20.交易银行卡号
    "",
    ""
from
    (select t.user_id from msc.tmp_report_01_loan_user t 
    where exists (select 1 from msc.tmp_report_01_invest_user b where t.user_id = b.user_id)) t
left join 
    (select * from msc.tmp_acc_p2p_20190507 where account_type = 'user') p2p
on t.user_id = p2p.owner_id
left join ods.t_user_info_hist u
on t.user_id = u.id

UNION all

SELECT
    ""                                                                                                      version,                --1.接口版本号
    'CERT20190411026'                                                                                       sourceCode,             --2.平台编号
    if(p2p.account_type = 'user','1','2')                                                                   userType,               --3.用户类型
    '1'                                                                                                     userAttr,               --4.用户属性
    date_format(u.register_time,'yyyy-MM-dd HH:mm:ss')                                                      userCreateTime,         --5.用户注册时间
    if(length(u.real_name) = 2,concat(substr(u.real_name,1,1),"*"),concat(substr(u.real_name,1,1),"**"))    userName,               --6.用户姓名/名称
    '-1'                                                                                                    countries,              --7.国别
    case 
        when u.card_type = '01' then '1'
        when u.card_type = '04' then '4'
        when u.card_type in ('05','10') then '2'
        when u.card_type = '07' then '5'
        when u.card_type = '25' then '7'
        end                                                                                                 cardType,               --8.证件类型（01：1A.中国（18位证件号）； 02：身份证（15位）； 03：2.中国（军官证）； 04：中国（台胞证）； 05：3A.中国（护照）； 07：港澳居民通行证； 10：3B.外国（护照）； 20：中国（其他）； 25：社会信用代码； 26：营业执照编号； 27：税务登记证； 28：组织机构代码证； 29：户口簿；）
    concat(substr(p2p.id_card,1,length(p2p.id_card)-4),"****")                                              userIdcard,             --9.用户证件号
    if(length(p2p.id_card) = 18,certIdcardHash(p2p.id_card),'-1')                                           userIdcardHash,         --10.用户证件号hash值
    concat(substr(p2p.mobile,1,length(p2p.mobile)-4),"****")                                                userPhone,              --11.用户手机号
    p2p.mobile                                 userPhoneHash,          --12.手机号hash值
    p2p.mobile                                  userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    if(length(p2p.id_card) = 18, if(substr(p2p.id_card,17,1) in ('1','3','5','7','9'), '1', '0')  ,'-1')    userSex,                --19.用户性别
    p2p.bank_card                                                                                           userBankAccount,        --20.交易银行卡号
    "",
    ""
from 
    (select * from msc.tmp_acc_p2p_20190507 where account_type = 'user' and bank_card is not null) p2p
left join
    (
        select distinct user_id from 
        (select user_id from msc.tmp_report_01_loan_user
        union all
        select user_id from msc.tmp_report_01_invest_user) a 
    ) li
on p2p.owner_id = li.user_id
left join ods.t_user_info_hist u
on p2p.owner_id = u.id
where li.user_id is null
;

