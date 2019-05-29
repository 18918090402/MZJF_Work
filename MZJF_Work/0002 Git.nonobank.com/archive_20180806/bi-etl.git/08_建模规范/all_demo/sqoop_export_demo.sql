##################################################################################################
#
#   Created by yening on 2016/11/09.
#	sqoop export demo 包含三种情况：
# 		1、全表导出
#		2、更新导出: 只更新数据
#		3、更新导出：更新的同时插入数据
####################################################################################################

# sqoop-shell
# 注意事项
	1) 导出数据时，目标表必须已经存在
	2) 注意数据内容与目标字段的类型匹配及空值情况



# 1、全表导出
	sqoop export \
	-D mapreduce.job.queuename=t_all_export \
	-D mapred.job.name=t_activity_vip_physicalgoods_all_export \
	--connect jdbc:mysql://localhost:3306/test    \
	--username test  --password test \
	--table activity_vip_physicalgoods         \
	--export-dir /user/hive/warehouse/ods.db/t_activity_vip_physicalgoods_tmp  \
	--fields-terminated-by '\001';


参数说明：
	1) table:目标表的名称
	2) export-dir：hive表在hdfs上的路径
	3）fields-terminated-by：字段分割符，和hive表结构一致




# 2、更新导出(只更新数据，不插入新数据)
	sqoop export \
	-D mapreduce.job.queuename=t_all_export \
	-D mapred.job.name=t_activity_vip_physicalgoods_update_export \
	--connect jdbc:mysql://localhost:3306/test    \
	--username test  --password test \
	--table activity_vip_physicalgoods         \
	--export-dir /user/hive/warehouse/ods.db/t_activity_vip_physicalgoods_tmp_export2  \
	--fields-terminated-by '\001' \
	--input-null-string '\\N' \
	--input-null-non-string '\\N' \
	--update-key id;
参数说明：
	1）input-null-string:数据库中string列NULL的值 
	2) input-null-non-string:数据库中非string列NULL的值
	3) update-key:更新依据的字键,多个字段可以用逗号分隔




# 3、更新导出(不仅更新数据，同时插入新数据)
	sqoop export \
	-D mapreduce.job.queuename=t_all_export \
	-D mapred.job.name=t_activity_vip_physicalgoods_update_export \
	--connect jdbc:mysql://localhost:3306/test    \
	--username test  --password test \
	--table activity_vip_physicalgoods         \
	--export-dir /user/hive/warehouse/ods.db/t_activity_vip_physicalgoods_tmp_export2  \
	--fields-terminated-by '\001' \
	--input-null-string '\\N' \
	--input-null-non-string '\\N' \
	--update-mode allowinsert \
	--update-key id;
参数说明：
	1) update-mode:更新模式，默认为updateonly，这里设置成allowinsert，新增记录会插入导出表中
	2) update-key: 更新依据的字键，多个字段可以用逗号分隔
 




 