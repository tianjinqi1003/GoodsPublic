<%@ page import="com.goodsPublic.util.StringUtils"%>
<%@ page import="goodsPublic.entity.HtmlGoodsDMTTS"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	HtmlGoodsDMTTS htmlGoodsDMTTS=(HtmlGoodsDMTTS)request.getAttribute("htmlGoodsDMTTS");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/dmtts/editModule.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">

</script>
</head>
<body>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">多媒体图书</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>

<div class="middle_div" id="middle_div" style="">
	<div>
		<input class="title1_input" type="text" id="title1" name="title1" placeholder="请输入标题" value="${requestScope.htmlGoodsDMTTS.title1 }"/>
	</div>
	<div class="memo1_div">
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsDMTTS.getMemo1()) %></textarea>
	</div>
	<div class="embed1_div" id="embed1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openEmbed1ModBgDiv();">编辑</a>|
				<a onclick="deleteEmbed1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsDMTTS.embed1_1 ne null }">
			<embed class="item_embed" id="embed1_1" alt="" src="${requestScope.htmlGoodsDMTTS.embed1_1 }"/>
			</c:if>
		</div>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsDMTTS.qrCode }">
	<div class="preview_div" onclick="previewHtmlGoodsDMTTS();">预览</div>
	<div class="save_div" onclick="saveEdithtmlGoodsDMTTS();">保存</div>
	<div class="finishEdit_div" onclick="finishEdithtmlGoodsDMTTS();">完成编辑</div>
	<div class="saveStatus_div" id="saveStatus_div"></div>
</div>
	<input type="hidden" id="id" name="id" value="${requestScope.htmlGoodsDMTTS.id }" />
	<input type="hidden" id="goodsNumber" name="goodsNumber" value="${requestScope.htmlGoodsDMTTS.goodsNumber }" />
	<input type="hidden" id="accountNumber_hid" name="accountNumber" value="${sessionScope.user.id }" />
	<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
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