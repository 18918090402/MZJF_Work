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
    date_format(p2p.create_time,'yyyy-MM-dd HH:mm:ss')                                                      userCreateTime,         --5.用户注册时间
    if(length(p2p.name) = 2,concat(substr(p2p.name,1,1),"*"),concat(substr(p2p.name,1,1),"**"))             userName,               --6.用户姓名/名称
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
    p2p.mobile                                                                                              userPhoneHash,          --12.手机号hash值
    p2p.mobile                                                                                              userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    case
        when length(p2p.id_card) = 18 and substr(p2p.id_card,17,1) in ('1','3','5','7','9') then '1'
        when length(p2p.id_card) = 18 and substr(p2p.id_card,17,1) in ('2','4','6','8','0') then '0'
        when length(p2p.id_card) = 15 and substr(p2p.id_card,15,1) in ('1','3','5','7','9') then '1'
        when length(p2p.id_card) = 15 and substr(p2p.id_card,15,1) in ('2','4','6','8','0') then '0'
        else '1' end                                                                                        userSex,                --19.用户性别
    if(p2p.bank_card is null,'-1',p2p.bank_card)                                                            userBankAccount,        --20.交易银行卡号
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
    if(p2p.account_type = 'user' or p2p.account_type is null,'1','2')                                       userType,               --3.用户类型
    '2'                                                                                                     userAttr,               --4.用户属性
    date_format(coalesce(p2p.create_time,u.register_time),'yyyy-MM-dd HH:mm:ss')                            userCreateTime,         --5.用户注册时间
    coalesce(p2p.name,u.real_name)                                                                          userName,               --6.用户姓名/名称                                                                                            userName,               --6.用户姓名/名称
    '-1'                                                                                                    countries,              --7.国别
    case 
        when u.card_type = '01' then '1'
        when u.card_type = '04' then '4'
        when u.card_type in ('05','10') then '2'
        when u.card_type = '07' then '5'
        when u.card_type = '25' then '7'
        end                                                                                                 cardType,               --8.证件类型（01：1A.中国（18位证件号）； 02：身份证（15位）； 03：2.中国（军官证）； 04：中国（台胞证）； 05：3A.中国（护照）； 07：港澳居民通行证； 10：3B.外国（护照）； 20：中国（其他）； 25：社会信用代码； 26：营业执照编号； 27：税务登记证； 28：组织机构代码证； 29：户口簿；）
    concat(substr(coalesce(p2p.id_card,u.id_num),1,length(coalesce(p2p.id_card,u.id_num))-4),"****")        userIdcard,             --9.用户证件号
    certIdcardHash(coalesce(p2p.id_card,u.id_num))                                                          userIdcardHash,         --10.用户证件号hash值
    concat(substr(coalesce(p2p.mobile,u.mobile_num),1,length(coalesce(p2p.mobile,u.mobile_num))-4),"****")  userPhone,              --11.用户手机号
    coalesce(p2p.mobile,u.mobile_num)                                                                       userPhoneHash,          --12.手机号hash值
    coalesce(p2p.mobile,u.mobile_num)                                                                       userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    case
        when length(coalesce(p2p.id_card,u.id_num)) = 18 and substr(coalesce(p2p.id_card,u.id_num),17,1) in ('1','3','5','7','9') then '1'
        when length(coalesce(p2p.id_card,u.id_num)) = 18 and substr(coalesce(p2p.id_card,u.id_num),17,1) in ('2','4','6','8','0') then '0'
        when length(coalesce(p2p.id_card,u.id_num)) = 15 and substr(coalesce(p2p.id_card,u.id_num),15,1) in ('1','3','5','7','9') then '1'
        when length(coalesce(p2p.id_card,u.id_num)) = 15 and substr(coalesce(p2p.id_card,u.id_num),15,1) in ('2','4','6','8','0') then '0'
        else '1' end                                                                                        userSex,                --19.用户性别
    if(p2p.bank_card is null,'-1',p2p.bank_card)                                                            userBankAccount,        --20.交易银行卡号
    "",
    ""
