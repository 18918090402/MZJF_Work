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
    date_format(u.register_time,'yyyy-MM-dd hh:mm:ss')                                                      userCreateTime,         --5.用户注册时间
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
    certIdcardHash(p2p.id_card)                                                                             userIdcardHash,         --10.用户证件号hash值
    concat(substr(p2p.mobile,1,length(p2p.mobile)-4),"****")                                                userPhone,              --11.用户手机号
    certPhoneHashSalt(p2p.mobile)['phone']                                                                  userPhoneHash,          --12.手机号hash值
    certPhoneHashSalt(p2p.mobile)['salt']                                                                   userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    certIdcardSex(p2p.id_card)                                                                              userSex,                --19.用户性别
    p2p.bank_card                                                                                           userBankAccount,        --20.交易银行卡号
    "",
    ""
from 
    (select t.user_id from msc.tmp_report_01_invest_user t 
    where not exists (select 1 from msc.tmp_report_01_loan_user b where t.user_id = b.user_id)) t
left join ods.t_acc_p2p_hist p2p
on t.user_id = p2p.owner_id
left join ods.t_user_info_hist u
on t.user_id = u.id

UNION all
SELECT
    ""                                                                                                      version,                --1.接口版本号
    'CERT20190411026'                                                                                       sourceCode,             --2.平台编号
    if(p2p.account_type = 'user','1','2')                                                                   userType,               --3.用户类型
    '2'                                                                                                     userAttr,               --4.用户属性
    date_format(u.register_time,'yyyy-MM-dd hh:mm:ss')                                                      userCreateTime,         --5.用户注册时间
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
    certIdcardHash(p2p.id_card)                                                                             userIdcardHash,         --10.用户证件号hash值
    concat(substr(p2p.mobile,1,length(p2p.mobile)-4),"****")                                                userPhone,              --11.用户手机号
    certPhoneHashSalt(p2p.mobile)['phone']                                                                  userPhoneHash,          --12.手机号hash值
    certPhoneHashSalt(p2p.mobile)['salt']                                                                   userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    certIdcardSex(p2p.id_card)                                                                              userSex,                --19.用户性别
    p2p.bank_card                                                                                           userBankAccount,        --20.交易银行卡号
    "",
    ""
from 
    (select t.user_id from msc.tmp_report_01_loan_user t 
    where not exists (select 1 from msc.tmp_report_01_invest_user b where t.user_id = b.user_id)) t
left join ods.t_acc_p2p_hist p2p
on t.user_id = p2p.owner_id
left join ods.t_user_info_hist u
on t.user_id = u.id

UNION all

SELECT
    ""                                                                                                      version,                --1.接口版本号
    'CERT20190411026'                                                                                       sourceCode,             --2.平台编号
    if(p2p.account_type = 'user','1','2')                                                                   userType,               --3.用户类型
    '3'                                                                                                     userAttr,               --4.用户属性
    date_format(u.register_time,'yyyy-MM-dd hh:mm:ss')                                                      userCreateTime,         --5.用户注册时间
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
    certIdcardHash(p2p.id_card)                                                                             userIdcardHash,         --10.用户证件号hash值
    concat(substr(p2p.mobile,1,length(p2p.mobile)-4),"****")                                                userPhone,              --11.用户手机号
    certPhoneHashSalt(p2p.mobile)['phone']                                                                  userPhoneHash,          --12.手机号hash值
    certPhoneHashSalt(p2p.mobile)['salt']                                                                   userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    certIdcardSex(p2p.id_card)                                                                              userSex,                --19.用户性别
    p2p.bank_card                                                                                           userBankAccount,        --20.交易银行卡号
    "",
    ""
from
    (select t.user_id from msc.tmp_report_01_loan_user t 
    where exists (select 1 from msc.tmp_report_01_invest_user b where t.user_id = b.user_id)) t
left join ods.t_acc_p2p_hist p2p
on t.user_id = p2p.owner_id
left join ods.t_user_info_hist u
on t.user_id = u.id

;
--	273804

--出借人
create view msc.tmp_report_01_invest_user
as 
select user_id from odsopr.debt_exchange_account_20190430 where price > 0 and bank_flag = 1 group by user_id 
;

--借款人
create view msc.tmp_report_01_loan_user
as 
select a.user_id from odsopr.debt_exchange_account_20190430 t 
left join odsopr.borrows a 
on a.id = t.bo_id 
where price > 0 and bank_flag = 1
group by a.user_id
;

--既是借款人又是出借人
select t.user_id from msc.tmp_report_01_loan_user t 
where exists (select 1 from msc.tmp_report_01_invest_user b where t.user_id = b.user_id);











