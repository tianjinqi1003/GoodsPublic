package com.goodsPublic.util.wxpay;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jpay.ext.kit.HttpKit;
import com.jpay.ext.kit.PaymentKit;
import com.jpay.weixin.api.WxPayApiConfigKit;

/**
 * 微信回调
 * @author Administrator
 *
 */
public class WxPayNotifySevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public WxPayNotifySevlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 支付结果通用通知文档:https://pay.weixin.qq.com/wiki/doc/api/native.php?chapter=9_7&index=8
		String xmlMsg = HttpKit.readData(request);
		System.out.println("收到微信支付回调通知===" + xmlMsg);
		Map<String, String> params = PaymentKit.xmlToMap(xmlMsg);
		 String appid = params.get("appid");
		 //商户号
		 String mch_id = params.get("mch_id");
		String result_code = params.get("result_code");
		 String openId = params.get("openid");
		 //交易类型
		 String trade_type = params.get("trade_type");
		 //付款银行
		 String bank_type = params.get("bank_type");
		 // 总金额
		String money = params.get("total_fee");
		 //现金支付金额
		 String cash_fee = params.get("cash_fee");
		 // 微信支付订单号
		String transactionId = params.get("transaction_id");
		// // 商户订单号
		String outTradeNo = params.get("out_trade_no");
		// // 支付完成时间，格式为yyyyMMddHHmmss
		// String time_end = params.get("time_end");
		///////////////////////////// 以下是附加参数///////////////////////////////////
		String type = params.get("attach");
		 String fee_type = params.get("fee_type");
		 String is_subscribe = params.get("is_subscribe");
		 String err_code = params.get("err_code");
		 String err_code_des = params.get("err_code_des");
		if (PaymentKit.verifyNotify(params, WxPayApiConfigKit.getWxPayApiConfig().getPaternerKey())) {
			System.out.println("result_code==="+result_code);
			if (("SUCCESS").equals(result_code)) {
				//自行实现
				System.out.println("SUCCESS...自行实现......");
				
			}
		}

	}

}
