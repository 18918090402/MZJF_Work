package com.scistor.aixinfclient;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.collections.set.SynchronizedSortedSet;
import org.apache.commons.lang.StringUtils;
import org.cert.open.CertException;
import org.cert.open.CertToolV1;
import org.cert.utils.SHA;

import net.sf.json.JSONObject;
import net.sf.json.processors.JsonBeanProcessor;

/**
 * 网贷机构接入接口调试样例
 *
 * @author 国家互联网应急中心
 */
public class test {
	private static String ENDPOINT1 = "https://api.ifcert.org.cn/p2p/userInfo/test";// 用户
	private static String ENDPOINT2 = "https://api.ifcert.org.cn/p2p/scatterInvest/test";// 散标
	private static String ENDPOINT5 = "https://api.ifcert.org.cn/p2p/status/test";// 散标状态
	private static String ENDPOINT10 = "https://api.ifcert.org.cn/p2p/repayPlan/test";// 还款计划
	private static String ENDPOINT9 = "https://api.ifcert.org.cn/p2p/creditor/test";// 债权信息
	private static String ENDPOINT6 = "https://api.ifcert.org.cn/p2p/transferProject/test";// 转让项目
	private static String ENDPOINT12 = "https://api.ifcert.org.cn/p2p/transferStatus/test";// 转让状态
	private static String ENDPOINT11 = "https://api.ifcert.org.cn/p2p/underTake/test";// 承接信息
	private static String ENDPOINT4 = "https://api.ifcert.org.cn/p2p/transact/test";// 交易流水
	private static String ENDPOINT13 = "https://api.ifcert.org.cn/p2p/lendProduct/test";// 产品信息
	private static String ENDPOINT14 = "https://api.ifcert.org.cn/p2p/lendProductConfig/test";// 产品配置
	private static String ENDPOINT15 = "https://api.ifcert.org.cn/p2p/lendParticulars/test";// 投资明细
	//注：以上接口地址均为测试地址，正式地址是在测试地址的基础上去掉【/test】
	
	public static String version = "1.5";
	public static String sourceCode = ""; // 企业自己的sourceCode
	public static String apiKey = ""; // 企业自己的apiKey

	public static CertToolV1 tool = new CertToolV1();
	public static Random rand = new Random();

	public static void main(String[] args) throws CertException {
		for (int i = 0; i < 1; i++) {
			userinfoTest(); // 用户
			scatterInvestTest(); // 散标
			updateStatusTest(); // 散标状态
			repayPlanTest();// 还款计划
			creditorTest();// 债权信息
			transferTest(); // 转让项目
			transferStatusTest();// 转让状态
			underTakeTest(); // 承接信息
			transactTest(); // 交易流水
//			lendProductTest();// 产品信息
//			lendProductConfigTest();// 产品配置
//			lendParticularsTest();// 投资明细
		}
	}

	/**
	 * p2p 1.5用户数据推送
	 */
	private static void userinfoTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();

				String idcard = "";//身份证号
				String phonenum = "";//手机号码
				Map<String, String> map = getPhoneAndSalt(phonenum);
				param.put("version", "1.5");
				param.put("sourceCode", sourceCode);
				param.put("userType", "2");
				param.put("userAttr", "1");
				param.put("userCreateTime", "2017-05-17 00:00:00");
				param.put("userName", "张三");
				param.put("countries", "-1");
				param.put("cardType", "1");
				param.put("userIdcard", "147852dfghjklfghjkl");
				param.put("userIdcardHash", tool.idCardHash(idcard));
				param.put("userPhone", "-1");
				param.put("userPhoneHash", map.get("phoneHash"));
				param.put("userUuid", map.get("userUuid"));
				param.put("userLawperson", "-1");
				param.put("userFund", "-1");
				param.put("userProvince", "-1");
				param.put("userAddress", "-1");
				param.put("registerDate", "-1");
				param.put("userSex", "-1");
				// param.put("userStatus", "2");//选填
				// param.put("userMail", "qq@163.com");//选填
				// param.put("userAscription",
				// tool.getIdcardAscription(idcard));//选填
				// param.put("userAge", tool.getAge(idcard));//选填
				// param.put("phoneAscription",
				// tool.getPhoneAscription(phonenum));//选填
				// param.put("riskRating", "A");// 选填

