<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String memo1=(String)request.getAttribute("memo1");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/hdqd/addModule.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">
function goBack(){
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=hdqd";
}
</script>
</head>
<body>
<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">活动签到-案例</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div style="background-color: #FBE0B5;text-align: center;height: 60px;line-height: 60px;">
		<input class="title_input" type="text" id="title" name="title" placeholder="请输入标题"/>
	</div>
	<div class="image1_div" id="image1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.image1List }" var="image1" varStatus="status">
			<img class="item_img" id="img1_1" alt="" src="${image1.value }">
			</c:forEach>
		</div>
	</div>
	<div class="hdap_div" id="hdap_div">
		<table class="hdap_tab" id="hdap_tab">
			<tr class="head_tr">
				<td class="hdap_td" colspan="4">活动安排</td>
			</tr>
			<c:forEach items="${requestScope.hdapList }" var="hdap" varStatus="status">
			<tr class="item_tr" id="tr${status.index+1 }" height="50">
				<input type="hidden" name="hdapName${status.index+1 }" value="${hdap.name }" />
				<td class="name_td">
					<input type="text" name="hdapName${status.index+1 }" value="${hdap.name }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue${status.index+1 }_1" value="${hdap.value }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue${status.index+1 }_2" value="${hdap.value2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow${status.index+1 }" name="hdapIfShow${status.index+1 }" value="true" />
					<input type="button" class="hdapIfShow_inp" value="显示" onclick="changeHDAPTrIfShow(${status.index+1 },this)"/>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>
</body>
</html>