set mapreduce.job.name = idw_fact_csyy_aum_snapshot_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode = nostrict;
set hive.exec.dynamic.partition = true;

insert overwrite table idw.fact_csyy_aum_snapshot partition(STAT_DATE)
select
    ui.user_code                    as user_code,
    coalesce(t1.user_id,t2.user_id) as user_id,

    nvl(t1.invest_amt,0) as invest_amt,
    nvl(t1.aum,0)        as aum,
    greatest(coalesce(t1.aum,0),coalesce(t2.max_aum,0))                                                      as max_aum,
    if((coalesce(t1.aum,0)-coalesce(t2.max_aum,0)) >0,t1.stat_date,t2.max_aum_date)                          as max_aum_date,

    nvl(t1.cszpb_invest_amt,0) as cszpb_invest_amt,
    nvl(t1.cszpb_aum,0)        as cszpb_aum,
    greatest(coalesce(t1.cszpb_aum,0),coalesce(t2.cszpb_max_aum,0))                                        as cszpb_max_aum,
    if((coalesce(t1.cszpb_aum,0)-coalesce(t2.cszpb_max_aum,0)) >0,t1.stat_date,t2.cszpb_max_aum_date)      as cszpb_max_aum_date,

    nvl(t1.csyxb_invest_amt,0) as csyxb_invest_amt,
    nvl(t1.csyxb_aum,0)        as csyxb_aum,
    greatest(coalesce(t1.csyxb_aum,0),coalesce(t2.csyxb_max_aum,0))                                                      as csyxb_max_aum,
    if((coalesce(t1.csyxb_aum,0)-coalesce(t2.csyxb_max_aum,0)) >0,t1.stat_date,t2.csyxb_max_aum_date)      as csyxb_max_aum_date,

    nvl(t1.zjjxk_invest_amt,0) as zjjxk_invest_amt,
    nvl(t1.zjjxk_aum,0)        as zjjxk_aum,
    greatest(coalesce(t1.zjjxk_aum,0),coalesce(t2.zjjxk_max_aum,0))                                                      as zjjxk_max_aum,
    if((coalesce(t1.zjjxk_aum,0)-coalesce(t2.zjjxk_max_aum,0)) >0,t1.stat_date,t2.zjjxk_max_aum_date)      as zjjxk_max_aum_date,

    nvl(t1.xrb_invest_amt,0) as xrb_invest_amt,
    nvl(t1.xrb_aum,0)        as xrb_aum,
    greatest(coalesce(t1.xrb_aum,0),coalesce(t2.xrb_max_aum,0))                                                      as xrb_max_aum,
    if((coalesce(t1.xrb_aum,0)-coalesce(t2.xrb_max_aum,0)) >0,t1.stat_date,t2.xrb_max_aum_date)        as xrb_max_aum_date,

    nvl(t1.xhjk_invest_amt,0) as xhjk_invest_amt,
    nvl(t1.xhjk_aum,0)        as xhjk_aum,
    greatest(coalesce(t1.xhjk_aum,0),coalesce(t2.xhjk_max_aum,0))                                                      as xhjk_max_aum,
    if((coalesce(t1.xhjk_aum,0)-coalesce(t2.xhjk_max_aum,0)) >0,t1.stat_date,t2.xhjk_max_aum_date)        as xhjk_max_aum_date,

    nvl(t1.xbjk_invest_amt,0) as xbjk_invest_amt,
    nvl(t1.xbjk_aum,0)        as xbjk_aum,
    greatest(coalesce(t1.xbjk_aum,0),coalesce(t2.xbjk_max_aum,0))                                         as xbjk_max_aum,
    if((coalesce(t1.xbjk_aum,0)-coalesce(t2.xbjk_max_aum,0)) >0,t1.stat_date,t2.xbjk_max_aum_date)        as xbjk_max_aum_date,

    nvl(t1.xzjk_invest_amt,0) as xzjk_invest_amt,
    nvl(t1.xzjk_aum,0)        as xzjk_aum,
    greatest(coalesce(t1.xzjk_aum,0),coalesce(t2.xzjk_max_aum,0))                                                      as xzjk_max_aum,
    if((coalesce(t1.xzjk_aum,0)-coalesce(t2.xzjk_max_aum,0)) >0,t1.stat_date,t2.xzjk_max_aum_date)       as xzjk_max_aum_date,

    nvl(t1.xyxb_invest_amt,0) as xyxb_invest_amt,
    nvl(t1.xyxb_aum,0)        as xyxb_aum,
    greatest(coalesce(t1.xyxb_aum,0),coalesce(t2.xyxb_max_aum,0))                                                      as xyxb_max_aum,
    if((coalesce(t1.xyxb_aum,0)-coalesce(t2.xyxb_max_aum,0)) >0,t1.stat_date,t2.xyxb_max_aum_date)       as xyxb_max_aum_date,

    nvl(t1.kxcs_invest_amt,0) as kxcs_invest_amt,
    nvl(t1.kxcs_aum,0)        as kxcs_aum,
    greatest(coalesce(t1.kxcs_aum,0),coalesce(t2.kxcs_max_aum,0))                                                      as kxcs_max_aum,
    if((coalesce(t1.kxcs_aum,0)-coalesce(t2.kxcs_max_aum,0)) >0,t1.stat_date,t2.kxcs_max_aum_date)       as kxcs_max_aum_date,

    nvl(t1.other_invest_amt,0) as other_invest_amt,
    nvl(t1.other_aum,0)        as other_aum,

   'SYS'                                                   AS DW_CREATE_BY,
    from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
    'SYS'                                                  AS DW_UPDATE_BY,
    from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
    '{T_SUB_1}' as stat_date
