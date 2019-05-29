--原始
createtab_stmt	
CREATE VIEW odsopr.tb_p2p_record_recharge AS SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.version,a.create_time,a.update_time,a.type,a.status,a.order_no,a.record_no,a.trans_no,a.trans_record_no,a.user_id,a.mobile,a.token,a.sms_code,a.amount,a.total_fee,a.provider_fee,a.pay_time,a.account_no,a.bank_card_no,a.bank_card_short_no,a.bank_card_id,a.acc_seq_no,a.user_name,a.return_code,a.return_msg,a.remark,a.bank_code	
FROM ODSOPR.TB_P2P_RECORD_RECHARGE_HIST A	
LEFT JOIN ODSOPR.TB_P2P_RECORD_RECHARGE_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.version,a.create_time,a.update_time,a.type,a.status,a.order_no,a.record_no,a.trans_no,a.trans_record_no,a.user_id,a.mobile,a.token,a.sms_code,a.amount,a.total_fee,a.provider_fee,a.pay_time,a.account_no,a.bank_card_no,a.bank_card_short_no,a.bank_card_id,a.acc_seq_no,a.user_name,a.return_code,a.return_msg,a.remark,a.bank_code	
FROM ODSOPR.TB_P2P_RECORD_RECHARGE_CUR A	





--修改

ALTER VIEW odsopr.tb_p2p_record_recharge 
AS 
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.version,a.create_time,a.update_time,a.type,a.status,a.order_no,a.record_no,a.trans_no,a.trans_record_no,a.user_id
       ,t.mobile_num,a.token,a.sms_code,a.amount,a.total_fee,a.provider_fee,a.pay_time
       ,case
              when length(trim(a.account_no)) = 0
                     or a.account_no    is NULL
                     then ''
                     else CONCAT(substr(trim(a.account_no),1,4), '***********' ,substr(trim(a.account_no),-4,4))
       end account_no
       ,case
              when length(trim(a.bank_card_no)) = 0
                     or a.bank_card_no    is NULL
                     then ''
                     else CONCAT(substr(trim(a.bank_card_no),1,4), '***********' ,substr(trim(a.bank_card_no),-4,4))
       end bank_card_no
       ,a.bank_card_short_no,a.bank_card_id,a.acc_seq_no
       ,t.real_name,a.return_code,a.return_msg,a.remark,a.bank_code	
FROM ODSOPR.TB_P2P_RECORD_RECHARGE_HIST A	
LEFT JOIN ODSOPR.TB_P2P_RECORD_RECHARGE_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
left join ods.t_insensitive_date_hist t 
on t.user_id = a.user_id
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.version,a.create_time,a.update_time,a.type,a.status,a.order_no,a.record_no,a.trans_no,a.trans_record_no,a.user_id
       ,t.mobile_num,a.token,a.sms_code,a.amount,a.total_fee,a.provider_fee,a.pay_time
       ,case
              when length(trim(a.account_no)) = 0
                     or a.account_no    is NULL
                     then ''
                     else CONCAT(substr(trim(a.account_no),1,4), '***********' ,substr(trim(a.account_no),-4,4))
       end account_no
       ,case
              when length(trim(a.bank_card_no)) = 0
                     or a.bank_card_no    is NULL
                     then ''
                     else CONCAT(substr(trim(a.bank_card_no),1,4), '***********' ,substr(trim(a.bank_card_no),-4,4))
       end bank_card_no
       ,a.bank_card_short_no,a.bank_card_id,a.acc_seq_no
       ,t.real_name,a.return_code,a.return_msg,a.remark,a.bank_code	
FROM ODSOPR.TB_P2P_RECORD_RECHARGE_CUR A	
left join ods.t_insensitive_date_hist t 
on t.user_id = a.user_id


