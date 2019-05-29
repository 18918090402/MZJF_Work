
--截至2017-06-30放款金额
SELECT
    sum(bo.bo_finish_price)
from idw.fact_borrows bo
where 1=1
    and bo.bo_is_success = 1
    and to_date(bo.bo_finish_time) <= '2017-06-30';




--截至2017-06-30贷余
SELECT
    sum(br.br_price_b)
from idw.fact_borrows_repayment br
left join idw.fact_borrows bo
on bo.bo_id = br.bo_id
where 1=1
    and to_date(bo.bo_finish_time) <= '2017-06-30'
    and (br.br_is_repay = 0 or to_date(br.br_repay_time) > '2017-06-30')



--截至2018-08-31贷余
SELECT
    sum(bo.bo_finish_price)
from idw.fact_borrows bo
where 1=1
    and bo.bo_is_success = 1
    and to_date(bo.bo_finish_time) <= '2018-08-31';



--截至2018-08-31贷余
SELECT
    sum(br.br_price_b)
from idw.fact_borrows_repayment br
left join idw.fact_borrows bo
on bo.bo_id = br.bo_id
where 1=1
    and to_date(bo.bo_finish_time) <= '2018-08-31'
    and (br.br_is_repay = 0 or to_date(br.br_repay_time) > '2018-08-31')






--关联方历史借款数据
SELECT
    bo.user_id,
    us.real_name,
    bo.bo_finish_price
from idw.fact_borrows bo
left join odsopr.user_info us on us.id = bo.user_id
where 1=1
    and bo.bo_is_success = 1
    AND us.real_name IN ( "上海麦子资产管理有限公司",
                           "北京财神爷爷科技发展有限公司",
                           "上海图辰企业信用征信有限公司",
                           "上海爱曼商务咨询有限公司",
                           "上海诺明投资中心（有限合伙）",
                           "上海金贝壳投资中心（有限合伙）",
                           "上海积曼信息科技有限公司",
                           "仟佰清（杭州）资产管理有限公司",
                           "上海仁康物业经营管理有限公司",
                           "上海旺倍信息科技有限公司",
                           "苏州镑天商务信息咨询有限公司",
                           "北京华夏亚通科技有限公司",
                           "北京华夏亚通科技有限公司成都分公司",
                           "荣域商业保理（深圳）有限公司",
                           "大房东（上海）金融科技有限公司",
                           "上海诺容企业管理咨询有限公司",
                           "合肥大房东信息咨询服务有限公司",
                           "大房东信息咨询无锡有限公司",
                           "大房东（苏州）信息科技有限公司",
                           "上海诺宜财富管理有限公司",
                           "上海诺宜财富管理有限公司苏州分公司",
                           "霍尔果斯万恒金融信息服务有限公司",
                           "中融寰球国际融资租赁（深圳）有限公司",
                           "北京买呀科技发展有限公司",
                           "冒泡（上海）文化传媒有限公司",
                           "名校贷（上海）金融科技有限公司",
                           "上海诺友金融信息服务有限公司",
                           "财神爷爷（上海）金融科技有限公司",
                           "上海岦彤企业发展中心（有限合伙）",
                           "上海速宜投资咨询有限公司",
                           "北京元古企业管理中心（有限合伙）",
                           "上海诺明投资中心（有限合伙）",
                           "上海琛坤科技发展有限公司",
                           "上海伟容商务咨询中心（有限合伙）",
                           "上海明容企业管理中心（有限合伙）",
                           "上海年图企业管理中心（有限合伙）",
                           "上海葩星信息科技有限公司",
                           "北京中爱梦想投资中心（有限合伙）",
                           "上海金贝壳投资中心（有限合伙）",
                           "重庆皇融环保科技有限公司",
                           "深圳市智启世纪资产管理有限公司",
                           "上海诺米信息科技有限公司",
                           "上海金贝壳投资中心（有限合伙）",
                           "北京元古投资中心（有限合伙）",
                           "上海诺明投资中心（有限合伙）",
                           "上海迈复科技有限公司",
                           "上海申言资产管理有限公司",
                           "UNIFI TECHNOLOGY INFORMATION SEVICE CO.",
                           "原动天(厦门)资产管理有限公司",
                           "湖南讯付达企业管理有限公司",
                           "武汉关仟佰信息咨询有限公司",
                           "陕西正维金融信息服务有限公司",
                           "安徽省和盈来企业管理有限公司",
                           "江西华盛商务信息服务有限公司",
                           "亳州麦子信息科技有限公司",
                           "麦子(北京)保险经纪有限公司",
                           "杭州易股台网络技术有限公司",
                           "武汉世纪方圆软件有限公司",
                            "北京神州微融金融信息服务有限公司",
                            "上海诺诺镑客金融信息服务有限公司");



