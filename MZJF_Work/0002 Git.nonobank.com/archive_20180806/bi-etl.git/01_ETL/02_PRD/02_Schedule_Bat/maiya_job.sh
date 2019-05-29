#!/bin/bash
source /etc/profile
cd /home/localadmin/ETL/02_Schedule_Bat

etlrun=$(date +"%Y-%m-%d %H:%M:%S")
etllog=$(date +"%Y%m%d_%H_%M_%S")


JAVA_HOME=/usr/local/java
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib
export JAVA_HOME PATH CLASSPATH

date="$(date +"%Y-%m-%d %H:%M:%S")"

export LANG="en_US.UTF-8"



           ### ---    maiya_job ----XCW

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------maiya_job-----" >> /home/localadmin/ETL/03_ETL_LOG/maiya_job$etllog.log
  /home/localadmin/ETL/00_PDI_Kettle/data-integration/kitchen.sh /file  /home/localadmin/ETL/01_Kettle_File/maiya_job/maiya_job.kjb /level:Basic >> /home/localadmin/ETL/03_ETL_LOG/maiya_job$etllog.log

            ### ---   NC_MAIYA ----麦芽所有放款

echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------maiya_bach-----" >> /home/localadmin/ETL/03_ETL_LOG/maiya_bach$etllog.log
 /home/localadmin/ETL/00_PDI_Kettle/data-integration/kitchen.sh /file  /home/localadmin/ETL/01_Kettle_File/NC_MAIYA/maiya_bach.kjb /level:Basic >> /home/localadmin/ETL/03_ETL_LOG/maiya_bach$etllog.log
            ### ---   NC_MAIYA_OVERDUE ----麦芽分案数据

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------maiya_bach_overdue-----" >> /home/localadmin/ETL/03_ETL_LOG/maiya_bach_overdue$etllog.log
  /home/localadmin/ETL/00_PDI_Kettle/data-integration/kitchen.sh /file  /home/localadmin/ETL/01_Kettle_File/NC_MAIYA_OVERDUE/maiya_bach_overdue.kjb /level:Basic >> /home/localadmin/ETL/03_ETL_LOG/maiya_bach_overdue$etllog.log

             ### ---   NC_MAIYA_YQBFB ----麦芽新增逾期未还

 echo "$(date +"%Y-%m-%d %H:%M:%S") scripts runing ....------maiya_bach_yqbfb-----" >> /home/localadmin/ETL/03_ETL_LOG/maiya_bach_yqbfb$etllog.log
  /home/localadmin/ETL/00_PDI_Kettle/data-integration/kitchen.sh /file  /home/localadmin/ETL/01_Kettle_File/NC_MAIYA_YQBFB/maiya_bach_yqbfb.kjb /level:Basic >> /home/localadmin/ETL/03_ETL_LOG/maiya_bach_yqbfb$etllog.log

 


