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

function addHtmlGoodsSPZS(){
	document.getElementById("sub_but").click();
}
</script>
</head>
<body>
<div>编辑</div>
<form id="form1" name="form1" method="post" action="addHtmlGoodsSPZS" enctype="multipart/form-data">
<div id="main_div">
	<div>
		<textarea id="memo1" name="memo1" cols="100" rows="8" style="width:700px;height:150px;visibility:hidden;"><%=htmlspecialchars(memo1) %></textarea>
	</div>
	<div id="image1_div">
		<img alt="" src="${requestScope.image1 }" style="width: 200px;height: 200px;">
	</div>
	<div>
		<table id="spxq_tab" style="width: 500px;">
			<tr height="60">
				<td colspan="2" style="text-align: center;background-color: #999;">商品详情</td>
			</tr>
		<c:forEach items="${requestScope.spxqList }" var="spxq" varStatus="status">
			<tr height="50">
				<input type="hidden" name="spxqName${status.index+1 }" value="${spxq.name }" />
				<input type="hidden" name="spxqValue${status.index+1 }" value="${spxq.value }" />
				<td>
					${spxq.name }
				</td>
				<td>
					${spxq.value }
				</td>
			</tr>
		</c:forEach>
		</table>
	</div>
	<div>
		<textarea id="memo2" name="memo2" cols="100" rows="8" style="width:700px;height:150px;visibility:hidden;"><%=htmlspecialchars(memo2) %></textarea>
	</div>
	<div>
		<textarea id="memo3" name="memo3" cols="100" rows="8" style="width:700px;height:150px;visibility:hidden;"><%=htmlspecialchars(memo3) %></textarea>
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