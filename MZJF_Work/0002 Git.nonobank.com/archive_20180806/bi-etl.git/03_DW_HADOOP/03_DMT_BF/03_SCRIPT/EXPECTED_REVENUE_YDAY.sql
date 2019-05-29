-- ###################################1.月月升(一人多标)(IDW_USER_EXPECTED_REVENUE_YDAY_02)
-- 逻辑规则：昨日持有中的资产的订单金额*预期年化收益/100/365,且退出中的资产不计为持有中资产(计算当前持有是第几期,通过finance_plan表找出其年化收益率)
-- 时间：要计算临界点:昨日持有中的资产(未退出,退出临界点计算与兑付逻辑相同),包含1.未兑付 2.已兑付,但兑付时间在当天凌晨至JOB运行时间之间,这块也要计算到昨日收益中。
-- 不考虑加息券、不支持手动债转
SELECT 
  t.user_id,
  t.pro_type,
  SUM(t.EXPECTED_REVENUE) AS EXPECTED_REVENUE 
FROM
  (SELECT 
    a.user_id,
    a.fp_id,
    'YYS' AS pro_type,
    a.amount,
    c.rate_all,
    a.amount * c.rate_all / 100 / 365 AS EXPECTED_REVENUE 
  FROM
    (SELECT 
      fp.start_date,
      vf.id AS vf_id,
      fp.id AS fp_id,
      vf.user_id,
      nvl (vf.amount, va.amount) AS amount,
      CAST(
        (
          CASE
            WHEN ADD_MONTHS (
              fp.start_date,
              (
                (
                  YEAR(CURRENT_DATE()) * 12+ MONTH(CURRENT_DATE())
                ) - (
                  YEAR(fp.start_date) * 12+ MONTH(fp.start_date)
                )
              )
            ) <= TO_DATE (CURRENT_DATE()) 
            THEN 
            CASE
              WHEN (
                YEAR(CURRENT_DATE()) * 12+ MONTH(CURRENT_DATE())
              ) - (
                YEAR(fp.start_date) * 12+ MONTH(fp.start_date)
              ) + 1-1 <= 0 
              THEN 1 
              ELSE (
                YEAR(CURRENT_DATE()) * 12+ MONTH(CURRENT_DATE())
              ) - (
                YEAR(fp.start_date) * 12+ MONTH(fp.start_date)
              ) + 1-1 
            END 
            ELSE 
            CASE
              WHEN (
                YEAR(CURRENT_DATE()) * 12+ MONTH(CURRENT_DATE())
              ) - (
                YEAR(fp.start_date) * 12+ MONTH(fp.start_date)
              ) - 1 <= 0 
              THEN 1 
              ELSE (
                YEAR(CURRENT_DATE()) * 12+ MONTH(CURRENT_DATE())
              ) - (
                YEAR(fp.start_date) * 12+ MONTH(fp.start_date)
              ) - 1 
            END 
          END
        ) AS INT
      ) AS mo 
    FROM
      ods.t_vip_account_hist va 
      INNER JOIN ods.t_vip_form_hist vf 
        ON va.user_id = vf.user_id 
        AND va.fp_id = vf.fp_id 
        AND vf.service_status = 1 
      LEFT JOIN ods.t_finance_plan_hist fp 
        ON fp.id = va.fp_id 
      LEFT JOIN ods.t_invt_stage_quit_form_hist sq 
        ON sq.va_id = va.id 
      LEFT JOIN ods.t_invt_finance_plan_stage_info_hist si 
        ON si.fp_id = fp.id 
    WHERE fp.scope = 15
      AND (va.is_cash = 0
	   OR (
        va.is_cash = 1 
        AND va.cash_time < FROM_UNIXTIME(
          UNIX_TIMESTAMP(),
          'yyyy-MM-dd HH:MM:ss'
        ) 
        AND va.cash_time >= CURRENT_DATE()
      )
	  )	
      AND (
        sq.id IS NULL 
        OR (
          sq.quit_apply_time >= to_date (CURRENT_DATE()) 
          AND sq.quit_apply_time < FROM_UNIXTIME(
            UNIX_TIMESTAMP(),
            'yyyy-MM-dd HH:MM:ss'
          ) 
          AND sq.quit_status = 1
        )
      )) a 
    LEFT JOIN 
      (SELECT 
        fp_id,
        rate_all,
        CAST(
          row_number () over (
            PARTITION BY fp_id 
            ORDER BY CAST(rate_all AS DECIMAL (38, 10))
          ) AS INT
        ) AS a 
      FROM
        (SELECT 
          fp_id,
          rate_all 
        FROM
          (SELECT 
            fp_id,
            Split (rate_all, ',') b 
          FROM
            ods.t_invt_finance_plan_stage_info_hist) t_a Lateral VIEW Explode (b) Splittab AS rate_all) t_b 
      WHERE rate_all NOT IN ('', ',')) c 
      ON c.fp_id = a.fp_id 
      AND c.a = a.mo) t 
