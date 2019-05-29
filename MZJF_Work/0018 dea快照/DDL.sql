drop table if exists dmt.fact_debt_exchange_account_snapshot;

create table dmt.fact_debt_exchange_account_snapshot
(	
    user_id bigint comment '债权持有人',
    bo_id bigint comment '借款id',
    va_id bigint comment '精选对应va_id 如果非精选则为0',
    hold_num decimal(38,10) comment '持有债权总数',
    locking_num decimal(38,10) comment '锁定份额',
    transfer_num decimal(38,10) comment '已转让份额',
    original_price decimal(38,10) comment '原始价值',
    price decimal(38,10) comment '债权价值',
    lock_price decimal(38,10) comment '购买锁定金额',
    transfer_price decimal(38,10) comment '已转让金额',
    repay_price decimal(38,10) comment '还款金额',
    status int comment '状态 0:初始化 1:持有中 2：债转中 3：还款中 99：已结束',
    seri_no string comment '交易流水号',
    bank_flag int comment '存管标记 1:存管 2:非存管',
    version int comment '版本',
    create_time string comment '创建时间',
    update_time string comment '更新时间',
    dw_create_by string comment '系统字段-创建者',
    dw_create_time string comment '系统字段-创建时间',
    dw_update_by string comment '系统字段-修改者',
    dw_update_time string comment '系统字段-修改时间'
)
comment '债权持有-快照表'
partitioned by (stat_date string comment '统计日期 年-月-日')
row format delimited null defined as '' stored as parquet
tblproperties ("parquet.compression"="snappy")
;



--SQL
set mapreduce.job.name=dmt_fact_debt_exchange_account_snapshot; 
set mapreduce.job.queuename = etl-dw;  

set hive.exec.parallel=true ;
set hive.groupby.skewindata = true ;
set hive.map.aggr = true ; 

set hive.enforce.bucketing = true;

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict; 
set hive.exec.max.dynamic.partitions.pernode=100000000;
set hive.exec.max.dynamic.partitions=100000000;
set hive.exec.max.created.files=100000000;


insert overwrite table dmt.fact_debt_exchange_account_snapshot partition(stat_date)
     select user_id,
            bo_id,
            va_id,
            hold_num,
            locking_num,
            transfer_num,
            original_price,
            price,
            lock_price,
            transfer_price,
            repay_price,
            status,
            seri_no,
            bank_flag,
            version,
            create_time,
            update_time,
            'SYS' AS DW_CREATE_BY,
            from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
            'SYS' AS DW_UPDATE_BY,
            from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
            '{T_SUB_1}' stat_date
      from odsopr.debt_exchange_account dea
      where dea.price > 0 
      ;
      