--关联方借款数据查询
SELECT m.user_id 用户id
        ,min(m.real_name) 用户名
        ,count(1) 借款笔数
        ,min(m.id_num) 身份证
        ,min(m.p_id) p_id
        ,min(m.biz_name) 业务线
        ,min(m.bo_finish_time) 借款时间
        ,sum(m.bo_finish_price) 借款金额
        ,sum(m.br_price_b) 贷款余额
        ,max(br_repay_time) 最后还款时间
        ,max(br_time) 最后计划时间
FROM
  (SELECT bo.user_id,
          us.real_name,
          us.id_num,
          bo.bo_id,
          bo.p_id,
          p.biz_name,
          bo.bo_finish_time,
          bo.bo_finish_price,
          br.br_price_b,
          br2.br_repay_time,
          br2.br_time
   FROM idw.fact_borrows bo
   LEFT JOIN
     (SELECT bo_id,
             sum(br_price_b) br_price_b
      FROM idw.fact_borrows_repayment
      WHERE br_is_repay = 0
      GROUP BY bo_id) br ON bo.bo_id = br.bo_id
   LEFT JOIN odsopr.user_info us ON us.id = bo.user_id
   LEFT JOIN odsopr.dim_bia_asset_product p ON bo.p_key = p.p_key
   LEFT JOIN
     ( SELECT bo_id,
              max(br_repay_time) br_repay_time,
              max(br_time) br_time
      FROM idw.fact_borrows_repayment
      GROUP BY bo_id ) br2 ON bo.bo_id = br2.bo_id
   WHERE 1=1
     AND bo.bo_is_success = 1
     AND us.real_name IN ( "上海麦子资产管理有限公司",
                           "北京财神爷爷科技发展有限公司",
                           "上海图辰企业信用征信有限公司",
                           "上海爱曼商务咨询有限公司",
                           "上海诺明投资中心（有限合伙）",
                           "上海金贝壳投资中心（有限合伙）",
                           "上海积曼信息科技有限公司",
                           "仟佰清（杭州）资产管理有限公司",
                           "上海仁康物业经营管理有限公司",
                           "上海旺倍信息科技有限公司",
                           "苏州镑天商务信息咨询有限公司",
                           "北京华夏亚通科技有限公司",
                           "北京华夏亚通科技有限公司成都分公司",
                           "荣域商业保理（深圳）有限公司",
                           "大房东（上海）金融科技有限公司",
                           "上海诺容企业管理咨询有限公司",
                           "合肥大房东信息咨询服务有限公司",
                           "大房东信息咨询无锡有限公司",
                           "大房东（苏州）信息科技有限公司",
                           "上海诺宜财富管理有限公司",
                           "上海诺宜财富管理有限公司苏州分公司",
                           "霍尔果斯万恒金融信息服务有限公司",
                           "中融寰球国际融资租赁（深圳）有限公司",
                           "北京买呀科技发展有限公司",
                           "冒泡（上海）文化传媒有限公司",
                           "名校贷（上海）金融科技有限公司",
                           "上海诺友金融信息服务有限公司",
                           "财神爷爷（上海）金融科技有限公司",
                           "上海岦彤企业发展中心（有限合伙）",
                           "上海速宜投资咨询有限公司",
                           "北京元古企业管理中心（有限合伙）",
                           "上海诺明投资中心（有限合伙）",
                           "上海琛坤科技发展有限公司",
                           "上海伟容商务咨询中心（有限合伙）",
                           "上海明容企业管理中心（有限合伙）",
                           "上海年图企业管理中心（有限合伙）",
                           "上海葩星信息科技有限公司",
                           "北京中爱梦想投资中心（有限合伙）",
                           "上海金贝壳投资中心（有限合伙）",
                           "重庆皇融环保科技有限公司",
                           "深圳市智启世纪资产管理有限公司",
                           "上海诺米信息科技有限公司",
                           "上海金贝壳投资中心（有限合伙）",
                           "北京元古投资中心（有限合伙）",
                           "上海诺明投资中心（有限合伙）",
                           "上海迈复科技有限公司",
                           "上海申言资产管理有限公司",
                           "UNIFI TECHNOLOGY INFORMATION SEVICE CO.",
                           "原动天(厦门)资产管理有限公司",
                           "湖南讯付达企业管理有限公司",
                           "武汉关仟佰信息咨询有限公司",
                           "陕西正维金融信息服务有限公司",
                           "安徽省和盈来企业管理有限公司",
                           "江西华盛商务信息服务有限公司",
                           "亳州麦子信息科技有限公司",
                           "麦子(北京)保险经纪有限公司",
                           "杭州易股台网络技术有限公司",
                           "武汉世纪方圆软件有限公司",
                            "北京神州微融金融信息服务有限公司",
                            "上海诺诺镑客金融信息服务有限公司") ) m
