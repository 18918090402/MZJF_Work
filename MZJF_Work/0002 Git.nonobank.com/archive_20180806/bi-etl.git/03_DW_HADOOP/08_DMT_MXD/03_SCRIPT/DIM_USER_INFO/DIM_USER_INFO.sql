set mapreduce.job.name = dmt_mxd_dim_user_info_01;
set mapreduce.job.queuename = etl-dw;

INSERT overwrite table DMT_MXD.DIM_USER_INFO
  SELECT USER_ID,
         USER_NAME,
         case
           when GENDER = 1 then
            '男'
           when GENDER = 2 then
            '女'
           else
            '未知'
         end GENDER,
         case
           when year(REGISTER_TIME) - year(BIRTHDAY) >= 18 and
                year(REGISTER_TIME) - year(BIRTHDAY) <= 50 then
            cast((year(REGISTER_TIME) - year(BIRTHDAY)) as int)
           else
            null
         end AGE,
         case
           when month(REGISTER_TIME) < 9 and
                (year(REGISTER_TIME) - cast(year(EDU_START_DATE) as int)) >= 1 and
                (year(REGISTER_TIME) - cast(year(EDU_START_DATE) as int)) <= 5 then
            cast((year(REGISTER_TIME) - cast(year(EDU_START_DATE) as int)) as int)
           when month(REGISTER_TIME) >= 9 and
                (year(REGISTER_TIME) - cast(year(EDU_START_DATE) as int) + 1) >= 1 and
                (year(REGISTER_TIME) - cast(year(EDU_START_DATE) as int) + 1) <= 5 then
            cast((year(REGISTER_TIME) - cast(year(EDU_START_DATE) as int) + 1) as int)
           else
            null
         end GRADE,
         MXD_EDUCATION EDUCATION,
         CURRENT_PROVINCE_NAME REGISTER_PROVINCE,
         SCHOOL_PROVINCE_NAME SCHOOL_PROVINCE,
         ACADEMY SCHOOL,
         REGISTER_TERMINAL TERMINAL_NAME,
         'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME
    FROM idw.dim_user ui;