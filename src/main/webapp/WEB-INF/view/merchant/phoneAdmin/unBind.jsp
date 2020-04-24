<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<%@include file="../js.jsp"%>
<script type="text/javascript">
var message='${requestScope.message }';
var msgArr=message.split("，");
$(function(){
	$("#msg1_div").text(msgArr[0]);
	$("#msg2_div").text(msgArr[1]);
});
</script>
<title>Insert title here</title>
<style type="text/css">
.msg1_div{
	font-size: 16px;text-align: center;margin: 100px auto 0;
}
.msg2_div{
	font-size: 16px;text-align: center;margin: 10px auto 0;
}
.okBut_div{
	width: 112px;height: 38px;line-height: 38px;margin: 50px auto 0;text-align: center;color: #fff;background-color: #00A3FF;border-radius: 3px;
}
</style>
</head>
<body>
<div class="msg1_div" id="msg1_div"></div>
<div class="msg2_div" id="msg2_div"></div>
<div class="okBut_div" onclick="WeixinJSBridge.call('closeWindow')">知道了</div>
</body>
</html>