<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新用户注册</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
var baseUrl="${pageContext.request.contextPath}";
$(function(){
	
});

function focusUserName(){
	var userName=$("#userName").val();
	if(userName=="请输入手机号或邮箱"){
		$("#userName").val("");
		$("#userName").css("color","#000");
	}
}

function checkUserName(){
	var userName=$("#userName").val();
	if(userName==null||userName==""||userName=="请输入手机号或邮箱"){
		$("#userName").css("color","#f00");
		$("#userName").val("请输入手机号或邮箱");
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

function checkForm(){
	if(checkUserName()){
		if(checkPassword()){
			if(checkPassword1()){
				submit();
			}
		}
	}
}

function submit(){
	var userName=$("#userName").val();
	var password=MD5($("#password").val()).toUpperCase();
	var phone=$("#userName").val();
	$.post(baseUrl+"/merchant/regist",
		{userName:userName,passWord:password,phone:phone},
		function(result){
			if(result.status==0){
				window.location.href=baseUrl+result.url
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
	/*
	$("#nickName").val("");
	$("#phone").val("");
	$("#email").val("");
	*/
}
</script>
<style>
/*
.register_content {
	width: 53%;
	margin: auto;
	background-color: #fff;
	border-radius: 3px;
}

body .beg-login-bg {
	position: inherit;
	overflow: auto;
}

.beg-login-bg {
	background-color: #393D49;
}

.register_title {
	padding: 10px 0 20px 0;
}

.register {
	margin-top: 100px;
}

.register-form {
	padding: 20px;
	border-radius: 5px;
	width: 90%;
	max-width: 1080px;
	margin: auto;
}

.title {
	font-size: 21px;
	font-weight: 600;
	text-align: center;
}

.layui-form-item>label {
	font-size: 14px;
	width: 90px;
	font-weight: 600;
}

.layui-form-item>.layui-input-block {
	margin-left: 120px;
}

.layui-form {
	width: 90%
}
*/
body{
	background-color: #f0f0f0;
}
.regist_div{
	width: 830px;height:585px;background: #fafcfa;margin: 175px auto 0;padding: 1px;
}
.regist_div .title1_div{
	height: 34px;line-height: 34px;font-size: 24px;color: #4caf50;text-align: center;margin-top: 50px;
}
.main_div{
	width: 740px;height:420px;margin: 20px auto 0;background-color: #fff;padding:1px;
}
.left_div{
	width:365px;height:340px;margin-top: 50px;
}
.sjhdl_h2{
	height:20px;line-height:20px;color: #4a4a4a;font-size:16px;font-weight: 700;text-align: center;margin-bottom: 20px;
}
.userName_div,.password_div,.password1_div{
	width: 220px;height:50px;margin: auto;
}
.userName_inp,.password_inp,.password1_inp{
	width: 210px;height: 48px;line-height: 48px;padding: 0 5px;border-top:0px;border-right:0px;border-bottom: 1px solid rgb(230,230,230);border-left:0px;
}
input::-webkit-input-placeholder{
    color:#BEBEBE;
}
input::-moz-placeholder{   /* Mozilla Firefox 19+ */
    color:#BEBEBE;
}
input:-moz-placeholder{    /* Mozilla Firefox 4 to 18 */
    color:#BEBEBE;
}
input:-ms-input-placeholder{  /* Internet Explorer 10-11 */ 
    color:#BEBEBE;
}
.submitBut_div{
	width: 220px;
	height:38px;
	line-height:38px;
	margin:20px auto 0;
	font-size: 16px;
    color: #fff;
    text-align: center;
    background-color: #4caf50;
    border-radius: 4px;
    cursor: pointer;
}
.resetBut_div{
	width: 218px;
	height:38px;
	line-height:38px;
	margin:20px auto 0;
	font-size: 16px;
    color: #999;
    text-align: center;
    background-color: #fff;
    border:1px solid #999;
    border-radius: 4px;
    cursor: pointer;
}
.cutLine_div{
	width: 1px;height: 250px;left: 50%;margin-top: -295px;background-color: rgba(120,130,140,.13);position: absolute;
}
.right_div{
	width:365px;height:220px;margin-top:-340px;margin-left:385px;position: absolute;
}
.wxkjdl_h2{
	height:20px;line-height:20px;color: #4a4a4a;font-size:16px;font-weight: 700;text-align: center;margin-bottom: 20px;
}
.wxkjdl_div{
	width: 100%;height:210px;margin: 20px auto 0;text-align: center;
}
.qrcode_img{
	width: 180px;height:180px;
}
.wxsys_div{
	font-size: 12px;color: #9B9B9B;
}
.zjdl_div{
	font-size: 12px;color: #9b9b9b;text-align: center;
}
.zjdl_a{
	color: #357bb3;
}
</style>
</head>
<body>
 <div class="regist_div">
	<div class="title1_div">注册账号，生成的二维码将保存在你的账号后台</div>
	<div style="height: 22px;line-height: 22px;color: #999;font-size: 16px;font-weight: 400;text-align: center;">可随时修改内容，二维码图案不变</div>
	<div class="main_div">
		<div class="left_div">
			<h2 class="sjhdl_h2">二维码查询商家注册</h2>
			<div class="userName_div">
				<input type="text" class="userName_inp" id="userName" placeholder="请输入手机号或邮箱" onfocus="focusUserName();" onblur="checkUserName();"/>
			</div>
			<div class="password_div">
				<input type="password" class="password_inp" id="password" placeholder="请输入密码" onblur="checkPassword();"/>
			</div>
			<div class="password1_div">
				<input type="password" class="password1_inp" id="password1" placeholder="请再次输入密码" onblur="checkPassword1();"/>
			</div>
			<div style="width: 100%;height: 38px;margin: auto;">
				<div class="submitBut_div" onclick="checkForm();">立即提交</div>
				<div class="resetBut_div" onclick="reset();">重置</div>
			</div>
		</div>
		<div class="cutLine_div"></div>
		<div class="right_div">
			<h2 class="wxkjdl_h2">微信快捷登录</h2>
			<div class="wxkjdl_div">
				<img class="qrcode_img" src="<%=basePath%>resource/images/009.png"/>
					<div class="wxsys_div">无需验证码，快速登录</div>
			</div>
		</div>
	</div>
 	<div class="zjdl_div">已有账号？<a class="zjdl_a" href="<%=basePath%>merchant/login">直接登录</a></div>
 </div>
	 
	<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
	<script type="text/javascript">
	/*
	var baseUrl="${pageContext.request.contextPath}"
		layui.use('form', function() {
			var form = layui.form;

			//监听提交
			form.on('submit(formDemo)', function(data) {
				url=baseUrl+"/merchant/regist"
				data.field.passWord=MD5(data.field.passWord).toUpperCase();
				$.post(url,data.field,function(result){
					console.log(result)
					if(result.status==0){
						window.location.href=baseUrl+result.url
					}else if(result.status==2){
						alert(result.msg)
					}
				},"json")
				console.log("===111===")
				return false
			});
			 form.verify({
		            //验证密码是否一样
		            same_password: function (value) {
		                var pass1 = $("#password").val();
		                if (value !== pass1) {
		                    return '两次输入密码不一致';
		                }
		            }
		        });
		})
		*/
	</script>
</body>
</html>