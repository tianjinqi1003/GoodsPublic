<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>积分兑换奖品在线行动</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
$(function(){
	var rbdw=$("#redBag_div").css("width");
	rbdw=rbdw.substring(0,rbdw.length-2);
	var rbdh=parseInt(rbdw*534/359);
	$("#redBag_div").css("height",rbdh+"px");
	
	var sdw=$("#score_div").css("width");
	sdw=sdw.substring(0,sdw.length-2);
	var sdh=parseInt(sdw*534/359);
	$("#score_div").css("height",sdh+"px");
	
	var djmdw=$("#djm_div").css("width");
	djmdw=djmdw.substring(0,djmdw.length-2);
	var djmdh=parseInt(djmdw*534/359);
	$("#djm_div").css("height",djmdh+"px");
});

function openRedBag(){
	$("#redBag_div").css("display","none");
	$("#score_div").css("display","block");
}
</script>
</head>
<body style="background-color: #039045;margin: 0;">
	<div style="width:100%;height:170px;padding-top: 20px;padding-left: 20px;">
		<img alt="" src="${requestScope.scoreQrcode.shopLogo }" style="width: 150px;height: 150px;">
	</div>
	<div id="redBag_div" style="background-image: url('/GoodsPublic/resource/images/jfdhjp/001.png');background-size: 100% auto;
	background-repeat: no-repeat;width: 70%;margin: auto;">
		<div style="width: 70%;height:78px;margin-top: 290px;position: absolute;">
			<div class="openBut_div" onclick="openRedBag()" style="width: 75px;height:75px;margin:auto;"></div>
		</div>
	</div>
	
	<div id="score_div" style="background-image: url('/GoodsPublic/resource/images/jfdhjp/002.png');background-size: 100% auto;
	background-repeat: no-repeat;width: 50%;margin: auto;display: none;">
	${requestScope.scoreQrcode.score }
	</div>
	
	<div id="djm_div" style="background-image: url('/GoodsPublic/resource/images/jfdhjp/003.png');background-size: 100% auto;
	background-repeat: no-repeat;width: 50%;margin: auto;display: none;">
	</div>
	
	<div style="width:227px;color: #FDC303;font-size: 20px;font-weight: bold;margin: 5px auto 0;">你的店铺积分累积：${requestScope.jc.score }</div>
	<div style="color: #fff;font-size: 20px;padding: 15px 20px 15px 20px;word-wrap:break-word;">活动规则说明：aaaaaaa</div>
</body>
</html>