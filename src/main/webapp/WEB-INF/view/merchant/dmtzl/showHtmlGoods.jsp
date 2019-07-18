<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>多媒体资料</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/dmtzl/showHtmlGoods.css" />
</head>
<body>
<div class="main_div" id="main_div">
	<div class="title_div">
		${requestScope.htmlGoodsDMTZL.title }
	</div>
	<div class="memo1_div">
		${requestScope.htmlGoodsDMTZL.memo1 }
	</div>
	<div class="embed1_div" id="embed1_div">
		<c:if test="${requestScope.htmlGoodsDMTZL.embed1_1 ne null }">
			<embed class="embed1_1_embed" alt="" src="${requestScope.htmlGoodsDMTZL.embed1_1 }">
		</c:if>
	</div>
	<div class="memo2_div">
		${requestScope.htmlGoodsDMTZL.memo2 }
	</div>
	<div class="image1_div" id="image1_div">
		<c:if test="${requestScope.htmlGoodsDMTZL.image1_1 ne null }">
			<img class="image1_1_img" alt="" src="${requestScope.htmlGoodsDMTZL.image1_1 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsDMTZL.image1_2 ne null }">
			<img class="image1_2_img" alt="" src="${requestScope.htmlGoodsDMTZL.image1_2 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsDMTZL.image1_3 ne null }">
			<img class="image1_3_img" alt="" src="${requestScope.htmlGoodsDMTZL.image1_3 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsDMTZL.image1_4 ne null }">
			<img class="image1_4_img" alt="" src="${requestScope.htmlGoodsDMTZL.image1_4 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsDMTZL.image1_5 ne null }">
			<img class="image1_5_img" alt="" src="${requestScope.htmlGoodsDMTZL.image1_5 }">
		</c:if>
	</div>
</div>
</body>
</html>