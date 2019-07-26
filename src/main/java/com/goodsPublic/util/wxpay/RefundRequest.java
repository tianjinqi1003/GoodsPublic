package com.goodsPublic.util.wxpay;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import com.goodsPublic.util.MD5Util;

/**
 * 退款请求参数(必填)
 * @author Y
 *
 */
public class RefundRequest {

	private String appid;				//公众账号ID
	private String mch_id;				//商户号
	private String nonce_str;			//随机字符串
	private String sign;				//签名
	private String out_trade_no;		//商户订单号
	private String out_refund_no;		//商户退款单号
	private String total_fee;			//订单金额
	private String refund_fee;			//退款金额
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
	public String getOut_trade_no() {
		return out_trade_no;
	}
	public void setOut_trade_no(String out_trade_no) {
		this.out_trade_no = out_trade_no;
	}
	public String getOut_refund_no() {
		return out_refund_no;
	}
	public void setOut_refund_no(String out_refund_no) {
		this.out_refund_no = out_refund_no;
	}
	public String getTotal_fee() {
		return total_fee;
	}
	public void setTotal_fee(String total_fee) {
		this.total_fee = total_fee;
	}
	public String getRefund_fee() {
		return refund_fee;
	}
	public void setRefund_fee(String refund_fee) {
		this.refund_fee = refund_fee;
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
	public String createSign(RefundRequest refundRequest) {
		//根据规则创建可排序的map集合
		SortedMap<String, String> packageParams = new TreeMap<String, String>();
		packageParams.put("appid", refundRequest.getAppid());
		packageParams.put("mch_id", refundRequest.getMch_id());
		packageParams.put("nonce_str", refundRequest.getNonce_str());
		packageParams.put("out_refund_no", refundRequest.getOut_refund_no());
		packageParams.put("out_trade_no", refundRequest.getOut_trade_no());
		packageParams.put("refund_fee", refundRequest.getRefund_fee());
		packageParams.put("total_fee", refundRequest.getTotal_fee());
 
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
