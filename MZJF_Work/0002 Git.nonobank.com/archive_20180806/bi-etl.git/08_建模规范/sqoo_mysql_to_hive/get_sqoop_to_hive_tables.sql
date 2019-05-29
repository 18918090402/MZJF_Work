#
# 获取mysql库导入hive中的业务库表及相关信息
# @author: yening
# @date: 2016-11-14
#  

SELECT m.*,ifnull(n.TABLE_ROWS,0) TABLE_ROWS
  FROM ( SELECT
      CASE FROM_TABLE_SCHEMA
      WHEN 'db_nono' THEN
      '3306'
      WHEN 'db_nono_pay' THEN
      '3306'
      WHEN 'db_nono_legacy' THEN
      '3307'
      ELSE '3308'
      END AS `port` 
      ,FROM_TABLE_SCHEMA 
      ,FROM_TABLE_NAME 
      ,PRIMARY_KEY 
      ,CONCAT('t_',LOWER(TO_TABLE_NAME),'_tmp') AS STG_TABLE 
      ,CONCAT('t_',LOWER(TO_TABLE_NAME),'_cur') AS ODS_TABLE 
      ,CON_CNT 
      ,CASE FROM_TABLE_NAME
      WHEN 'yilian_recharges' THEN
      'idNo=string'
      ELSE '\'\''
      END AS MAP_COLUMN_HIVE ,CASE
      WHEN INCREMENT_FIELD IS NULL THEN
      '\'\''
      ELSE INCREMENT_FIELD
      END AS INCREMENT_FIELD
  FROM ETL.ETL_CONTROL_TASK_M2M
  WHERE TO_JNDI_NAME= "DW_ODS" AND TO_TABLE_NAME<>'finance_log_legacy' ) m
LEFT JOIN 
  (SELECT TABLE_SCHEMA,
         TABLE_NAME ,
         NOW() ,
         `DATA_LENGTH` / 1024.0 / 1024+ A.`INDEX_LENGTH` / 1024.0 / 1024 AS `DATA_LENGTH(M)` ,
         A.`INDEX_LENGTH` / 1024.0 / 1024 AS `INDEX_LENGTH(M)` ,
         A.`TABLE_ROWS` AS `TABLE_ROWS`
  FROM information_schema.TABLES A
  WHERE TABLE_NAME IN 
    (SELECT CONCAT('t_',LOWER(TO_TABLE_NAME))
    FROM ETL.ETL_CONTROL_TASK_M2M
    WHERE TO_JNDI_NAME= "DW_ODS")
    ORDER BY  TABLE_NAME ) n
ON CONCAT('t_',LOWER(m.FROM_TABLE_NAME)) = n.TABLE_NAME
ORDER BY  m.FROM_TABLE_SCHEMA,n.TABLE_ROWS DESC;









 