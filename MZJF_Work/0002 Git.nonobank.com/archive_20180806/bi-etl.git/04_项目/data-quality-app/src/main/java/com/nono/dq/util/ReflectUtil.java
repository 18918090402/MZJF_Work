package com.nono.dq.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

public class ReflectUtil {

	public static Object getValueByField(Object obj, String field) throws Exception {
		Field[] fields = obj.getClass().getDeclaredFields();
		
		for (Field refField : fields) {
			if (refField.getName().equals(field)) {
				refField.setAccessible(true);
				return refField.get(obj);
			}
		}
		return null;
	}
	/**
	 * 根据参数名、参数类型、
	 * @param obj
	 * @param methodName 方法名
	 * @param parameterTypes 方法类型
	 * @param args 方法值
	 * @return
	 * @throws Exception
	 */
	public static Object getValueByMethod(Object obj,String methodName,Class<?>[] parameterTypes,Object[] args) throws Exception {
		Method method= obj.getClass().getMethod(methodName,parameterTypes);
		if(method!=null){
			return method.invoke(obj, args);
		}
		return null;
	}
}