GROUP BY t.user_id,
  t.pro_type 
  ;

-- ## ##################################################贴心计划 
-- ## ######################2.懒人计划 (系统自动投标,已计算好) (IDW_USER_EXPECTED_REVENUE_YDAY_03)
-- 逻辑规则：昨日持有中的订单的(订单金额 - 转让成功的金额)*预期年化收益/100/365,表中金额为已计算好金额(懒人计划是到期自动续投,计算收益时只需要调取当前最大期数,即为目前持有本金,再取其对应利息即可)
-- 时间：要计算临界点:昨日持有中的资产(未兑付),包含1.未兑付 2.已兑付,但兑付时间在当天凌晨至JOB运行时间之间,这块也要计算到昨日收益中。
-- 考虑加息券、债转金额已计算好(懒人计划只有第一期结算发息的时候加息券才有效，结算收益的时候会加上加息券部分的利息)
SELECT 
  t.user_id,
  t.pro_type,
  SUM(t.price) AS EXPECTED_REVENUE 
FROM
  (SELECT 
    vf.id,
    'LRJH' AS pro_type,
    la.user_id,
    la.fp_id,
    CASE
      WHEN la.current_add_count = 1 
      THEN (nvl (la.rate, '0') + nvl (uc.value, 0)) * vf.amount / 100 / 365 
      ELSE nvl (la.rate, '0') * vf.amount / 100 / 365 
    END AS price,
    nvl (uc.value, 0) AS VALUE,
    vf.amount 
  FROM
    ods.t_lazy_add_hist la 
    LEFT JOIN ods.t_vip_account_hist va 
      ON va.user_id = la.user_id 
      AND la.fp_id = va.fp_id 
    INNER JOIN ods.t_vip_form_hist vf 
      ON va.user_id = vf.user_id 
      AND va.fp_id = vf.fp_id 
      AND vf.service_status = 1 
    LEFT JOIN ods.t_finance_plan_hist fp 
      ON fp.id = va.fp_id 
    LEFT JOIN ods.t_coupon_use_hist cu 
      ON cu.bb_id = vf.id 
      AND cu.ir_p_type = 1 
    LEFT JOIN ods.t_user_coupon_hist uc 
      ON cu.uv_id = uc.id 
      AND uc.is_used = 1 
    JOIN 
      (SELECT 
        la.user_id,
        la.fp_id,
        MAX(current_add_count) AS current_add_count 
      FROM
        ods.t_lazy_add_hist la 
      GROUP BY la.user_id,
        la.fp_id) la2 
      ON la.user_id = la2.user_id 
      AND la2.fp_id = la.fp_id 
      AND la.current_add_count = la2.current_add_count 
  WHERE fp.scope = 12 
    AND la.is_effect = 1 
    AND (
      va.is_cash = 0 
      OR (
        va.is_cash = 1 
        AND va.cash_time < FROM_UNIXTIME(
          UNIX_TIMESTAMP(),
          'yyyy-MM-dd HH:MM:ss'
        ) 
        AND va.cash_time >= CURRENT_DATE()
      )
    )) t 
GROUP BY t.user_id,
  t.pro_type 
  ;
  
  -- #################################################################### 3.新客计划、0元计划 (IDW_USER_EXPECTED_REVENUE_YDAY_04)
  -- 逻辑规则：昨日持有中的订单的(订单金额 - 转让成功的金额)*预期年化收益/100/365
