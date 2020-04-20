<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新用户注册</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
$(function(){
	
});
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
	width: 900px;height:715px;background: #fafcfa;margin: 175px auto 0;padding: 1px;
}
.regist_div .title1_div{
	height: 34px;line-height: 34px;font-size: 24px;color: #4caf50;text-align: center;margin-top: 50px;
}
.main_div{
	width: 816px;height:550px;margin: 20px auto 0;background-color: #fff;padding:1px;
}
.left_div{
	width:365px;height:495px;margin-top: 50px;
}
.sjhdl_h2{
	height:20px;line-height:20px;color: #4a4a4a;font-size:16px;font-weight: 700;text-align: center;margin-bottom: 20px;
}
.userName_div,.password_div,.password1_div{
	width: 220px;height:68px;
}
.nickName_div,.phone_div,.email_div{
	width: 220px;height:50px;
}
.userName_div .tit_div,.password_div .tit_div,.password1_div .tit_div,.nickName_div .tit_div,.phone_div .tit_div,.email_div .tit_div{
	width:100px;height:38px;line-height:38px;
}
.userName_div .tit_span,.password_div .tit_span,.password1_div .tit_span,.nickName_div .tit_span,.phone_div .tit_span,.email_div .tit_span{
	color: #4a4a4a;font-weight: 700;float: right;margin-right: 10px;
}
.userName_inp,.password_inp,.password1_inp,.nickName_inp,.phone_inp,.email_inp{
	width: 210px;height: 38px;line-height: 38px;margin-top:-38px;margin-left:100px; padding: 0 5px;border-radius: 4px;border: 1px solid rgba(120,130,140,0.25);
}
.warn_div{
	width: 213px;height: 30px;color: #999;padding-left: 8px;margin-left: 101px;
}
.submitBut_div{
	width: 220px;height:38px;line-height:38px;font-size: 16px;
    color: #fff;
    text-align: center;
    background-color: #4caf50;border-radius: 4px;cursor: pointer;
}
.resetBut_div{
	width: 218px;height:38px;line-height:38px;margin-top:10px;font-size: 16px;
    color: #999;
    text-align: center;
    background-color: #fff;border:1px solid #999;border-radius: 4px;cursor: pointer;
}
.cutLine_div{
	width: 1px;height: 495px;left: 50%;margin-top: -495px;background-color: rgba(120,130,140,.13);position: absolute;
}
.right_div{
	width:365px;height:220px;margin-top:-495px;margin-left:430px;
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
<!-- 
	<div class="register">
		<div class="register_content register-form">
			<div class="register_title">
				<h2 class="title">二维码查询商家注册</h2>
			</div>
			<form class="layui-form" method="post">
				<input type="hidden" name="action" value="${param.action }"/>
				<input type="hidden" name="price" value="${param.price }"/>
				<div class="layui-form-item">
					<label class="layui-form-label">用户名</label>
					<div class="layui-input-inline">
						<input type="text" name="userName" required lay-verify="required"
							placeholder="请输入用户名" autocomplete="off" class="layui-input">
					</div>
					<div class="layui-form-mid layui-word-aux">该用户名将作为登录账号使用</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">密码:</label>
					<div class="layui-input-inline">
						<input type="password" name="passWord" id="password"required
							lay-verify="required" placeholder="请输入密码" autocomplete="off"
							class="layui-input">
					</div>
					<div class="layui-form-mid layui-word-aux">请确保两次输入密码一致</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">确认密码:</label>
					<div class="layui-input-inline">
						<input type="password" name="passWord1" id="password1" required
							lay-verify="required|same_password" placeholder="请再次输入密码" autocomplete="off"
							class="layui-input">
					</div>
					<div class="layui-form-mid layui-word-aux">请确保两次输入密码一致</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">昵称</label>
					<div class="layui-input-inline">
						<input type="text" name="nickName" required lay-verify="required"
							placeholder="请输入用户昵称" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">手机:</label>
					<div class="layui-input-block">
						<input type="text" name="phone" required
							lay-verify="required|phone" placeholder="请输入手机号"
							autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">邮箱:</label>
					<div class="layui-input-block">
						<input type="text" name="email"
							placeholder="请输入邮箱地址" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
						<button type="reset" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	 -->
	 
 <div class="regist_div">
	<div class="title1_div">注册账号，生成的二维码将保存在你的账号后台</div>
	<div style="height: 22px;line-height: 22px;color: #999;font-size: 16px;font-weight: 400;text-align: center;">可随时修改内容，二维码图案不变</div>
	<div class="main_div">
		<div class="left_div">
			<h2 class="sjhdl_h2">二维码查询商家注册</h2>
			<div class="userName_div">
				<div class="tit_div"><span class="tit_span">用户名</span></div>
				<input type="text" class="userName_inp" id="userName" placeholder="请输入用户名" onfocus="focusUserName();" onblur="checkUserName();"/>
				<div class="warn_div">该用户名将作为登录账号使用</div>
			</div>
			<div class="password_div">
				<div class="tit_div"><span class="tit_span">密码</span></div>
				<input type="password" class="password_inp" id="password" placeholder="请输入密码" onblur="checkPassword();"/>
				<div class="warn_div">请确保两次输入密码一致</div>
			</div>
			<div class="password1_div">
				<div class="tit_div"><span class="tit_span">确认密码</span></div>
				<input type="password" class="password1_inp" id="password1" placeholder="请再次输入密码" onblur="checkPassword1();"/>
				<div class="warn_div">请确保两次输入密码一致</div>
			</div>
			<div class="nickName_div">
				<div class="tit_div"><span class="tit_span">昵称</span></div>
				<input type="text" class="nickName_inp" id="nickName" placeholder="请输入用户昵称" onfocus="focusNickName();" onblur="checkNickName();"/>
			</div>
			<div class="phone_div">
				<div class="tit_div"><span class="tit_span">手机</span></div>
				<input type="text" class="phone_inp" id="phone" placeholder="请输入手机号" onfocus="focusPhone();" onblur="checkPhone();"/>
			</div>
			<div class="email_div">
				<div class="tit_div"><span class="tit_span">邮箱</span></div>
				<input type="text" class="email_inp" id="email" placeholder="请输入邮箱地址" onfocus="focusEmail();" onblur="checkEmail();"/>
			</div>
			<div style="width: 240px;height: 38px;margin: auto;">
				<div class="submitBut_div" onclick="submit();">立即提交</div>
				<div class="resetBut_div" onclick="reset();">重置</div>
			</div>
		</div>
		<div class="cutLine_div"></div>
		<div class="right_div">
			<h2 class="wxkjdl_h2">微信快捷登录</h2>
			<div class="wxkjdl_div">
				<img class="qrcode_img" src="http://www.qrcodesy.com:8080/GoodsPublic/resource/images/qrcode.png"/>
					<div class="wxsys_div">无需验证码，快速登录</div>
			</div>
		</div>
	</div>
 	<div class="zjdl_div">已有账号？<a class="zjdl_a" href="<%=basePath%>merchant/login">直接登录</a></div>
 </div>
	 
	<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
	<script type="text/javascript">
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
	</script>
</body>
</html>