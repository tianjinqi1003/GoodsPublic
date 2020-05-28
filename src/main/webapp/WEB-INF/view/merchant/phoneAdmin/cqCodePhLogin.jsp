<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>辰麒二维码追溯系统，一物一码，智能追溯</title>
<%@include file="../js.jsp"%>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<script type="text/javascript">
var baseUrl="${pageContext.request.contextPath}";
function focusUserName(){
	var userName=$("#userName").val();
	if(userName=="请填写用户名"||userName=="用户名不能有特殊字符"||userName=="用户名首尾不能出现下划线\'_\'"){
		$("#userName").val("");
		$("#userName").css("color","#000");
	}
}
    
function checkUserName(){
    var userName=$("#userName").val();
    if(userName==null||userName==""||userName=="请填写用户名"){
		$("#userName").css("color","#f00");
		$("#userName").val("请填写用户名");
		return false;
	}
    else if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(userName)) {
    	$("#userName").css("color","#f00");
		$("#userName").val("用户名不能有特殊字符");
        return false;
    }
    else if (/(^\_)|(\__)|(\_+$)/.test(userName)) {
    	$("#userName").css("color","#f00");
		$("#userName").val("用户名首尾不能出现下划线\'_\'");
        return false;
    }
	else
		return true;
}

function checkPassword(){
	var password=$("#password").val();
	if(password==null||password==""||password=="请填写密码"){
		alert("请填写密码");
		return false;
	}
	else
		return true;
}

function login(){
	if(checkUserName()){
		if(checkPassword()){
			var userName=$("#userName").val();
			var password=MD5($("#password").val()).toUpperCase();
			var from='${param.from}';
			$.post(baseUrl + "/merchant/login",
				{userName:userName,password:password,from:from},
				function(json){
		        	console.log(json)
		        	if(json.status==0){
		        		window.location.href=baseUrl+json.url;
		        	}else if(json.status==1){
		        		alert(json.msg);
		        	}
				}
			,"json");
		}
	}
}

function goBack(){
	location.href="http://cqcode.qdhualing.com";
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
.sjhdl_h2 {
    height: 20px;
    line-height: 20px;
	margin-top: 50px;
    font-size: 16px;
    font-weight: 700;
    color: #4a4a4a;
    text-align: center;
}
.userName_div, .password_div {
    width: 220px;
    height: 48px;
    margin: 20px auto 0;
    border-bottom: 3px solid #eee;
}
.userName_inp, .password_inp {
    height: 48px;
    border: 0;
}
.layui-input, .layui-textarea {
    display: block;
    width: 96%;
    padding-left: 10px;
}
.loginBut_div {
    width: 220px;
    height: 38px;
    line-height: 38px;
    margin: 25px auto 0;
    font-size: 16px;
    color: #fff;
    text-align: center;
    background-color: #4caf50;
    border-radius: 4px;
}
.wxdl_div,.yhzc_div{
	text-align: center;margin-top: 10px;
}
.wxdl_div a,.yhzc_div a{
	color: #4caf50;font-size: 16px;text-decoration: underline;
}
.tiShi_div{
	width:225px;margin: 25px auto 0;text-align: center;
}
</style>
</head>
<body>
<div class="main_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<h2 class="sjhdl_h2">用户登录</h2>
	<div class="userName_div">
		<input class="userName_inp layui-input" type="text" id="userName" placeholder="请输入登录名" value="" onfocus="focusUserName();" onblur="checkUserName();">
	</div>
	<div class="password_div">
		<input class="password_inp layui-input" type="password" id="password" placeholder="请输入密码" value="" onblur="checkPassword()">
	</div>
	<div class="loginBut_div" onclick="login()">登录</div>
	<div class="wxdl_div">
		<a href="<%=basePath %>merchant/phone/goWxScanLogin">微信登录</a>
	</div>
	<div class="yhzc_div">
		<a href="<%=basePath %>merchant/phone/goCQCodePhRegister">用户注册</a>
	</div>
	<div class="tiShi_div">请用电脑登录http://www.qrcodesy.com，体验辰麒二维码追溯平台动态码生成功能</div>
</div>
</body>
</html>