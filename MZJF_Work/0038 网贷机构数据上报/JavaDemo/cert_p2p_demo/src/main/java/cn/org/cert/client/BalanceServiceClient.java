package cn.org.cert.client;

import java.util.Random;

import org.cert.utils.SHA;

/**
 * 网贷机构对账接口样例
 *
 * @author 国家互联网应急中心
 */
public class BalanceServiceClient {

	private static String url1 = "https://api.ifcert.org.cn/balanceService/v15/yiBuMessage";//企业查询异步消息表
	private static String url2 = "https://api.ifcert.org.cn/balanceService/v15/batchNum";//企业推送批次数
	private static String url3 = "https://api.ifcert.org.cn/balanceService/v15/batchList";//企业推送批次列表
	private static String url4 = "https://api.ifcert.org.cn/balanceService/v15/dataList";//企业某批次数据列表

	public static String sourceCode = "企业自己的sourceCode"; 
	public static String apiKey = "企业自己的apiKey"; 

	public static void main(String[] args) throws Exception {
		String batchNum = "需要查询的批次号";
		String dataType = "";
		String version = "1.5";
		String infType = "";
		
		// 1：查询异步消息
		test1(apiKey, batchNum, dataType, sourceCode, version,infType);
		// 2：企业推送批次数
		test2(apiKey, dataType, sourceCode, version);
		// 3：企业推送批次列表
		test3(apiKey, dataType, sourceCode, version,"1");
		// 4：企业某批次数据列表
		test4(apiKey, batchNum, dataType, sourceCode, version);
	}



	// 4：企业某批次数据列表
	public static void test4(String apiKey, String batchNum, String dataType, String sourceCode, String version)
			throws Exception {
		long timestamp = System.currentTimeMillis();
		String nonce = Integer.toHexString(new Random().nextInt());
		String apiKey2 = getApiKey(apiKey, sourceCode, version, timestamp, nonce);
		StringBuilder url=new StringBuilder(url4);
		url.append("?apiKey=");
		url.append(apiKey2);
		url.append("&nonce=");
		url.append(nonce);
		url.append("&sourceCode=");
		url.append(sourceCode);
		url.append("&timestamp=");
		url.append(timestamp+"");
		url.append("&version=");
		url.append(version);
		url.append("&dataType=");
		url.append(dataType);
		url.append("&batchNum=");
		url.append(batchNum);
		String result=SendUtils.getReq(url.toString());
		System.out.println(result);
	}

	// 3：企业推送批次列表
	public static void test3(String apiKey, String dataType, String sourceCode, String version,String pageNum) throws Exception {
		long timestamp = System.currentTimeMillis();
		String nonce = Integer.toHexString(new Random().nextInt());
		String apiKey2 = getApiKey(apiKey, sourceCode, version, timestamp, nonce);
		StringBuilder url=new StringBuilder(url3);
		url.append("?apiKey=");
		url.append(apiKey2);
		url.append("&dataType=");
		url.append(dataType);
		url.append("&nonce=");
		url.append(nonce);
		url.append("&sourceCode=");
		url.append(sourceCode);
		url.append("&timestamp=");
		url.append(timestamp+"");
		url.append("&version=");
		url.append(version);
		url.append("&pageNum=");
		url.append(pageNum);
		String result=SendUtils.getReq(url.toString());
		System.out.println(result);
	}

	// 2：企业推送批次数
	public static void test2(String apiKey, String dataType, String sourceCode, String version) throws Exception {
		long timestamp = System.currentTimeMillis();
		String nonce = Integer.toHexString(new Random().nextInt());
		String apiKey2 = getApiKey(apiKey, sourceCode, version, timestamp, nonce);
		StringBuilder url=new StringBuilder(url2);
		url.append("?apiKey=");
		url.append(apiKey2);
		url.append("&nonce=");
		url.append(nonce);
		url.append("&sourceCode=");
		url.append(sourceCode);
		url.append("&timestamp=");
		url.append(timestamp+"");
		url.append("&version=");
		url.append(version);
		url.append("&dataType=");
		url.append(dataType);
		String result=SendUtils.getReq(url.toString());
		System.out.println(result);
	}

	// 1：查询异步消息
	public static void test1(String apiKey, String batchNum, String dataType, String sourceCode, String version,String infType) {
		try {
			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			String apiKey2 = getApiKey(apiKey, sourceCode, version, timestamp, nonce);
			StringBuilder url=new StringBuilder(url1);
			url.append("?apiKey=");
			url.append(apiKey2);
			url.append("&nonce=");
			url.append(nonce);
			url.append("&sourceCode=");
			url.append(sourceCode);
			url.append("&timestamp=");
			url.append(timestamp+"");
			url.append("&version=");
			url.append(version);
			url.append("&dataType=");
			url.append(dataType);
			url.append("&batchNum=");
			url.append(batchNum);
			url.append("&infType=");
			url.append(infType);
			System.out.println(url.toString());
			String result=SendUtils.getReq(url.toString());
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * apiKey加密
	 * 
	 * @param apiKey
	 * @param source_code
	 * @param version
	 *            版本号，如：v1.1-->110; v1.2-->120; v1.3-->130
	 * @return
	 * @throws CertException
	 */


	private static String getApiKey(String apiKey, String source_code, String versionStr, Long currentTime,String nonce) {

		double version_double = Double.valueOf(versionStr);
		int version =(int)(version_double*100);
		String versionHex = "0x" + Integer.toHexString(version);
		StringBuilder s = new StringBuilder();
		s.append(source_code);
		s.append(versionHex);
		s.append(apiKey);
		s.append(currentTime);
		s.append(nonce);
		String key = SHA.SHA256(s.toString());
		return key;
	}

}
