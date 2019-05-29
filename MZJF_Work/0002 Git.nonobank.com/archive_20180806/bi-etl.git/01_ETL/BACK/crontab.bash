# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command
#############################################################################################################
############################################################################################################
### 删除2天前日志
00 12 * * * /home/localadmin/ETL/02_Schedule_Bat/file_clean.sh

###################################################################################
### ETL 核心表备份
00 22 * * * /home/localadmin/ETL/02_Schedule_Bat/99_BAK_KETTLE_TABLE.sh
###################################################################################
### 回流
*/30 01-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_BACKFLOW_MAIN.sh
###################################################################################
### 关键指标 风控DMT
00 3 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_Dashboard.sh
00 7 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_Dashboard.sh
00 2 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_DMT_RM.sh
#00 5 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_DMT_RM.sh
###################################################################################
### mysql ods
#*/5 05-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_100000001.sh
#*/6 05-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_100000002.sh
#*/7 05-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_100000003.sh
#*/5 05-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_100000004.sh
#*/6 05-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_100000005.sh
*/7 05-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_100000006.sh
*/5 05-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_100000007.sh
*/6 05-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_100000008.sh
*/7 05-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_100000009.sh
*/8 05-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_100000010.sh

###################################################################################
### hadoop ods
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_110000001.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_110000002.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_110000003.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_110000004.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_110000005.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_110000006.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_110000007.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_110000008.sh
*/10 00-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_110000009.sh
*/10 00-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_110000010.sh
### hadoop IDW DMT
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_210000001.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_210000002.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_210000003.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_210000004.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_210000005.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_210000006.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_210000007.sh
*/10 00-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_210000008.sh
*/10 00-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_210000009.sh
*/10 00-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_210000010.sh
###BACK FLOW
*/10 01-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_310000001.sh
*/10 01-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_310000002.sh
*/10 01-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_310000003.sh
*/10 01-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_310000004.sh
*/10 01-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_310000005.sh
*/10 01-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_310000006.sh
*/10 01-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_310000007.sh
*/10 01-08 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_310000008.sh
*/10 01-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_310000009.sh
*/10 01-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_310000010.sh

*/10 01-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_410000001.sh
###SCD
#*/10 01-10 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_910000001.sh
#*/10 01-10 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_910000002.sh
#*/10 01-10 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_910000003.sh
#*/10 01-10 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_910000004.sh
#*/10 01-10 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_910000005.sh
#*/10 01-10 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_910000006.sh
#*/10 01-10 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_910000007.sh
#*/10 01-10 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_910000008.sh
#*/10 01-15 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_910000009.sh
#*/10 01-22 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_910000010.sh




#发送邮件 email
0 8 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_EMAIL/AVALIABLE_DEBT.sh

#短信
*/60 7-22 * * * /home/localadmin/ETL/02_Schedule_Bat/MZJK_RT/job_monitor.sh



###################################################################################
###BACK FLOW
*/10 01-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_200000001.sh
*/10 01-23 * * * /home/localadmin/ETL/02_Schedule_Bat/ETL_SCHEDULING_PLATFORM_200000002.sh

###################################################################################
#Ansible: io status
*/1 * * * * /etc/zabbix/script/iostat_output.sh

###################################################################################


##########maiya
00 7 * * * /home/localadmin/ETL/02_Schedule_Bat/maiya_job.sh
00 8 * * * /home/localadmin/ETL/02_Schedule_Bat/NC_MAIYA_YQBFB.sh

#############################################################################################################
#############################################################################################################

#Ansible: io top connect status
*/1 * * * * /etc/zabbix/script/top_connect_status.sh



#爬虫日志调度
0 * * * * /opt/anaconda3/bin/python /webapps/bi-crawl/theNetworkConsensus/run.py 1
0 12 * * * /opt/anaconda3/bin/python /webapps/bi-crawl/theNetworkConsensus/run.py 2
0 * * * * /opt/anaconda3/bin/python /webapps/bi-crawl/theNetworkConsensus/run.py 3

#行业竞品调度
#0 8 30 * * /opt/anaconda3/bin/python /webapps/bi-crawl/industryProductCrawl/run.py 4
#0 8 30 * * /opt/anaconda3/bin/python /webapps/bi-crawl/industryProductCrawl/run.py 5
#0 8 30 * * /opt/anaconda3/bin/python /webapps/bi-crawl/industryProductCrawl/run.py 6

# TODO
*/1 * * * * /opt/anaconda3/bin/python /webapps/userBehaviorSchedule/fromRedisToMysql.py  

# 发送短息
5 */1 * * * /opt/anaconda3/bin/python  /webapps/sendSMS/runJob.py  

# 监控短信
*/1 * * * * /opt/anaconda3/bin/python  /webapps/sendSMS/monitorRunJob.py
