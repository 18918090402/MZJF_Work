hive -e "
    SET hive.cli.print.header=true; 
    select concat_ws
    (
        ',',
        coalesce(htbh,''),
        coalesce(cast(bo_id as string),''),
        coalesce(cast(user_id as string),''),
        coalesce(real_name,''),
        coalesce(p_name,''),
        coalesce(cast(bo_expect as string),''),
        coalesce(bo_agree_time,''),
        coalesce(bo_finish_time,''),
        coalesce(bo_repay_end_time,''),
        coalesce(cast(bo_finish_price as string),''),
        coalesce(cast(avg_fee as string),''),
        coalesce(cast(bo_rate as string),''),
        coalesce(cast(total_fee as string),''),
        coalesce(cast(br_extra_fee as string),''),
        coalesce(cast(repayed_extra_fee as string),''),
        coalesce(cast(unrecover_br_extra_fee as string),''),
        coalesce(bo_all_repayed,''),
        coalesce(br_time,''),
        coalesce(br_repay_time,''),
        coalesce(cast(br_service_fee as string),''),
        coalesce(create_day,'')
    )
    from msc.sj_data_tmp20190307 
    limit 100
" > sj.csv 


--
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2016-03" ' | sed -e 's/\t/,/g'  > sj_201603.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2016-04" ' | sed -e 's/\t/,/g'  > sj_201604.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2016-05" ' | sed -e 's/\t/,/g'  > sj_201605.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2016-06" ' | sed -e 's/\t/,/g'  > sj_201606.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2016-07" ' | sed -e 's/\t/,/g'  > sj_201607.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2016-08" ' | sed -e 's/\t/,/g'  > sj_201608.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2016-09" ' | sed -e 's/\t/,/g'  > sj_201609.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2016-10" ' | sed -e 's/\t/,/g'  > sj_201610.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2016-11" ' | sed -e 's/\t/,/g'  > sj_201611.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2016-12" ' | sed -e 's/\t/,/g'  > sj_201612.csv 


--
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2017-04" ' | sed -e 's/\t/,/g'  > sj_201704.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2017-05" ' | sed -e 's/\t/,/g'  > sj_201705.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2017-06" ' | sed -e 's/\t/,/g'  > sj_201706.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2017-07" ' | sed -e 's/\t/,/g'  > sj_201707.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2017-08" ' | sed -e 's/\t/,/g'  > sj_201708.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2017-09" ' | sed -e 's/\t/,/g'  > sj_201709.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2017-10" ' | sed -e 's/\t/,/g'  > sj_201710.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2017-11" ' | sed -e 's/\t/,/g'  > sj_201711.csv 
hive -e 'SET hive.cli.print.header=true; select * from msc.sj_data_tmp20190307 where substr(create_day,1,7) = "2017-12" ' | sed -e 's/\t/,/g'  > sj_201712.csv 



hive -e 'SET hive.cli.print.header=true; select * from DMT_BF.NONO_90_DAYS_AVG_INVEST_CHANGE_LOG where stat_date = "2019-03-11" | sed -e 's/\t/,/g'  > NONO_90_DAYS_AVG_INVEST_CHANGE_LOG.csv 
