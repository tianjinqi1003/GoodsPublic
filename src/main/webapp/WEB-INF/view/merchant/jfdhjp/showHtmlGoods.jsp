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
var accountNumber='${requestScope.scoreQrcode.accountNumber }';
var dhjpScore=parseInt('${requestScope.jfdhjpActivity.dhjpScore }');
var shopScore=parseInt('${requestScope.jc.score }');
var redBagScore=parseInt('${requestScope.scoreQrcode.score }');
//var redBagScore=10;
var endTime='${requestScope.jfdhjpActivity.endTime }';
var windowHeight=$(window).height();

$(function(){
	if('${requestScope.scoreQrcode }'==""||new Date(endTime).getTime()-new Date().getTime()<=0){
		$("#redBag_div").css("display","none");
		$("#ygq_div").css("display","block");
	}
	else if('${requestScope.scoreQrcode.enable }'=="true"){
		$("#redBag_div").css("display","none");
		$("#qrcodeUsed_div").css("display","block");
	}
	else{
		$("body").css("background-color","#000");
		var rbdh=$("#redBag_div").css("height");
		rbdh=rbdh.substring(0,rbdh.length-2);
		var rbdmt=(windowHeight-rbdh)/2;
		$("#redBag_div").css("margin-top",rbdmt+"px");
		
	}
});

