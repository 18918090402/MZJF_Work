package canal.client.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

import org.apache.log4j.chainsaw.Main;

/**
 * 读取配置文件工具类
 * 
 * **/
public class PropertiesUtil {
	//配置文件的地址
	private static final String DEFAULT_CONFIG_FILE = "system.properties";
	private static Properties prop = null;

	 /**
     * 读取配置文件
     */
    public static Properties loadProperty(String path) {
        prop=new Properties();
        try {
        	//File file = new File(path);
            InputStream is= PropertiesUtil.class.getResourceAsStream("/"+path);
            
            prop.load(is);
            is.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return prop;
    }
    
  //写入Properties信息
    public static void WriteProperties (String pKey, String pValue){
    Properties pps = new Properties();
    try {
    	File file = new File(DEFAULT_CONFIG_FILE);
        InputStream is= new FileInputStream(file);
    //调用 Hashtable 的方法 put。使用 getProperty 方法提供并行性。  
    //强制要求为属性的键和值使用字符串。返回值是 Hashtable 调用 put 的结果。
    pps.load(is);
    OutputStream out = new FileOutputStream(DEFAULT_CONFIG_FILE);
    pps.setProperty(pKey, pValue);
    //以适合使用 load 方法加载到 Properties 表中的格式，  
    //将此 Properties 表中的属性列表（键和元素对）写入输出流  
    pps.store(out, "Update " + pKey + " name");
    out.close();
    is.close();
    } catch (Exception e) {
		e.printStackTrace();
	}
   }
    
    public static void main(String[] args) {
    	InputStream is= PropertiesUtil.class.getClassLoader().getResourceAsStream("kafka.properties");
	}
}
