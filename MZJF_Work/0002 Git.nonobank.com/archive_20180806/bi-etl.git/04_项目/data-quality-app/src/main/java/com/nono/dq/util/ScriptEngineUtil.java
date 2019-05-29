package com.nono.dq.util;

import java.text.DecimalFormat;

import com.googlecode.aviator.AviatorEvaluator;

public class ScriptEngineUtil {
	
	/**
	 * JS脚本计算表达式的值
	 * @param expr
	 * @return
	 * @throws Exception
	 */
	public static Object evalValue(String expr) throws Exception{
//		ScriptEngineManager manager = new ScriptEngineManager();
//		ScriptEngine engine = manager.getEngineByName("js");
//		return  engine.eval(expr);
		return AviatorEvaluator.execute(expr);
	}
	public static void main(String[] args) {
		Double a = new Double("101.4");
		DecimalFormat decimalFormat= new DecimalFormat("#.##");
		System.out.println(decimalFormat.format(a));
	}
}