GROUP BY m.user_id
ORDER BY 借款金额 DESC;





--夏志敏
SELECT   m.user_id 用户id
        ,min(m.real_name) 用户名
        ,count(1) 借款笔数
        ,min(m.id_num) 身份证
        ,min(m.p_id) p_id
        ,min(m.biz_name) 业务线
        ,min(m.bo_finish_time) 借款时间
        ,sum(m.bo_finish_price) 借款金额
        ,sum(m.br_price_b) 贷款余额
        ,max(br_repay_time) 最后还款时间
        ,max(br_time) 最后计划时间
FROM
  (SELECT bo.user_id,
          us.real_name,
          us.id_num,
          bo.bo_id,
          bo.p_id,
          p.biz_name,
          bo.bo_finish_time,
          bo.bo_finish_price,
          br.br_price_b,
          br2.br_repay_time,
          br2.br_time
   FROM idw.fact_borrows bo
   LEFT JOIN
     (SELECT bo_id,
             sum(br_price_b) br_price_b
      FROM idw.fact_borrows_repayment
      WHERE br_is_repay = 0
      GROUP BY bo_id) br ON bo.bo_id = br.bo_id
   LEFT JOIN odsopr.user_info us ON us.id = bo.user_id
   LEFT JOIN odsopr.dim_bia_asset_product p ON bo.p_key = p.p_key
   LEFT JOIN
     ( SELECT bo_id,
              max(br_repay_time) br_repay_time,
              max(br_time) br_time
      FROM idw.fact_borrows_repayment
      GROUP BY bo_id ) br2 ON bo.bo_id = br2.bo_id
   WHERE 1=1
     AND bo.bo_is_success = 1
     AND us.real_name IN ( "夏志敏") ) m
GROUP BY m.user_id
ORDER BY 借款金额 DESC;


--下载荣域商业保理出借数据
select
va.user_id 用户ID
,u.real_name 真实名字
,va.amount 投资金额
,va.create_time  投资时间
,va.cash_time 结算时间
from odsopr.vip_account va
left join odsopr.user_info u on u.id= va.user_id
where user_id = 1060684;


