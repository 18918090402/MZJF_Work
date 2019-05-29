--原始
createtab_stmt	
CREATE VIEW odsopr.sop_shop_face AS SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.username,a.password,a.face_no,a.name,a.shop_id,a.status,a.address,a.mobile,a.fax,a.link_man,a.link_man_mobile,a.payment_note	
FROM ODSOPR.SOP_SHOP_FACE_HIST A	
LEFT JOIN ODSOPR.SOP_SHOP_FACE_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.username,a.password,a.face_no,a.name,a.shop_id,a.status,a.address,a.mobile,a.fax,a.link_man,a.link_man_mobile,a.payment_note	
FROM ODSOPR.SOP_SHOP_FACE_CUR A	




--修改

ALTER VIEW odsopr.sop_shop_face 
AS 
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.username,a.password,a.face_no,'' name,a.shop_id,a.status,a.address,'' mobile,a.fax,'' link_man,'' link_man_mobile,a.payment_note	
FROM ODSOPR.SOP_SHOP_FACE_HIST A	
LEFT JOIN ODSOPR.SOP_SHOP_FACE_CUR B 	
ON a.id= b.id AND a.id = b.id AND a.id = b.id	
WHERE b.id IS NULL AND b.id IS NULL AND b.id IS NULL	
UNION ALL	
SELECT  a.dw_create_by , a.dw_create_time , a.dw_update_by , a.dw_update_time  ,a.id,a.disabled,a.uuid,a.create_user,a.create_time,a.update_user,a.update_time,a.remark,a.username,a.password,a.face_no,'' name,a.shop_id,a.status,a.address,'' mobile,a.fax,'' link_man,'' link_man_mobile,a.payment_note	
FROM ODSOPR.SOP_SHOP_FACE_CUR A	



