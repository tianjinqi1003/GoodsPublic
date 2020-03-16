<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家信息</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
$(function(){
	$("#zhxx_div").css("width",setFitWidthInParent("body")+"px");
	$("#gsxx_div").css("width",setFitWidthInParent("body")+"px");
});

function checkEditNickName(){
	if(checkNickName()){
		var nickName=$("#nickName").val();

		$.post("editAccountInfo",
			{nickName:nickName},
			function(data){
				if(data.status==1){
					$.messager.defaults.ok = "是";
				    $.messager.defaults.cancel = "否";
				    $.messager.defaults.width = 350;//更改消息框宽度
				    $.messager.confirm(
				    	"提示",
				    	"账户信息编辑成功，重新登录生效！是否重新登录？"
				        ,function(r){    
				            if (r){    
				                location.href="../exit";
				            }
				        }); 
				}
				else{
					$.messager.alert("提示","账户信息编辑失败","warning");
				}
			}
		,"json");
	}
}

function checkEditCompany(){
	if(checkCompanyName()){
		if(checkCompanyAddress()){
			if(checkPhone()){
				if(checkEmail()){
					var companyName=$("#companyName").val();
					var companyAddress=$("#companyAddress").val();
					var phone=$("#phone").val();
					var email=$("#email").val();
					
					$.post("editAccountInfo",
						{companyName:companyName,companyAddress:companyAddress,phone:phone,email:email},
						function(data){
							if(data.status==1){
								$.messager.defaults.ok = "是";
							    $.messager.defaults.cancel = "否";
							    $.messager.defaults.width = 350;//更改消息框宽度
							    $.messager.confirm(
							    	"提示",
							    	"商家编辑成功，重新登录生效！是否重新登录？"
							        ,function(r){    
							            if (r){    
							                location.href="../exit";
							            }
							        }); 
							}
							else{
								$.messager.alert("提示","商家编辑失败","warning");
							}
						}
					,"json");
				}
			}
		}
	}
}

function focusNickName(){
	var nickName = $("#nickName").val();
	if(nickName=="昵称不能为空"){
		$("#nickName").val("");
		$("#nickName").css("color", "#555555");
	}
}

//验证昵称
function checkNickName(){
	var nickName = $("#nickName").val();
	if(nickName==null||nickName==""||nickName=="昵称不能为空"){
		$("#nickName").css("color","#E15748");
    	$("#nickName").val("昵称不能为空");
    	return false;
	}
	else
		return true;
}

function focusCompanyName(){
	var companyName = $("#companyName").val();
	if(companyName=="公司名称不能为空"){
		$("#companyName").val("");
		$("#companyName").css("color", "#555555");
	}
}

//验证公司名称
function checkCompanyName(){
	var companyName = $("#companyName").val();
	if(companyName==null||companyName==""||companyName=="公司名称不能为空"){
		$("#companyName").css("color","#E15748");
    	$("#companyName").val("公司名称不能为空");
    	return false;
	}
	else
		return true;
}

function focusCompanyAddress(){
	var companyAddress = $("#companyAddress").val();
	if(companyAddress=="公司地址不能为空"){
		$("#companyAddress").val("");
		$("#companyAddress").css("color", "#555555");
	}
}

//验证公司地址
function checkCompanyAddress(){
	var companyAddress = $("#companyAddress").val();
	if(companyAddress==null||companyAddress==""||companyAddress=="公司地址不能为空"){
		$("#companyAddress").css("color","#E15748");
    	$("#companyAddress").val("公司地址不能为空");
    	return false;
	}
	else
		return true;
}

function focusPhone(){
	var phone = $("#phone").val();
	if(phone=="联系方式不能为空"){
		$("#phone").val("");
		$("#phone").css("color", "#555555");
	}
}

//验证联系方式
function checkPhone(){
	var phone = $("#phone").val();
	if(phone==null||phone==""||phone=="联系方式不能为空"){
		$("#phone").css("color","#E15748");
    	$("#phone").val("联系方式不能为空");
    	return false;
	}
	else
		return true;
}

function focusEmail(){
	var email = $("#email").val();
	if(email=="邮箱不能为空"){
		$("#email").val("");
		$("#email").css("color", "#555555");
	}
}

