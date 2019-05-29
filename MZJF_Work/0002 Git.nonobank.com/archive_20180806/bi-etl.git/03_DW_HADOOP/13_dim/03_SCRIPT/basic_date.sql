insert overwrite table dim.basic_date
  select 'SYS' DW_CREATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_CREATE_TIME,
         'SYS' DW_UPDATE_BY,
         from_unixtime(unix_timestamp(), 'yyyy-MM-dd HH:mm:ss') DW_UPDATE_TIME,
         day_id date_key,
         day_short_desc date_name,
         day_long_desc date_desc,
         day(day_short_desc) day,
         day_short_name,
         pmod(datediff(day_short_desc, '1920-01-01') - 3, 7) week,
         week_no_desc week_desc,
         month(day_short_desc) month,
         concat(lpad(cast(month(day_short_desc) as string), 2, '0'), '月') month_desc,
         case
           when month(day_short_desc) >= 1 and month(day_short_desc) <= 3 then
            1
           when month(day_short_desc) >= 4 and month(day_short_desc) <= 6 then
            2
           when month(day_short_desc) >= 7 and month(day_short_desc) <= 9 then
            3
           when month(day_short_desc) >= 10 and month(day_short_desc) <= 12 then
            4
         end quarter,
         case
           when month(day_short_desc) >= 1 and month(day_short_desc) <= 3 then
            '1季度'
           when month(day_short_desc) >= 4 and month(day_short_desc) <= 6 then
            '2季度'
           when month(day_short_desc) >= 7 and month(day_short_desc) <= 9 then
            '3季度'
           when month(day_short_desc) >= 10 and month(day_short_desc) <= 12 then
            '4季度'
         end quarter_desc,
         year_id year,
         year_long_desc year_desc,
         constellation,
         constellation_name,
         zodiac,
         zodiac_name,
         month_id year_month,
         month_short_desc year_month_name,
         month_long_desc year_month_desc,
         to_date(trunc(day_short_desc, 'MM')) month_first_day,
         month_end month_last_day,
         quarter_id year_quarter,
         quater_long_desc year_quarter_desc,
         weekofyear(day_short_desc) year_week_no,
         case
           when weekofyear(day_short_desc) < 10 and
                month(day_short_desc) > 11 then
            (year(day_short_desc) + 1) * 100 + weekofyear(day_short_desc)
           when weekofyear(day_short_desc) > 10 and
                month(day_short_desc) < 2 then
            (year(day_short_desc) - 1) * 100 + weekofyear(day_short_desc)
           else
            year(day_short_desc) * 100 + weekofyear(day_short_desc)
         end year_week,
         concat(lpad(cast(weekofyear(day_short_desc) as string), 2, '0'),
                '周') year_week_name,
         case
           when weekofyear(day_short_desc) < 10 and
                month(day_short_desc) > 11 then
            concat(cast(year(day_short_desc) + 1 as string),
                   '年第',
                   lpad(cast(weekofyear(day_short_desc) as string), 2, '0'),
                   '周')
           when weekofyear(day_short_desc) > 10 and
                month(day_short_desc) < 2 then
            concat(cast(year(day_short_desc) - 1 as string),
                   '年第',
                   lpad(cast(weekofyear(day_short_desc) as string), 2, '0'),
                   '周')
           else
            concat(cast(year(day_short_desc) as string),
                   '年第',
                   lpad(cast(weekofyear(day_short_desc) as string), 2, '0'),
                   '周')
         end year_week_desc,
         concat(to_date(date_sub(day_short_desc,
                                 pmod(datediff(day_short_desc, '1920-01-01') - 3,
                                      7) - 1)),
                '~',
                to_date(date_add(day_short_desc,
                                 7 -
                                 pmod(datediff(day_short_desc, '1920-01-01') - 3,
                                      7)))) week_range,
         to_date(date_sub(day_short_desc,
                          pmod(datediff(day_short_desc, '1920-01-01') - 3, 7) - 1)) week_start_day,
         to_date(date_add(day_short_desc,
                          7 -
                          pmod(datediff(day_short_desc, '1920-01-01') - 3, 7))) week_end_day
    from idw.dim_date;