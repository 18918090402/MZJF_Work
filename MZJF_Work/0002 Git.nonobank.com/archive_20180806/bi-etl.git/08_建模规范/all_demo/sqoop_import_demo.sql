
##################################################################################################
#
#   Created by yening on 2016/11/08.
#	sqoop improt demo 包含三种情况：
# 		1、首次数据导入，带自动创建目标表
#		2、增量模式（id增量）：append
#		3、增量模式（更新时间）：lastmodified
#		4、快速导入（direct）
#	同时增加创建sqoop job demo
####################################################################################################

# sqoop-shell
# 注意事项
1) 集群启用了默认的文件压缩机制，如果想要被impala直接访问，在导入数据的格式为textfile时候，请在sqoop脚本中加入以下两行代码：
	-D mapreduce.map.output.compress=false
	-D mapreduce.output.fileoutputformat.compress=false
2) 便于任务资源管理，在数据导入中引入任务队列以及任务名称的定义。如下：
	-D mapreduce.job.queuename=t_first_load 
	-D mapred.job.name=t_activity_vip_physicalgoods_first_import 
3) 脚本中是以字段id为demo的，具体请酌情处理。
4) direct方式导入不能结合hive-drop-import-delims一起使用


import part
	
# 1) 首次导入，自动创建表
	sqoop import \
	-D mapreduce.map.output.compress=false \
	-D mapreduce.output.fileoutputformat.compress=false \
	-D mapreduce.job.queuename=t_first_load \
	-D mapred.job.name=t_activity_vip_physicalgoods_first_import \
	--connect jdbc:mysql://172.16.0.109/db_nono --username risk --password WYTn1Q1q \
	--table activity_vip_physicalgoods \
	--split-by id \
	-m 3 \
	--hive-import \
	--create-hive-table \
	--hive-table ods.t_activity_vip_physicalgoods_tmp \
	--fields-terminated-by '\001' \
	--map-column-hive id=string \
	--hive-drop-import-delims \
	--null-string '\\N' \
    --null-non-string '\\N' \
	--as-textfile;

参数说明：
	1）mapreduce.job.queuename 为任务队列的名称，用于任务的分类标识；mapred.job.name 任务名称
	2）table 为mysql中的表名
	3）split-by 结合m来使用，按哪个字段来split
	4) m 为任务的map个数
	5) create-hive-table 在hive库中创建目标表，可配合map-column-hive来指定目标的字段类型（用逗号分割）
	6) hive-table 为目标表
	7) fields-terminated-by 字段分割符，默认为'\001'。
	7) hive-drop-import-delims 删除字段中\n,\001,\002,\003等系统的分割符
	8) as-textfile 指明目标表存储的数据格式，也是配合create-hive-table来使用，可选值：--as-avrodatafile、--as-sequencefile、--as-textfile 、--as-parquetfile


# 2) 增量导入，按id增量(append)
	sqoop import \
	-D mapred.job.queue.name=t_append_load \
	--connect jdbc:mysql://172.16.0.109/db_nono --username risk --password WYTn1Q1q \
	--table activity_vip_physicalgoods \
	--split-by id \
	--hive-import \
	--hive-database ods \
	--hive-table t_activity_vip_physicalgoods_tmp \
	--hive-drop-import-delims \
	--check-column id \
	--incremental append \
	--last-value 10000 \
	-m 3;


参数说明：
	0) check-column:增量的字段值
	1) incremental：增量模式为append
	2) last-value:导入大于这个值得的数据



# 3) 增量导入，按update_time增量(lastmodified)
	sqoop import \
	-D mapreduce.job.queuename=t_lastmodified_load \
	--connect jdbc:mysql://172.16.0.109/db_nono --username risk --password WYTn1Q1q \
	--query 'select * from user_info where id > 5 and $CONDITIONS' \
	--split-by id \
	-m 3 \
	--hive-import \
	--hive-database tmp \
	--hive-table t_user_info_tmp \
	--hive-drop-import-delims \
	--check-column update_time \
	--incremental lastmodified \
	--last-value  '2016/11/08 13:00:00' \
	--target-dir /user/hive/warehoure/tmp.db/t_user_info_tmp;


参数说明:
	1) incremental：增量模式为 lastmodified
	2) last-value:导入大于这个值得的数据
	3) 当使用--query的时候需要有$CONDITIONS
	4) target-dir：指定HDFS上存放数据目录
	  

# 4) 快速导入:采用direct方式，类似mysqldump
	sqoop import \
	-D mapreduce.map.output.compress=false \
	-D mapreduce.output.fileoutputformat.compress=false \
	-D mapreduce.job.queuename=t_first_load \
	--connect jdbc:mysql://172.16.0.109/db_nono --username risk --password WYTn1Q1q \
	--table activity_vip_physicalgoods \
	--split-by id \
	-m 3 \
	--hive-import \
	--create-hive-table \
	--hive-table ods.t_activity_vip_physicalgoods_tmp \
	--fields-terminated-by '\001' \
	--map-column-hive id=string \
	--as-textfile \
	--direct


sqoop job demo part
#创建job
	sqoop job \
	--create t_first_load_job \
	-- import \
	--connect jdbc:mysql://172.16.0.109/db_nono --username risk --password WYTn1Q1q \
	--table sms_task_detail \
	--split-by id \
	--hive-import \
	--hive-table ods.t_sms_task_detail_tmp \
	--fields-terminated-by '\001' \
	--map-column-hive id=string \
	--hive-drop-import-delims \
	-m 3 

#列出所有job
	sqoop job --list

#查看job
	sqoop job --show t_first_load_job
	Enter password: 
	Job: t_first_load_job
	Tool: import
	Options:
	----------------------------
	verbose = false
	hcatalog.drop.and.create.table = false
	...

#执行job
	sqoop job --exec t_first_load_job
 
 
#重写参数
	sqoop job --exec t_first_load_job -- --map-column-hive id=int 
 
  