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
var path='<%=basePath %>';
var openId='${param.openId}';
var sqUuid='${param.sqUuid}';
$(function(){
	var enable='${requestScope.scoreQrcode.enable }';
	if(enable=="true"){
		alert("您已扫过");
	}
	else{
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
	}
});

function openRedBag(){
	var createTime='${requestScope.scoreQrcode.createTime }';
	var qrcode='${requestScope.scoreQrcode.qrcode }';
	var shopLogo='${requestScope.scoreQrcode.shopLogo }';
	//var redBagScore=parseInt('${requestScope.scoreQrcode.score }');
	var redBagScore=10;
	var endTime='${requestScope.scoreQrcode.endTime }';
	var accountNumber='${requestScope.scoreQrcode.accountNumber }';
	$.post(path+"merchant/phone/openJPDHJFRedBagByJC",
		{openId:openId,uuid:sqUuid,createTime:createTime,qrcode:qrcode,shopLogo:shopLogo,score:redBagScore,endTime:endTime,accountNumber:accountNumber},
		function(data){
			if(data.status=="ok"){
				$("#redBag_div").css("display","none");
				$("#score_div").css("display","block");
				var shopScore=parseInt($("#shopScore_span").text());
				$("#shopScore_span").text(shopScore+redBagScore);
			}
			else{
				alert(data.message);
			}
		}
	,"json");
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
	background-repeat: no-repeat;width: 50%;margin: auto;padding: 1px;display: none;">
		<div style="font-size: 30px;text-align: center;margin-top: 103px;">${requestScope.scoreQrcode.score }</div>
	</div>
	
	<div id="djm_div" style="background-image: url('/GoodsPublic/resource/images/jfdhjp/003.png');background-size: 100% auto;
	background-repeat: no-repeat;width: 50%;margin: auto;display: none;">
	</div>
	
	<div style="width:227px;color: #FDC303;font-size: 20px;font-weight: bold;margin: 5px auto 0;">你的店铺积分累积：<span id="shopScore_span">${requestScope.jc.score }</span></div>
	<div style="color: #fff;font-size: 20px;padding: 15px 20px 15px 20px;word-wrap:break-word;">活动规则说明：aaaaaaa</div>
</body>
</html>