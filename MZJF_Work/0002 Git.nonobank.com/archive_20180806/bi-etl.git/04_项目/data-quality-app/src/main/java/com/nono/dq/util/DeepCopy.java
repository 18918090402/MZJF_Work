package com.nono.dq.util;

import com.alibaba.fastjson.JSON;

public class DeepCopy<T> {
	
	public T jsonClone(T t){
		String json = JSON.toJSONString(t);
		return (T)JSON.parseObject(json,t.getClass());
	}
}
