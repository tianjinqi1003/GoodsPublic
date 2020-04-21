<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<%@include file="../js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
function createQrcode(){
	$.ajax({
		url:path+"/merchant/chenQi/createQrcodeByCQSCQ",
		data:{url:"aaaaaa"},
		dataType:"jsonp",
		type:"post",
		jsonpCallback:"jsonpCallback",
		success:function(data){
			console.log(data);
			var json=JSON.parse(data);
			$("#createSuccess_div #qrcode_img").attr("src",json.qrcode);
			openCreateSuccessDiv(1);
		}
	});
}

function openCreateSuccessDiv(flag){
	if(flag==1){
		$("#createSuccess_div").css("display","block");
	}
	else{
		$("#createSuccess_div").css("display","none");
		$("#createSuccess_div #qrcode_img").attr("src","");
	}
}
</script>
<style type="text/css">
body{
	margin: 0;
	background: #f9f9f9;
}
.createSuccess_div{
	width: 100%;height:100%;background: #f9f9f9;position: fixed;display: none;
}
.createSuccess_div .close_span{
	float: right;margin-top: 10px;margin-right: 10px;
}
.createSuccess_div .qrcode_div{
	text-align: center;margin-top: 50px;
}
.createSuccess_div .qrcode_img{
	width: 300px;height:300px;
}
.createSuccess_div .but_div{
	width: 100%;bottom: 30px;position: fixed;
}
.createSuccess_div .dlqcBut_div{
	width: 90%;height: 38px;line-height: 38px;margin: 0 auto;text-align: center;color: rgba(255,255,255,1);background-color: #00A3FF;cursor: pointer;border-radius: 3px;
}
.ljsm_div{
	height: 30px;line-height: 30px;text-align: center;font-weight: bold;
}
.contentTa_div{
	width: 95%;height: 200px;margin: 20px auto 0;
}
.content_ta{
	width: 90%;height: 100%;font-size:16px;padding:16px;background-color: #fff;border: 0;
}
.cqBut_div{
	width: 112px;height: 38px;line-height: 38px;margin: 50px auto 0;text-align: center;color: rgba(255,255,255,1);background-color: #00A3FF;border-radius: 3px;
}
</style>
<title>立即生码</title>
</head>
<body>
<div class="createSuccess_div" id="createSuccess_div">
	<span class="close_span" onclick="openCreateSuccessDiv(0)">X</span>
	<div class="qrcode_div">
		<img class="qrcode_img" id="qrcode_img" alt="" src="">
	</div>
	<div class="but_div">
		<div class="dlqcBut_div">下载二维码图片</div>
	</div>
</div>

<div class="ljsm_div">立即生码</div>
<div class="contentTa_div">
	<textarea class="content_ta" rows="" cols="" placeholder="输入文本或网址"></textarea>
</div>
<div class="cqBut_div" onclick="createQrcode()">生成二维码</div>
<%@include file="nav.jsp"%>
</body>
</html>