DELIMITER $$

USE `risk`$$

DROP PROCEDURE IF EXISTS `SP_FACT_APPROVAL`$$

CREATE DEFINER=`risk`@`%` PROCEDURE `SP_FACT_APPROVAL`()
BEGIN
DECLARE t1 DATETIME;
DECLARE t2 DATETIME;
DECLARE t DATETIME;
SET t1=DATE_ADD(DATE(SYSDATE()),INTERVAL -12 DAY);
SET t2=CURDATE();
SET t=t1;
WHILE (t<t2)
DO 
DELETE FROM FACT_APPROVAL WHERE process_begin_time>=t AND process_begin_time<DATE_ADD(t,INTERVAL 1 DAY);
INSERT INTO FACT_APPROVAL
SELECT bo.id apply_no,p.p_name product,bo.publish_time  process_begin_time,"提交申请" process_name,NULL process_end_time
FROM db_nono.borrows bo 
LEFT JOIN db_nono.products p ON p.id=bo.p_id
WHERE 1=1
AND bo.publish_time>=t
AND bo.publish_time<DATE_ADD(t,INTERVAL 1 DAY)

UNION ALL
SELECT ba.bo_id,p.p_name product,ba.create_time process_begin_time,"提交视频" process_name,NULL process_end_time
FROM db_nono.borrows_archive ba 
JOIN db_nono.borrows bo  ON bo.id=ba.bo_id
LEFT JOIN db_nono.products p ON p.id=bo.p_id
WHERE 1=1
AND ba.create_time>=t
AND ba.create_time<DATE_ADD(t,INTERVAL 1 DAY)

UNION ALL
SELECT ba.bo_id,p.p_name product,am_audit_time process_begin_time,"初审分配" process_name,NULL process_end_time
FROM db_nono.borrows_archive ba 
JOIN db_nono.borrows bo  ON bo.id=ba.bo_id
LEFT JOIN db_nono.products p ON p.id=bo.p_id
WHERE 1=1
AND ba.create_time>=DATE_ADD(t,INTERVAL -3 DAY)
AND am_audit_time>=t
AND am_audit_time<DATE_ADD(t,INTERVAL 1 DAY)

UNION ALL
SELECT bo.id,p.p_name product,awr.create_time process_begin_time,awr.title process_name,NULL process_end_time
FROM db_nono.admin_work_remark awr
JOIN db_nono.borrows bo  ON bo.id=awr.bo_id
LEFT JOIN db_nono.products p ON p.id=bo.p_id
WHERE 1=1
AND awr.create_time>=t
AND awr.create_time<DATE_ADD(t,INTERVAL 1 DAY)

UNION ALL
SELECT bo.id apply_no,p.p_name product,bo.bo_agree_time  process_begin_time,"签约完成" process_name,NULL process_end_time
FROM db_nono.borrows bo 
LEFT JOIN db_nono.products p ON p.id=bo.p_id
WHERE 1=1
AND bo.bo_agree_time>=t
AND bo.bo_agree_time<DATE_ADD(t,INTERVAL 1 DAY)

;
SET t=DATE_ADD(t,INTERVAL  1 DAY);
END WHILE;
END$$

DELIMITER ;