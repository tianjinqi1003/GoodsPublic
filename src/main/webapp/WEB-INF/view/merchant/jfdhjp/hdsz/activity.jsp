<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>活动设置</title>
<%@include file="../../js.jsp"%>
<script type="text/javascript">
$(function(){
	$("#zhxx_div").css("width",setFitWidthInParent("body")+"px");
	$("#gsxx_div").css("width",setFitWidthInParent("body")+"px");
	
	$("#save_but").linkbutton({
		iconCls:"icon-save"
	});
	
	endTimeDTB=$("#endTime_dtb").datetimebox({
		width:157,
		editable:false
	});
});	

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-310;
}
</script>
</head>
<body>
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
	<div id="gsxx_div" style="height:350px;margin-top:20px;margin-left: 238px;padding-top:40px;padding-left:40px;background-color:#FAFDFE;">
		<div style="font-size: 20px;color: #373737;font-weight:700;">活动设置</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">活动开关&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;：</span>
			<span>
				开&nbsp;<input type="radio" id="open_rad" name="enable" checked="checked"/>&nbsp;&nbsp;&nbsp;
				关&nbsp;<input type="radio" id="close_rad" name="enable" onclick="showTextLocArea()"/>
			</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">兑换奖品积分：</span>
			<input id="dhjpScore_inp" name="dhjpScore" type="text" value="" maxlength="20" onfocus="focusDhjpScore()" onblur="checkDhjpScore()"/>
			<span style="color: #f00;">*</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">兑奖截止日期：</span>
			<span><input id="endTime_dtb" name="endTime" type="text" value="" maxlength="20"/>
					<span style="color: #f00;">*</span>
					</span>
		</div>
		<div style="margin-top:20px;">
			<div style="width:100px;height:100px;font-size: 14px;color: #373737;font-weight: 700;">兑换奖品规则：</div>
			<div style="margin-left:102px;margin-top: -100px;">
				<textarea id="jpmdhReg_ta" name="jpmdhReg" rows="6" cols="50" onfocus="focusJpmdhReg()" onblur="checkJpmdhReg()">${requestScope.accountMsg.jpmdhReg }</textarea>
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