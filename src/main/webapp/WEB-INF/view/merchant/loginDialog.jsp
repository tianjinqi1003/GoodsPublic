<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<script charset="utf-8" src="<%=basePath %>/resource/js/MD5.js"></script>
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
		 //url:"http://www.bainuojiaoche.com:8080/GoodsPublic/merchant/loginQL",
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
<div id="login_bg_div" style="background-color:rgba(0, 0, 0, 0.3);position:fixed;width:100%;height:100%;display:none;z-index:6;">
	<div style="width: 642px;position: relative;height: 430px;margin: 0 auto;margin-top:200px;background: #eff2f3;text-align: center;border: 1px solid #eee;border-radius: 6px;box-sizing: border-box;overflow: hidden;">
		<div style="right:10px;top:10px;color:#bbb;position: absolute;cursor: pointer;" onclick="closeLoginBgDiv();">X</div>
		<div style="width:220px;height:280px;margin-top:50px;margin-left:50px;">
			<h2 style="color: #4caf50;font-size:20px;height:30px;line-height:30px;">登录</h2>
			<div style="width:220px;height:200px;margin-top:20px;">
				<input type="text" id="userName" style="width: 226px;height: 46px;line-height: 46px;border: 0;padding: 0 15px;font-size: 12px;display: inline-block;vertical-align: middle;box-sizing: border-box;border-radius: 4px;border: 1px solid rgba(120,130,140,0.25);background-color:rgb(255,248,197);" onfocus="focusUserName();" onblur="checkUserName();"/>
				<input type="password" id="password" style="width: 226px;height: 46px;line-height: 46px;border: 0;padding: 0 15px;font-size: 12px;display: inline-block;vertical-align: middle;box-sizing: border-box;border-radius: 4px;border: 1px solid rgba(120,130,140,0.25);background-color:rgb(255,248,197);" onblur="checkPassword();"/>
				<div style="width: 226px;height: 40px;line-height: 40px;font-size: 16px;color:#fff;margin-top:20px;border-radius: 4px;background-color:rgb(76, 175, 80);cursor: pointer;" onclick="checkInputData();">登 录</div>
			</div>
		</div>
		<div style="width: 1px;height: 246px;top: 72px;left: 320px;background-color: rgba(120,130,140,.13);position: absolute;"></div>
		<div style="width:220px;height:280px;margin-top:-280px;margin-left:365px;border: 1px solid rgba(120,130,140,0.25);padding: 16px 0 24px;box-sizing: border-box;border-radius: 4px;background: #fff;">
			<h2 style="color: #4caf50;font-size:20px;height:30px;line-height:30px;">微信账号登录</h2>
			<img style="width:170px;height:170px;" src="http://www.bainuojiaoche.com:8080/GoodsPublic/resource/images/qrcode.png"/>
			<p style="color: #666;font-size: 14px;margin-top: 10px;">微信扫码快速注册登录</p>
		</div>
		<div style="width:100%;height:50px;line-height:50px;color: #9b9b9b;text-align:center;background-color:#fff;bottom: 0;position: absolute;">
			没有账号？
			<a style="color: #357bb3;" onclick="goRegist();">手机号注册</a>
		</div>
		<input type="hidden" id="price_hid"/>
	</div>
</div>