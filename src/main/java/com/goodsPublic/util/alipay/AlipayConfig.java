package com.goodsPublic.util.alipay;

import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {
	
//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id = "2019072265971163";
	
	// 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC5iR4FunUOM6c2uiE6C7qBzz7RW8xQT8NLxn3B5hL6dS3Zo9y7nb02Js3PGYWZgnvZsKrtn1Y3VJNdZyKoKlktHF8N7v/qhCdYHKHnj1DE7J/3v23lD/9tUt58rC58QoMKbxQjpWB/gua75WcvGChCXKvmG1OWIIkAAi6stSxrac6hNVH2b4oLfGy4941ATR4f019m9fOs64kgzX5Mv0SbnPCemeoeSfKbYEMm6pLiVWLVGxdsE/ufCvOhGBAorVJbgXngWeNn9GLlWx8wrMZPt6lRJ9bDG1QtFpeYeq6/R7XFGphQL2rPOsipwHwXzrIYLZ9uytnb+Z698lU8IlatAgMBAAECggEAXjC9PB0/xdj1P/RYX/aKVdJXysN2wyLrO7HmMCTUZ7BLeZ0Vt23KHA6xFz2WtKsoowhsjjwA8hAOzDFKx+LP6PXpT9KQu4chzjqi+0Knt4GFaKoXaV2ox+B1MQfchZrimc5wg/Q2PCXBa4x3yNHTxnTzk9s1oRadVpLFDUrg5Rov3vOaFDjDXOpNDsVsEZPhA3oehh+MF/VuO3ypJRT2FttvD11n5S03T4ZiPt/ft70AMVzsI9x2ElWpEre5hqPX/73QABB7gaJ9uTMI7hsCx39nlpElIbVM3xSWrrVFegy17oQ9wx89Eg77aEfR/IzJ+KmSnSEoy6ZmcaNpaG9E5QKBgQD44DHQCVzNTffqNQDCAO5KeL8ffdb+8BG0RGEdfDM0ZDP3kymssAADYZH+8Tau8azRt++hr5GOBcI3P0hqK9tZE/m9fQMEk9nBicgVjq9W/oRK9n6S9Emu8F61GFWDcPZEuqOKRjbIERqaNVq4KeJEYHbg+fplQtaT5bKUDtshewKBgQC+2MFELBlhdtjk9vH+bjzCWGE/VOk7bBI44Yp7QSlP72D8l+VasCbj9pULh+qT2ieQMg0rwaj8N0CB5t0yQtwAl59gApoNrcNNzoXPWrmaHAX4lKflyJk5yjEE9Clafj66nOVIUja+S0Ny7sZnoeGy1y4BPvKWndYusU0Yp9JL9wKBgCfZzmAff6qoN3BbOFnYSE/IceIbBlggHNWetWZBQvm6qc+U0vGB5R6levk1qqnsrN2P9GERed8h8O1jxrapeyASYMUExXzwJ8gjxdQd2tm1O329ZpslXr8SYjfhQ6AecHCk6hb0E0WJ55aVwIcIveBxCdgQbxXT1AQunZ+zmUcNAoGBAI/mEbucYLrLiPkDdi344tlLGHBPTtjeQNMgxHDxDfxWq1NqGKaLoZdLitA5+FbpK+Gey62NhSQ/aOVJtMk7/nR33tTewVfFCDj3mo9hggbAUIRBWmN5IIehe9qXW0L/Y78DpCIm014ik8XqYjErr2lQtEB+PR3x/tgQGeiYSYm7AoGBAKLD58z45CKAVLIlro4ktA8zFn/xqL4mUMQKCg+dwK6D4HWo/hpGYHKyz131Qmx5HjJ05VARkxiH/nIq/gkTKyamOENYeEs+U1iQhq3CRM+fvOrWOB4fpxbE1c2baSWugWLvhO4QKtW5xxl3r55MzLupxYbB8y/IkakoiRmBbeWY";
	
	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    //public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuYkeBbp1DjOnNrohOgu6gc8+0VvMUE/DS8Z9weYS+nUt2aPcu529NibNzxmFmYJ72bCq7Z9WN1STXWciqCpZLRxfDe7/6oQnWByh549QxOyf979t5Q//bVLefKwufEKDCm8UI6Vgf4Lmu+VnLxgoQlyr5htTliCJAAIurLUsa2nOoTVR9m+KC3xsuPeNQE0eH9NfZvXzrOuJIM1+TL9Em5zwnpnqHknym2BDJuqS4lVi1RsXbBP7nwrzoRgQKK1SW4F54FnjZ/Ri5VsfMKzGT7epUSfWwxtULRaXmHquv0e1xRqYUC9qzzrIqcB8F86yGC2fbsrZ2/mevfJVPCJWrQIDAQAB";
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAg3R04pFb/esO+7EZ0zzSUAWmk7mm1b7R2886RSSuf+NC4ahhSYsB0bBVaGf6OjEqNhRJrBWenOyy/sXI+JYlq++HAlNrN5s4KLuVHMg8u5/3mbWFih2TY6xs1s88Mupvv8hQjJKrMRwscob26150YH95DCyYyQk3dKY3mRaebctrimcYDwkUPUNDK13oEjcWXQ64Y7Qqu4X7NxutU8uE/5DUO4i8afu4IeVLkPHA4bfb/ovvM1SW54c7RAQZhwMa+wC9SLh6+qKMHRenqQs+mOWmxJreNmxy9nkc59Uq/aeV6jY0nuG8qPnSpVe5C5L0VPXVhQCRnB0FrO+UtpdKYQIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	//public static String notify_url = "http://工程公网访问地址/alipay.trade.page.pay-JAVA-UTF-8/notify_url.jsp";
	public static String notify_url = "http://www.bainuojiaoche.com:8080/GoodsPublic/merchant/main/kaiTongByAlipay";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	//public static String return_url = "http://工程公网访问地址/alipay.trade.page.pay-JAVA-UTF-8/return_url.jsp";
	public static String return_url = "http://120.27.5.36:8080/GoodsPublic/merchant/login";

	// 签名方式
	//public static String sign_type = "SHA256";
	public static String sign_type = "RSA2";
	
	// 字符编码格式
	public static String charset = "utf-8";
	
	// 支付宝网关
	//public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";
	public static String gatewayUrl = "https://openapi.alipay.com/gateway.do";
	
	// 支付宝网关
	//public static String log_path = "C:\\";
	public static String log_path = "/log";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /** 
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
}

