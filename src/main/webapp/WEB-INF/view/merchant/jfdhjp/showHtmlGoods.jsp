<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>积分兑换奖品在线行动</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
$(function(){
	var rbdw=$("#redBag_div").css("width");
	rbdw=rbdw.substring(0,rbdw.length-2);
	var rbdh=parseInt(rbdw*534/359);
	$("#redBag_div").css("height",rbdh+"px");
});
</script>
</head>
<body style="background-color: #039045;margin: 0;">
	<div style="padding-top: 20px;padding-left: 20px;">
		<img alt="" src="${requestScope.scoreQrcode.shopLogo }" style="width: 300px;height: 300px;">
	</div>
	<div id="redBag_div" style="background-image: url('/GoodsPublic/resource/images/jfdhjp/001.png');background-size: 100% auto;
	background-repeat: no-repeat;width: 80%;margin: auto;">
	</div>
	<div class="openBut_div" onclick="alert(1)" style="width: 200px;height:200px;margin: -378px auto;"></div>
	<div style="width:603px;color: #FDC303;font-size: 38px;font-weight: bold;margin: 570px auto 0;">你的店铺积分累积：</div>
	<div style="color: #fff;font-size: 38px;padding: 40px 20px 40px 20px;word-wrap:break-word;">活动规则说明：aaaaaaa</div>
</body>
</html>