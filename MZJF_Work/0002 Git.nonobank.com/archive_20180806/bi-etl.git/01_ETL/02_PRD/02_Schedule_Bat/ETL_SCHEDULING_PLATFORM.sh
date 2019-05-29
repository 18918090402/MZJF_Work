#!/bin/bash

cur_folder=`dirname $0`
task_id=$1

echo $cur_folder
echo $task_id

. "${cur_folder}/set_etl_env.sh"
setETLEnv

echo ${ETL_FOLDER}

cd ${ETL_FOLDER}/02_Schedule_Bat
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%Y%m%d_%H_%M_%S")

date="$(date +"%Y-%m-%d %H:%M:%S")"

 # ---    ETL_SCHEDULING_PLATFORM ----
echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_SCHEDULING_PLATFORM_${task_id}-----" >> ${ETL_FOLDER}/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_${task_id}_${etllog}.log
   
${ETL_FOLDER}/00_PDI_Kettle/data-integration/kitchen.sh -rep=PROD -job=ETL_SCHEDULING_PLATFORM/000_000_000/01_ETL_CONTROL_MAIN -param:P_JOB_ID=${task_id} -level:Detailed >> ${ETL_FOLDER}/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_${task_id}_${etllog}.log
 
echo "$(date +"%Y-%m-%d %H:%M:%S") scripts finish ....------ETL_SCHEDULING_PLATFORM_${task_id}-----" >> ${ETL_FOLDER}/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_${task_id}_${etllog}.log