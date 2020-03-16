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
	/*
	$("#edit_div").dialog({
		title:"商家信息",
		width:setFitWidthInParent("body"),
		height:setFitHeightInParent(".layui-side"),
		top:60,
		left:200,
		buttons:[
           {text:"提交",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkEdit();
           }}
        ]
	});
	
	$("#edit_div table").css("width","800px");
	$("#edit_div table").css("magin","-100px");
	$("#edit_div table td").css("padding-left","50px");
	$("#edit_div table td").css("padding-right","20px");
	$("#edit_div table td").css("font-size","15px");
	$("#edit_div table tr").css("height","45px");
	$("#edit_div table tr").each(function(){
		$(this).find("td").eq(0).css("color","#006699");
		$(this).find("td").eq(0).css("border-right","#CAD9EA solid 1px");
		$(this).find("td").eq(0).css("font-weight","bold");
		$(this).find("td").eq(0).css("background-color","#F5FAFE");
	});
	
	$("#edit_div table tr").mousemove(function(){
		$(this).css("background-color","#ddd");
	}).mouseout(function(){
		$(this).css("background-color","#fff");
	});
	
	$(".panel.window").css("width","783px");
	$(".panel.window").css("margin-top","20px");
	$(".panel.window").css("margin-left",initWindowMarginLeft());
	$(".panel.window").css("background","linear-gradient(to bottom,#E7F4FD 0,#E7F4FD 20%)");
	$(".panel.window .panel-title").css("color","#000");
	$(".panel.window .panel-title").css("font-size","15px");
	$(".panel.window .panel-title").css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").css("width","800px");
	$(".window-shadow").css("margin-top","20px");
	$(".window-shadow").css("margin-left",initWindowMarginLeft());
	$(".window-shadow").css("background","#E7F4FD");
	
	$(".window,.window .window-body").css("border-color","#ddd");
	
	$("#ok_but").css("left","45%");
	$("#ok_but").css("position","absolute");
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","15px");
	*/
	
	$("#zhxx_div").css("width",setFitWidthInParent("body")+"px");
	$("#gsxx_div").css("width",setFitWidthInParent("body")+"px");
});

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

function checkEdit(){
	if(checkNickName()){
		//document.getElementById("sub_but").click();
		var formData=new FormData($("#form1")[0]);
		 
		$.ajax({
			type:"post",
			url:"editAccountInfo",
			dataType: "json",
			data:formData,
			cache: false,
			processData: false,
			contentType: false,
			success: function (data){
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
		});
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

function showAvatarImg(obj){
	var $file = $(obj);
    var fileObj = $file[0];
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#uploadImg");

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);
    } else {
        dataURL = $file.val();
        var imgObj = document.getElementById("preview");
        // 两个坑:
        // 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
        // 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
        imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;

    }
}
	
function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-310;
}
	
function setFitHeightInParent(o){
	var height=$(o).css("height");
	return height.substring(0,height.length-2)-98;
}

function initWindowMarginLeft(){
	var editDivWidth=$("#edit_div").css("width");
	editDivWidth=editDivWidth.substring(0,editDivWidth.length-2);
	var pwWidth=$(".panel.window").css("width");
	pwWidth=pwWidth.substring(0,pwWidth.length-2);
	return ((editDivWidth-pwWidth)/2)+"px";
}

function openEditCompanyDialog(flag){
	$("#editCompanyBg_div").css("display",flag==1?"block":"none");
}
</script>
<style type="text/css">
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
	<!-- 
	<div id="edit_div">
		  <form id="form1" name="form1" method="post" action="editAccountInfo" enctype="multipart/form-data">
		  <input type="hidden" id="id" name="id" value="${param.accountId }"/>
		  <table>
			  <tr>
				<td align="right">
					昵称
				</td>
				<td>
					<input id="nickName" name="nickName" type="text" value="${requestScope.accountMsg.nickName }" onfocus="focusNickName()" onblur="checkNickName()"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					网站Logo
				</td>
				<td style="padding-top: 7px;padding-bottom: 5px;">
					<img style="width: 100px; height: 100px;max-height: 100px;max-width: 100px;min-height: 100px;min-width: 100px;padding-bottom: 6px;" src="${requestScope.accountMsg.avatar_img }" class="uploadImg" id="uploadImg" /> 
					<input type="file" name="file" onchange="showAvatarImg(this)"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					公司名称
				</td>
				<td>
					
					<input id="companyName" name="companyName" type="text" value="${requestScope.accountMsg.companyName }"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					公司地址
				</td>
				<td>
					
					<input id="companyAddress" name="companyAddress" type="text" value="${requestScope.accountMsg.companyAddress }"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					邮政编码
				</td>
				<td>
					
					<input id="postcode" name="postcode" type="text" value="${requestScope.accountMsg.postcode }"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					手机号
				</td>
				<td>
					<input id="phone" name="phone" type="text" value="${requestScope.accountMsg.phone }"/>
					可填多个电话，用逗号隔开
				</td>
			  </tr>
			  <tr>
				<td align="right">
					商话
				</td>
				<td>
					<input id="quotient" name="quotient" type="text" value="${requestScope.accountMsg.quotient }"/>
					可填多个电话，用逗号隔开
				</td>
			  </tr>
			  <tr>
				<td align="right">
					公司传真
				</td>
				<td>
					<input id="fax" name="fax" type="text" value="${requestScope.accountMsg.fax }"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					邮箱
				</td>
				<td>
					<input id="email" name="email" type="text" value="${requestScope.accountMsg.email }"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					统计代码
				</td>
				<td style="padding-top: 7px;padding-bottom: 5px;">
					<textarea id="countCode" name="countCode" rows="3" cols="28" style="width: 212px;height: 51px;min-height: 51px;max-height: 51px;">${requestScope.accountMsg.countCode }</textarea>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					备案号
				</td>
				<td>
					<input id="recordNumber" name="recordNumber" type="text" value="${requestScope.accountMsg.recordNumber }"/>
				</td>
			  </tr>
		  </table>
		  </form>
	</div>
	 -->
	<div id="zhxx_div" style="height:230px;margin-top:20px;margin-left: 238px;padding-top:40px;padding-left:40px;background-color:#FAFDFE;">
		<div style="font-size: 20px;color: #373737;font-weight:700;">账户信息</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</span>
			<span>${requestScope.accountMsg.nickName }</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">用户账号：</span>
			<span>${requestScope.accountMsg.userName }</span>
		</div>
		<div style="margin-top:20px;">
			<span style="font-size: 14px;color: #373737;font-weight: 700;">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</span>
			<span>${requestScope.accountMsg.passWord }</span>
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