<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>商户注册</title>
<%@include file="../js.jsp"%>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<script type="text/javascript">
var baseUrl="${pageContext.request.contextPath}";
function focusUserName(){
	var userName=$("#userName").val();
	if(userName=="请输入用户名"){
		$("#userName").val("");
		$("#userName").css("color","#000");
	}
}

function checkUserName(){
	var userName=$("#userName").val();
	if(userName==null||userName==""||userName=="请输入用户名"){
		$("#userName").css("color","#f00");
		$("#userName").val("请输入用户名");
		return false;
	}
	else
		return true;
}

function checkPassword(){
	var password=$("#password").val();
	if(password==null||password==""||password=="请输入密码"){
		alert("请输入密码");
		return false;
	}
	else
		return true;
}

function checkPassword1(){
	var password=$("#password").val();
	var password1=$("#password1").val();
	if(password1==null||password1==""||password1=="请输入确认密码"){
		alert("请输入确认密码");
		return false;
	}
	if(password!=password1){
		alert("两次密码不一致");
		return false;
	}
	else
		return true;
}

function focusNickName(){
	var nickName=$("#nickName").val();
	if(nickName=="请输入用户昵称"){
		$("#nickName").val("");
		$("#nickName").css("color","#000");
	}
}

function checkNickName(){
	var nickName=$("#nickName").val();
	if(nickName==null||nickName==""||nickName=="请输入用户昵称"){
		$("#nickName").css("color","#f00");
		$("#nickName").val("请输入用户昵称");
		return false;
	}
	else
		return true;
}

function focusPhone(){
	var phone=$("#phone").val();
	if(phone=="请输入手机号"){
		$("#phone").val("");
		$("#phone").css("color","#000");
	}
}

function checkPhone(){
	var phone=$("#phone").val();
	if(phone==null||phone==""||phone=="请输入手机号"){
		$("#phone").css("color","#f00");
		$("#phone").val("请输入手机号");
		return false;
	}
	else
		return true;
}

function checkForm(){
	if(checkUserName()){
		if(checkPassword()){
			if(checkPassword1()){
				if(checkNickName()){
					if(checkPhone()){
						submit();
					}
				}
			}
		}
	}
}

function submit(){
	var userName=$("#userName").val();
	var password=MD5($("#password").val()).toUpperCase();
	var nickName=$("#nickName").val();
	var phone=$("#phone").val();
	var email=$("#email").val();
	$.post(baseUrl+"/merchant/regist",
		{userName:userName,passWord:password,nickName:nickName,phone:phone,email:email},
		function(result){
			if(result.status==0){
				window.location.href=baseUrl+"/merchant/phone/goAdminCreateQrcode";
			}else if(result.status==2){
				alert(result.msg);
			}
		}
	,"json");
}

function reset(){
	$("#userName").val("");
	$("#password").val("");
	$("#password1").val("");
	$("#nickName").val("");
	$("#phone").val("");
	$("#email").val("");
}

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
.yhzc_h2 {
    height: 20px;
    line-height: 20px;
	margin-top: 10px;
    font-size: 16px;
    font-weight: 700;
    color: #4a4a4a;
    text-align: center;
}
.userName_div, .password_div,.password1_div,.nickName_div,.phone_div,.email_div {
    width: 220px;
    height: 48px;
    margin: 20px auto 0;
    border-bottom: 3px solid #eee;
}
.userName_inp, .password_inp,.password1_inp,.nickName_inp,.phone_inp,.email_inp {
    height: 48px;
    border: 0;
}
.layui-input, .layui-textarea {
    display: block;
    width: 96%;
    padding-left: 10px;
}
.submitBut_div {
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
.resetBut_div{
	width: 220px;
    height: 38px;
    line-height: 38px;
    margin: 15px auto;
    font-size: 16px;
    color: #999;
    text-align: center;
    background-color: #fff;
    border:1px solid #999;
    border-radius: 4px;
}
.zjdl_div{
	font-size: 12px;color: #9b9b9b;text-align: center;margin-bottom: 25px;
}
.zjdl_a{
	color: #357bb3;
}
</style>
</head>
<body>
<div class="main_div">
	<span class="back_span" onclick="goBack()">&lt;返回</span>
	<h2 class="yhzc_h2">用户注册</h2>
	<div class="userName_div">
		<input class="userName_inp layui-input" type="text" id="userName" placeholder="请输入登录名" onfocus="focusUserName();" onblur="checkUserName();">
	</div>
	<div class="password_div">
		<input class="password_inp layui-input" type="password" id="password" placeholder="请输入密码" onblur="checkPassword()">
	</div>
	<div class="password1_div">
		<input class="password1_inp layui-input" type="password" id="password1" placeholder="请再次输入密码" onblur="checkPassword1()">
	</div>
	<div class="nickName_div">
		<input class="nickName_inp layui-input" type="text" id="nickName" placeholder="请输入用户昵称" onfocus="focusNickName();" onblur="checkNickName();">
	</div>
	<div class="phone_div">
		<input class="phone_inp layui-input" type="text" id="phone" placeholder="请输入手机号" onfocus="focusPhone();" onblur="checkPhone();">
	</div>
	<div class="email_div">
		<input class="email_inp layui-input" type="text" id="email" placeholder="请输入邮箱地址">
	</div>
	<div class="submitBut_div" onclick="checkForm();">立即提交</div>
	<div class="resetBut_div" onclick="reset();">重置</div>
	<div class="zjdl_div">已有账号？<a class="zjdl_a" href="<%=basePath%>merchant/phone/goCQCodePhLogin">直接登录</a></div>
</div>
</body>
</html>