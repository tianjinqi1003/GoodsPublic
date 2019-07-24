<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>支付中心</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/fee/buy.css" />
<script type="text/javascript">
function goPay(){
	location.href="${pageContext.request.contextPath}/merchant/main/goFeeTenpay";
}
</script>
</head>
<body style="background-color: #eee;">
<div style="width: 1020px;height:300px;margin: 0 auto;background-color: #fff;">
	<div style="margin-left: 50px;height: 40px;line-height:40px;font-size: 20px;">支付方式</div>
	<div style="margin-left: 50px;">
		<div style="width: 150px;height: 60px;line-height:60px;text-align: center;display: table-cell;vertical-align: middle;border: 1px solid #eceeef;background-color: #fff;border-radius: 3px;">
			<img alt="" src="<%=basePath %>/resource/images/alipay_icon1.png">
		</div>
		<div style="width: 150px;height: 60px;line-height:60px;left:20px;position:relative; text-align: center;display: table-cell;vertical-align: middle;border: 1px solid #eceeef;background-color: #fff;border-radius: 3px;">
			<img alt="" src="<%=basePath %>/resource/images/wechatpay_icon@1x.png">
		</div>
		<div style="height: 60px;line-height:60px;">
			我已阅读并同意
			<div style="width: 150px;height: 40px;line-height:40px;text-align: center;color:#fff;background-color: #ef6c00;border-radius: 3px;" onclick="goPay();">去付款</div>
		</div>
	</div>
</div>
</body>
</html>