--关联方历史投资
SELECT va.user_id '用户ID',u.real_name '真实名字',va.amount '投资金额',va.create_time '投资时间',va.cash_time '结算时间' from odsopr.vip_account va
LEFT JOIN odsopr.user_info u on u.id = va.user_id
where u.real_name in (
                           "上海麦子资产管理有限公司",
                           "北京财神爷爷科技发展有限公司",
                           "上海图辰企业信用征信有限公司",
                           "上海爱曼商务咨询有限公司",
                           "上海诺明投资中心（有限合伙）",
                           "上海金贝壳投资中心（有限合伙）",
                           "上海积曼信息科技有限公司",
                           "仟佰清（杭州）资产管理有限公司",
                           "上海仁康物业经营管理有限公司",
                           "上海旺倍信息科技有限公司",
                           "苏州镑天商务信息咨询有限公司",
                           "北京华夏亚通科技有限公司",
                           "北京华夏亚通科技有限公司成都分公司",
                           "荣域商业保理（深圳）有限公司",
                           "大房东（上海）金融科技有限公司",
                           "上海诺容企业管理咨询有限公司",
                           "合肥大房东信息咨询服务有限公司",
                           "大房东信息咨询无锡有限公司",
                           "大房东（苏州）信息科技有限公司",
                           "上海诺宜财富管理有限公司",
                           "上海诺宜财富管理有限公司苏州分公司",
                           "霍尔果斯万恒金融信息服务有限公司",
                           "中融寰球国际融资租赁（深圳）有限公司",
                           "北京买呀科技发展有限公司",
                           "冒泡（上海）文化传媒有限公司",
                           "名校贷（上海）金融科技有限公司",
                           "上海诺友金融信息服务有限公司",
                           "财神爷爷（上海）金融科技有限公司",
                           "上海岦彤企业发展中心（有限合伙）",
                           "上海速宜投资咨询有限公司",
                           "北京元古企业管理中心（有限合伙）",
                           "上海诺明投资中心（有限合伙）",
                           "上海琛坤科技发展有限公司",
                           "上海伟容商务咨询中心（有限合伙）",
                           "上海明容企业管理中心（有限合伙）",
                           "上海年图企业管理中心（有限合伙）",
                           "上海葩星信息科技有限公司",
                           "北京中爱梦想投资中心（有限合伙）",
                           "上海金贝壳投资中心（有限合伙）",
                           "重庆皇融环保科技有限公司",
                           "深圳市智启世纪资产管理有限公司",
                           "上海诺米信息科技有限公司",
                           "上海金贝壳投资中心（有限合伙）",
                           "北京元古投资中心（有限合伙）",
                           "上海诺明投资中心（有限合伙）",
                           "上海迈复科技有限公司",
                           "上海申言资产管理有限公司",
                           "UNIFI TECHNOLOGY INFORMATION SEVICE CO.",
                           "原动天(厦门)资产管理有限公司",
                           "湖南讯付达企业管理有限公司",
                           "武汉关仟佰信息咨询有限公司",
                           "陕西正维金融信息服务有限公司",
                           "安徽省和盈来企业管理有限公司",
                           "江西华盛商务信息服务有限公司",
                           "亳州麦子信息科技有限公司",
                           "麦子(北京)保险经纪有限公司",
                           "杭州易股台网络技术有限公司",
                           "武汉世纪方圆软件有限公司",
                            "北京神州微融金融信息服务有限公司",
                            "上海诺诺镑客金融信息服务有限公司"
);





--关联方当前投资
select
user_id 用户ID,
aum 在投金额,
u.real_name 真实姓名,
u.mobile_num 手机号

