<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>二维码商品发布登录</title>
<%@include file="js.jsp"%>
<style>
/*
.beg-login-box {
	width: 450px;
	height: 330px;
	margin: 10% auto;
	background-color: rgba(255, 255, 255, 0.407843);
	border-radius: 10px;
	color: aliceblue;
}

.beg-login-main {
	height: 185px;
	padding: 0px 90px 0px;
}

header {
	justify-content: center;
	display: flex;
	padding-top: 20px;
}

body {
	font-size: 12px;
	background-color: #000;
}

.beg-pull-right {
	float: right;
}

.beg-pull-left {
	float: left;
}
*/
body{
	background-color: #f0f0f0;
}
.login_div{
	width: 816px;height:465px;background-color: #fff;margin: 175px auto 0;padding: 1px;
}
.main_div{
	margin-top: 70px;width: 100%;height: 250px;
}
.left_div{
	width: 406px;height:250px;
}
.sjhdl_h2{
	height: 20px;line-height: 20px;font-size: 16px;font-weight: 700;color: #4a4a4a;text-align: center;
}
.userName_div,.password_div{
	width: 220px;height:48px;margin: 20px auto 0;border-bottom: 1px solid #eee;
}
.userName_inp,.password_inp{
	height:48px;border:0;
}
.loginBut_div{
	width: 220px;height:38px;line-height:38px;margin:25px auto 0; font-size: 16px;color:#fff;text-align:center;background-color: #4caf50;border-radius:4px;cursor: pointer;
}
.cutLine_div{
	width: 1px;height: 250px;left: 50%;margin-top: -250px;background-color: #e6e6e6;position: absolute;
}
.right_div{
	width: 406px;height:250px;margin-left: 410px;margin-top: -250px;
}
.wxkjdl_h2{
	height: 20px;line-height: 20px;font-size: 16px;font-weight: 700;color: #4a4a4a;text-align: center;
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
.regist_div{
	font-size: 12px;color: #9b9b9b;text-align: center;margin-top: 80px;
}
.regist_a{
	color: #357bb3;
}
</style>
</head>
<body>
<!-- 
	<div class="beg-login-box">
		<header>
		<h1>二维码商品发布登录</h1>
		</header>
		<div class="beg-login-main">
			<form class="layui-form" method="post">
				<div class="layui-form-item">
					<label class="beg-login-icon"> <i class="layui-icon">&#xe612;</i>
					</label> <input type="text" name="userName" placeholder="请输入登录名"
						class="layui-input" lay-verify="required|userName"
						autocomplete="off" value="">
				</div>
				<div class="layui-form-item">
					<label class="beg-login-icon"> <i class="layui-icon">&#xe642;</i>
					</label> <input type="password" name="password" placeholder="请输入密码"
						class="layui-input" lay-verify="required|password_"
						autocomplete="off" value="">
				</div>
				<div class="layui-form-item">
					<div class="layui-row layui-col-space8">
						<div class="layui-col-md4">
							<input type="text" name="loginVCode" lay-verify="verifyCode"
								autocomplete="off" placeholder="验证码" lay-verify="required"
								class="layui-input" style="padding-left: 9px">
						</div>
						<div class="layui-col-md5">
							<img src="<%=basePath%>/merchant/login/captcha" id="loginVCode"
								style="width: 115px; height: 39px" />
						</div>
						<div class="layui-col-md3">
							<span style="font-size: 14px; line-height: 39px; float: right"><a
								href="javascript:void(0)" class="replace_code"
								style="color: #FFF; cursor: pointer">换一张?</a></span>
						</div>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="beg-pull-left ">
						<button class="layui-btn layui-btn-primary" lay-submit=""
							lay-filter="login">
							<i class="layui-icon">&#xe650;</i> 登录
						</button>
					</div>
					<div class="beg-pull-right">
						<a class="layui-btn layui-btn-primary"
							href="<%=basePath%>merchant/regist">注册新用户</a>
					</div>
					<div class="beg-clear"></div>
				</div>
			</form>
		</div>
	</div>
 -->
 <div class="login_div">
 	<div class="main_div">
 		<div class="left_div">
 			<h2 class="sjhdl_h2">手机号登录</h2>
 			<div class="userName_div">
 				<input class="userName_inp layui-input" type="text" id="userName" placeholder="请输入登录名" value="" onfocus="focusUserName();" onblur="checkUserName();">
 			</div>
 			<div class="password_div">
 				<input class="password_inp layui-input" type="password" id="password" placeholder="请输入密码" value="" onblur="checkPassword()">
 			</div>
 			<!-- 
 			<div style="width: 220px;height:48px;margin: 20px auto 0;border-bottom: 1px solid #eee;">
 				<input type="text" id="loginVCode" name="loginVCode" lay-verify="verifyCode"
							autocomplete="off" placeholder="验证码" lay-verify="required" onblur="checkVerifyCode()"
							class="layui-input" style="padding-left: 9px;width:85px;height:48px;">
				<img src="<%=basePath%>/merchant/login/captcha" id="loginVCode"
							style="width: 115px;height: 48px;margin-top: -48px;margin-left: 95px;" />
				<span style="font-size: 14px; line-height: 39px; float: right"><a
							href="javascript:void(0)" class="replace_code"
							style="cursor: pointer;margin-top: -48px;margin-left: ">换一张?</a></span>
 			</div>
 			 -->
 			<div class="loginBut_div" onclick="login()">登录</div>
 		</div>
 		<div class="cutLine_div"></div>
 		<div class="right_div">
 			<h2 class="wxkjdl_h2">微信快捷登录</h2>
 			<div class="wxkjdl_div">
 				<img class="qrcode_img" alt="" src="http://www.qrcodesy.com:8080/GoodsPublic/resource/images/qrcode.png">
 				<div class="wxsys_div">微信扫一扫，快速登录</div>
 			</div>
 		</div>
 	</div>
 	<div class="regist_div">还没有账号？<a class="regist_a" href="<%=basePath%>merchant/regist">立即免费注册</a></div>
 </div>
</body>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<script type="text/javascript">
    //更换验证码
    var baseUrl="${pageContext.request.contextPath}";
    /*
    $(".replace_code").bind("click",function () {
        $("#loginVCode").hide().attr('src', baseUrl+ "/merchant/login/captcha?" + Math.floor(Math.random() * 100) ).fadeIn();
    });
    //form提交
    layui.use(['layer', 'form'], function () {
        var layer = layui.layer,
            $ = layui.jquery,
            form = layui.form;
        //监听提交按钮
        form.on('submit(login)', function (data) {
            $(data.elem).attr('class', 'layui-btn layui-btn-disabled');
            var url=baseUrl + "/merchant/login"
            var params = {
                    userName: data.field.userName,
                    password: MD5(data.field.password).toUpperCase(),
                    rememberMe : data.field.rememberMe,
                    loginVCode:data.field.loginVCode
            };
            $.post(url,params,function(result){
            	var json=JSON.parse(result); 
            	console.log(json)
            	if(json.status==0){
            		layer.msg(json.msg, {icon: 6});
            		window.location.href=baseUrl+json.url;
            	}else if(json.status==1){
            		layer.alert(json.msg,{icon:5})
            	}
            	return false;
            })
            return false;
        });

        //自定义验证规则
        form.verify({
            userName: function (value) {
                if (!new RegExp("^[a-zA-Z0-9_\u4e00-\u9fa5\\s·]+$").test(value)) {
                    return '用户名不能有特殊字符';
                }
                if (/(^\_)|(\__)|(\_+$)/.test(value)) {
                    return '用户名首尾不能出现下划线\'_\'';
                }
              //  if(!/^1[3|4|5|7|8][0-9]{9}$/.test(value)){
             //       return '请输入正确用户名（手机号）';
              //  }
            },
            verifyCode: function (value) {
                if (value === '') {
                    return '验证码不能为空'
                } else if (value.length > 4) {
                    return '请输入四个字母验证码'
                } else if (value.length < 4) {
                    return '请输入四个字母验证码'
                }
            }
        });
    });
    */
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

function checkVerifyCode(){
	var loginVCode=$("#loginVCode").val();
	if (loginVCode === '') {
		alert("验证码不能为空");
        return false;
    } 
	else if (loginVCode.length > 4) {
    	alert("请输入四个字母验证码");
        return false;
    } 
	else if (loginVCode.length < 4) {
    	alert("请输入四个字母验证码");
        return false;
    }
    else{
    	return true;
    }
}

function login(){
	if(checkUserName()){
		if(checkPassword()){
			var userName=$("#userName").val();
			var password=MD5($("#password").val()).toUpperCase();
			//var loginVCode=$("#loginVCode").val();
			$.post(baseUrl + "/merchant/login",
				{userName:userName,password:password},
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
</script>
</html>