from odsopr.user ui
left join
(
select
    STAT_DATE,
    USER_CODE,
    USER_ID,
    sum(INVEST_AMT) as INVEST_AMT,
    sum(AUM)        as AUM,

    sum(
    case
      when PRODUCT_CODE = 'NN0005'
      then INVEST_AMT
    end
    ) as CSZPB_INVEST_AMT,
    sum(
    case
      when PRODUCT_CODE = 'NN0005'
      then AUM
    end
    ) as CSZPB_AUM,

    sum(
    case
      when PRODUCT_CODE = 'NN00011'
      then INVEST_AMT
    end
    ) as CSYXB_INVEST_AMT,
    sum(
    case
      when PRODUCT_CODE = 'NN00011'
      then AUM
    end
    ) as CSYXB_AUM,

    sum(
    case
      when PRODUCT_CODE = 'NN0009'
      then INVEST_AMT
    end
    ) as ZJJXK_INVEST_AMT,
    sum(
    case
      when PRODUCT_CODE = 'NN0009'
      then AUM
    end
    ) as ZJJXK_AUM,

    sum(
    case
      when PRODUCT_CODE = 'NN0012'
      then INVEST_AMT
    end
    ) as XRB_INVEST_AMT,
    sum(
    case
      when PRODUCT_CODE = 'NN0012'
      then AUM
    end
    ) as XRB_AUM,

    sum(
    case
      when PRODUCT_CODE = 'NN0014'
      then INVEST_AMT
    end
    ) as XHJK_INVEST_AMT,
    sum(
    case
      when PRODUCT_CODE = 'NN0014'
      then AUM
    end
    ) as XHJK_AUM,

    sum(
    case
      when PRODUCT_CODE = 'NN0015'
      then INVEST_AMT
    end
    ) as XBJK_INVEST_AMT,
    sum(
    case
      when PRODUCT_CODE = 'NN0015'
      then AUM
    end
    ) as XBJK_AUM,

    sum(
    case
      when PRODUCT_CODE = 'NN0016'
      then INVEST_AMT
    end
    ) as XZJK_INVEST_AMT,
    sum(
    case
      when PRODUCT_CODE = 'NN0016'
      then AUM
    end
    ) as XZJK_AUM,

    sum(
    case
      when PRODUCT_CODE = 'NN0017'
      then INVEST_AMT
    end
    ) as XYXB_INVEST_AMT,
    sum(
    case
      when PRODUCT_CODE = 'NN0017'
      then AUM
    end
    ) as XYXB_AUM,

    sum(
    case
      when PRODUCT_CODE = 'NN0018'
      then INVEST_AMT
    end
    ) as KXCS_INVEST_AMT,
    sum(
    case
      when PRODUCT_CODE = 'NN0018'
      then AUM
    end
    ) as KXCS_AUM,

    sum(
    case
      when PRODUCT_CODE NOT IN ('NN0018','NN0017','NN0016','NN0015','NN0014','NN0012','NN00011','NN0009','NN0005')
      then INVEST_AMT
    end
    ) as OTHER_INVEST_AMT,
    sum(
    case
      when PRODUCT_CODE NOT IN ('NN0018','NN0017','NN0016','NN0015','NN0014','NN0012','NN00011','NN0009','NN0005')
      then AUM
    end
    ) as OTHER_AUM
from  idw.fact_csyy_aum_detail_snapshot
where STAT_DATE = '{T_SUB_1}'
group by stat_date,user_code,user_id
) t1
on ui.user_code = t1.user_code
left join idw.fact_csyy_aum_snapshot t2
on t2.stat_date = '{T_SUB_2}'
and ui.user_code = t2.user_code
where t1.aum > 0
 or t2.max_aum > 0;