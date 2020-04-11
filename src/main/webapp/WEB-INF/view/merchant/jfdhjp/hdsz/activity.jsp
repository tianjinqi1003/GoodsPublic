<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>活动设置</title>
<%@include file="../../js.jsp"%>
<script type="text/javascript" src="<%=basePath %>resource/js/MD5.js"></script>
<script type="text/javascript">
$(function(){
	$("#zhxx_div").css("width",setFitWidthInParent("body")+"px");
	$("#hdsz_div").css("width",setFitWidthInParent("body")+"px");
	
	$("#save_but").linkbutton({
		iconCls:"icon-save",
		onClick:function(){
			if(checkJpmLimit()){
				if(checkDhjpScore()){
					if(checkJpmdhReg()){
						if(checkEndTime()){
							editJFDHJPActivity();
						}
					}
				}
			}
		}
	});
	
	var enable='${requestScope.jfdhjpActivity.enable }';
	if(enable=="true")
		$("#open_rad").prop("checked",true);
	else
		$("#close_rad").prop("checked",true);
	endTimeDTB=$("#endTime_dtb").datetimebox({
		width:157,
		editable:false
	});
	endTimeDTB.datetimebox("setValue",'${requestScope.jfdhjpActivity.endTime }');
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

function checkEditPwd(){
	if(checkPassWord()){
		if(checkNewPwd()){
			if(checkNewPwd2()){
				var passWord = $("#newPwd").val();
				$.post("updatePwdByAccountId",
					{passWord:MD5(passWord).toUpperCase()},
					function(result){
						var json=JSON.parse(result);
						if(json.status==1){
							$.messager.defaults.ok = "是";
						    $.messager.defaults.cancel = "否";
						    $.messager.defaults.width = 350;//更改消息框宽度
						    $.messager.confirm(
						    	"提示",
						    	"修改密码成功，重新登录生效！是否重新登录？"
						        ,function(r){    
						            if (r){    
						                location.href="../exit";
						            }
						        }); 
						}
						else{
							$.messager.alert("提示","修改密码失败","warning");
						}
					}
				);
			}
		}
	}
}

function editJFDHJPActivity(){
	var id=$("#hdsz_div #id").val();
	var jpmLimit = $("#jpmLimit_inp").val();
	var dhjpScore = $("#dhjpScore_inp").val();
	var jpmdhReg = $("#jpmdhReg_ta").val();
	var endTime=endTimeDTB.datetimebox("getValue");
	var accountNumber=$("#hdsz_div #accountNumber").val();
	var enable=$("#open_rad").prop("checked");
	$.post("editJFDHJPActivity",
		{id:id,jpmLimit:jpmLimit,dhjpScore:dhjpScore,jpmdhReg:jpmdhReg,endTime:endTime,accountNumber:accountNumber,enable:enable},
		function(data){
			if(data.status==1){
				alert(data.msg);
				location.href=location.href;
			}
			else
				alert(data.msg);
		}
	,"json");
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

//验证原密码
function checkPassWord(){
	var flag=false;
	var userName='${sessionScope.user.userName}';
	var passWord = $("#passWord").val();
	if(passWord==null||passWord==""){
    	alert("原密码不能为空");
    	flag=false;
	}
	else{
		$.ajaxSetup({async:false});
		$.post("checkPassWord",
			{passWord:MD5(passWord).toUpperCase(),userName:userName},
			function(data){
				if(data.status=="ok"){
					flag=true;
				}
				else{
					alert(data.message);
					flag=false;
				}
			}
		,"json");
	}
	return flag;
}

//验证新密码
function checkNewPwd(){
	var passWord = $("#passWord").val();
	var newPwd = $("#newPwd").val();
	if(newPwd==null||newPwd==""){
  	alert("新密码不能为空");
  	return false;
	}
	if(newPwd==passWord){
		alert("新密码不能和原密码一致！");
  	return false;
	}
	else
		return true;
}

//验证确认密码
function checkNewPwd2(){
	var newPwd = $("#newPwd").val();
	var newPwd2 = $("#newPwd2").val();
	if(newPwd2==null||newPwd2==""){
  	alert("确认密码不能为空");
  	return false;
	}
	else if(newPwd!=newPwd2){
		alert("两次密码不一致！");
  	return false;
	}
	else
		return true;
}

function focusJpmLimit(){
	var jpmLimit = $("#jpmLimit_inp").val();
	if(jpmLimit=="奖品码期限不能为空"){
		$("#jpmLimit_inp").val("");
		$("#jpmLimit_inp").css("color", "#555555");
	}
}

function checkJpmLimit(){
	var jpmLimit = $("#jpmLimit_inp").val();
	if(jpmLimit==null||jpmLimit==""||jpmLimit=="奖品码期限不能为空"){
		$("#jpmLimit_inp").css("color","#E15748");
    	$("#jpmLimit_inp").val("奖品码期限不能为空");
    	return false;
	}
	else{
		return true;
	}
}

function focusDhjpScore(){
	var dhjpScore = $("#dhjpScore_inp").val();
	if(dhjpScore=="兑换奖品积分不能为空"){
		$("#dhjpScore_inp").val("");
		$("#dhjpScore_inp").css("color", "#555555");
	}
}

function checkDhjpScore(){
	var dhjpScore = $("#dhjpScore_inp").val();
	if(dhjpScore==null||dhjpScore==""||dhjpScore=="兑换奖品积分不能为空"){
		$("#dhjpScore_inp").css("color","#E15748");
    	$("#dhjpScore_inp").val("兑换奖品积分不能为空");
    	return false;
	}
	else{
		return true;
	}
}

function focusJpmdhReg(){
	var jpmdhReg = $("#jpmdhReg_ta").val();
	if(jpmdhReg=="兑换奖品规则不能为空"){
		$("#jpmdhReg_ta").val("");
		$("#jpmdhReg_ta").css("color", "#555555");
	}
}

function checkJpmdhReg(){
	var jpmdhReg = $("#jpmdhReg_ta").val();
	if(jpmdhReg==null||jpmdhReg==""||jpmdhReg=="兑换奖品规则不能为空"){
		$("#jpmdhReg_ta").css("color","#E15748");
    	$("#jpmdhReg_ta").val("兑换奖品规则不能为空");
    	return false;
	}
	else{
		return true;
	}
}

function checkEndTime(){
	var endTime=endTimeDTB.datetimebox("getValue");
	if(endTime==""||endTime==null){
		alert("请选择活动到期时间！");
		return false;
	}
	else
		return true;
}

function openEditNickNameDialog(flag){
	$("#editNickNameBg_div").css("display",flag==1?"block":"none");
}

function openEditPwdDialog(flag){
	$("#editPwdBg_div").css("display",flag==1?"block":"none");
}

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-310;
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
.editPwd_div .close_span{
	float: right;margin-top: 20px;margin-right: 20px;font-size: 25px;cursor: pointer;
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
.editPwd_div .confirm_div{
	width:240px;height:40px;line-height:40px;margin: 30px auto;text-align:center;font-size:17px;color:#fff;background-color:#4caf50;border-radius:3px;cursor: pointer;
}
.editPwd_div .warn_div{
	width: 100%;margin-top: 20px;border-radius: 0 0 4px 4px;font-size: 12px;text-align: center;color: #9b9b9b;
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
			<span class="close_span" onclick="openEditPwdDialog(0)">×</span>
		</div>
		<h4 class="title">修改密码</h4>
		<div class="ymm_div">
			<input type="password" id="passWord" placeholder="原密码"/>
		</div>
		<div class="xmm_div">
			<input type="password" id="newPwd" placeholder="新密码"/>
		</div>
		<div class="qrmm_div">
			<input type="password" id="newPwd2" placeholder="确认密码"/>
		</div>
		<div class="confirm_div" onclick="checkEditPwd()">确定</div>
		<div class="warn_div">注意：密码修改后需要重新登录系统</div>
	</div>
</div>

<div class="layui-layout layui-layout-admin">
	<%@include file="../../side.jsp"%>
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
	<div id="hdsz_div" style="height:350px;margin-top:20px;margin-left: 238px;padding-top:40px;padding-left:40px;background-color:#FAFDFE;">
		<input type="hidden" id="id" value="${requestScope.jfdhjpActivity.id eq null?'':requestScope.jfdhjpActivity.id }"/>
		<input type="hidden" id="accountNumber" value="${requestScope.accountMsg.id }"/>
		<div style="font-size: 20px;color: #373737;font-weight:700;">活动设置</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">活动开关&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</span>
			<span>
				开&nbsp;<input type="radio" id="open_rad" name="enable" checked="checked"/>&nbsp;&nbsp;&nbsp;
				关&nbsp;<input type="radio" id="close_rad" name="enable"/>
			</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">奖品码期限&nbsp;&nbsp;&nbsp;：</span>
			<input id="jpmLimit_inp" name="jpmLimit" type="text" value="${requestScope.jfdhjpActivity.jpmLimit }" size="18" maxlength="20" onfocus="focusJpmLimit()" onblur="checkJpmLimit()"/>
			（生成后几天）<span style="color: #f00;">*</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">兑换奖品积分：</span>
			<input id="dhjpScore_inp" name="dhjpScore" type="text" value="${requestScope.jfdhjpActivity.dhjpScore }" maxlength="20" onfocus="focusDhjpScore()" onblur="checkDhjpScore()"/>
			<span style="color: #f00;">*</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">兑奖截止日期：</span>
			<span><input id="endTime_dtb" name="endTime" type="text" maxlength="20"/>
					<span style="color: #f00;">*</span>
					</span>
		</div>
		<div style="margin-top:20px;">
			<div style="width:100px;height:100px;font-size: 14px;color: #373737;font-weight: 700;">兑换奖品规则：</div>
			<div style="margin-left:102px;margin-top: -100px;">
				<textarea id="jpmdhReg_ta" name="jpmdhReg" rows="6" cols="50" onfocus="focusJpmdhReg()" onblur="checkJpmdhReg()">${requestScope.jfdhjpActivity.jpmdhReg }</textarea>
				<span style="color: #f00;">*</span>
			</div>
		</div>
		<div style="margin-top:20px;">
			<a id="save_but">保存设置</a>
		</div>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>