--用户姓名脱敏
SELECT
	user_id,
	user_name,
	real_name,
	case 
	    when length(regexp_replace(real_name,'\\w','')) = 0 or real_name is NULL then '未知'                      --real_name为NULL or 非汉字
	    when length(regexp_replace(real_name,'\\w','')) = 3 then real_name                                        --real_name有1个字
	    when length(regexp_replace(real_name,'\\w','')) = 6 then replace(real_name, substr(real_name,4), '*')     --real_name有2个字
	    when length(regexp_replace(real_name,'\\w','')) = 9 then replace(real_name, substr(real_name,4,length(real_name)-3*2), '*')  --real_name有3个字
	    when length(regexp_replace(real_name,'\\w','')) > 9 and real_name like '%公司%' then replace(real_name, substr(real_name,4,length(real_name)-3*3), '*******')
        when length(regexp_replace(real_name,'\\w','')) > 9 then replace(real_name, substr(real_name,4,length(real_name)-3*2), '*')
	end real_name1
from idw.dim_user  
where length(trim(real_name))  > 9 and real_name like '%公司%'
limit 50 ; 




--身份证脱敏
SELECT
	user_id,
	id_num,
	case 
	    when length(trim(id_num)) = 0 or id_num is NULL then '未知'
        when length(trim(id_num)) = 9 then CONCAT(STRLEFT(trim(id_num),2), '*****' ,STRRIGHT(trim(id_num),2))
	    when length(trim(id_num)) = 15 then CONCAT(STRLEFT(trim(id_num),3), '*********' ,STRRIGHT(trim(id_num),3))
	    when length(trim(id_num)) = 18 then CONCAT(STRLEFT(trim(id_num),3), '***********' ,STRRIGHT(trim(id_num),4))
	end id_num1
from idw.dim_user  
limit 20 ; 



--email脱敏
SELECT
	user_id,
	email,
	case 
	    when length(trim(email)) = 0 or email is NULL then '未知'
	    when length(trim(email)) > 0 then replace(email, substr(regexp_extract(email, '@.*', 0),2), '*')
	end email1
from idw.dim_user  where 
limit 20 ; 


--银行卡
SELECT  owner_id,
        bank_card,
    	case 
    	    when length(trim(bank_card)) = 0 or bank_card is NULL then '未知'
    	    else CONCAT(STRLEFT(trim(bank_card),4), '***********' ,STRRIGHT(trim(bank_card),4))
    	end bank_card1
from odsopr.acc_p2p
LIMIT 20
;

--手机号
SELECT  owner_id,
        mobile,
    	case 
    	    when length(trim(mobile)) = 0 or mobile is NULL then '未知'
    	    else CONCAT(STRLEFT(trim(mobile),3), '****' ,STRRIGHT(trim(mobile),4))
    	end mobile1 
from odsopr.acc_p2p
LIMIT 20
;

