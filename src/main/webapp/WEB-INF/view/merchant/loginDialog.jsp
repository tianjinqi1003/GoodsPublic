<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<script charset="utf-8" src="<%=basePath %>/resource/js/MD5.js"></script>
<style>
.login_bg_div{
	width:100%;height:100%;background-color:rgba(0, 0, 0, 0.3);position:fixed;display:none;z-index:6;
}
.login_div{
	width: 795px;height: 540px;margin: 60px auto 0;background: #eff2f3;border: 1px solid #eee;padding:1px;border-radius: 6px;box-sizing: border-box;overflow: hidden;position: relative;
}
.login_div .closeBut_div{
	right:10px;top:10px;color:#bbb;position: absolute;cursor: pointer;
}
.login_div .dlqlzh_div{
	height: 34px;line-height: 34px;font-size: 24px;color: #4caf50;text-align: center;margin-top: 50px;
}
.login_div .main_div{
	width: 735px;height:380px;margin: 45px auto 0;background-color: #fff;padding:1px;
}
.login_div .logLeft_div{
	width:365px;height:220px;margin-top: 50px;
}
.login_div .sjhdl_h2{
	height:20px;line-height:20px;color: #4a4a4a;font-size:16px;font-weight: 700;text-align: center;margin-bottom: 20px;
}
.login_div .userName_div,.login_div .password_div{
	width: 220px;height:48px;margin: auto;border-bottom: 1px solid #eee;
}
.login_div .userName_inp,.login_div .password_inp{
	width: 210px;height: 48px;line-height: 48px;padding: 0 5px;border-radius: 4px;border: 1px solid rgba(120,130,140,0.25);
}
.login_div .loginBut_div{
	width: 220px;height: 38px;line-height: 38px;font-size: 16px;color:#fff;text-align:center;margin:40px auto 0;border-radius: 4px;background-color:rgb(76, 175, 80);cursor: pointer;
}
.login_div .cutLine_div{
	width: 1px;height: 183px;left: 50%;margin-top: -183px;background-color: rgba(120,130,140,.13);position: absolute;
}
.login_div .logRight_div{
	width:365px;height:220px;margin-top:-220px;margin-left:370px;
}
.login_div .wxkjdl_h2{
	height:20px;line-height:20px;color: #4a4a4a;font-size:16px;font-weight: 700;text-align: center;margin-bottom: 20px;
}
.login_div .wxkjdl_div{
	width: 100%;height:210px;margin: 20px auto 0;text-align: center;
}
.login_div .qrcode_img{
	width: 180px;height:180px;
}
.login_div .wxsys_div{
	font-size: 12px;color: #9B9B9B;
}
.login_div .regist_div{
	font-size: 12px;color: #9b9b9b;text-align: center;margin-top: 75px;
}
.login_div .regist_a{
	color: #357bb3;
}
</style>
<script type="text/javascript">
function checkInputData(){
	if(checkUserName()){
		if(checkPassword()){
			login();
		}
	}
}

function focusUserName(){
	var userName=$("#userName").val();
	if(userName=="请填写用户名"){
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
	  var userName=$("#userName").val();
	  var password=MD5($("#password").val()).toUpperCase();
	  $.ajax({
		 //url:"http://www.qrcodesy.com:8080/GoodsPublic/merchant/loginQL",
		 url:"http://localhost:8088/GoodsPublic/merchant/loginQL",
		 dataType:'jsonp',
		 data:"userName="+userName+"&password="+password+"&action=addModule",
		 processData: false, 
		 jsonp:'callback',
		 jsonpCallback:"jsonpCallback",
		 type:'get',
		 success:function(data){
		   var json=JSON.parse(data);
		   console.log(json);
		   if(json.status==0){
			  var trade='${param.trade}';
			  if(trade=="spzs")
			  	addHtmlGoodsSPZS();
			  else if(trade=="dmtzl")
				 addHtmlGoodsDMTZL();
			  else if(trade=="jzsg")
				  addHtmlGoodsJZSG();
		   }
		   else{
			  alert(json.msg);
		   }
		 },
		 error:function(XMLHttpRequest, textStatus, errorThrown) {
		   alert(XMLHttpRequest);
		   alert(XMLHttpRequest.status);
		   alert(XMLHttpRequest.readyState);
		   alert(textStatus);
		 }
	 });
}

function closeLoginBgDiv(){
	 $("#login_bg_div").css("display","none");
}
</script>
<div class="login_bg_div" id="login_bg_div">
	<div class="login_div">
		<div class="closeBut_div" onclick="closeLoginBgDiv();">X</div>
		<div class="dlqlzh_div">登录辰麒账号</div>
		<div class="main_div">
			<div class="logLeft_div">
				<h2 class="sjhdl_h2">手机号登录</h2>
				<div class="userName_div">
					<input type="text" class="userName_inp" id="userName" onfocus="focusUserName();" onblur="checkUserName();"/>
				</div>
				<div class="password_div">
					<input type="password" class="password_inp" id="password" onblur="checkPassword();"/>
				</div>
				<div class="loginBut_div" onclick="checkInputData();">登 录</div>
			</div>
			<div class="cutLine_div"></div>
			<div class="logRight_div">
				<h2 class="wxkjdl_h2">微信快捷登录</h2>
				<div class="wxkjdl_div">
					<img class="qrcode_img" src="http://www.qrcodesy.com:8080/GoodsPublic/resource/images/qrcode.png"/>
 					<div class="wxsys_div">微信扫一扫，快速登录</div>
				</div>
			</div>
 			<div class="regist_div">还没有账号？<a class="regist_a" href="<%=basePath%>merchant/regist">立即免费注册</a></div>
		</div>
		<input type="hidden" id="price_hid"/>
	</div>
</div>