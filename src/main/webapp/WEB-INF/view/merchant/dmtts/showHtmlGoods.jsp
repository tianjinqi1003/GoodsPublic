<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>多媒体图书</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/dmtts/showHtmlGoods.css" />
</head>
<body>
<div class="main_div" id="main_div">
	<div class="title1_div">
		${requestScope.htmlGoodsDMTTS.title1 }
	</div>
	<div class="embed1_div" id="embed1_div">
		<c:if test="${requestScope.htmlGoodsDMTTS.embed1_1 ne null }">
			<embed class="embed1_1_embed" alt="" src="${requestScope.htmlGoodsDMTTS.embed1_1 }">
		</c:if>
	</div>
	<div class="memo1_div">
		${requestScope.htmlGoodsDMTTS.memo1 }
	</div>
	<div class="title2_div">
		${requestScope.htmlGoodsDMTTS.title2 }
	</div>
	<div class="embed2_div" id="embed2_div">
		<c:if test="${requestScope.htmlGoodsDMTTS.embed2_1 ne null }">
			<embed class="embed2_1_embed" alt="" src="${requestScope.htmlGoodsDMTTS.embed2_1 }">
		</c:if>
	</div>
</div>
</body>
</html>