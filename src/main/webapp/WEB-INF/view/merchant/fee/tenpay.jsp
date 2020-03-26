<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微信支付</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
$(function(){
	$.post("main/addCreatePayCodeRecord",
		{outTradeNo:'${requestScope.codeUrl}',accountNumber:'${sessionScope.user.id}',phone:'${sessionScope.user.phone}',vipType:'${requestScope.vipType}',payType:2,money:'${requestScope.totalFee}',codeUrl:'${requestScope.codeUrl}'},
		function(){
		
		}
	,"json");
});
</script>
</head>
<body style="background-color: #eee;">
	<div style="width: 1020px;height:500px;margin: 0 auto;background-color: #fff;">
		<div style="text-align: center;height: 40px;line-height: 40px;">扫一扫付款（元）</div>
		<div style="color: #f57c00;font-size: 36px;text-align: center;height: 40px;line-height: 40px;">￥${requestScope.totalFee}</div>
		<div style="width: 230px;height: 320px;padding: 20px;border: 1px solid #ddd;margin: auto;">
			<div style="width:100%;height: 190px;line-height: 190px;text-align: center;vertical-align: middle;margin:0 auto; margin-bottom: 20px;">
				<img alt="" src="${basePath}/GoodsPublic/wxPayCode/${requestScope.codeUrl}.png" style="width: 190px;height: 190px;">
				<!-- 
				<img alt="" src="http://192.168.230.1:8088/GoodsPublic/merchant/wxPayServlet?action=unifiedorder" style="width: 190px;height: 190px;">
				<img alt="" src="http://www.qrcodesy.com:8080/GoodsPublic/merchant/wxPayServlet?action=unifiedorder" style="width: 190px;height: 190px;">
				 -->
			</div>
			<div style="width: 190px;height: 60px;margin: auto;background: url(/GoodsPublic/resource/images/checkout_greentip.png) no-repeat;background-size: cover;"></div>
		</div>
	</div>
</body>
</html>