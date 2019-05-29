#!/bin/bash

cur_folder=`dirname $0`

$cur_folder/set_etl_env.sh

cd $ETL_FOLDER/02_Schedule_Bat
etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%Y%m%d_%H_%M_%S")

date="$(date +"%Y-%m-%d %H:%M:%S")"

 # ---    ETL_SCHEDULING_PLATFORM_110000001 ----
echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------ETL_SCHEDULING_PLATFORM_110000001-----" >> $ETL_FOLDER/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_110000001_$etllog.log
   
$ETL_FOLDER/00_PDI_Kettle/data-integration/kitchen.sh /file  $ETL_FOLDER/01_Kettle_File/ETL_SCHEDULING_PLATFORM/000_000_000/01_ETL_CONTROL_MAIN.kjb /param:P_JOB_ID=110000001 /level:Detailed >> $ETL_FOLDER/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_110000001_$etllog.log
 
echo "$(date +"%Y-%m-%d %H:%M:%S") scripts finish ....------ETL_SCHEDULING_PLATFORM_110000001-----" >> $ETL_FOLDER/03_ETL_LOG/ETL_SCHEDULING_PLATFORM_110000001_$etllog.log
