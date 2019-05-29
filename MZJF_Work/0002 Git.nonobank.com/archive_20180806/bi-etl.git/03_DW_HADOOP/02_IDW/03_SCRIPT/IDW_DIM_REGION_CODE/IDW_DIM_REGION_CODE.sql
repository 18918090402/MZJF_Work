set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_DIM_REGION_CODE_01;

set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;


INSERT OVERWRITE TABLE IDW.DIM_REGION_CODE 
SELECT
 code3 AS key,
 code3 AS CODE,
 -- Çø
 code3,
 name3,
 -- ÊÐ
 code2,
 name2,
 -- Ê¡
 code1,
 name1
,'SYS' AS DW_CREATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
        ,'SYS' AS DW_UPDATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
FROM (
    SELECT   
      a3.code code3,
      a3.name name3,  
      a2.`code`  code2,
      a2.`name`  name2,    
      CASE WHEN a1.level IS NULL THEN a2.`code` ELSE a1.`code` END code1,
      CASE WHEN a1.level IS NULL THEN a2.`name` ELSE a1.`name` END name1  
    FROM
      ODS.t_region_hist a3
      LEFT JOIN ODS.t_region_hist a2
        ON a3.`parent_code` = a2.code
      LEFT JOIN ODS.t_region_hist a1
        ON a2.`parent_code` = a1.code
    WHERE a3.level = 3
    UNION ALL
    SELECT
     a3.`code`  code3,
     a3.`name`  name3,
     a3.`code`  code2,
     a3.`name`  name2,  
     a2.`code`  code1,
     a2.`name`  name1  
    FROM
      ODS.t_region_hist a3
      LEFT JOIN ODS.t_region_hist a2
        ON a3.`parent_code` = a2.code
    WHERE a3.level = 2
    UNION ALL
    SELECT
    a3.`code`  code3,
    a3.`name`  name3,
    a3.`code`  code2,
    a3.`name`  name2,
    a3.`code`  code1,
    a3.`name`  name1
      FROM
      ODS.t_region_hist a3
    WHERE a3.level = 1
    ) A;