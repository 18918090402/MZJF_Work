package com.nonobank.bi.common.enums;

public class CommonEnum{
	public enum CanalServerModelEnum {
		STAND_ALONE("stand-alone"),
		CLUSTER("cluster");
		
		private String value;
		
		private CanalServerModelEnum(String value){
			this.value=value;
		}
		
		public String getValue(){
			return this.value;
		}
	}
}