package com.nonobank.bi;

import java.util.Properties;

import org.apache.kafka.common.security.JaasUtils;

import kafka.admin.AdminUtils;
import kafka.admin.RackAwareMode;
import kafka.utils.ZkUtils;

public class Test {

	public static void main(String[] args) {
		ZkUtils zkUtils = ZkUtils.apply("DEV-BI-CDH05:2181,DEV-BI-CDH06:2181,DEV-BI-CDH07:2181/kafka", 30000, 30000, JaasUtils.isZkSecurityEnabled());
		// 创建一个单分区单副本名为t1的topic
		AdminUtils.createTopic(zkUtils, "test1", 4, 2, new Properties(), RackAwareMode.Enforced$.MODULE$);
		zkUtils.close();
	}
}