set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_49_01;

set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.enforce.bucketing = true;

set hive.exec.parallel=true ;
set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

FROM 
(
  select user_id, fp_category NONO_INVEST_PREFERRED
    from (select user_id,
                 fp_category,
                 aum / (sum(aum) over(partition by user_id)) zb
            from (select t1.user_id,
                         case
                           when t1.category_code_02 = 1 then
                            '新客'
                           when t1.category_code_02 = 15 then
                            '月月升'
                           when t1.category_code_02 in (0, 11) and
                                t2.expect <= 3 then
                            '短期-0至3个月'
                           when t1.category_code_02 in (0, 11) and t2.expect > 3 and
                                t2.expect <= 6 then
                            '中期-3至6个月(不含3个月)'
                           when t1.category_code_02 in (0, 11) and t2.expect > 6 and
                                t2.expect <= 12 then
                            '长期-6至12个月(不含6个月)'
                           when t1.category_code_02 in (0, 11) and
                                t2.expect > 12 then
                            '超长期-12个月以上'
                           else
                            '其他'
                         end fp_category,
                         sum(t1.aum) aum
                    from idw.fact_nono_aum_detail_snapshot t1
                    left join (select invest_relation_no, expect
                                from idw.fact_nono_invest_order
                               where status in (1, 2)
                                 and category_code_02 in (0, 11)
                               group by invest_relation_no, expect) t2
                      on t1.invest_relation_no = t2.invest_relation_no
                   where t1.stat_date = '2017-04-09'
                     and t1.user_id not in (1598, 1600, 920272)
                   group by t1.user_id,
                            case
                              when t1.category_code_02 = 1 then
                               '新客'
                              when t1.category_code_02 = 15 then
                               '月月升'
                              when t1.category_code_02 in (0, 11) and
                                   t2.expect <= 3 then
                               '短期-0至3个月'
                              when t1.category_code_02 in (0, 11) and t2.expect > 3 and
                                   t2.expect <= 6 then
                               '中期-3至6个月(不含3个月)'
                              when t1.category_code_02 in (0, 11) and t2.expect > 6 and
                                   t2.expect <= 12 then
                               '长期-6至12个月(不含6个月)'
                              when t1.category_code_02 in (0, 11) and
                                   t2.expect > 12 then
                               '超长期-12个月以上'
                              else
                               '其他'
                            end) a) b
   where zb > 0.8
) OUTPUT
INSERT OVERWRITE TABLE IDW.USER_TAG_TMP_01 PARTITION(TAG_ID=217) SELECT  USER_ID,NONO_INVEST_PREFERRED, 4
;
-- -------------------------------------------------------------------------------------------------
set mapreduce.job.queuename=etl-dw;

set mapreduce.job.name=IDW_FACT_USER_TAG_49_02;

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 
set hive.auto.convert.join=true;
set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;

INSERT OVERWRITE TABLE   IDW.USER_TAG_HIST  PARTITION(TAG_ID,HASH_PARTITION_ID)
SELECT   USER_ID       
        ,TAG_VALUE
        ,'SYS' AS DW_CREATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME
        ,'SYS' AS DW_UPDATE_BY
        ,FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME
        ,TAG_ID
        ,CAST(PMOD(USER_ID,10) AS INT) HASH_PARTITION_ID 
FROM    IDW.USER_TAG_TMP_01  
WHERE TAG_ID = 217
  AND USER_ID   IS NOT NULL 
  AND TAG_VALUE IS NOT NULL 
  ;