-- 时间：要计算临界点:昨日持有中的资产(未兑付),包含1.未兑付 2.已兑付,但兑付时间在当天凌晨至JOB运行时间之间,这块也要计算到昨日收益中。
-- 考虑加息券、不考虑债转

  SELECT 
    t.user_id,
    t.pro_type,
    SUM(t.PRICE) AS EXPECTED_REVENUE 
  FROM
    (SELECT 
      vf.id AS vf_id,
      vf.user_id,
      vf.fp_id,
      CASE
        WHEN fp.scope = '1' 
        THEN 'XKZXJH' 
        WHEN fp.scope = '13' 
        THEN 'LYJH' 
      END AS pro_type,
      fp.rate_min,
      (nvl (uc.value, 0) + fp.rate_min) * nvl (vf.amount, va.amount) / 100 / 365 AS PRICE,
       nvl (vf.amount, va.amount) AS amount,
      nvl (uc.value, 0) AS VALUE,
      va.is_cash,
      va.cash_time 
    FROM
      ods.t_vip_account_hist va 
      INNER JOIN ods.t_vip_form_hist vf 
        ON va.user_id = vf.user_id 
        AND va.fp_id = vf.fp_id 
        AND vf.service_status = 1 
      LEFT JOIN ods.t_finance_plan_hist fp 
        ON fp.id = va.fp_id 
      LEFT JOIN ods.t_coupon_use_hist cu 
        ON cu.bb_id = vf.id 
        AND cu.ir_p_type = 1 
      LEFT JOIN ods.t_user_coupon_hist uc 
        ON cu.uv_id = uc.id 
        AND uc.is_used = 1 
    WHERE fp.scope IN (1, 13) 
      AND (
        va.is_cash = 0 
        OR (
          va.is_cash = 1
          AND va.cash_time < FROM_UNIXTIME(
            UNIX_TIMESTAMP(),
            'yyyy-MM-dd HH:MM:ss'
          ) 
          AND va.cash_time >= CURRENT_DATE()
        )
      )) t 
  GROUP BY t.user_id,
    t.pro_type ;

-- ################################################ 4.贴心计划 (IDW_USER_EXPECTED_REVENUE_YDAY_05)
-- 逻辑规则：昨日持有中的订单的(订单金额 - 转让成功的金额)*预期年化收益/100/365,加息券提取规则：MIN(每笔订单的投资本金与债转后的剩余本金)*(年化+利息),
-- 时间：要计算临界点:昨日持有中的资产(未兑付),包含1.未兑付 2.已兑付,但兑付时间在当天凌晨至JOB运行时间之间,这块也要计算到昨日收益中。
-- 考虑加息券、债转金额
-- 存在问题：既债转又加息的,根据上述加息规则，计算收益偏大
 /*
对于精选计划，存在订单表vip_form和兑付表vip_account，两者通过user_id、fp_id关联，当一个用户多次投资同一精选计划时，订单有多笔，兑付只有一笔，用户在投资时，可以使用加息券，而在投资过程中，部分计划是支撑债转的，其中加息与vip_form关联，债转与vip_account关联
-- 问题描述
假设一个用户多次投资同一计划，并且部分订单使用了加息券，在持有过程中，用户将部分投资进行了债转，这时会出现以下两个主要问题：
1.vip_account中金额不会更新，也就是说以vip_account计算用户在投是不准确的；
2.债转的金额无法追溯到是属于哪笔订单，也就是说无法知道债转出去的是使用了加息券的还是未使用加息券的，而且从订单的视角，无法跟踪每笔订单的全生命周期，即何时产生、何时退出。
*/

SELECT 
  t.user_id,
  t.pro_type,
  SUM(t.price) AS EXPECTED_REVENUE 