from
(
SELECT user_id,sum(aum) aum
FROM(
SELECT m.user_id,
       m.aum
FROM
  (SELECT user_id,
          '财神' AS platform,
          SUM(aum) aum
   FROM idw. fact_biz_csyy_aum ds
   WHERE 1=1
     AND ds.stat_date='2018-10-09'
   GROUP BY 1,
            2
   UNION ALL SELECT user_id,
                    '诺诺',
                   SUM(aum) aum
   FROM idw. fact_biz_nono_aum ds
   WHERE 1=1
     AND ds.stat_date='2018-10-09'
   GROUP BY 1,
            2) m

WHERE user_id in
(
select id from odsopr.user_info where real_name in (
                           "上海麦子资产管理有限公司",
                           "北京财神爷爷科技发展有限公司",
                           "上海图辰企业信用征信有限公司",
                           "上海爱曼商务咨询有限公司",
                           "上海诺明投资中心（有限合伙）",
                           "上海金贝壳投资中心（有限合伙）",
                           "上海积曼信息科技有限公司",
                           "仟佰清（杭州）资产管理有限公司",
                           "上海仁康物业经营管理有限公司",
                           "上海旺倍信息科技有限公司",
                           "苏州镑天商务信息咨询有限公司",
                           "北京华夏亚通科技有限公司",
                           "北京华夏亚通科技有限公司成都分公司",
                           "荣域商业保理（深圳）有限公司",
                           "大房东（上海）金融科技有限公司",
                           "上海诺容企业管理咨询有限公司",
                           "合肥大房东信息咨询服务有限公司",
                           "大房东信息咨询无锡有限公司",
                           "大房东（苏州）信息科技有限公司",
                           "上海诺宜财富管理有限公司",
                           "上海诺宜财富管理有限公司苏州分公司",
                           "霍尔果斯万恒金融信息服务有限公司",
                           "中融寰球国际融资租赁（深圳）有限公司",
                           "北京买呀科技发展有限公司",
                           "冒泡（上海）文化传媒有限公司",
                           "名校贷（上海）金融科技有限公司",
                           "上海诺友金融信息服务有限公司",
                           "财神爷爷（上海）金融科技有限公司",
                           "上海岦彤企业发展中心（有限合伙）",
                           "上海速宜投资咨询有限公司",
                           "北京元古企业管理中心（有限合伙）",
                           "上海诺明投资中心（有限合伙）",
                           "上海琛坤科技发展有限公司",
                           "上海伟容商务咨询中心（有限合伙）",
                           "上海明容企业管理中心（有限合伙）",
                           "上海年图企业管理中心（有限合伙）",
                           "上海葩星信息科技有限公司",
                           "北京中爱梦想投资中心（有限合伙）",
                           "上海金贝壳投资中心（有限合伙）",
                           "重庆皇融环保科技有限公司",
                           "深圳市智启世纪资产管理有限公司",
                           "上海诺米信息科技有限公司",
                           "上海金贝壳投资中心（有限合伙）",
                           "北京元古投资中心（有限合伙）",
                           "上海诺明投资中心（有限合伙）",
                           "上海迈复科技有限公司",
                           "上海申言资产管理有限公司",
                           "UNIFI TECHNOLOGY INFORMATION SEVICE CO.",
                           "原动天(厦门)资产管理有限公司",
                           "湖南讯付达企业管理有限公司",
                           "武汉关仟佰信息咨询有限公司",
                           "陕西正维金融信息服务有限公司",
                           "安徽省和盈来企业管理有限公司",
                           "江西华盛商务信息服务有限公司",
                           "亳州麦子信息科技有限公司",
                           "麦子(北京)保险经纪有限公司",
                           "杭州易股台网络技术有限公司",
                           "武汉世纪方圆软件有限公司",
                            "北京神州微融金融信息服务有限公司",
                            "上海诺诺镑客金融信息服务有限公司"

)
)
) n
group by user_id

)t

left join odsopr.user_info u on t.user_id = u.id
order by aum desc;


--累计投资
--公司高管及亲属累计金额明细
SELECT va.user_id 用户ID ,
       min(u.real_name) 真实姓名,
       sum(va.amount) 投资金额
FROM odsopr.vip_account va
LEFT JOIN odsopr.user_info u ON va.user_id = u.id
WHERE u.real_name IN ("黄大容",
                      "龚文魁",
                      "石蔚明",
                      "李晓忠",
                      "陈弘",
                      "彭琛",
                      "周玉琳",
                      "谢知君",
                      "彭新贵",
                      "全心焕",
                      "季玉珍",
                      "彭思勤",
                      "李小燕",
                      "李忠林",
                      "李四英",
                      "李三英",
                      "庞青",
                      "陈奕",
                      "陈媛",
                      "赵铃",
                      "黄正良",
                      "何廷淑",
                      "夏音希",
                      "黄大林",
                      "周志泽",
                      "叶馨",
                      "韦秋金",
                      "石振瑛",
                      "何飞九",
                      "刘诗洋",
                      "石向明",
                      "王金英",
                      "柳嗣琪",
                      "谢尚希",
                      "谢丹妮",
                      "谢萍妮",
                      "LI XIAOZHONG")
GROUP BY user_id
;




