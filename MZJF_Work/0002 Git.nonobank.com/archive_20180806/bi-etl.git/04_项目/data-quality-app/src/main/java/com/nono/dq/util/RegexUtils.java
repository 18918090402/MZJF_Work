package com.nono.dq.util;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.nono.dq.model.dto.metadata.DqColumnResult;
import com.nono.dq.model.dto.metadata.DqCompareResult;

public class RegexUtils {
	//抽取0+${9}+3+${1}中的数字
	private static final Pattern EXTRACT_PATTERN = Pattern.compile("\\$\\{[0-9]{1,}\\}");
	
	private static final Pattern REPLACE_PATTERN = Pattern.compile("\\$|\\{|\\}");
	/**
	 * 从表达式中抽取字段
	 * @param str
	 * @return
	 */
	public static List<Integer> extractInteger(String str){
		List<Integer> resList = new ArrayList<>();
		Matcher matcher = EXTRACT_PATTERN.matcher(str);
		while(matcher.find()){
			resList.add(Integer.valueOf(REPLACE_PATTERN.matcher(matcher.group(0)).replaceAll("")));
		}
		return resList;
	}
	/**
	 * 0+${1}+3+${2} --> 0+${348.01}+3+${34590.123}
	 * @param originStr
	 * @param dqCompareResult
	 * @return
	 */
	public static String replaceInteger(String originStr,DqColumnResult dqCompareResult){
		Pattern replacePattern = Pattern.compile("\\$\\{"+dqCompareResult.getColumnId()+"\\}");
		Matcher matcher = replacePattern.matcher(originStr);
		return matcher.replaceAll(dqCompareResult.getColumnValue());
	}
}
