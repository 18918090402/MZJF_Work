DELIMITER $$

USE `risk`$$

DROP PROCEDURE IF EXISTS `SP_FACT_LOAN_AFTER_STATIC_MONTHLY`$$

CREATE DEFINER=`risk`@`%` PROCEDURE `SP_FACT_LOAN_AFTER_STATIC_MONTHLY`()
BEGIN
DECLARE t DATETIME;
DECLARE t1 DATETIME;
DECLARE t2 DATETIME;
SET t1=DATE_FORMAT(DATE_ADD(DATE(SYSDATE()) ,INTERVAL  -DAY(DATE(SYSDATE()))+1 DAY), '%Y-%m-%d');
SET t2=DATE_ADD(DATE_FORMAT(DATE_ADD(DATE(SYSDATE()) ,INTERVAL  -DAY(DATE(SYSDATE()))+1 DAY), '%Y-%m-%d'),INTERVAL 1 MONTH) ;

SET t=t1;
WHILE (t<t2)
DO

INSERT INTO FACT_LOAN_AFTER_STATIC_MONTHLY_01_Temp
SELECT 
  br.id br_id,
  br.br_time,
  br.bo_id,
  br.br_expect_num,
  br.br_overdue_terms,
  br.br_price_b,
  IF(
    br.br_overdue_terms = 1,
    br.br_price_b,
    NULL
  ) br_price_b_lc,
  NOW() create_time,
  NOW() update_time 
FROM
  db_nono.borrows_repayment br 
  LEFT JOIN risk.FACT_LOAN_AFTER_STATIC_MONTHLY_01_Temp rt 
    ON rt.br_id = br.id 
WHERE br.br_overdue_terms > 0 
  AND br.br_time < CURDATE() 
  AND rt.br_id IS NULL ;
  
  
  
UPDATE 
  FACT_LOAN_AFTER_STATIC_MONTHLY_01_Temp aa 
  JOIN 
    (SELECT 
      a.br_id,
      SUM(b.br_price_b) br_price_b_lc 
    FROM
      FACT_LOAN_AFTER_STATIC_MONTHLY_01_Temp a 
      JOIN FACT_LOAN_AFTER_STATIC_MONTHLY_01_Temp b 
        ON a.bo_id = b.bo_id 
        AND b.br_expect_num >= a.br_expect_num - a.br_overdue_terms + 1 
        AND b.br_expect_num <= a.br_expect_num 
    WHERE a.br_price_b_lc IS NULL 
    GROUP BY 1) bb 
    ON aa.br_id = bb.br_id SET aa.br_price_b_lc = bb.br_price_b_lc ;
DELETE FROM FACT_LOAN_AFTER_STATIC_MONTHLY_01 WHERE remain_date=t;
INSERT INTO FACT_LOAN_AFTER_STATIC_MONTHLY_01
SELECT 
  bo.id,
  bo.user_id,
  bo.bo_audit_time,
  bo.bo_agree_time,
  bo.bo_finish_price,
  DATE(t) remain_date,
  DATE_ADD(t, INTERVAL - 1 MONTH) belong_date,
  
  SUM(
    IF(
      br.br_is_repay = 1 
      AND br.br_repay_time < t,
      br.br_price_b,
      0
    )
  ) repay_b, 
  
  SUM(
    IF(
      br.br_is_repay = 1 
      AND br.br_repay_time < t,
      1,
      0
    )
  ) repay_cnt, 
  
  SUM(
    IF(
      br.br_is_repay = 1 
      AND br.br_repay_time < t 
      AND br.br_overdue_terms > 0,
      br.br_price_b,
      0
    )
  ) repay_overdue_b , 
    
  SUM(
    IF(
      br.br_is_repay = 1 
      AND br.br_repay_time < t 
      AND br.br_overdue_terms > 0,
      1,
      0
    )
  ) repay_overdue_cnt , 
  
  SUM(
    IF(
      br.br_is_repay = 0 
      OR br.br_repay_time >= t,
      br.br_price_b,
      0
    )
  ) unrepay_b, 
  SUM(
    IF(
      br.br_is_repay = 0 
      OR br.br_repay_time >= t,
      1,
      0
    )
  ) unrepay_cnt, 
  SUM(
    IF(
      br.br_is_repay = 0 
      OR br.br_repay_time >= t,
      br.br_price,
      0
    )
  ) unrepay_bx, 
  
  
  SUM(
    IF(
      br.br_is_repay = 0 
      OR br.br_repay_time >= t 
      AND br.br_time < DATE_ADD(t, INTERVAL - 1 DAY)  
      AND br.br_overdue_terms > 0,
      br.br_price_punish,
      0
    )
  ) unrepay_punish 
  ,
  SUM(
    IF(
      (
        br.br_is_repay = 0 
        OR br.br_repay_time >= t
      ) 
      AND br.br_overdue_terms > 0 
      AND br.br_time < DATE_ADD(t, INTERVAL - 1 DAY), 
      br.br_price_b,
      0
    )
  ) unrepay_overdue_b, 
  SUM(
    IF(
      (
        br.br_is_repay = 0 
        OR br.br_repay_time >= t
      ) 
      AND br.br_overdue_terms > 0 
      AND br.br_time < DATE_ADD(t, INTERVAL - 1 DAY), 
      1,
      0
    )
  ) unrepay_overdue_cnt,  
  SUM(
    IF(
      br.br_overdue_terms > 0 
      AND br.br_time < DATE_ADD(t, INTERVAL - 1 DAY), 
      1,
      0
    )
  ) overdue_cnt,  
  MAX(
    CASE
      WHEN br.br_overdue_terms > 0 
      AND br.br_time < DATE_ADD(t, INTERVAL - 1 DAY)  
      AND (
        br.br_is_repay = 0 
        OR br.br_repay_time >= t
      ) 
      THEN br.id 
      ELSE NULL 
    END
  ) remain_br_id,  
  MAX(
    IF(
      br.br_time <  DATE_ADD(t, INTERVAL - 1 DAY),  
      br.br_overdue_terms,
      0
    )
  ) br_overdue_terms, 
  NULL br_price_b_lc,
  IFNULL(
    MAX(
      DATEDIFF(
        CASE
          WHEN br.br_overdue_terms > 0 
          AND br.br_time <  DATE_ADD(t, INTERVAL - 1 DAY)  
          AND (
            br.br_is_repay = 0 
            OR br.br_repay_time >= t
          ) 
          THEN DATE_ADD(t, INTERVAL - 1 DAY) 
          ELSE NULL 
        END,
        br.br_time
      )
    ),
    0
  ) unrepay_max_overdue_day, 
  0 overdue_level 
  ,
  IFNULL(
    MAX(
      DATEDIFF(
        CASE
          WHEN br.br_overdue_terms > 0 
          AND br.br_time <  DATE_ADD(t, INTERVAL - 1 DAY)  
          THEN IF(
            (
              br.br_is_repay = 0 
              OR br.br_repay_time >= t
            ),
            DATE_ADD(t, INTERVAL - 1 DAY),  
            br.br_repay_time
          ) 
          ELSE NULL 
        END,
        br.br_time      
      )
    ),
    0
  ) max_overdue_day,  
  SUM(
    IF(
      br.br_is_repay = 1 
      AND br.br_repay_time >= DATE_ADD(t, INTERVAL - 1 MONTH) 
      AND br.br_repay_time < t,
      br.br_price_b,
      0
    )
  ) repay_b_this_month  
  ,
  NOW() create_time,
  NOW() update_time 
