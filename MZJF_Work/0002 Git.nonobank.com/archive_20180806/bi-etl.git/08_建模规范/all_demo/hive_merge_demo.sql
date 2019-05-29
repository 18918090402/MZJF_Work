##################################################################################################
#
#   Created by yening on 2016/11/09.
#	hive merge demo 包含两种情况：
# 		1、当天合并：新增数据与当天当前最大分区数据合并，产生最新的分区
#		2、历史合并：当天最后一个分区与历史全量合并
#		
####################################################################################################



	## 当天合并：新增数据与当天当前最大分区数据合并，产生最新的分区
 	## 获取当天最大partition值
	last_partition=$(hive -e "show partitions ods.ods_$table_cur" | grep -v "partition" | sort -r |head -1 |sed  "s/.*patch=//")

	# 以当前时间戳为分区值
	new_partition=$(hive -e "select unix_timestamp();")

	if [[ "$last_partition" != "" ]] || [[ "$last_partition" != "NULL" ]];then
		# 当天数据第一个分区
		`hive -e "
				  	SET hive.exec.dynamic.partition = true;
					SET hive.exec.dynamic.partition.mode = nonstrict;
					SET hive.exec.max.dynamic.partitions.pernode = 1000;
					SET hive.exec.max.dynamic.partitions = 100000;
					insert overwrite table ods.ods_$table_cur partition(patch)
					select *,$new_partition from ods.ods_$table_tmp;
				"`
	else
		`hive -e "
					SET hive.exec.dynamic.partition = true;
					SET hive.exec.dynamic.partition.mode = nonstrict;
					SET hive.exec.max.dynamic.partitions.pernode = 1000;
					SET hive.exec.max.dynamic.partitions = 100000;
					insert overwrite table ods.ods_$table_cur partition(patch) 
					select *,$new_partition from 
					(
					 	select cur.* from 
							(select $field_list from ods.ods_$table_cur where patch=$last_partition) cur 
							left join ods.ods_$table_tmp tmp 
							on cur.$primary_key = tmp.$primary_key 
							where tmp.primary_key is null
						union all
							select * from ods.ods_$table_tmp
					) t;
				"`
	fi



	## 历史合并：当天最后一个分区与历史全量合并
	# 获取历史数据表最大partition值
	his_last_partition=$(hive -e "show partitions ods.ods_$table_his" | grep -v "partition"| sort -r |head -1|sed "s/.*$partition_name=//")

	# 获取当天最大partition值
	last_partition=$(hive -e "show partitions ods.ods_$table_cur" | grep -v "partition" | sort -r |head -1 | sed  "s/.*patch=//")

	if [[ "$his_last_partition" != "" ]] || [[ "$his_last_partition" != "NULL" ]];then
		# 历史数据第一个分区
		`hive -e "
				  	SET hive.exec.dynamic.partition = true;
					SET hive.exec.dynamic.partition.mode = nonstrict;
					SET hive.exec.max.dynamic.partitions.pernode = 1000;
					SET hive.exec.max.dynamic.partitions = 100000;
					insert overwrite table ods.ods_$table_his partition($partition_name)
					select *,$partition_value from ods.ods_$table_cur where patch=$last_partition;
				"`
	else
		`hive -e "
					SET hive.exec.dynamic.partition = true;
					SET hive.exec.dynamic.partition.mode = nonstrict;
					SET hive.exec.max.dynamic.partitions.pernode = 1000;
					SET hive.exec.max.dynamic.partitions = 100000;
					insert overwrite table ods.ods_$table_his partition($partition_name) 
					select * from 
					(
					 	select his.* from 
							(select $field_list,$partition_value from ods.ods_$table_his his 
							left join ods.ods_$table_cur cur 
							on his.$primary_key = cur.$primary_key 
							where cur.primary_key is null
						union all
							select *,$partition_value from ods.ods_$table_cur where patch=$last_partition
					) t;
				"`
	fi

		