FROM
  (SELECT 
    b.vf_id,
    b.va_id,
    b.user_id,
    'TXJH' AS pro_type,
    b.fp_id,
    b.rate_min,
    b.jx_value,
    b.syprice,
    CASE
      WHEN b.vf_amount <= b.syprice 
      THEN (
        b.vf_amount * (b.rate_min + b.jx_value) / 100 / 365
      ) 
      ELSE b.syprice * (b.rate_min + b.jx_value) / 100 / 365 
    END AS price 
  FROM
    (SELECT 
      va.id AS va_id,
      fp.scope,
      va.user_id,
      fp.id AS fp_id,
      vf.id AS vf_id,
      fp.rate_min,
      vf.amount AS vf_amount,
      va.amount AS va_amount,
      nvl(debt.debt_price, 0) AS debt_price,
       case when  va.amount - nvl(debt.debt_price, 0)>0 then va.amount - nvl(debt.debt_price, 0)
     else 0 end AS syprice,
      nvl(uc.value, 0) AS jx_value 
    FROM
      ods.t_vip_account_hist va 
      INNER JOIN ods.t_vip_form_hist vf 
        ON va.user_id = vf.user_id 
        AND va.fp_id = vf.fp_id 
        AND vf.service_status = 1 
      LEFT JOIN ods.t_finance_plan_hist fp 
        ON fp.id = va.fp_id 
      LEFT JOIN ods.t_coupon_use_hist cu 
        ON cu.bb_id = vf.id 
        AND cu.ir_p_type = 1 
      LEFT JOIN ods.t_user_coupon_hist uc 
        ON cu.uv_id = uc.id 
        AND uc.is_used = 1 
      LEFT JOIN 
        (SELECT 
          va_id,
          SUM(
            (ds.transfer_num - ds.residue_num) * ds.one_price
          ) AS debt_price 
        FROM
          ods.t_debt_sale_hist ds 
        WHERE op_type = 1 
        GROUP BY va_id) debt 
        ON va.id = debt.va_id 
    WHERE 
       fp.scope = 11 
	AND (va.`is_cash`='0' OR 
		(va.`is_cash`='1' AND va.`cash_time`<FROM_UNIXTIME(UNIX_TIMESTAMP(),'yyyy-MM-dd HH:MM:ss') AND va.`cash_time`>=CURRENT_DATE())
		)
    ) b
) t 
GROUP BY t.user_id,
  t.pro_type ;

-- ##########################################5.散投、债转 (IDW_USER_EXPECTED_REVENUE_YDAY_01)
-- 逻辑规则：还款时间<昨天,收益为0,其余为当期预期利息 / 当期天数 具体包括(1.当期利息未提前还款 2.当期利息已提前还款),price_interest是已经计算过的持有本金
-- 时间:临界点计算、(当期天数取值 用plan_time - plan_time减一个月)、还款时间success_time
-- 不考虑加息券等信息
-- 存在问题：
/* 还款时间在昨天或者昨天之前的,昨日收益 = 当期预期利息 / 当期天数  怎么跟客户解释问题？
*/
SELECT 
  t.user_id,
  t.pro_type,
  SUM(t.price_interest) AS EXPECTED_REVENUE 
FROM
  (SELECT 
    ba.id,
    ba.bo_id,
    ba.user_id,
    'STZHZH' AS pro_type,
    CASE
      WHEN ba.is_pay = 0 
      AND ba.plan_time < ADD_MONTHS (DATE_SUB(CURRENT_DATE(), 1), 1) 
      AND ba.plan_time >= DATE_SUB(CURRENT_DATE(), 1) 
      THEN ba.price_interest * ba.owner_rate /DATEDIFF(DATE_SUB(ba.plan_time, 1),ADD_MONTHS (DATE_SUB(ba.plan_time, 1), - 1)) 
      WHEN ba.is_pay = 1 
      AND ba.success_time >= DATE_SUB(CURRENT_DATE(), 1) 
      THEN ba.price_interest * ba.owner_rate / DATEDIFF(DATE_SUB(ba.plan_time, 1),ADD_MONTHS (DATE_SUB(ba.plan_time, 1), - 1))  
    END AS price_interest 
  FROM
    ods.t_borrows_accept_hist ba 
  WHERE ba.is_vip = 0 
    AND ba.va_id = 0) t 
GROUP BY t.user_id,
  t.pro_type 
HAVING SUM(t.price_interest) <> 0 ;

