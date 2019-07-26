package com.goodsPublic.util.wxpay;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import com.goodsPublic.util.MD5Util;

/**
 * 统一下单请求参数(必填)
 * @author Y
 *
 */
public class UnifiedOrderRequest {

	private String appid;				//公众账号ID
	private String mch_id;				//商户号
	private String nonce_str;			//随机字符串
	private String sign;				//签名
	private String body;				//商品描述
	private String out_trade_no;		//商户订单号
	private String total_fee;			//总金额
	private String spbill_create_ip;	//终端IP
	private String notify_url;			//通知地址
	private String trade_type;			//交易类型
	public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	public String getMch_id() {
		return mch_id;
	}
	public void setMch_id(String mch_id) {
		this.mch_id = mch_id;
	}
	public String getNonce_str() {
		return nonce_str;
	}
	public void setNonce_str(String nonce_str) {
		this.nonce_str = nonce_str;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getOut_trade_no() {
		return out_trade_no;
	}
	public void setOut_trade_no(String out_trade_no) {
		this.out_trade_no = out_trade_no;
	}
	public String getTotal_fee() {
		return total_fee;
	}
	public void setTotal_fee(String total_fee) {
		this.total_fee = total_fee;
	}
	public String getSpbill_create_ip() {
		return spbill_create_ip;
	}
	public void setSpbill_create_ip(String spbill_create_ip) {
		this.spbill_create_ip = spbill_create_ip;
	}
	public String getNotify_url() {
		return notify_url;
	}
	public void setNotify_url(String notify_url) {
		this.notify_url = notify_url;
	}
	public String getTrade_type() {
		return trade_type;
	}
	public void setTrade_type(String trade_type) {
		this.trade_type = trade_type;
	}

	/**
	 * 生成签名
	 * 
	 * @param appid_value
	 * @param mch_id_value
	 * @param productId
	 * @param nonce_str_value
	 * @param trade_type 
	 * @param notify_url 
	 * @param spbill_create_ip 
	 * @param total_fee 
	 * @param out_trade_no 
	 * @return
	 */
	public String createSign(UnifiedOrderRequest unifiedOrderRequest) {
		//根据规则创建可排序的map集合
		SortedMap<String, String> packageParams = new TreeMap<String, String>();
		packageParams.put("appid", unifiedOrderRequest.getAppid());
		packageParams.put("body", unifiedOrderRequest.getBody());
		packageParams.put("mch_id", unifiedOrderRequest.getMch_id());
		packageParams.put("nonce_str", unifiedOrderRequest.getNonce_str());
		packageParams.put("notify_url", unifiedOrderRequest.getNotify_url());
		packageParams.put("out_trade_no", unifiedOrderRequest.getOut_trade_no());
		packageParams.put("spbill_create_ip", unifiedOrderRequest.getSpbill_create_ip());
		packageParams.put("trade_type", unifiedOrderRequest.getTrade_type());
		packageParams.put("total_fee", unifiedOrderRequest.getTotal_fee());
 
		StringBuffer sb = new StringBuffer();
		Set es = packageParams.entrySet();//字典序
		Iterator it = es.iterator();
		while (it.hasNext()) {
			Map.Entry entry = (Map.Entry) it.next();
			String k = (String) entry.getKey();
			String v = (String) entry.getValue();
			//为空不参与签名、参数名区分大小写
			if (null != v && !"".equals(v) && !"sign".equals(k)
					&& !"key".equals(k)) {
				sb.append(k + "=" + v + "&");
			}
		}
		//第二步拼接key，key设置路径：微信商户平台(pay.weixin.qq.com)-->账户设置-->API安全-->密钥设置
		sb.append("key=" +"GTusD1WphSK1zMjDFjRM4a3notET41hJ");
		String sign = MD5Util.MD5Encode(sb.toString())
				.toUpperCase();//MD5加密
		return sign;
	}
}
