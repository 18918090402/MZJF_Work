SELECT
                                                                                    'version',              --1.接口版本号
                                                                                    sourceCode,             --2.平台编号
    u.user_type                                                                     userType,               --3.用户类型:0未知，1理财，2贷款，3白领，4微企业主，5学生，6企业主，7VIP企业主 8 企业
                                                                                    userAttr,               --4.用户属性
    u.register_time                                                                 userCreateTime,         --5.用户注册时间
    u.real_name                                                                     userName,               --6.用户姓名/名称
    '-1'                                                                            countries,              --7.国别
    u.card_type                                                                     cardType,               --8.证件类型（01：1A.中国（18位证件号）； 02：身份证（15位）； 03：2.中国（军官证）； 04：中国（台胞证）； 05：3A.中国（护照）； 07：港澳居民通行证； 10：3B.外国（护照）； 20：中国（其他）； 25：社会信用代码； 26：营业执照编号； 27：税务登记证； 28：组织机构代码证； 29：户口簿；）
    concat(substr(u.id_num_n,1,length(u.id_num_n)-4), "****")                       userIdcard,             --9.用户证件号
                                                                                    userIdcardHash,         --10.用户证件号hash值
    concat(substr(u.mobile_num_n,1,length(u.mobile_num_n)-4), "****")               userPhone,              --11.用户手机号
                                                                                    userPhoneHash,          --12.手机号hash值
                                                                                    userUuid,               --13.用户手机盐值
    '-1'                                                                            userLawperson,          --14.法人代表姓名    
    '-1'                                                                            userFund,               --15.注册资本(万元)
    '-1'                                                                            userProvince,           --16.注册省份
    '-1'                                                                            userAddress,            --17.注册地址
    '-1'                                                                            registerDate,           --18.企业注册时间
    u.gender                                                                        userSex,                --19.用户性别
    ub.bank_card_no                                                                 userBankAccount         --20.交易银行卡号
from 
    (
    SELECT 
        u.*,
        regexp_extract(regexp_replace(id_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) id_num_n,
        regexp_extract(regexp_replace(mobile_num, ' ', ''), '^[\s\n\t]*([0-9]+[xX]?)[_\-]?[0-9]?[\s\n\t]*$', 1) mobile_num_n
    FROM ods.t_user_info_hist u where status = 1 
    ) u
left join 
    (select * 
    from 
        (select ubi.*, row_number() over(partition by ubi.user_id order by ubi.update_time desc ) rn 
        from ods.t_user_bankcard_info_hist ubi  ) a where a.rn = 1) ub
on ub.user_id = u.id 
where u.register_time < '2019-05-01'
order by userIdcard
;
--	11477446
                                                                                        

 


1. 从acc_p2p中取手机号、id_num,银行卡号 
2. 6个企业用户是否要手工插入

