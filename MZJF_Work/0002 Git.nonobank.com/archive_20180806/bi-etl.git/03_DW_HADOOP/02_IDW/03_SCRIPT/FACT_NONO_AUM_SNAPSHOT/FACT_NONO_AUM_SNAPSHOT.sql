set mapreduce.job.name = idw_fact_nono_aum_snapshot_01;
set mapreduce.job.queuename = etl-dw;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.parallel=true;

insert overwrite table idw.FACT_NONO_AUM_SNAPSHOT partition
  (stat_date = '{T_SUB_1}')
  select ui.id user_id,
         nvl(t1.INVEST_AMT, 0),
         nvl(t1.AUM, 0),
         CASE
           WHEN nvl(t1.aum, 0) > nvl(t2.max_aum, 0) THEN
            t1.aum
           ELSE
            t2.max_aum
         END max_aum,
         CASE
           WHEN nvl(t1.aum, 0) > nvl(t2.max_aum, 0) THEN
            t1.stat_date
           ELSE
            t2.max_aum_date
         END max_aum_date,
         nvl(t1.zz_invest_amt, 0),
         nvl(t1.zz_aum, 0),
         CASE
           WHEN nvl(t1.zz_aum, 0) > nvl(t2.zz_max_aum, 0) THEN
            nvl(t1.zz_aum, 0)
           ELSE
            nvl(t2.zz_max_aum, 0)
         END zz_max_aum,
         CASE
           WHEN nvl(t1.zz_aum, 0) > nvl(t2.zz_max_aum, 0) THEN
            t1.stat_date
           ELSE
            t2.zz_max_aum_date
         END zz_max_aum_date,
         nvl(t1.st_invest_amt, 0),
         nvl(t1.st_aum, 0),
         CASE
           WHEN nvl(t1.st_aum, 0) > nvl(t2.st_max_aum, 0) THEN
            nvl(t1.st_aum, 0)
           ELSE
            nvl(t2.st_max_aum, 0)
         END st_max_aum,
         CASE
           WHEN nvl(t1.st_aum, 0) > nvl(t2.st_max_aum, 0) THEN
            t1.stat_date
           ELSE
            t2.st_max_aum_date
         END st_max_aum_date,
         nvl(t1.jx_invest_amt, 0),
         nvl(t1.jx_aum, 0),
         CASE
           WHEN nvl(t1.jx_aum, 0) > nvl(t2.jx_max_aum, 0) THEN
            nvl(t1.jx_aum, 0)
           ELSE
            nvl(t2.jx_max_aum, 0)
         END jx_max_aum,
         CASE
           WHEN nvl(t1.jx_aum, 0) > nvl(t2.jx_max_aum, 0) THEN
            t1.stat_date
           ELSE
            t2.jx_max_aum_date
         END jx_max_aum_date,
         nvl(t1.xk_invest_amt, 0),
         nvl(t1.xk_aum, 0),
         CASE
           WHEN nvl(t1.xk_aum, 0) > nvl(t2.xk_max_aum, 0) THEN
            nvl(t1.xk_aum, 0)
           ELSE
            nvl(t2.xk_max_aum, 0)
         END xk_max_aum,
         CASE
           WHEN nvl(t1.xk_aum, 0) > nvl(t2.xk_max_aum, 0) THEN
            t1.stat_date
           ELSE
            t2.xk_max_aum_date
         END xk_max_aum_date,
         nvl(t1.jgjx_invest_amt, 0),
         nvl(t1.jgjx_aum, 0),
         CASE
           WHEN nvl(t1.jgjx_aum, 0) > nvl(t2.jgjx_max_aum, 0) THEN
            nvl(t1.jgjx_aum, 0)
           ELSE
            nvl(t2.jgjx_max_aum, 0)
         END jgjx_max_aum,
         CASE
           WHEN nvl(t1.jgjx_aum, 0) > nvl(t2.jgjx_max_aum, 0) THEN
            t1.stat_date
           ELSE
            t2.jgjx_max_aum_date
         END jgjx_max_aum_date,
         nvl(t1.tx_invest_amt, 0),
         nvl(t1.tx_aum, 0),
         CASE
           WHEN nvl(t1.tx_aum, 0) > nvl(t2.tx_max_aum, 0) THEN
            nvl(t1.tx_aum, 0)
           ELSE
            nvl(t2.tx_max_aum, 0)
         END tx_max_aum,
         CASE
           WHEN nvl(t1.tx_aum, 0) > nvl(t2.tx_max_aum, 0) THEN
            t1.stat_date
           ELSE
            t2.tx_max_aum_date
         END tx_max_aum_date,
         nvl(t1.lr_invest_amt, 0),
         nvl(t1.lr_aum, 0),
         CASE
           WHEN nvl(t1.lr_aum, 0) > nvl(t2.lr_max_aum, 0) THEN
            nvl(t1.lr_aum, 0)
           ELSE
            nvl(t2.lr_max_aum, 0)
         END lr_max_aum,
         CASE
           WHEN nvl(t1.lr_aum, 0) > nvl(t2.lr_max_aum, 0) THEN
            t1.stat_date
           ELSE
            t2.lr_max_aum_date
         END lr_max_aum_date,
         nvl(t1.zy_invest_amt, 0),
         nvl(t1.zy_aum, 0),
         CASE
           WHEN nvl(t1.zy_aum, 0) > nvl(t2.zy_max_aum, 0) THEN
            nvl(t1.zy_aum, 0)
           ELSE
            nvl(t2.zy_max_aum, 0)
         END zy_max_aum,
         CASE
           WHEN nvl(t1.zy_aum, 0) > nvl(t2.zy_max_aum, 0) THEN
            t1.stat_date
           ELSE
            t2.zy_max_aum_date
         END zy_max_aum_date,
         nvl(t1.yys_invest_amt, 0),
         nvl(t1.yys_aum, 0),
         CASE
           WHEN nvl(t1.yys_aum, 0) > nvl(t2.yys_max_aum, 0) THEN
            nvl(t1.yys_aum, 0)
           ELSE
            nvl(t2.yys_max_aum, 0)
         END yys_max_aum,
         CASE
           WHEN nvl(t1.yys_aum, 0) > nvl(t2.yys_max_aum, 0) THEN
            t1.stat_date
           ELSE
            t2.yys_max_aum_date
         END yys_max_aum_date,
         nvl(t1.other_invest_amt, 0),
         nvl(t1.other_aum, 0),
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         nvl(t1.IN_INVEST_AMT, 0),
         CASE
           WHEN nvl(t1.IN_INVEST_AMT, 0) > nvl(t2.MAX_IN_INVEST_AMT, 0) THEN
            t1.IN_INVEST_AMT
           ELSE
            t2.MAX_IN_INVEST_AMT
         END MAX_IN_INVEST_AMT,
         CASE
           WHEN nvl(t1.IN_INVEST_AMT, 0) > nvl(t2.MAX_IN_INVEST_AMT, 0) THEN
            t1.stat_date
           ELSE
            t2.MAX_IN_INVEST_AMT_DATE
         END MAX_IN_INVEST_AMT_DATE
    from odsopr.user_info ui
    left join (SELECT aumd.user_id,
                      aumd.stat_date,
                      SUM(aumd.invest_amt) INVEST_AMT,
                      SUM(aumd.aum) AUM,
                      SUM(CASE
                            WHEN aumd.invest_type_code = 2 THEN
                             aumd.invest_amt
                            ELSE
                             0
                          END) ZZ_INVEST_AMT,
                      SUM(CASE
                            WHEN aumd.invest_type_code = 2 THEN
                             aumd.aum
                            ELSE
                             0
                          END) ZZ_AUM,
                      SUM(CASE
                            WHEN aumd.invest_type_code = 1 THEN
                             aumd.invest_amt
                            ELSE
                             0
                          END) ST_INVEST_AMT,
                      SUM(CASE
                            WHEN aumd.invest_type_code = 1 THEN
                             aumd.aum
                            ELSE
                             0
                          END) ST_AUM,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 0 THEN
                             aumd.invest_amt
                            ELSE
                             0
                          END) JX_INVEST_AMT,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 0 THEN
                             aumd.aum
                            ELSE
                             0
                          END) JX_AUM,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 1 THEN
                             aumd.invest_amt
                            ELSE
                             0
                          END) XK_INVEST_AMT,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 1 THEN
                             aumd.aum
                            ELSE
                             0
                          END) XK_AUM,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 10 THEN
                             aumd.invest_amt
                            ELSE
                             0
                          END) JGJX_INVEST_AMT,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 10 THEN
                             aumd.aum
                            ELSE
                             0
                          END) JGJX_AUM,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 11 THEN
                             aumd.invest_amt
                            ELSE
                             0
                          END) TX_INVEST_AMT,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 11 THEN
                             aumd.aum
                            ELSE
                             0
                          END) TX_AUM,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 12 THEN
                             aumd.invest_amt
                            ELSE
                             0
                          END) LR_INVEST_AMT,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 12 THEN
                             aumd.aum
                            ELSE
                             0
                          END) LR_AUM,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 13 THEN
                             aumd.invest_amt
                            ELSE
                             0
                          END) ZY_INVEST_AMT,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 13 THEN
                             aumd.aum
                            ELSE
                             0
                          END) ZY_AUM,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 15 THEN
                             aumd.invest_amt
                            ELSE
                             0
                          END) YYS_INVEST_AMT,
                      SUM(CASE
                            WHEN aumd.category_code_02 = 15 THEN
                             aumd.aum
                            ELSE
                             0
                          END) YYS_AUM,
                      SUM(CASE
                            WHEN aumd.invest_type_code not in (1, 2) and
                                 coalesce(aumd.category_code_02, -1) not in
                                 (0, 1, 10, 11, 12, 13, 15) THEN
                             aumd.invest_amt
                            ELSE
                             0
                          END) OTHER_INVEST_AMT,
                      SUM(CASE
                            WHEN aumd.invest_type_code not in (1, 2) and
                                 coalesce(aumd.category_code_02, -1) not in
                                 (0, 1, 10, 11, 12, 13, 15) THEN
                             aumd.aum
                            ELSE
                             0
                          END) OTHER_AUM,
                      SUM(aumd.IN_INVEST_AMT) IN_INVEST_AMT
                 FROM idw.fact_nono_aum_detail_snapshot aumd
                where aumd.stat_date = '{T_SUB_1}'
                group by aumd.user_id, aumd.stat_date) t1
      on ui.id = t1.user_id
    left join idw.FACT_NONO_AUM_SNAPSHOT t2
      on ui.id = t2.user_id
     and t2.stat_date = '{T_SUB_2}'
   where t1.aum > 0
      or t2.max_aum > 0;