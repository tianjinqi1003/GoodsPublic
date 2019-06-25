<%@page import="com.goodsPublic.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" 
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String memo1=(String)request.getAttribute("memo1");
	String memo2=(String)request.getAttribute("memo2");
	String memo3=(String)request.getAttribute("memo3");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">
KindEditor.ready(function(K) {
	var editor1 = K.create('textarea[name="memo1"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	var editor2 = K.create('textarea[name="memo2"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	var editor3 = K.create('textarea[name="memo3"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	prettyPrint();
});

$(function(){
	
});

function showOptionDiv(o){
	$(o).parent().find("#but_div").css("display","block");
}

function hideOptionDiv(o){
	$(o).parent().find("#but_div").css("display","none");
}

function addHtmlGoodsSPZS(){
	document.getElementById("sub_but").click();
}

function openTabModBgDiv(){
	$("#tabModBg_div").css("display","block");
	var table=$("#tabModBg_div table");
	table.empty();
	table.append("<tr style=\"height: 50px;background-color: #eee;\">"
			+"<td colspan=\"2\" style=\"text-align: center;\">商品详情</td>"
			+"<td style=\"text-align: center;\">操作</td>"
		+"</tr>");
	$("#spxq_tab tr[id^='tr']").each(function(i){
		var name=$(this).find("td").eq(0).text();
		var value=$(this).find("td").eq(1).text();
		
		table.append("<tr style=\"height: 40px;background-color: #fff;\">"
				+"<td style=\"width: 20%;border: #eee solid 1px;padding-left: 20px;\" onclick=\"editTdBefore(this);\">"+name+"</td>"
				+"<td style=\"width: 60%;border: #eee solid 1px;padding-left: 20px;\">"+value+"</td>"
				+"<td style=\"width: 20%;border: #eee solid 1px;padding-left: 20px;\">"
				+"<img alt=\"\" src=\"/GoodsPublic/resource/images/002.png\" onclick=\"addSPXQTabTr("+(i+1)+")\"/>"
				+"<img alt=\"\" src=\"/GoodsPublic/resource/images/003.png\" onclick=\"removeSPXQTabTr("+(i+1)+")\"/>"
				+"</td>"
			+"</tr>");
	});
}

function editTdBefore(td){
	var text=$(td).text();
	$(td).html("<input type=\"text\" value=\""+text+"\" onblur=\"editTdAfter(this);\"/>");
	$(td).find("input")[0].focus();
}

function editTdAfter(input){
	var value=$(input).val();
	$(input).parent().text(value);
}

function closeTabModBgDiv(){
	$("#tabModBg_div").css("display","none");
}

function addSPXQTabTr(index){
	$("#tabModBg_div table tr").eq(index).after("<tr style=\"height: 40px;background-color: #fff;\">"
			+"<td style=\"width: 20%;border: #eee solid 1px;padding-left: 20px;\"></td>"
			+"<td style=\"width: 60%;border: #eee solid 1px;padding-left: 20px;\"></td>"
			+"<td style=\"width: 20%;border: #eee solid 1px;padding-left: 20px;\">"
			+"<img alt=\"\" src=\"/GoodsPublic/resource/images/002.png\" onclick=\"addSPXQTabTr("+(index+1)+")\"/>"
			+"<img alt=\"\" src=\"/GoodsPublic/resource/images/003.png\" onclick=\"removeSPXQTabTr("+(index+1)+")\"/>"
			+"</td>"
		+"</tr>");
}

function removeSPXQTabTr(index){
	$("#tabModBg_div table tr").eq(index).remove();
}

function deleteSPXQDiv(){
	$("#spxq_div").remove();
}

function removeInSPXQTab(){
	
}
</script>
</head>
<body style="background-color: #eee;">
<form id="form1" name="form1" method="post" action="addHtmlGoodsSPZS" enctype="multipart/form-data">

<div id="tabModBg_div" style="width:100%;height:100%;position: fixed;background:rgba(0,0,0,0.5);display:none;z-index: 1;">
	<div id="tabMod_div" style="width: 600px;margin: 0 auto;margin-top: 100px;background-color: #fff;">
		<div style="width: 100%;height: 50px;line-height: 50px;border-bottom: #999 solid 1px;">
			<span style="margin-left: 20px;">表格模块</span>
			<span style="float: right;margin-right: 20px;cursor: pointer;" onclick="closeTabModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table style="width: 550px;margin:0 auto;margin-top: 20px;border: #eee solid 1px;">
				<!-- 
				<tr style="height: 50px;background-color: #eee;">
					<td colspan="2" style="text-align: center;">商品详情</td>
					<td style="text-align: center;">操作</td>
				</tr>
				<tr style="height: 40px;background-color: #fff;">
					<td style="width: 20%;border: #eee solid 1px;padding-left: 20px;">aaa</td>
					<td style="width: 60%;border: #eee solid 1px;padding-left: 20px;">bbb</td>
					<td style="width: 20%;border: #eee solid 1px;padding-left: 20px;">
						<img alt="" src="/GoodsPublic/resource/images/002.png"/>
						<img alt="" src="/GoodsPublic/resource/images/003.png"/>
					</td>
				</tr>
				<tr style="height: 40px;background-color: #fff;">
					<td style="width: 20%;border: #eee solid 1px;padding-left: 20px;">aaa</td>
					<td style="width: 60%;border: #eee solid 1px;padding-left: 20px;">bbb</td>
					<td style="width: 20%;border: #eee solid 1px;padding-left: 20px;">
						<img alt="" src="/GoodsPublic/resource/images/002.png"/>
						<img alt="" src="/GoodsPublic/resource/images/003.png"/>
					</td>
				</tr>
				 -->
			</table>
		</div>
		<div id="but_div" style="width: 100%;height: 50px;line-height: 50px;margin-top: 20px;border-top: #999 solid 1px;">
			<div style="width:80px;height:35px;line-height:35px;text-align:center;color:#fff;float:right;margin-top: 7px;margin-right:13px;background-color: #4caf50;border-radius:5px;" onclick="removeInSPXQTab();">确&nbsp;认</div>
			<div style="width:80px;height:33px;line-height:33px;text-align:center;color:#999;float:right;margin-top: 7px;margin-right:13px;border: #999 solid 1px;border-radius:5px;" onclick="closeTabModBgDiv();">取&nbsp;消</div>
		</div>
	</div>
</div>

<div id="main_div" style="width: 650px;margin: 0 auto;background-color: #fff;">
	<div>
		<input type="text" id="productName" name="productName" placeholder="请输入标题" style="width: 100%;height: 40px;line-height: 40px;text-align: center;font-size: 20px;font-weight: bold;"/>
	</div>
	<div id="image1_div" style="width: 650px;height: 650px;line-height:600px;text-align: center;">
		<img alt="" src="${requestScope.image1 }" style="width: 600px;height: 600px;margin-top: 25px;">
	</div>
	<div>
		<textarea id="memo1" name="memo1" cols="100" rows="8" style="width:650px;height:150px;visibility:hidden;"><%=htmlspecialchars(memo1) %></textarea>
	</div>
	<div id="spxq_div" style="margin-top: 20px;">
		<div id="option_div" style="width:650px;position:absolute;" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div id="but_div" style="width:100px;height:30px;line-height:30px;margin:0 auto;margin-top: 30px;text-align:center;z-index: 1;background-color: #fff;border-radius:5px;display:none; ">
				<a onclick="openTabModBgDiv();">编辑</a>|
				<a onclick="deleteSPXQDiv();">删除</a>
			</div>
		</div>
		<table id="spxq_tab" style="width: 600px;margin: 0 auto;border: #eee solid 1px;" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<tr style="height:60px;">
				<td colspan="2" style="text-align: center;background-color: #eee;">商品详情</td>
			</tr>
			<c:forEach items="${requestScope.spxqList }" var="spxq" varStatus="status">
			<tr id="tr${status.index+1 }" height="50">
				<input type="hidden" name="spxqName${status.index+1 }" value="${spxq.name }" />
				<input type="hidden" name="spxqValue${status.index+1 }" value="${spxq.value }" />
				<td style="width:30%;border: #eee solid 1px;padding-left: 20px;">${spxq.name }</td>
				<td style="width:70%;border: #eee solid 1px;">${spxq.value }</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div style="margin-top: 20px;">
		<textarea id="memo2" name="memo2" cols="100" rows="8" style="width:650px;height:220px;visibility:hidden;"><%=htmlspecialchars(memo2) %></textarea>
	</div>
	<div id="image2_div" style="width: 650px;height: 650px;line-height:600px;text-align: center;">
		<img alt="" src="${requestScope.image2 }" style="width: 600px;height: 600px;margin-top: 25px;">
	</div>
	<div id="image3_div" style="width: 650px;height: 650px;line-height:600px;text-align: center;">
		<img alt="" src="${requestScope.image3 }" style="width: 600px;height: 600px;margin-top: 25px;">
	</div>
	<div style="margin-top: 20px;">
		<textarea id="memo3" name="memo3" cols="100" rows="8" style="width:650px;height:550px;visibility:hidden;"><%=htmlspecialchars(memo3) %></textarea>
	</div>
</div>
	<input type="hidden" id="accountNumber_hid" name="accountNumber" value="${sessionScope.user.id }" />
	<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
<div>
	<input type="button" value="生成二维码" onclick="addHtmlGoodsSPZS();"/>
</div>
</form>
</body>
</html>

<%!
private String htmlspecialchars(String str) {
	//System.out.println(str);
	if(!StringUtils.isEmpty(str)){
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
	}
	return str;
}
%>