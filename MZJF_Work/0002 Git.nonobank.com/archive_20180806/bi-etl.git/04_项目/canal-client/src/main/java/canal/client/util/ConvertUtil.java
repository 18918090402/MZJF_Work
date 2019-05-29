package canal.client.util;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * 转换工具类
 * 
 * **/
public class ConvertUtil {
	public static Set<String> StringToSet(String str, String split) {
		Set<String> set = null;
		if ((!"".equals(str)) && (!str.isEmpty()) && str != null) {
			str = str.toLowerCase();
			String[] arr = str.split(split);// 根据“ ”和“,”区分
			set = new HashSet<String>(Arrays.asList(arr));
		}
		return set;
	}
}