/* --如果开户信息为空，出借方
SELECT
    ''                                                                              'version',              --1.接口版本号
    'CERT20190411026'                                                               sourceCode,             --2.平台编号
    cast(u.user_type as string)                                                     userType,               --3.用户类型:0未知，1理财，2贷款，3白领，4微企业主，5学生，6企业主，7VIP企业主 8 企业
    '1-出借方'                                                                      userAttr,               --4.用户属性
    cast(u.register_time as string)                                                 userCreateTime,         --5.用户注册时间
    u.real_name                                                                     userName,               --6.用户姓名/名称
    '-1'                                                                            countries,              --7.国别
    u.card_type                                                                     cardType,               --8.证件类型（01：1A.中国（18位证件号）； 02：身份证（15位）； 03：2.中国（军官证）； 04：中国（台胞证）； 05：3A.中国（护照）； 07：港澳居民通行证； 10：3B.外国（护照）； 20：中国（其他）； 25：社会信用代码； 26：营业执照编号； 27：税务登记证； 28：组织机构代码证； 29：户口簿；）
    cast(if(p2p.id_card is null,u.id_num,p2p.id_card) as string)                    userIdcard,             --9.用户证件号
    certIdcardHash(if(p2p.id_card is null,u.id_num,p2p.id_card))                    userIdcardHash,         --10.用户证件号hash值
    if(p2p.mobile is null,u.mobile_num,p2p.mobile)                                  userPhone,              --11.用户手机号
    certPhoneHashSalt(if(p2p.mobile is null,u.mobile_num,p2p.mobile))['phone']      userPhoneHash,          --12.手机号hash值
    certPhoneHashSalt(if(p2p.mobile is null,u.mobile_num,p2p.mobile))['salt']       userUuid,               --13.用户手机盐值
    '-1'                                                                            userLawperson,          --14.法人代表姓名    
    '-1'                                                                            userFund,               --15.注册资本(万元)
    '-1'                                                                            userProvince,           --16.注册省份
    '-1'                                                                            userAddress,            --17.注册地址
    '-1'                                                                            registerDate,           --18.企业注册时间
    cast(u.gender as string)                                                        userSex,                --19.用户性别
    p2p.bank_card                                                                   userBankAccount         --20.交易银行卡号
from odsopr.debt_exchange_account_20190430 t
left join ods.t_acc_p2p_hist p2p
on t.user_id = p2p.owner_id
left join 
    (select 
        user_id,
        user_type,
        register_time,
        real_name,
        card_type,
        gender,
        concat(substr(id_num,1, length(id_num)-4), "****") id_num,
        concat(substr(mobile_num,1, length(mobile_num)-4), "****") mobile_num
    from
        (SELECT 
            id user_id,
            user_type,
            register_time,
            real_name,
            card_type,
            gender,
            regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num,
            regexp_extract(regexp_replace(mobile_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) mobile_num
        FROM ods.t_user_info_hist
        where status = 1) u
    ) u
on u.user_id = t.user_id
where 1=1
    and u.register_time < '2019-05-01' 
    and t.bank_flag = 1
    and t.price > 0
    and t.user_id not in 
        (SELECT a.user_id from (SELECT user_id from odsopr.debt_exchange_account_20190430 where price > 0) a
        join (SELECT user_id from idw.fact_borrows where bo_all_repayed = 0 and bo_is_success = 1) b
        on a.user_id = b.user_id)
order by userIdcard
;
--借款方
SELECT
    ''                                                                              'version',              --1.接口版本号
    'CERT20190411026'                                                               sourceCode,             --2.平台编号
    cast(u.user_type as string)                                                     userType,               --3.用户类型:0未知，1理财，2贷款，3白领，4微企业主，5学生，6企业主，7VIP企业主 8 企业
    '2-借款方'                                                                      userAttr,               --4.用户属性
    cast(u.register_time as string)                                                 userCreateTime,         --5.用户注册时间
    u.real_name                                                                     userName,               --6.用户姓名/名称
    '-1'                                                                            countries,              --7.国别
    u.card_type                                                                     cardType,               --8.证件类型（01：1A.中国（18位证件号）； 02：身份证（15位）； 03：2.中国（军官证）； 04：中国（台胞证）； 05：3A.中国（护照）； 07：港澳居民通行证； 10：3B.外国（护照）； 20：中国（其他）； 25：社会信用代码； 26：营业执照编号； 27：税务登记证； 28：组织机构代码证； 29：户口簿；）
    cast(if(p2p.id_card is null,u.id_num,p2p.id_card) as string)                    userIdcard,             --9.用户证件号
    certIdcardHash(if(p2p.id_card is null,u.id_num,p2p.id_card))                    userIdcardHash,         --10.用户证件号hash值
    if(p2p.mobile is null,u.mobile_num,p2p.mobile)                                  userPhone,              --11.用户手机号
    certPhoneHashSalt(if(p2p.mobile is null,u.mobile_num,p2p.mobile))['phone']      userPhoneHash,          --12.手机号hash值
    certPhoneHashSalt(if(p2p.mobile is null,u.mobile_num,p2p.mobile))['salt']       userUuid,               --13.用户手机盐值
    '-1'                                                                            userLawperson,          --14.法人代表姓名    
    '-1'                                                                            userFund,               --15.注册资本(万元)
    '-1'                                                                            userProvince,           --16.注册省份
    '-1'                                                                            userAddress,            --17.注册地址
    '-1'                                                                            registerDate,           --18.企业注册时间
    cast(u.gender as string)                                                        userSex,                --19.用户性别
    p2p.bank_card                                                                   userBankAccount         --20.交易银行卡号
from odsopr.debt_exchange_account_20190430 t
left join idw.fact_borrows bo
on bo.bo_id = t.bo_id
left join ods.t_acc_p2p_hist p2p
on bo.user_id = p2p.owner_id
left join 
    (select 
        user_id,
        user_type,
        register_time,
        real_name,
        card_type,
        gender,
        concat(substr(id_num,1, length(id_num)-4), "****") id_num,
        concat(substr(mobile_num,1, length(mobile_num)-4), "****") mobile_num
    from
        (SELECT 
            id user_id,
            user_type,
            register_time,
            real_name,
            card_type,
            gender,
            regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num,
            regexp_extract(regexp_replace(mobile_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) mobile_num
        FROM ods.t_user_info_hist
        where status = 1) u
    ) u
on u.user_id = bo.user_id
where 1=1
    and u.register_time < '2019-05-01' 
    and t.bank_flag = 1
    and t.price > 0
    and bo.user_id not in 
        (SELECT a.user_id from (SELECT user_id from odsopr.debt_exchange_account_20190430 where price > 0) a
        join (SELECT user_id from idw.fact_borrows where bo_all_repayed = 0 and bo_is_success = 1) b
        on a.user_id = b.user_id)
order by userIdcard
;

--3-出借方＋借款方
SELECT
    ''                                                                              'version',              --1.接口版本号
    'CERT20190411026'                                                               sourceCode,             --2.平台编号
    cast(u.user_type as string)                                                     userType,               --3.用户类型:0未知，1理财，2贷款，3白领，4微企业主，5学生，6企业主，7VIP企业主 8 企业
    '3-出借方＋借款方'                                                              userAttr,               --4.用户属性
    cast(u.register_time as string)                                                 userCreateTime,         --5.用户注册时间
    u.real_name                                                                     userName,               --6.用户姓名/名称
    '-1'                                                                            countries,              --7.国别
    u.card_type                                                                     cardType,               --8.证件类型（01：1A.中国（18位证件号）； 02：身份证（15位）； 03：2.中国（军官证）； 04：中国（台胞证）； 05：3A.中国（护照）； 07：港澳居民通行证； 10：3B.外国（护照）； 20：中国（其他）； 25：社会信用代码； 26：营业执照编号； 27：税务登记证； 28：组织机构代码证； 29：户口簿；）
    cast(if(p2p.id_card is null,u.id_num,p2p.id_card) as string)                    userIdcard,             --9.用户证件号
    certIdcardHash(if(p2p.id_card is null,u.id_num,p2p.id_card))                    userIdcardHash,         --10.用户证件号hash值
    if(p2p.mobile is null,u.mobile_num,p2p.mobile)                                  userPhone,              --11.用户手机号
    certPhoneHashSalt(if(p2p.mobile is null,u.mobile_num,p2p.mobile))['phone']      userPhoneHash,          --12.手机号hash值
    certPhoneHashSalt(if(p2p.mobile is null,u.mobile_num,p2p.mobile))['salt']       userUuid,               --13.用户手机盐值
    '-1'                                                                            userLawperson,          --14.法人代表姓名    
    '-1'                                                                            userFund,               --15.注册资本(万元)
    '-1'                                                                            userProvince,           --16.注册省份
    '-1'                                                                            userAddress,            --17.注册地址
    '-1'                                                                            registerDate,           --18.企业注册时间
    cast(u.gender as string)                                                        userSex,                --19.用户性别
    p2p.bank_card                                                                   userBankAccount         --20.交易银行卡号
from odsopr.debt_exchange_account_20190430 t
left join ods.t_acc_p2p_hist p2p
on t.user_id = p2p.owner_id
left join 
    (select 
        user_id,
        user_type,
        register_time,
        real_name,
        card_type,
        gender,
        concat(substr(id_num,1, length(id_num)-4), "****") id_num,
        concat(substr(mobile_num,1, length(mobile_num)-4), "****") mobile_num
    from
        (SELECT 
            id user_id,
            user_type,
            register_time,
            real_name,
            card_type,
            gender,
            regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num,
            regexp_extract(regexp_replace(mobile_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) mobile_num
        FROM ods.t_user_info_hist
        where status = 1) u
    ) u
on u.user_id = t.user_id
where 1=1
    and u.register_time < '2019-05-01' 
    and t.bank_flag = 1
    and t.price > 0
    and t.user_id in 
        (SELECT a.user_id from (SELECT user_id from odsopr.debt_exchange_account_20190430 where price > 0) a
        join (SELECT user_id from idw.fact_borrows where bo_all_repayed = 0 and bo_is_success = 1) b
        on a.user_id = b.user_id)
order by userIdcard
; */