function openRedBag(){
	var createTime='${requestScope.scoreQrcode.createTime }';
	var takeTime=createTakeTime();
	var qrcode='${requestScope.scoreQrcode.qrcode }';
	var shopLogo='${requestScope.scoreQrcode.shopLogo }';
	$.post(path+"merchant/phone/openJPDHJFRedBagByJC",
		{openId:openId,uuid:sqUuid,createTime:createTime,takeTime:takeTime,qrcode:qrcode,shopLogo:shopLogo,score:redBagScore,accountNumber:accountNumber},
		function(data){
			if(data.status=="ok"){
				$("#redBag_div").css("display","none");
				shopScore+=redBagScore
				if(shopScore>=dhjpScore){
					createPrizeCode();
				}
				else{
					$("body").css("background-color","#009446");
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

function createTakeTime(){
	var date=new Date();
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	var date1=date.getDate();
	var hours=date.getHours();
	var minutes=date.getMinutes();
	var seconds=date.getSeconds();
	return year+"-"+month+"-"+date1+" "+hours+":"+minutes+":"+seconds;
}

function createPrizeCode(){
	$.post(path+"merchant/phone/createPrizeCode",
		{dhjpScore:dhjpScore,accountNumber:accountNumber,sqUuid:sqUuid,openId:openId},
		function(data){
			if(data.status=="ok"){
				$("body").css("background-color","#009446");
				$("#djm_div").css("display","block");
				$("#codeNo_span").text(data.codeNo);
				setInterval("reloadDJS()","1000","1000");
				$("#syjf_span").text(shopScore-dhjpScore);
			}
		}
	,"json");
}

//刷新倒计时
function reloadDJS(){
	var time=new Date(endTime).getTime()-new Date().getTime();
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

function showJFYE(){
	$("#jfye_div").text(shopScore+"积分");
}
</script>
</head>
<body style="background-color: #009446;margin: 0;">
	<div id="redBag_div" style="width:350px;height:525px;background-image: url('/GoodsPublic/resource/images/jfdhjp/001.png');background-size: 100% auto;
	background-repeat: no-repeat;margin: auto;display: block;">
		<div id="shopLogo_div" style="width:350px;height:68px;margin-top:110px;text-align: center;position: absolute;">
			<img alt="" src="${requestScope.scoreQrcode.shopLogo }" style="width: 68px;height: 68px;border-radius: 5px;">
		</div>
		<div id="open_div" style="width: 350px;height:100px;margin-top:339px;position: absolute;">
			<div class="openBut_div" onclick="openRedBag()" style="width: 100px;height:100px;margin:auto;"></div>
		</div>
	</div>
	
	<div id="score_div" style="width: 350px;height:418px;background-image: url('/GoodsPublic/resource/images/jfdhjp/002.png');background-size: 100% auto;
	background-repeat: no-repeat;margin: 30px auto 0;padding: 1px;display: none;">
		<div id="value_div" style="color:#A3682E;font-size: 25px;text-align: center;margin-top:125px;">${requestScope.scoreQrcode.score }积分</div>
		<div id="shopScore_div" style="width:100%;color: #FDE198;font-size: 25px;font-weight: 600;text-align: center;margin-top:125px;display: block;"><span id="shopScore_span">${requestScope.jc.score }</span>积分</div>
		<div id="jpmdhReg_div" style="color: #FFCC66;font-size: 20px;margin-top:105px;padding: 0 20px 0 20px;word-wrap:break-word;display: block;">活动规则说明：${requestScope.jfdhjpActivity.jpmdhReg }</div>
	</div>
	
	<div id="djm_div" style="width: 350px;height:436px;background-image: url('/GoodsPublic/resource/images/jfdhjp/003.png');background-size: 100% auto;
	background-repeat: no-repeat;margin: 30px auto 0;padding: 1px;display: none;">
		<span id="codeNo_span" style="color: #E02E24;font-size:25px;margin-top:135px;margin-left: 175px;position: absolute;">123</span>
		<div id="djs_div" style="width:100%;color:#fff;font-size:25px;margin-top:208px;position: absolute;">
			<span id="day_span" style="margin-left: 127px;">1</span>
			<span id="hour_span" style="margin-left: 23px;position: absolute;">2</span>
			<span id="minute_span" style="margin-left: 60px;position: absolute;">3</span>
			<span id="second_span" style="margin-left: 100px;position: absolute;">4</span>
		</div>
		<span id="syjf_span" style="color: #FFCC66;font-size:20px;margin-top:402px;margin-left: 163px;position: absolute;"></span>
		<div id="jpmdhReg_div" style="color: #FFCC66;font-size: 17px;margin-top:438px;word-wrap:break-word;display: block;">活动规则说明：${requestScope.jfdhjpActivity.jpmdhReg }</div>
	</div>
	
	<div id="qrcodeUsed_div" style="width: 350px;height:330px;background-image: url('/GoodsPublic/resource/images/jfdhjp/004.png');background-size: 100% auto;
	background-repeat: no-repeat;margin: 30px auto 0;padding: 1px;display: none;">
		<div id="shopLogo_div" style="width:350px;height:68px;margin-top:133px;text-align: center;position: absolute;">
			<img alt="" src="${requestScope.scoreQrcode.shopLogo }" style="width: 68px;height: 68px;border-radius: 5px;">
		</div>
		<div id="ckjfye_div" style="width: 350px;height:54px;margin-top:263px;position: absolute;">
			<div class="ckjfyeBut_div" onclick="showJFYE()" style="width: 203px;height:54px;margin:auto;"></div>
		</div>
		<div id="jfye_div" style="width: 350px;height:32px;color:#FFF699;font-size: 25px;text-align: center;margin-top:333px;"></div>
		<div id="jpmdhReg_div" style="color: #fff;font-size: 17px;margin-top:20px;padding: 0 35px 0 35px;word-wrap:break-word;display: block;">活动规则说明：${requestScope.jfdhjpActivity.jpmdhReg }</div>
	</div>
	<div id="ygq_div" style="width: 350px;height:330px;background-image: url('/GoodsPublic/resource/images/jfdhjp/006.png');background-size: 100% auto;
	background-repeat: no-repeat;margin: 30px auto 0;padding: 1px;display: none;">
	</div>
	<div style="width: 100%;height:40px;line-height:40px;color: #fff;font-size: 17px;text-align: center;bottom: 0;position: fixed;">${requestScope.accountMsg.companyName }</div>
</body>
</html>