from 
    (select t.user_id from msc.tmp_report_01_loan_user t 
    where not exists (select 1 from msc.tmp_report_01_invest_user b where t.user_id = b.user_id)) t
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
    '3'                                                                                                     userAttr,               --4.用户属性
    date_format(p2p.create_time,'yyyy-MM-dd HH:mm:ss')                                                      userCreateTime,         --5.用户注册时间
    if(length(p2p.name) = 2,concat(substr(p2p.name,1,1),"*"),concat(substr(p2p.name,1,1),"**"))             userName,               --6.用户姓名/名称
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
    p2p.mobile                                                                                              userPhoneHash,          --12.手机号hash值
    p2p.mobile                                                                                              userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    case
        when length(p2p.id_card) = 18 and substr(p2p.id_card,17,1) in ('1','3','5','7','9') then '1'
        when length(p2p.id_card) = 18 and substr(p2p.id_card,17,1) in ('2','4','6','8','0') then '0'
        when length(p2p.id_card) = 15 and substr(p2p.id_card,15,1) in ('1','3','5','7','9') then '1'
        when length(p2p.id_card) = 15 and substr(p2p.id_card,15,1) in ('2','4','6','8','0') then '0'
        else '1' end                                                                                        userSex,                --19.用户性别
    if(p2p.bank_card is null,'-1',p2p.bank_card)                                                            userBankAccount,        --20.交易银行卡号
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
    date_format(p2p.create_time,'yyyy-MM-dd HH:mm:ss')                                                      userCreateTime,         --5.用户注册时间
    if(length(p2p.name) = 2,concat(substr(p2p.name,1,1),"*"),concat(substr(p2p.name,1,1),"**"))             userName,               --6.用户姓名/名称
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
    p2p.mobile                                                                                              userPhoneHash,          --12.手机号hash值
    p2p.mobile                                                                                              userUuid,               --13.用户手机盐值
    '-1'                                                                                                    userLawperson,          --14.法人代表姓名    
    '-1'                                                                                                    userFund,               --15.注册资本(万元)
    '-1'                                                                                                    userProvince,           --16.注册省份
    '-1'                                                                                                    userAddress,            --17.注册地址
    '-1'                                                                                                    registerDate,           --18.企业注册时间
    case
        when length(p2p.id_card) = 18 and substr(p2p.id_card,17,1) in ('1','3','5','7','9') then '1'
        when length(p2p.id_card) = 18 and substr(p2p.id_card,17,1) in ('2','4','6','8','0') then '0'
        when length(p2p.id_card) = 15 and substr(p2p.id_card,15,1) in ('1','3','5','7','9') then '1'
        when length(p2p.id_card) = 15 and substr(p2p.id_card,15,1) in ('2','4','6','8','0') then '0'
        else '1' end                                                                                        userSex,                --19.用户性别
    if(p2p.bank_card is null,'-1',p2p.bank_card)                                                            userBankAccount,        --20.交易银行卡号
    "",
    ""
from 
    (select * from msc.tmp_acc_p2p_20190507 
    where account_type = 'user' and owner_id not in (1060684,29345427,29454600,29455040,29710510,29739268,29785949,29785951)) p2p
left join
    (
	select user_id from msc.tmp_report_01_loan_user
	union all
    select user_id from msc.tmp_report_01_invest_user) li
on p2p.owner_id = li.user_id
left join ods.t_user_info_hist u
on p2p.owner_id = u.id
where li.user_id is null

UNION all

SELECT
    ""                                                                                                      version,                --1.接口版本号
    'CERT20190411026'                                                                                       sourceCode,             --2.平台编号
    '2'                                                                                                     userType,               --3.用户类型
    qy.user_attr                                                                                            userAttr,               --4.用户属性
    date_format(qy.r_time,'yyyy-MM-dd HH:mm:ss')                                                            userCreateTime,         --5.用户注册时间
    qy.corp_name                                                                                            userName,               --6.用户姓名/名称
    '-1'                                                                                                    countries,              --7.国别
    '7'                                                                                                     cardType,               --8.证件类型（01：1A.中国（18位证件号）； 02：身份证（15位）； 03：2.中国（军官证）； 04：中国（台胞证）； 05：3A.中国（护照）； 07：港澳居民通行证； 10：3B.外国（护照）； 20：中国（其他）； 25：社会信用代码； 26：营业执照编号； 27：税务登记证； 28：组织机构代码证； 29：户口簿；）
    qy.code                                                                                                 userIdcard,             --9.用户证件号
    certIdcardHash(qy.code)                                                                                 userIdcardHash,         --10.用户证件号hash值
    concat(substr(qy.mobile_num,1,length(qy.mobile_num)-4),"****")                                          userPhone,              --11.用户手机号
    qy.mobile_num                                                                                           userPhoneHash,          --12.手机号hash值
    qy.mobile_num                                                                                           userUuid,               --13.用户手机盐值
    qy.real_name                                                                                            userLawperson,          --14.法人代表姓名    
    qy.ziben                                                                                                userFund,               --15.注册资本(万元)
    certCompanyAscription(qy.code)                                                                          userProvince,           --16.注册省份
    qy.address                                                                                              userAddress,            --17.注册地址
    date_format(qy.r_time,'yyyy-MM-dd HH:mm:ss')                                                            registerDate,           --18.企业注册时间
    '-1'                                                                                                    userSex,                --19.用户性别
    if(qy.bankcardno is null,'-1',qy.bankcardno)                                                            userBankAccount,        --20.交易银行卡号
    "",
    ""
from msc.qiye20190521 qy
;
--2348143


--出借人
create table msc.tmp_report_01_invest_user
as 
	select distinct user_id from odsopr.debt_exchange_account_20190430
	where 1=1
		and bank_flag = 1 
		and price >= 0.01  
        and status in (1,2,3)
		and bo_id in (select cast(sourceproductcode as int) from pdw.report_02_scatterinvest)
		and user_id not in (1060684,29345427,29454600,29455040,29710510,29739268,29785949,29785951)
;

--35391

--借款人
create table msc.tmp_report_01_loan_user
as 
    select distinct bo.user_id
    from pdw.report_02_scatterinvest p
    left join idw.fact_borrows bo
    on cast(p.sourceProductCode as int) = bo.bo_id
    where user_id not in (1060684,29345427,29454600,29455040,29710510,29739268,29785949,29785951)
    ;

--237795

--既是借款人又是出借人
select t.user_id from msc.tmp_report_01_loan_user t 
where exists (select 1 from msc.tmp_report_01_invest_user b where t.user_id = b.user_id);

--64



SELECT * from msc.tmp_acc_p2p_20190507 where id = 1860427;	230106830930324;

SELECT * from ods.t_acc_p2p_hist where id = 1860427;







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