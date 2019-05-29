drop table if exists dim.basic_date;
create table if not exists dim.basic_date
( 
  `dw_create_by` string COMMENT '系统字段-创建者', 
  `dw_create_time` string COMMENT '系统字段-创建时间', 
  `dw_update_by` string COMMENT '系统字段-修改者', 
  `dw_update_time` string COMMENT '系统字段-修改时间', 
  `date_key` int COMMENT '日期代理键', 
  `date_name` string COMMENT '日期名称', 
  `date_desc` string COMMENT '日期描述', 
  `day` int COMMENT '日编号', 
  `day_desc` string COMMENT '日描述', 
  `week` int COMMENT '周编号', 
  `week_desc` string COMMENT '周描述', 
  `month` int COMMENT '月编号', 
  `month_desc` string COMMENT '月描述', 
  `quarter` int COMMENT '季度编号', 
  `quarter_desc` string COMMENT '季度描述', 
  `year` int COMMENT '年编号', 
  `year_desc` string COMMENT '年份描述', 
  `constellation` int COMMENT '星座编号', 
  `constellation_name` string COMMENT '星座名称', 
  `zodiac` int COMMENT '生肖编号', 
  `zodiac_name` string COMMENT '生肖名称', 
  `year_month` int COMMENT '年月', 
  `year_month_name` string COMMENT '年月名称', 
  `year_month_desc` string COMMENT '年月描述', 
  `month_first_day` string COMMENT '月初日期', 
  `month_last_day` string COMMENT '月末日期', 
  `year_quarter` int COMMENT '年季度', 
  `year_quarter_desc` string COMMENT '年季度描述', 
  `year_week_no` int COMMENT '年周编号', 
  `year_week` int COMMENT '年周', 
  `year_week_name` string COMMENT '年周名称', 
  `year_week_desc` string COMMENT '年周描述', 
  `week_range` string COMMENT '周范围', 
  `week_start_day` string COMMENT '周起始日', 
  `week_end_day` string COMMENT '周结束日')
COMMENT '基础日期维度'
ROW FORMAT DELIMITED
  NULL DEFINED AS ''
STORED AS PARQUET 
TBLPROPERTIES ("parquet.compression"="SNAPPY");