//验证邮箱
function checkEmail(){
	var email = $("#email").val();
	if(email==null||email==""||email=="邮箱不能为空"){
		$("#email").css("color","#E15748");
    	$("#email").val("邮箱不能为空");
    	return false;
	}
	else
		return true;
}
	
function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-310;
}

function openEditNickNameDialog(flag){
	$("#editNickNameBg_div").css("display",flag==1?"block":"none");
}

function openEditPwdDialog(flag){
	$("#editPwdBg_div").css("display",flag==1?"block":"none");
}

function openEditCompanyDialog(flag){
	$("#editCompanyBg_div").css("display",flag==1?"block":"none");
}
</script>
<style type="text/css">
.editNickNameBg_div{
	width: 100%;height:100%;
	background: rgba(0,0,0,0.65);
	position: fixed;
	display: none;
	z-index: 1001;
}
.editNickName_div{
	width:500px;height:190px;margin:245px auto;background: #f8f8f8;border-radius: 6px;
}
.editNickName_div .title{
	font-size: 22px;color: #4CAF50;text-align: center;padding-top: 20px;
}
.editNickName_div .nc_div{
	width:255px;margin: auto;padding-top: 20px;
}
.editNickName_div input{
	width: 200px;height:30px;margin-left: 20px;border: 1px solid #DDE0E2;
}
.editNickName_div .but_div{
	width:168px;margin: auto;padding-top: 20px;
}
.editNickName_div .but{
	width: 76px;padding: 5px 10px;font-size: 14px;border: 1px solid #d9d9d9;border-radius: 4px;cursor: pointer;
}
.editNickName_div .cancel_but{
	color: #323232;background: #FFF;
}
.editNickName_div .submit_but{
	color: #FFF;background: #4CAF52;margin-left: 12px;
}

.editPwdBg_div{
	width: 100%;height:100%;
	background: rgba(0,0,0,0.65);
	position: fixed;
	display: none;
	z-index: 1001;
}
.editPwd_div{
	width:400px;height:420px;margin:100px auto;background: #f8f8f8;border-radius: 6px;
}
.editPwd_div .title{
	font-size: 22px;color: #4CAF50;text-align: center;padding-top: 50px;
}
.editPwd_div .ymm_div{
	width:240px;margin: auto;padding-top: 20px;
}
.editPwd_div .xmm_div,.editPwd_div .qrmm_div{
	width:240px;margin: auto;
}
.editPwd_div input{
	width: 216px;
    height: 46px;
    padding: 0 15px;
    font-size: 12px;
	border: 1px solid #DDE0E2;
    border-radius: 4px;
}

.editCompanyBg_div{
	width: 100%;height:100%;
	background: rgba(0,0,0,0.65);
	position: fixed;
	display: none;
	z-index: 1001;
}
.editCompany_div{
	width:500px;height:340px;margin:100px auto;background: #f8f8f8;border-radius: 6px;
}
.editCompany_div .title{
	font-size: 22px;color: #4CAF50;text-align: center;padding-top: 20px;
}
.editCompany_div .gsmc_div,.editCompany_div .gsdz_div,.editCompany_div .lxdh_div,.editCompany_div .yx_div{
	width:300px;margin: auto;padding-top: 20px;
}
.editCompany_div input{
	width: 200px;height:30px;margin-left: 20px;border: 1px solid #DDE0E2;
}
.editCompany_div .but_div{
	width:168px;margin: auto;padding-top: 20px;
}
.editCompany_div .but{
	width: 76px;padding: 5px 10px;font-size: 14px;border: 1px solid #d9d9d9;border-radius: 4px;cursor: pointer;
}
.editCompany_div .cancel_but{
	color: #323232;background: #FFF;
}
.editCompany_div .submit_but{
	color: #FFF;background: #4CAF52;margin-left: 12px;
}
</style>
</head>
<body>
<div class="editNickNameBg_div" id="editNickNameBg_div">
	<div class="editNickName_div">
		<h4 class="title">修改昵称</h4>
		<div class="nc_div">
			<span>昵称</span>
			<input type="text" id="nickName" value="${requestScope.accountMsg.nickName }" onfocus="focusNickName()" onblur="checkNickName()"/>
		</div>
		<div class="but_div">
			<button class="but cancel_but" onclick="openEditNickNameDialog(0)">取消</button>
			<button class="but submit_but" onclick="checkEditNickName()">提交</button>
		</div>
	</div>
