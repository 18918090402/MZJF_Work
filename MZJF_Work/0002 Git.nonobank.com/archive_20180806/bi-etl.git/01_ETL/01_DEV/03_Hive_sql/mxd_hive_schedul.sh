#!/bin/bash
set -e
schedulpath=/home/localadmin/ETL/Hive_Schedul/MXD
logname=mxd_hive_schedul_log_$(date +"%Y%m%d_%H_%M_%S")
begintime=$(date +"%Y-%m-%d %H:%M:%S")
echo "hive schedul begin $begintime" >> ${schedulpath}/LOG/$logname
#全量更新IDW.FACT_USER_INFO
beeline -u jdbc:hive2://bi-hd01:10000 -f ${schedulpath}/IDW/FACT_USER_INFO/insert_full_fact_user_info.sql >> ${schedulpath}/LOG/$logname 2>&1
#全量更新IDW.FACT_BORROWS
beeline -u jdbc:hive2://bi-hd01:10000 -f ${schedulpath}/IDW/FACT_BORROWS/insert_full_fact_borrows.sql >> ${schedulpath}/LOG/$logname 2>&1
#全量更新IDW.FACT_BORROWS_REPAYMENT
beeline -u jdbc:hive2://bi-hd01:10000 -f ${schedulpath}/IDW/FACT_BORROWS_REPAYMENT/insert_full_fact_borrows_repayment.sql >> ${schedulpath}/LOG/$logname 2>&1
#全量更新DMT.DIM_USER_INFO
beeline -u jdbc:hive2://bi-hd01:10000 -f ${schedulpath}/DMT/DIM_USER_INFO/insert_full_dim_user_info.sql >> ${schedulpath}/LOG/$logname 2>&1
#全量更新DMT.FACT_MXD_OPERATION
beeline -u jdbc:hive2://bi-hd01:10000 -f ${schedulpath}/DMT/FACT_MXD_OPERATION/insert_full_fact_mxd_operation.sql >> ${schedulpath}/LOG/$logname 2>&1
endtime=$(date +"%Y-%m-%d %H:%M:%S")
echo "hive schedul end $endtime" >> ${schedulpath}/LOG/$logname
cost=$(($(date +%s -d "$endtime") - $(date +%s -d "$begintime")))
echo "cost ${cost}s" >> ${schedulpath}/LOG/$logname
