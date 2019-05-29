--hist 原始

ALTER VIEW odsopr.acc_p2p_hist AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.owner_id, a.account_no, a.status, a.status_code, a.currency, a.balance, a.freeze_amount, a.mobile, a.bank_card, a.id_card, a.name, a.version, a.create_time, a.update_time, a.bid_agreement_no, a.debt_agreement_no, a.account_type, a.cnaps_code, a.agreement_expire_date, a.agreement_max_amount FROM ODS.T_ACC_P2P_HIST A



--cur 原始

CREATE VIEW odsopr.acc_p2p_cur AS SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.owner_id, a.account_no, a.status, a.status_code, a.currency, a.balance, a.freeze_amount, a.mobile, a.bank_card, a.id_card, a.name, a.version, a.create_time, a.update_time, a.bid_agreement_no, a.debt_agreement_no, a.account_type, a.cnaps_code, a.agreement_expire_date, a.agreement_max_amount, a.p_run_id FROM ODS.T_ACC_P2P_CUR A	
    WHERE a.p_run_id = 292662	



-- 原始

ALTER VIEW odsopr.acc_p2p AS SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.owner_id,a.account_no,a.status,a.status_code,a.currency,a.balance,a.freeze_amount,a.mobile,a.bank_card,a.id_card,a.name,a.version,a.create_time,a.update_time,a.bid_agreement_no,a.debt_agreement_no,a.account_type,a.cnaps_code,a.agreement_expire_date,a.agreement_max_amount	
FROM ODSOPR.ACC_P2P_HIST A	
LEFT JOIN ODSOPR.ACC_P2P_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.owner_id,a.account_no,a.status,a.status_code,a.currency,a.balance,a.freeze_amount,a.mobile,a.bank_card,a.id_card,a.name,a.version,a.create_time,a.update_time,a.bid_agreement_no,a.debt_agreement_no,a.account_type,a.cnaps_code,a.agreement_expire_date,a.agreement_max_amount	
FROM ODSOPR.ACC_P2P_CUR A	




--
ALTER VIEW odsopr.acc_p2p_hist AS
SELECT
       a.dw_create_by
       , a.dw_create_time
       , a.dw_update_by
       , a.dw_update_time
       , a.id
       , a.owner_id
       , case
              when length(trim(a.account_no)) = 0
                     or a.account_no    is NULL
                     then ''
                     else CONCAT(substr(trim(a.account_no),1,4), '***********' ,substr(trim(a.account_no),-4,4))
       end account_no
       , a.status
       , a.status_code
       , a.currency
       , a.balance
       , a.freeze_amount
       , case
              when length(trim(a.mobile)) = 0
                     or a.mobile    is NULL
                     then ''
                     else CONCAT(substr(trim(a.mobile),1,3), '****' ,substr(trim(a.mobile),-4,4))
       end mobile
       , case
              when length(trim(a.bank_card)) = 0
                     or a.bank_card    is NULL
                     then ''
                     else CONCAT(substr(trim(a.bank_card),1,4), '***********' ,substr(trim(a.bank_card),-4,4))
       end bank_card
       , case
              when length(trim(a.id_card)) = 0
                     or a.id_card    is NULL
                     then ''
              when length(trim(a.id_card)) = 15
                     then CONCAT(substr(trim(a.id_card),1,3), '*********' ,substr(trim(a.id_card),-3,3))
              when length(trim(a.id_card)) = 18
                     then CONCAT(substr(trim(a.id_card),1,3), '***********' ,substr(trim(a.id_card),-4,4))
              when length(trim(a.id_card)) = 9
                     then CONCAT(substr(trim(a.id_card),1,3), '***********' ,substr(trim(a.id_card),-3,3))
       end id_card
       ,case
            when length(trim(a.name)) = 0
                 or a.name    is NULL
                 then ''
            when length('中') = 1 and length(trim(a.name)) = 1
                 then a.name
            when length('中') = 1 and length(trim(a.name)) = 2
                 then CONCAT(substr(regexp_replace(a.name,'\[\-\·\)\_1\]\+',''),1,1) ,'*')
            when length('中') = 1 and length(trim(a.name)) = 3
                 then CONCAT(substr(regexp_replace(a.name,'\[\-\·\)\_1\]\+',''),1,1) ,'*' ,substr(trim(regexp_replace(a.name,'\[\-\·\)\_1\]\+','')),-1))
            when length('中') = 1 and length(trim(a.name)) > 3
                 then
                 case
                    when a.name like '%公司'
                        then CONCAT(substr(regexp_replace(a.name,'\[\-\·\)\_1\]\+',''),1,1) ,'*' ,substr(trim(regexp_replace(a.name,'\[\-\·\)\_1\]\+','')),-2))
                        else CONCAT(substr(regexp_replace(a.name,'\[\-\·\)\_1\]\+',''),1,1) ,'*' ,substr(trim(regexp_replace(a.name,'\[\-\·\)\_1\]\+','')),-1))
                 end
            when length('中') = 3 and length(trim(a.name)) = 3
                 then a.name
            when length('中') = 3 and length(trim(a.name)) = 6
                 then CONCAT(substr(regexp_replace(a.name,'\[\-\·\)\_1\]\+',''),1,3) ,'*')
            when length('中') = 3 and length(trim(a.name)) = 6
                 then CONCAT(substr(regexp_replace(a.name,'\[\-\·\)\_1\]\+',''),1,3) ,'*' ,substr(trim(regexp_replace(a.name,'\[\-\·\)\_1\]\+','')),-3))
            when length('中') = 3 and length(trim(a.name)) > 6
                 then
                 case
                    when a.name like '%公司'
                        then CONCAT(substr(regexp_replace(a.name,'\[\-\·\)\_1\]\+',''),1,3) ,'*' ,substr(trim(regexp_replace(a.name,'\[\-\·\)\_1\]\+','')),-6))
                        else CONCAT(substr(regexp_replace(a.name,'\[\-\·\)\_1\]\+',''),1,3) ,'*' ,substr(trim(regexp_replace(a.name,'\[\-\·\)\_1\]\+','')),-3))
                 end                 
        end name
       , a.version
       , a.create_time
       , a.update_time
       , a.bid_agreement_no
       , a.debt_agreement_no
       , a.account_type
       , a.cnaps_code
       , a.agreement_expire_date
       , a.agreement_max_amount
FROM
       ODS.T_ACC_P2P_HIST a
;