</div>

<div class="editPwdBg_div" id="editPwdBg_div">
	<div class="editPwd_div">
		<div>
			<span style="float: right;margin-top: 20px;margin-right: 20px;font-size: 25px;cursor: pointer;" onclick="openEditPwdDialog(0)">×</span>
		</div>
		<h4 class="title">修改密码</h4>
		<div class="ymm_div">
			<input type="password" id="passWord" placeholder="原密码" onfocus="focusPassWord()" onblur="checkPassWord()"/>
		</div>
		<div class="xmm_div">
			<input type="password" id="newNewPwd" placeholder="新密码" onfocus="focusPassWord()" onblur="checkPassWord()"/>
		</div>
		<div class="qrmm_div">
			<input type="password" id="newNewPwd2" placeholder="确认密码" onfocus="focusPassWord()" onblur="checkPassWord()"/>
		</div>
		<div style="width:240px;height:40px;line-height:40px;margin: 30px auto;text-align:center;font-size:17px;color:#fff;background-color:#4caf50;border-radius:3px;">确定</div>
		<div style="width: 100%;margin-top: 20px;border-radius: 0 0 4px 4px;font-size: 12px;text-align: center;color: #9b9b9b;">注意：密码修改后需要重新登录系统</div>
	</div>
</div>

<div class="editCompanyBg_div" id="editCompanyBg_div">
	<div class="editCompany_div">
		<h4 class="title">公司信息</h4>
		<div class="gsmc_div">
			<span>公司名称</span>
			<input type="text" id="companyName" value="${requestScope.accountMsg.companyName }" onfocus="focusCompanyName()" onblur="checkCompanyName()"/>
		</div>
		<div class="gsdz_div">
			<span>公司地址</span>
			<input type="text" id="companyAddress" value="${requestScope.accountMsg.companyAddress }" onfocus="focusCompanyAddress()" onblur="checkCompanyAddress()"/>
		</div>
		<div class="lxdh_div">
			<span>联系电话</span>
			<input type="text" id="phone" value="${requestScope.accountMsg.phone }" onfocus="focusPhone()" onblur="checkPhone()"/>
		</div>
		<div class="yx_div">
			<span>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱</span>
			<input type="text" id="email" value="${requestScope.accountMsg.email }" onfocus="focusEmail()" onblur="checkEmail()"/>
		</div>
		<div class="but_div">
			<button class="but cancel_but" onclick="openEditCompanyDialog(0)">取消</button>
			<button class="but submit_but" onclick="checkEditCompany()">提交</button>
		</div>
	</div>
</div>

<div class="layui-layout layui-layout-admin">
	<%@include file="side.jsp"%>
	<div id="zhxx_div" style="height:230px;margin-top:20px;margin-left: 238px;padding-top:40px;padding-left:40px;background-color:#FAFDFE;">
		<div style="font-size: 20px;color: #373737;font-weight:700;">账户信息</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</span>
			<span>${requestScope.accountMsg.nickName }</span>
			<span style="font-size: 14px;color: #357bb3;margin-left: 15px;cursor: pointer;" onclick="openEditNickNameDialog(1)">修改昵称</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">用户账号：</span>
			<span>${requestScope.accountMsg.userName }</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</span>
			<span>已设置</span>
			<span style="font-size: 14px;color: #357bb3;margin-left: 15px;cursor: pointer;" onclick="openEditPwdDialog(1)">修改密码</span>
		</div>
		<div style="margin-top:20px;">
			<a>绑定微信</a>
		</div>
	</div>
	<div id="gsxx_div" style="height:260px;margin-top:20px;margin-left: 238px;padding-top:40px;padding-left:40px;background-color:#FAFDFE;">
		<div style="font-size: 20px;color: #373737;font-weight:700;">公司信息</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">公司名称：</span>
			<span>${requestScope.accountMsg.companyName }</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">公司地址：</span>
			<span>${requestScope.accountMsg.companyAddress }</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">联系电话：</span>
			<span>${requestScope.accountMsg.phone }</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</span>
			<span>${requestScope.accountMsg.email }</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #357bb3;cursor: pointer;" onclick="openEditCompanyDialog(1)">修改公司信息</span>
		</div>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>