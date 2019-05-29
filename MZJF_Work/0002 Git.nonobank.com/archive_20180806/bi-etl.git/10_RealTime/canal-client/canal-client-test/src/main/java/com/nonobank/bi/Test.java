package com.nonobank.bi;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		StringBuffer sbf = new StringBuffer("aaa");
		StringBuilder sbd = new StringBuilder("aaa");
		sbf.append("1");
		sbd.append("1");
		
		String str1 = new String("aaa");
		String str2 = new String("aaa");
		
		String str3 = "aaa";
		String str4 = "aaa";
		
		System.out.println(str1==str2);
	}
}
