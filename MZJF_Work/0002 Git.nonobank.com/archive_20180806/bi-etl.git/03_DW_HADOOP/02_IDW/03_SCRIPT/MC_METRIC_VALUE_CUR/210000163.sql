set hive.map.aggr=true;
set mapreduce.job.queuename = etl-dw;
set hive.groupby.orderby.position.alias=true;
set hive.exec.dynamic.partition.mode=nostrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set mapreduce.job.name=DMT_RM_FACT_HOR_DATA_STATIC;


INSERT OVERWRITE TABLE  DMT_RM.FACT_HOR_DATA_STATIC PARTITION (DAY_ID)
SELECT 
   row_number() over() as id
   ,USER_CERT_TYPE
  ,USER_CERT_NO
  --,CONCAT_WS(',',COLLECT_SET(CAST (BO_ID AS STRING)) ) AS BO_ID
  ,BO_ID as BO_ID
  ,MAX(IF(COLUMN_ID=35,VALUE,NULL)) AS ZM_ZMSCORE
  ,MAX(IF(COLUMN_ID=34,VALUE,NULL)) AS ZM_IVSSCORE
  ,MAX(IF(COLUMN_ID=36,VALUE,NULL)) AS ZM_MATCHED
  ,MAX(IF(CHANNEL_CODE='TONGDUN' AND COLUMN_NAME='7天内申请人在多个平台申请借款',VALUE,NULL)) AS TONGDUN_7DAYMORES
  ,CONCAT_WS(',',COLLECT_SET(IF(CHANNEL_CODE='TONGDUN' AND CHANNEL_NAME='同盾征信接口' 
    AND COLUMN_NAME IN ('身份证命中汽车租赁黑名单','身份证命中网贷黑名单','身份证命中失信还款名单','身份证_姓名命中网贷模糊黑名单','身份证命中同盾欺诈高级灰名单','身份证命中同盾欺诈中级灰名单','身份证命中同盾欺诈低级灰名单'
    ,'身份证_姓名命中法院失信模糊名单 ','身份证_姓名命中法院结案模糊名单','身份证命中法院失信名单','身份证命中法院执行名单','身份证命中法院结案名单','身份证命中公司欠税名单','身份证_姓名命中法院执行模糊名单'
    ,'第一联系人手机号命中网贷黑名单_一般联系人','第一联系人手机号命中同盾虚假号码或通信小号库_一般联系人','身份证命中欠税名单','身份证命中犯罪通缉名单','身份证归属地位于高风险较为集中地区'
    ,'手机号命中网贷黑名单','手机号命中同盾欺诈高级灰名单','手机号命中同盾通信小号库','手机号命中同盾虚假号码库','手机号命中同盾欺诈低级灰名单','手机号命中失信还款名单','手机号命中同盾欺诈中级灰名单','手机号命中网贷黑名单'
    ),COLUMN_NAME,NULL)) ) AS TONGDUN_BLACKSTYPE
  ,MAX(IF(CHANNEL_CODE='TONGDUN' AND  COLUMN_NAME='FINALSCORE',VALUE,NULL)) AS TONGDUN_FINALSCORE
  ,MAX(IF(CHANNEL_CODE='TONGDUN' AND  COLUMN_NAME='FINALDECISION',VALUE,NULL))AS TONGDUN_FINALDECISION
  ,CONCAT_WS(',',COLLECT_SET(IF(COLUMN_ID=1,VALUE,NULL) )) AS TXSK_MOBILE --多个手机号
  ,MAX(IF(COLUMN_ID=2,VALUE,NULL)) AS TXSK_ONLINETIME
  ,MAX(IF(COLUMN_ID=3,VALUE,NULL)) AS TXSK_RESULTSTATUS
  ,MAX(IF(COLUMN_ID IN(7,52),VALUE,NULL)) AS BAIQISHI_FINALDECISION
  ,MAX(IF(COLUMN_ID =50,VALUE,NULL)) AS BAIQISHI_FINALSCORE
  ,MAX(IF(COLUMN_ID =24,VALUE,NULL)) AS BR_RULEFINALDECISION
  ,MAX(IF(COLUMN_ID =25,VALUE,NULL)) AS BR_RULEFINALWEIGHT
  ,MAX(IF(COLUMN_ID =26,VALUE,NULL)) AS BR_ALSM3IDNBANKALLNUM
  ,'SYS' AS DW_CREATE_BY
  ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'YYYY-MM-dd HH:MM:SS') AS DW_CREATE_TIME
  ,'SYS' AS DW_UPDATE_BY
  ,FROM_UNIXTIME(UNIX_TIMESTAMP(), 'YYYY-MM-dd HH:MM:SS') AS DW_UPDATE_TIME
  ,FROM_UNIXTIME(UNIX_TIMESTAMP(create_time),'YYYY-MM-dd') AS DAY_ID
FROM DMT_RM.FACT_HOR_DATA
GROUP BY USER_CERT_TYPE,USER_CERT_NO,BO_ID,FROM_UNIXTIME(UNIX_TIMESTAMP(create_time),'YYYY-MM-dd');
