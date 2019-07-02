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
</head>
<body style="width: 100%;">
<div id="main_div" style="width: 100%;margin: 0 auto;background-color: #fff;">
	<div style="width: 95%;height: 40px;line-height: 40px;text-align: center;font-size: 20px;font-weight: bold;">
		${requestScope.htmlGoodsDMTZL.title }
	</div>
	<div style="width:95%;margin-top: 20px;">
		${requestScope.htmlGoodsDMTZL.memo1 }
	</div>
	<div id="embed1_div" style="width: 95%;text-align: center;">
		<c:if test="${requestScope.htmlGoodsDMTZL.embed1_1 ne null }">
			<img alt="" src="${requestScope.htmlGoodsDMTZL.embed1_1 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
	</div>
	<div style="width:95%;margin-top: 20px;">
		${requestScope.htmlGoodsDMTZL.memo2 }
	</div>
	<div id="image1_div" style="width: 95%;text-align: center;">
		<c:if test="${requestScope.htmlGoodsDMTZL.image1_1 ne null }">
			<img alt="" src="${requestScope.htmlGoodsDMTZL.image1_1 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsDMTZL.image1_2 ne null }">
			<img alt="" src="${requestScope.htmlGoodsDMTZL.image1_2 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsDMTZL.image1_3 ne null }">
			<img alt="" src="${requestScope.htmlGoodsDMTZL.image1_3 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsDMTZL.image1_4 ne null }">
			<img alt="" src="${requestScope.htmlGoodsDMTZL.image1_4 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsDMTZL.image1_5 ne null }">
			<img alt="" src="${requestScope.htmlGoodsDMTZL.image1_5 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
	</div>
</div>
</body>
</html>