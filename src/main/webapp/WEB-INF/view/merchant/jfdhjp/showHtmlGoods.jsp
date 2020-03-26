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
var dhjpScore=parseInt('${requestScope.accountMsg.dhjpScore }');

$(function(){
	var enable='${requestScope.scoreQrcode.enable }';
	if(enable=="true"){
		alert("您已扫过");
	}
	else{
		var rbdw=$("#redBag_div").css("width");
		rbdw=rbdw.substring(0,rbdw.length-2);
		var rbdh=parseInt(rbdw*2220/1080);
		$("#redBag_div").css("height",rbdh+"px");
		
		var sdw=$("#score_div").css("width");
		sdw=sdw.substring(0,sdw.length-2);
		var sdh=parseInt(sdw*2220/1080);
		$("#score_div").css("height",sdh+"px");
		
		var djmdw=$("#djm_div").css("width");
		djmdw=djmdw.substring(0,djmdw.length-2);
		var djmdh=parseInt(djmdw*2220/1080);
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
				var shopScore=parseInt($("#shopScore_span").text());
				shopScore+=redBagScore
				if(shopScore>=dhjpScore){
					createPrizeCode();
				}
				else{
					$("#score_div").css("display","block");
					$("#shopScore_span").text(shopScore);
				}
			}
			else{
				alert(data.message);
			}
		}
	,"json");
}

function createPrizeCode(){
	$.post(path+"merchant/phone/createPrizeCode",
		{openId:openId},
		function(data){
			if(data.status=="ok"){
				$("#djm_div").css("display","block");
				$("#codeNo_span").text(data.codeNo);
				setInterval("reloadDJS()","1000","1000");
			}
		}
	,"json");
}

//刷新倒计时
function reloadDJS(){
	var time=new Date('${requestScope.scoreQrcode.endTime }').getTime()-new Date().getTime();
	var dwSecond=1000;
	var dwMinute=60*dwSecond;
	var dwHour=60*dwMinute;
	var dwDay=24*dwHour;
	$("#day_span").text(Math.floor(time/dwDay));
	time=time%dwDay;
	$("#hour_span").text(Math.floor(time/dwHour));
	time=time%dwHour;
	$("#minute_span").text(Math.floor(time/dwMinute));
	time=time%dwMinute;
	$("#second_span").text(Math.floor(time/dwSecond));
}
</script>
</head>
<body style="background-color: #eee;margin: 0;">
	<div id="redBag_div" style="background-image: url('/GoodsPublic/resource/images/jfdhjp/001.png');background-size: 100% auto;
	background-repeat: no-repeat;width: 100%;display: block;">
		<div style="width:100%;height:60px;margin-top: 259px;text-align: center;position: absolute;">
			<img alt="" src="${requestScope.scoreQrcode.shopLogo }" style="width: 68px;height: 68px;border-radius: 5px;">
		</div>
		<div style="width: 100%;height:115px;margin-top: 491px;position: absolute;">
			<div class="openBut_div" onclick="openRedBag()" style="width: 115px;height:115px;margin:auto;"></div>
		</div>
	</div>
	
	<div id="score_div" style="background-image: url('/GoodsPublic/resource/images/jfdhjp/002.png');background-size: 100% auto;
	background-repeat: no-repeat;width: 100%;padding: 1px;display: none;">
		<div style="color:#A3682E;font-size: 25px;text-align: center;margin-top: 245px;">${requestScope.scoreQrcode.score }积分</div>
		<div id="shopScore_div" style="width:100%;color: #FDE198;font-size: 25px;font-weight: 600;text-align: center;margin: 147px auto 0;display: block;"><span id="shopScore_span">${requestScope.jc.score }</span>积分</div>
		<div style="color: #FFCC66;font-size: 20px;margin-top:122px;padding: 0 20px 0 20px;word-wrap:break-word;display: block;">活动规则说明：${requestScope.accountMsg.jpmdhReg }</div>
	</div>
	
	<div id="djm_div" style="background-image: url('/GoodsPublic/resource/images/jfdhjp/003.png');background-size: 100% auto;
	background-repeat: no-repeat;width: 100%;padding: 1px;display: none;">
		<span id="codeNo_span" style="color: #E02E24;font-size:25px;margin-top: 259px;margin-left: 210px;position: absolute;">123</span>
		<div style="width:100%;color:#fff;margin-top: 346px;font-size:25px;position: absolute;">
			<span id="day_span" style="margin-left: 150px;"></span>
			<span id="hour_span" style="margin-left: 29px;position: absolute;"></span>
			<span id="minute_span" style="margin-left: 76px;position: absolute;"></span>
			<span id="second_span" style="margin-left: 121px;position: absolute;"></span>
		</div>
		<span style="color: #FFCC66;font-size:20px;margin-top: 575px;margin-left: 193px;position: absolute;">50</span>
		<div style="color: #FFCC66;font-size: 17px;margin-top:610px;padding: 0 20px 0 20px;word-wrap:break-word;display: block;">活动规则说明：${requestScope.accountMsg.jpmdhReg }</div>
	</div>
	
</body>
</html>