FROM
  db_nono.borrows bo 
  JOIN db_nono.borrows_repayment br 
    ON br.bo_id = bo.id 
WHERE bo.bo_is_success = 1 
  AND (
    bo.bo_audit_time < t 
    OR bo.bo_agree_time < t
  ) 
GROUP BY 1 ;
UPDATE 
  FACT_LOAN_AFTER_STATIC_MONTHLY_01 a 
  JOIN 
    (SELECT 
      bo_id,
      MAX(br_price_b_lc) br_price_b_lc, 
      MAX(br_overdue_terms) br_overdue_terms 
    FROM
      FACT_LOAN_AFTER_STATIC_MONTHLY_01_Temp 
    WHERE 1 = 1 
      AND br_time < t 
    GROUP BY 1) b 
    ON a.bo_id = b.bo_id SET a.br_price_b_lc = b.br_price_b_lc 
WHERE remain_date = t ;


DELETE FROM FACT_LOAN_AFTER_STATIC_MONTHLY
WHERE FILE_DATE=t;
INSERT INTO FACT_LOAN_AFTER_STATIC_MONTHLY
SELECT mr.bo_id APPLY_NO
,DATE(bo.bo_agree_time)  DISBURSED_DATE
,bo.bo_finish_price DISBURSED_AMT 
,bo.bo_expect TERM
,bo.bo_expect_cat TERM_UNIT
,bo.bo_rate INTEREST_RATE
,CASE 
WHEN mr.unrepay_cnt=0 THEN "closed" 
WHEN mr.unrepay_overdue_cnt>0 THEN "overdue" 
ELSE "current" END STATUS
,mr.unrepay_max_overdue_day OVERDUE_DAY
,max_overdue_day  OVERDUE_DAY_MAX
,unrepay_overdue_cnt OVERDUE_TERM
,mr.br_overdue_terms OVERDUE_TERM_MAX
,NULL OVERDUE_AMT
,NULL  OVERDUE_AMT_MAX
,unrepay_b OUTSTANDING_AMT
,repay_cnt TERM_PAID
,mr.remain_date  FILE_DATE
,unrepay_overdue_b OVERDUE_PRINCIPAL_AMT
,br_price_b_lc  MAX_OVERDUE_PRINCIPAL_AMT
,p.p_name
,mr.repay_b_this_month
FROM risk.FACT_LOAN_AFTER_STATIC_MONTHLY_01 mr
JOIN db_nono.borrows bo ON bo.id=mr.bo_id
LEFT JOIN db_nono.products p ON p.id=bo.p_id
WHERE 1=1
AND mr.remain_date=t
AND bo.bo_agree_time<mr.remain_date
;
SET t = DATE_ADD(t, INTERVAL 1 MONTH) ;
END WHILE;
END$$

DELIMITER ;