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
	
	$("#edit_div table").css("width","100%");
	$("#edit_div table").css("magin","-100px");
	$("#edit_div table td").css("padding-left","50px");
	$("#edit_div table td").css("font-size","15px");
	$("#edit_div table tr").css("height","45px");
	
	$("#edit_div table tr").mousemove(function(){
		$(this).css("background-color","#ddd");
	}).mouseout(function(){
		$(this).css("background-color","#fff");
	});
	
	$(".panel.window").css("background","linear-gradient(to bottom,#F4F4F4 0,#F4F4F4 20%)"); 
	$(".window,.window .window-body").css("border-color","#ddd");
	$(".panel.window .panel-title").css("color","#000");
	$(".panel.window .panel-title").css("font-size","15px");
	$(".panel.window .panel-title").css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	$("#ok_but").css("left","45%");
	$("#ok_but").css("position","absolute");
	$(".dialog-button .l-btn-text").css("font-size","15px");
});

function checkEdit(){
	if(checkNickName()){
		document.getElementById("sub_but").click();
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
	return width.substring(0,width.length-2)-200;
}
	
function setFitHeightInParent(o){
	var height=$(o).css("height");
	return height.substring(0,height.length-2)-44;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="side.jsp"%>
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
					
					<input id="companyName" name="companyName" type="text" value="${requestScope.accountMsg.companyName }" onfocus="focusCompanyName()" onblur="checkCompanyName()"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					公司地址
				</td>
				<td>
					
					<input id="companyAddress" name="companyAddress" type="text" value="${requestScope.accountMsg.companyAddress }" onfocus="focusCompanyAddress()" onblur="checkCompanyAddress()"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					邮政编码
				</td>
				<td>
					
					<input id="postcode" name="postcode" type="text" value="${requestScope.accountMsg.postcode }" onfocus="focusPostcode()" onblur="checkPostcode()"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					手机号
				</td>
				<td>
					<input id="phone" name="phone" type="text" value="${requestScope.accountMsg.phone }" onfocus="focusPhone()" onblur="checkPhone()"/>
					可填多个电话，用逗号隔开
				</td>
			  </tr>
			  <tr>
				<td align="right">
					商话
				</td>
				<td>
					<input id="quotient" name="quotient" type="text" value="${requestScope.accountMsg.quotient }" onfocus="focusQuotient()" onblur="checkQuotient()"/>
					可填多个电话，用逗号隔开
				</td>
			  </tr>
			  <tr>
				<td align="right">
					公司传真
				</td>
				<td>
					<input id="fax" name="fax" type="text" value="${requestScope.accountMsg.fax }" onfocus="focusFax()" onblur="checkFax()"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					邮箱
				</td>
				<td>
					<input id="email" name="email" type="text" value="${requestScope.accountMsg.email }" onfocus="focusEmail()" onblur="checkEmail()"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					统计代码
				</td>
				<td style="padding-top: 7px;padding-bottom: 5px;">
					<textarea id="countCode" name="countCode" rows="3" cols="28" style="max-height: 45px;min-height: 45px">${requestScope.accountMsg.countCode }</textarea>
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
		  <div style="height: 1px;width: 100%;background-color: #00f;margin-top: -45px;"></div>
		  <div style="height: 1px;width: 100%;background-color: #00f;margin-top: -66px;"></div>
		  <div style="height: 1px;width: 100%;background-color: #00f;margin-top: -46px;"></div>
		  <div style="height: 1px;width: 100%;background-color: #00f;margin-top: -46px;"></div>
		  <div style="height: 1px;width: 100%;background-color: #00f;margin-top: -46px;"></div>
		  <div style="height: 1px;width: 100%;background-color: #00f;margin-top: -46px;"></div>
		  <div style="height: 1px;width: 100%;background-color: #00f;margin-top: -46px;"></div>
		  <div style="height: 1px;width: 100%;background-color: #00f;margin-top: -46px;"></div>
		  <div style="height: 1px;width: 100%;background-color: #00f;margin-top: -46px;"></div>
		  <div style="height: 1px;width: 100%;background-color: #00f;margin-top: -113px;"></div>
		  <input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
		  </form>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>