package com.goodsPublic.util.wxpay;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jpay.ext.kit.IpKit;
import com.jpay.ext.kit.PaymentKit;
import com.jpay.ext.kit.StrKit;
import com.jpay.weixin.api.WxPayApi;
import com.jpay.weixin.api.WxPayApi.TradeType;
import com.jpay.weixin.api.WxPayApiConfig;
import com.jpay.weixin.api.WxPayApiConfig.PayModel;
import com.jpay.weixin.api.WxPayApiConfigKit;
import com.goodsPublic.util.wxpay.WxPayConfig;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.goodsPublic.util.MoneyUtil;

import cn.hutool.core.io.FileUtil;
import cn.hutool.extra.qrcode.QrCodeUtil;

/**
 * 微信扫码支付
 */
@WebServlet("/merchant/wxPayServlet")
public class WxPayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private SimpleDateFormat orderIdSDF=new SimpleDateFormat("yyyyMMddHHmmss");
	private ServletConfig config;

	public void init(ServletConfig config) throws ServletException {
		this.config = config;
	}

	public WxPayServlet() {
		super();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String action = request.getParameter("action");
		switch (action) {
		case "unifiedorder":
			unifiedorder(request, response);
			break;
		}
	}
	
	private void unifiedorder(HttpServletRequest request, HttpServletResponse response) {
		// 网站根目录
		String rootPath = config.getServletContext().getRealPath("/");

		//订单金额
		String total_fee = "0.01";
		//订单号
		String outTradeNo = orderIdSDF.format(new Date());

		if (StrKit.isBlank(total_fee)) {
			System.out.println("支付金额不能为空");
			return;
		}

		String ip = IpKit.getRealIp(request);
		if (StrKit.isBlank(ip)) {
			ip = "127.0.0.1";
		}

		WxPayApiConfig wxPayApiConfig = WxPayApiConfig.New();

		// 微信公众号id
		wxPayApiConfig.setAppId(WxPayConfig.wxAppId);
		// 微信商户号
		wxPayApiConfig.setMchId(WxPayConfig.wxMerchantNo);
		// 微信商户支付密钥
		wxPayApiConfig.setPaternerKey(WxPayConfig.wxApiKey);
		// IP
		wxPayApiConfig.setSpbillCreateIp(ip);
		// 交易类型 扫码支付
		wxPayApiConfig.setTradeType(TradeType.NATIVE);
		// 回调地址
		wxPayApiConfig.setNotifyUrl(WxPayConfig.notifyUrl);
		// 订单号 不可重复
		wxPayApiConfig.setOutTradeNo(outTradeNo);
		// 订单金额
		wxPayApiConfig.setTotalFee(MoneyUtil.getMoney(total_fee));
		// 备注
		wxPayApiConfig.setBody("商品购买");
		// 支付模式 商户模式（自签约不可更改）
		wxPayApiConfig.setPayModel(PayModel.BUSINESSMODEL);
		WxPayApiConfigKit.putApiConfig(wxPayApiConfig);
		Map<String, String> params = WxPayApiConfigKit.getWxPayApiConfig().build();

		// ************************参数组装完毕开始发起支付*********************************//

		String xmlResult = WxPayApi.pushOrder(false, params);

		Map<String, String> result = PaymentKit.xmlToMap(xmlResult);

		String return_code = result.get("return_code");
		String return_msg = result.get("return_msg");
		if (!PaymentKit.codeIsOK(return_code)) {
			System.out.println(return_msg);
			return;
		}
		String result_code = result.get("result_code");
		if (!PaymentKit.codeIsOK(result_code)) {
			System.out.println(return_msg);
			return;
		}
		
		// 微信预支付订单生产成功 获取二维码url
		String qrCodeUrl = result.get("code_url");
		
		try {
			int width = 200;
			int height = 200;
			String format = "png";
			Hashtable hints = new Hashtable();
			hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
			BitMatrix bitMatrix = new MultiFormatWriter().encode(qrCodeUrl, BarcodeFormat.QR_CODE, width, height, hints);
			OutputStream out = null;
			out = response.getOutputStream();
			MatrixToImageWriter.writeToStream(bitMatrix, format, out);
			out.flush();
			out.close();
		} catch (Exception e) {
			
		}

		//QrCodeUtil.generate(qrCodeUrl, 300, 300, FileUtil.file(rootPath + "/wxPayCode/" + outTradeNo + ".png"));
		
		//request.setAttribute("codeUrl", outTradeNo);

		//request.getRequestDispatcher("/pay/wxpay.jsp").forward(request, response);
	}

}
