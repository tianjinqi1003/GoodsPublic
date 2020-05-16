<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>微信扫码登录</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
function goBack(){
	location.href="goCQCodePhLogin";
}
</script>
<style>
body{
	width:100%;
	margin:0;
	background-color: #fff;
}
.main_div{
	width:100%;
	height:400px;
	margin:auto;
	padding:1px;
}
.back_span{
	margin-left: 10px;
}
.qywxsmdl_h2 {
    height: 20px;
    line-height: 20px;
	margin-top: 50px;
    font-size: 16px;
    font-weight: 700;
    color: #4a4a4a;
    text-align: center;
}
.qrcode_div{
	text-align: center;
	margin-top: 30px;
}
.qrcode_div img{
	width: 300px;height: 300px;
}
</style>
</head>
<body>
<div class="main_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<h2 class="qywxsmdl_h2">请用微信扫码登录</h2>
	<div class="qrcode_div">
		<img alt="" src="<%=basePath %>resource/images/010.png">
	</div>
</div>
</body>
</html>