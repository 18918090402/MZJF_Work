--原始
createtab_stmt	
CREATE VIEW `odsopr.invt_settle_log_hist` AS SELECT `a`.`dw_create_by`, `a`.`dw_create_time`, `a`.`dw_update_by`, `a`.`dw_update_time`, `a`.`id`, `a`.`trans_id`, `a`.`credential`, `a`.`purchase_trans_id`, `a`.`proof_id`, `a`.`qf_id`, `a`.`qfd_id`, `a`.`user_id`, `a`.`fp_id`, `a`.`va_id`, `a`.`user_name`, `a`.`mobile_num`, `a`.`lack_capital`, `a`.`lack_profit`, `a`.`lack_coupon_profit`, `a`.`amount`, `a`.`profit`, `a`.`coupon_profit`, `a`.`status`, `a`.`coupon_list`, `a`.`channel_id`, `a`.`system_id`, `a`.`version`, `a`.`create_time`, `a`.`update_time`, `a`.`lock_amount`, `a`.`lack_remain_profit`, `a`.`remain_profit` FROM `ODS`.`T_INVT_SETTLE_LOG_HIST` `A`	

    
--修改    
ALTER VIEW odsopr.invt_settle_log_hist 
AS 
SELECT a.dw_create_by, a.dw_create_time, a.dw_update_by, a.dw_update_time, a.id, a.trans_id, a.credential, a.purchase_trans_id, a.proof_id, a.qf_id, a.qfd_id, a.user_id, a.fp_id, a.va_id
       , '' user_name
       , '' mobile_num
       , a.lack_capital, a.lack_profit, a.lack_coupon_profit, a.amount, a.profit, a.coupon_profit, a.status, a.coupon_list, a.channel_id, a.system_id, a.version, a.create_time, a.update_time, a.lock_amount, a.lack_remain_profit, a.remain_profit 
FROM ODS.T_INVT_SETTLE_LOG_HIST A	
