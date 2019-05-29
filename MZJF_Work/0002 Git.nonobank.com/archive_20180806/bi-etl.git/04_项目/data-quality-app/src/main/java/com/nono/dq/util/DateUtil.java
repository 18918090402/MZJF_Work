package com.nono.dq.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {

	public static final String FORMAT_DATE = "yyyy-MM-dd";

	public static String formatStr(Date date, String format) {
		SimpleDateFormat fm = new SimpleDateFormat(format);
		return fm.format(date);
	}
	/**
	 * 当前日期:yyyy-MM-dd
	 * @return
	 */
	public static String getStringCurrentDate(){
		SimpleDateFormat fm = new SimpleDateFormat(FORMAT_DATE);
		return fm.format(new Date());
	}
	
	/**
	 * 昨天日期:yyyy-MM-dd
	 * @return
	 */
	public static String getStringLastDate(){
		Calendar cal=Calendar.getInstance();
		cal.add(Calendar.DATE,-1);
		SimpleDateFormat fm = new SimpleDateFormat(FORMAT_DATE);
		return fm.format(cal.getTime());
	}
}