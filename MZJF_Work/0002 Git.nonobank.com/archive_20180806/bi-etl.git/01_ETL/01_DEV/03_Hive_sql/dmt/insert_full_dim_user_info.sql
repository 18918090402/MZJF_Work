INSERT overwrite table DMT.DIM_USER_INFO
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
                (year(REGISTER_TIME) - cast(EDU_START_DATE as int)) >= 1 and
                (year(REGISTER_TIME) - cast(EDU_START_DATE as int)) <= 5 then
            cast((year(REGISTER_TIME) - cast(EDU_START_DATE as int)) as int)
           when month(REGISTER_TIME) >= 9 and
                (year(REGISTER_TIME) - cast(EDU_START_DATE as int) + 1) >= 1 and
                (year(REGISTER_TIME) - cast(EDU_START_DATE as int) + 1) <= 5 then
            cast((year(REGISTER_TIME) - cast(EDU_START_DATE as int) + 1) as int)
           else
            null
         end GRADE,
         EDUCATION,
         REGISTER_PROVINCE,
         SCHOOL_PROVINCE,
         SCHOOL,
         TERMINAL_NAME
    FROM IDW.FACT_USER_INFO;