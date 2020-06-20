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
function changeAlipayChosen(){
	var clas=$("#alipay_div").attr("class");
	if(clas.indexOf("chosen")!=-1){
		$("#alipay_div").removeClass("chosen");
	}
	else{
		$("#alipay_div").addClass("chosen");
		$("#wechatpay_div").removeClass("chosen");
	}
}
function changeWechatpayChosen(){
	var clas=$("#wechatpay_div").attr("class");
	if(clas.indexOf("chosen")!=-1){
		$("#wechatpay_div").removeClass("chosen");
	}
	else{
		$("#wechatpay_div").addClass("chosen");
		$("#alipay_div").removeClass("chosen");
	}
}

function goPay(){
	var vipType;
	var price='${param.price}';
	switch (price) {
		/*
		case "0.01":
			vipType=1;
			break;
		*/
		case "600":
			vipType=2;
			break;
		case "1270":
			vipType=3;
			break;
		case "2670":
			vipType=4;
			break;
	}
	
	if(!$("#agree_cb").prop("checked")){
		alert("请选择《付费用户服务协议》!");
		return false;
	}
	
	if($("#alipay_div").attr("class").indexOf("chosen")!=-1)
		location.href="${pageContext.request.contextPath}/merchant/main/alipay?action=pay&vipType="+vipType+"&totalAmount="+price+"&accountNumber="+'${sessionScope.user.id}'+"&phone="+'${sessionScope.user.phone}';
	else if($("#wechatpay_div").attr("class").indexOf("chosen")!=-1)
		location.href="${pageContext.request.contextPath}/merchant/wxPayServlet?action=unifiedorder&vipType="+vipType+"&totalFee="+price;
	else{
		alert("请选择支付方式!");
		return false;
	}
}
</script>
</head>
<body>
<div class="main_div">
	<div class="payTypeTit_div">请选择支付方式</div>
	<div class="payType_div">
		<div class="alipay_div chosen" id="alipay_div" onclick="changeAlipayChosen();">
			<img alt="" src="<%=basePath %>/resource/images/alipay_icon1.png">
		</div>
		<div class="wechatpay_div" id="wechatpay_div" onclick="changeWechatpayChosen();">
			<img alt="" src="<%=basePath %>/resource/images/wechatpay_icon@1x.png">
		</div>
		<div class="agree_div">
			<input type="checkbox" id="agree_cb"/>我已阅读并同意<a href="http://qlcode.qdhualing.com/agreement.htm" style="color:#357bb3;" target="blank">《付费用户服务协议》</a>
			<div class="goPay_div" onclick="goPay();">去付款</div>
		</div>
	</div>
</div>
</body>
</html>