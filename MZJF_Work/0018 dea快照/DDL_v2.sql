drop table if exists dmt.fact_debt_exchange_account_snapshot;

create table dmt.fact_debt_exchange_account_snapshot
(	
    id bigint comment '主键ID',
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
    overdue_unpaid_price decimal(38,10) comment '逾期未还本金',
    unpaid_price decimal(38,10) comment '未还本金',
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

insert overwrite table dmt.fact_debt_exchange_account_snapshot partition(stat_date)
     select null,
            user_id,
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
            null overdue_unpaid_price,
            null unpaid_price,
            status,
            seri_no,
            bank_flag,
            version,
            create_time,
            update_time,
            DW_CREATE_BY,
            DW_CREATE_TIME,
            DW_UPDATE_BY,
            DW_UPDATE_TIME,
            stat_date
      from dmt.fact_debt_exchange_account_snapshot_bak
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
     select dea.id,
            dea.user_id,
            dea.bo_id,
            dea.va_id,
            dea.hold_num,
            dea.locking_num,
            dea.transfer_num,
            dea.original_price,
            dea.price,
            dea.lock_price,
            dea.transfer_price,
            dea.repay_price,
            sum( case when to_date(b.plan_time) <= to_date('{T_SUB_1}') and (b.success_time is null or b.plan_time < b.success_time) then b.price_principal else 0 end ) as overdue_unpaid_price_principal ,
            sum( case when to_date(b.plan_time) > to_date('{T_SUB_1}') then b.price_principal else 0 end ) as unpaid_price_principal ,
            dea.status,
            dea.seri_no,
            dea.bank_flag,
            dea.version,
            dea.create_time,
            dea.update_time,
            'SYS' AS DW_CREATE_BY,
            from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_CREATE_TIME,
            'SYS' AS DW_UPDATE_BY,
            from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') AS DW_UPDATE_TIME,
            '{T_SUB_1}' stat_date
      from odsopr.debt_exchange_account dea
 left join odsopr.invt_borrows_accept_unpaid b 
        on b.user_id = dea.user_id
       and b.bo_id = dea.bo_id
       and b.va_id = dea.va_id
       and b.seri_no = dea.seri_no
     where dea.price > 0        
  group by dea.id,
           dea.user_id,
           dea.bo_id,
           dea.va_id,
           dea.hold_num,
           dea.locking_num,
           dea.transfer_num,
           dea.original_price,
           dea.price,
           dea.lock_price,
           dea.transfer_price,
           dea.repay_price,
           dea.status,
           dea.seri_no,
           dea.bank_flag,
           dea.version,
           dea.create_time,
           dea.update_time
      ;
      
      