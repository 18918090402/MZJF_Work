package com.maizi.etl;

/**
 * Created by tre on 2016/11/9.
 */

import org.apache.hadoop.hive.ql.exec.UDF;


import java.net.URLDecoder;
public class UDFDecoderUrl extends UDF {
    private String url = null;
    private int times = 2;
    private String code = "GBK";

    public UDFDecoderUrl() {
    }

    public String evaluate(String urlStr, String srcCode, int count) {
        if (urlStr == null) {
            return null;
        }
        if (count <= 0) {
            return urlStr;
        }
        if (srcCode != null) {
            code = srcCode;
        }
        url = urlStr;
        times = count;
        for (int i = 0; i < times; i++) {
            url = decoder(url, code);
        }
        return url;
    }
    private String decoder(String urlStr, String code) {
        if (urlStr == null || code == null) {
            return null;
        }
        try {
            urlStr = URLDecoder.decode(urlStr, code);
        } catch (Exception e) {
            return null;
        }
        return urlStr;
    }
}
