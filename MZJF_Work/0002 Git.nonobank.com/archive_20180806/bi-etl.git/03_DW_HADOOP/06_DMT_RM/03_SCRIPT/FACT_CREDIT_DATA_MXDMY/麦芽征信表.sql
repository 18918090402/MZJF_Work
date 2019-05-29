INSERT OVERWRITE TABLE dmt_rm.FACT_CREDIT_DATA_MXDMY_01  partition (STAT_DATE)
SELECT 

	'-1' as ORDER_NO,
    nvl(f.bo_id,-1) AS APPLY_NO, 
    a.ZM CREDIT_ZM,
    CAST(td.final_score AS int) AS CREDIT_TD,
    CASE WHEN b.z1='nu' THEN NULL ELSE b.z1 END MULT_INVEST_1M,
    CASE WHEN b.z2='nu' THEN NULL ELSE b.z2 END MULT_INVEST_3M,
    CASE WHEN b.z3='nu' THEN NULL ELSE b.z3 END MULT_INVEST_6M,
    CASE 
    WHEN e.order_id IS NULL THEN -1
    WHEN e.JXL>=0  THEN e.JXL 
    ELSE NULL 
    END AS CREDIT_JXL ,
	f.credit_level CREDIT_MY,
	'-1' AS FACE_S,
	'-1' AS IDCARD_S,

  'SYS'              AS DW_CREATE_BY,
  FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')         AS DW_CREATE_TIME,
  'SYS'              AS DW_UPDATE_BY,
 FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss')         AS DW_UPDATE_TIME,
     '{TSUB1}' AS 'STAT_DATE'
    
FROM 
   ods.t_ORD_ORDER_hist f
    LEFT JOIN 
    (
        SELECT order_id,
  regexp_extract(cast(DATA as string),'zmScore\\"(:)?"([0-9]+)',2) as ZM
        FROM ods.t_ORD_USER_HONOR_hist
        WHERE honor_type ='ZHIMA' AND INSTR(UPPER(DATA),UPPER('zmScore'))>0   
    ) a 
    ON a.order_id=f.id 
    LEFT JOIN
    (
          SELECT order_id,
   regexp_extract(cast(DATA as string),'finalScore\\"(:)?([0-9]+)',2) as final_score
        FROM ods.t_ORD_USER_HONOR_hist
        WHERE honor_type ='TONGDUN'  AND data LIKE '%finalScore%'  
    ) td 
    ON a.order_id=td.order_id 
    LEFT JOIN
    (
        SELECT order_id,
 regexp_extract(cast(DATA as string),'1个月内申请人在多个平台申请借款.*platform_count\\"(:)?([0-9]+)',2) as z1,
	  regexp_extract(cast(DATA as string),'3个月内申请人在多个平台申请借款.*platform_count\\"(:)?([0-9]+)',2) as z2,
	   regexp_extract(cast(DATA as string),'6个月内申请人在多个平台申请借款.*platform_count\\"(:)?([0-9]+)',2) as z3
        FROM ods.t_ORD_USER_HONOR_hist
        WHERE honor_type ='TONGDUN'
        AND (
		      DATA LIKE '%1个月内申请人在多个平台申请借款%' 
			  OR 
			  DATA LIKE '%3个月内申请人在多个平台申请借款%' 
			  OR
			  DATA LIKE '%6个月内申请人在多个平台申请借款%' 
			  )
    ) b 
    ON a.order_id=b.order_id    
    LEFT JOIN 
    (
         SELECT order_id ,
        MAX(CASE WHEN  
         regexp_replace(cast(DATA as string),"与电商","") LIKE  '%根据运营商数据%'
        THEN         
        regexp_extract(cast(DATA as string),'根据运营商.*数据(,)?\\[([0-9]+)\\]号码使用了([0-9]+)个月',3)
        ELSE NULL END) AS JXL
        FROM ods.t_ORD_USER_HONOR_hist  a
        WHERE honor_type LIKE '%JUXINLI_MOBILE%'
        GROUP BY order_id 
    ) e ON a.order_id=e.order_id    

;