				List<Map<String, String>> tlist = new ArrayList<Map<String, String>>();
				Map<String, String> tmp1 = new LinkedHashMap<String, String>();
				// tmp1.put("userPay", "汇付天下");//选填
				// tmp1.put("userPayAccount", "HFTX00001");//选填
				// tmp1.put("userBank", "汇付天下北京分部");//选填
				tmp1.put("userBankAccount", "60100000001");
				Map<String, String> tmp2 = new LinkedHashMap<String, String>();
				// tmp2.put("userPay", "如意支付");//选填
				// tmp2.put("userPayAccount", "RYF00001");//选填
				// tmp2.put("userBank", "北京如意支付");//选填
				tmp2.put("userBankAccount", "60100000001");
				tlist.add(tmp1);
				tlist.add(tmp2);
				param.put("userList", tlist);// userlist选填
				list.add(param);
			}
			JSONObject json = new JSONObject();
			String nonce = Integer.toHexString(new Random().nextInt());
			long timestamp = System.currentTimeMillis();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", list.size() + "");
			json.accumulate("sentTime", new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "1");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);

			String result = sendPost(json, timestamp, nonce, ENDPOINT1);
			System.out.println(json);
			System.out.println("p2p_v1.5 用户新接口测试结果：" + result);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * p2p_v1.5散标接口
	 */
	private static void scatterInvestTest() {
		try {
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("productStartTime", "2017-05-18 12:31:39");
				// param.put("productRegType", "155");//选填
				param.put("productName", "房抵贷短期周转（3期）");

				// param.put("bankNo", "招商银行");// 选填
				param.put("sourceProductCode", "3234");
				param.put("userIdcardHash", tool.idCardHash("142723199902022055"));
				param.put("loanUse", "4");
				param.put("loanDescribe", "还房贷");
				param.put("loanRate", "0.002455");
				param.put("amount", "50000");
				// param.put("rate", "0.000016");//选填
				param.put("surplusAmount", "200.00");
				param.put("term", "12");
				param.put("payType", "1");
				param.put("serviceCost", "1000");
				param.put("loanType", "1");
				param.put("securityType", "1");
				// param.put("securityCompanyAmount", "111");//选填
				// param.put("riskMargin", "4000");//选填
				// param.put("securityCompanyName", "平安");// 选填
				// param.put("securityCompanyIdcard", "140110000120815");// 选填
				// param.put("isFinancingAssure", "1");// 选填
				// param.put("securityAmount", "10000");// 选填
				param.put("projectSource", "1");
				// param.put("loanCreditRating", "A");//选填
				// param.put("securityInfo", "担保信息");// 选填
				// param.put("collateralDesc", "2012年8月份大众帕萨特一辆，1.8T排量");// 选填
				// param.put("collateralInfo", "3月");// 选填
				// param.put("overdueLimmit", "4月");//选填
				// param.put("badDebtLimmit", "4月");//选填
				// param.put("amountLimmts", "50");// 选填
				// param.put("amountLimmtl", "500");// 选填
				// param.put("allowTransfer", "1");//选填
				// param.put("closeLimmit", "抵押");//选填
				// param.put("sourceProductUrl", "https://lantouzi.com/");//选填
				list.add(param);
			}
			JSONObject json = new JSONObject();
			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", list.size());
			json.accumulate("sentTime", new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "2");
			json.accumulate("dataType", "0");
			json.accumulate("timestamp", timestamp);
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT2);
			System.out.println(json);
			System.out.println("p2p_v1.5 散标接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * p2p_v1.5散标状态接口
	 */
	private static void updateStatusTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("sourceProductCode", "Pro1222323");
				param.put("productStatus", "2");
				param.put("productDate", "2016-05-12 18:33:59");
				// param.put("sourceFinancingCode", "Fin1222323");//选填
				// param.put("productStatusDesc", "截标");//选填

				list.add(param);
			}
			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			JSONObject json = new JSONObject();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", "" + list.size());
			json.accumulate("sentTime", new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "6");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT5);
			System.out.println(json);
			System.out.println("p2p_v1.5 散标状态接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("\n\n\n");
		}
	}

	/**
	 * p2p_v1.5还款计划
	 */
	private static void repayPlanTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String time = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("sourceProductCode", "BD201809");
				param.put("userIdcardHash", tool.idCardHash("142723199902062020"));
				param.put("totalIssue", "12");
				param.put("issue", "2");
				param.put("replanId", "BD2018465");
				param.put("curFund", "253.44");
				param.put("curInterest", " 190.11");
				param.put("curServiceCharge", "1.55");
				param.put("repayTime", "2018-10-11 11:20:20 ");
				list.add(param);
			}
			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			JSONObject json = new JSONObject();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", "" + list.size());
			json.accumulate("sentTime", time);
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "81");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT10);
			System.out.println(json);
			System.out.println("p2p_v1.5 还款计划接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * p2p_v1.5债权信息
	 */
	private static void creditorTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String time = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("finClaimId", "ZQ2018001");
				param.put("sourceProductCode", "BD2018090");
				param.put("userIdcardHash", tool.idCardHash("142723199902022055"));
				param.put("invAmount", "10000.00");
				param.put("invRate", "0.136667");
				param.put("invTime", "2018-11-06 11:20:20");
				param.put("redpackage", "200");
				param.put("lockTime", "2018-11-06");
				// param.put("sourceFinancingCode", "1080450000");//选填
				list.add(param);
			}
			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			JSONObject json = new JSONObject();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", "" + list.size());
			json.accumulate("sentTime", time);
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "82");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT9);
			System.out.println(json);
			System.out.println("p2p_v1.5 债权信息接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * p2p_v1.5转让信息接口
	 */
	private static void transferTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("transferId", "1212121");
				// param.put("bankNo", "161565");// 选填
				param.put("fromType", "1");
				param.put("finClaimId", "ZQ20180901");
				param.put("userIdcardHash", tool.idCardHash("142723199902062020"));
				param.put("sourceProductCode", "sou1212");
				// param.put("sourceFinancingCode", "fin12121");// 选填
				param.put("transferAmount", "9900");
				param.put("transferInterestRate", "0.333145");
				// param.put("transferInterest", "0.108911");// 选填
				param.put("floatMoney", "100.00");
				param.put("transferDate", "2018-11-05");
				// param.put("sourceProductUrl", "https://lantouzi.com");// 选填
				list.add(param);
			}
			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			JSONObject json = new JSONObject();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", "" + list.size());
			json.accumulate("sentTime", new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "83");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT6);
			System.out.println(json);
			System.out.println("p2p_v1.5 转让项目接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("\n\n\n");
		}
	}

	/**
	 * p2p_v1.5转让状态
	 */
	private static void transferStatusTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String time = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("transferId", "ZR20180020");
				param.put("transferStatus", "2");
				param.put("amount", "1540.10");
				param.put("floatMoney", "0.00");
				param.put("productDate", "2018-11-06 18:33:59");
				// param.put("interest", "0.00");//选填
				list.add(param);
			}
			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			JSONObject json = new JSONObject();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", "" + list.size());
			json.accumulate("sentTime", time);
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "84");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT12);
			System.out.println(json);
			System.out.println("p2p_v1.5 转让状态接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * p2p_v1.5承接信息
	 */
	private static void underTakeTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		String time = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date());
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("unFinClaimId", "121212");
				param.put("transferId", "ZR201809");
				param.put("finClaimId", "ZQ201809");
				param.put("userIdcardHash", "032da1988af3e5a1733be16a52cc9d9f8b96c9564a868061197da17c179d3b42");
				param.put("takeAmount", "9800.00 ");
				param.put("takeInterest", "300");
				param.put("floatMoney", "-200");
				param.put("takeRate", "0.136666 ");
				param.put("takeTime", "2018-10-11 11:20:20");
				param.put("redpackage", "200");
				param.put("lockTime", "2018-12-12");
				list.add(param);
			}
			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			JSONObject json = new JSONObject();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", "" + list.size());
			json.accumulate("sentTime", time);
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "85");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT11);
			System.out.println(json);
			System.out.println("p2p_v1.5 承接信息接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * p2p_v1.5交易流水接口
	 */
	private static void transactTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("transId", "YH4512");
				param.put("sourceProductCode", "3234");
				param.put("sourceProductName", "Pro00001");
				param.put("finClaimId", "ZQ2018090110");
				param.put("transferId", "ZR2018090110");
				param.put("replanId", "BD20180901000001-002");
				param.put("transType", "8");
				param.put("transMoney", "232323");
				param.put("userIdcardHash", tool.idCardHash("142723199902062020"));
				param.put("transTime", "2016-05-16 12:00:01");
				param.put("bankTransId", "bank45712");// 选填
				param.put("sourceFinancingCode", "12");// 选填
				param.put("sourceFinancingName", "Fin00001");// 选填
				param.put("transTypeDec", "放款");// 选填
				param.put("transDate", "2015-10-12");// 选填
				param.put("transPayment", "a");// 选填
				param.put("transBank", "建设银行");// 选填
				list.add(param);
			}

			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			JSONObject json = new JSONObject();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", "" + list.size());
			json.accumulate("sentTime", new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "4");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT4);
			System.out.println(json);
			System.out.println("p2p_v1.5 交易流水接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * p2p_v1.5产品信息接口
	 */
	public static void lendProductTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("sourceFinancingCode", "CP20180901000001");
				param.put("financingStartTime", "2019-03-12 10:00:00");
				param.put("productName", "惠农计划-32 期");
				param.put("rate", "0.082342");
				param.put("minRate", "0.045000");
				param.put("maxRate", "0.085000");
				param.put("term", "30");
				list.add(param);
			}

			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			JSONObject json = new JSONObject();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", "" + list.size());
			json.accumulate("sentTime", new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "86");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT13);
			System.out.println(json);
			System.out.println("p2p_v1.5 产品信息接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * p2p_v1.5产品配置接口
	 */
	public static void lendProductConfigTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("configId", "YH16133307173824");
				param.put("finClaimId", "YH16133307173824");
				param.put("sourceFinancingCode", "CP20180901000001");
				param.put("userIdcardHash", tool.idCardHash("142723199902062020"));
				list.add(param);
			}

			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			JSONObject json = new JSONObject();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", "" + list.size());
			json.accumulate("sentTime", new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "87");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT14);
			System.out.println(json);
			System.out.println("p2p_v1.5 产品配置接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * p2p_v1.5投资明细接口
	 */
	public static void lendParticularsTest() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			for (int i = 0; i < 1; i++) {
				Map<String, Object> param = new LinkedHashMap<String, Object>();
				param.put("version", version);
				param.put("sourceCode", sourceCode);
				param.put("transId", "YH16133307173824");
				param.put("sourceFinancingCode", "CP20180901000001");
				param.put("transType", "2");
				param.put("transMoney", "40000.00");
				param.put("userIdcardHash", tool.idCardHash("142723199902062020"));
				param.put("transTime", "2016-05-12 18:33:59");
				list.add(param);
			}

			long timestamp = System.currentTimeMillis();
			String nonce = Integer.toHexString(new Random().nextInt());
			JSONObject json = new JSONObject();
			json.accumulate("version", version);
			json.accumulate("batchNum", sourceCode + "_" + getTimeFormat() + "_" + System.currentTimeMillis());
			json.accumulate("checkCode", tool.checkCode(list.toString()));
			json.accumulate("totalNum", "" + list.size());
			json.accumulate("sentTime", new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new Date()));
			json.accumulate("sourceCode", sourceCode);
			json.accumulate("infType", "88");
			json.accumulate("dataType", "1");
			json.accumulate("timestamp", timestamp + "");
			json.accumulate("nonce", nonce);
			json.accumulate("dataList", list);
			String result = sendPost(json, timestamp, nonce, ENDPOINT15);
			System.out.println(json);
			System.out.println("p2p_v1.5 投资明细接口测试结果：" + result);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static String sendPost(JSONObject json, Long timestamp, String nonce, String url) {

		String token = getApiKey(apiKey, sourceCode, version, timestamp, nonce);
		String msg = json.toString();

		Map<String, String> params = new HashMap<>(2);

		params.put("apiKey", token);
		params.put("msg", msg);
		String rtnMsg = testUtils.postRequest(url, params);
		return rtnMsg;
	}

	/**
	 * apiKey加密
	 * 
	 * @param apiKey
	 * @param source_code
	 *            平台编号
	 * @param versionStr
	 *            版本号，如：1.3 ; 1.4
	 * @param currentTime
	 *            时间戳
	 * @param nonce
	 *            随机数
	 * @return
	 */
	private static String getApiKey(String apiKey, String source_code, String versionStr, Long currentTime,
			String nonce) {

		double version_double = Double.valueOf(versionStr);
		int version = (int) (version_double * 100);
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

	/**
	 * 获取时间格式化后的字符串
	 * 
	 * @return
	 */
	private static String getTimeFormat() {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		String time = dateFormat.format(date);
		return time;
	}

	/**
	 * 获去phoneHash 和userUUid
	 * 
	 * @param phonenum
	 * @return
	 * @throws CertException
	 */
	private static Map<String, String> getPhoneAndSalt(String phonenum) throws CertException {
		Map<String, String> map = new HashMap<String, String>();
		JSONObject json = tool.phoneHash(phonenum);
		String phoneHash = json.getString("phone");
		String salt = json.getString("salt");
		map.put("phoneHash", phoneHash);
		map.put("userUuid", salt);
		return map;
	}
}
