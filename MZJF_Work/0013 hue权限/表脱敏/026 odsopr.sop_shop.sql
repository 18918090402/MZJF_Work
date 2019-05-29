--原始
createtab_stmt	
CREATE VIEW odsopr.sop_shop AS SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.username,a.password,a.shop_no,a.name,a.county_code,a.address,a.company_type,a.licence_no,a.licence_url,a.orgination_no,a.orgination_url,a.tax_no,a.tax_url,a.link_man,a.link_man_mobile,a.permit_no,a.permit_file,a.end_date,a.shop_start_date,a.regist_capital,a.business_scope,a.regist_county_code,a.regist_address,a.control_man_id_card,a.control_man_id_card_file,a.house_rent_file,a.legal_id_card,a.legal_id_card_url,a.part_type,a.shop_status,a.shop_status3_time,a.shop_status5_time,a.paper_contract,a.shop_level,a.is_run_risk,a.deposit_scale,a.run_risk_remark	
FROM ODSOPR.SOP_SHOP_HIST A	
LEFT JOIN ODSOPR.SOP_SHOP_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.username,a.password,a.shop_no,a.name,a.county_code,a.address,a.company_type,a.licence_no,a.licence_url,a.orgination_no,a.orgination_url,a.tax_no,a.tax_url,a.link_man,a.link_man_mobile,a.permit_no,a.permit_file,a.end_date,a.shop_start_date,a.regist_capital,a.business_scope,a.regist_county_code,a.regist_address,a.control_man_id_card,a.control_man_id_card_file,a.house_rent_file,a.legal_id_card,a.legal_id_card_url,a.part_type,a.shop_status,a.shop_status3_time,a.shop_status5_time,a.paper_contract,a.shop_level,a.is_run_risk,a.deposit_scale,a.run_risk_remark	
FROM ODSOPR.SOP_SHOP_CUR A	




-修改
ALTER VIEW odsopr.sop_shop 
AS 
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.username,a.password,a.shop_no,'' name,a.county_code,a.address,a.company_type,a.licence_no,'' licence_url,a.orgination_no,'' orgination_url,a.tax_no,'' tax_url,'' link_man,'' link_man_mobile,a.permit_no,a.permit_file,a.end_date,a.shop_start_date,a.regist_capital,a.business_scope,a.regist_county_code,a.regist_address,'' control_man_id_card,'' control_man_id_card_file,'' house_rent_file,a.legal_id_card,'' legal_id_card_url,a.part_type,a.shop_status,a.shop_status3_time,a.shop_status5_time,a.paper_contract,a.shop_level,a.is_run_risk,a.deposit_scale,a.run_risk_remark	
FROM ODSOPR.SOP_SHOP_HIST A	
LEFT JOIN ODSOPR.SOP_SHOP_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.username,a.password,a.shop_no,'' name,a.county_code,a.address,a.company_type,a.licence_no,'' licence_url,a.orgination_no,'' orgination_url,a.tax_no,'' tax_url,'' link_man,'' link_man_mobile,a.permit_no,a.permit_file,a.end_date,a.shop_start_date,a.regist_capital,a.business_scope,a.regist_county_code,a.regist_address,'' control_man_id_card,'' control_man_id_card_file,'' house_rent_file,a.legal_id_card,'' legal_id_card_url,a.part_type,a.shop_status,a.shop_status3_time,a.shop_status5_time,a.paper_contract,a.shop_level,a.is_run_risk,a.deposit_scale,a.run_risk_remark	
FROM ODSOPR.SOP_SHOP_CUR A	
