<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>建筑施工</title>
<%@include file="../js.jsp"%>
</head>
<body style="width: 100%;">
<div id="main_div" style="width: 100%;margin: 0 auto;background-color: #fff;">
	<div style="width: 95%;height: 40px;line-height: 40px;text-align: center;font-size: 20px;font-weight: bold;">
		${requestScope.htmlGoodsJZSG.title }
	</div>
	<div id="image1_div" style="width: 95%;text-align: center;">
		<c:if test="${requestScope.htmlGoodsJZSG.image1_1 ne null }">
			<img alt="" src="${requestScope.htmlGoodsJZSG.image1_1 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJZSG.image1_2 ne null }">
			<img alt="" src="${requestScope.htmlGoodsJZSG.image1_2 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJZSG.image1_3 ne null }">
			<img alt="" src="${requestScope.htmlGoodsJZSG.image1_3 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
	</div>
	
	<div style="margin-top: 20px;">
		<table id="spxq_tab" style="width: 95%;margin: 0 auto;border: #eee solid 1px;">
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow1 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxName1 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxValue1 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow2 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxName2 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxValue2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow3 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxName3 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxValue3 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow4 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxName4 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxValue4 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow5 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxName5 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxValue5 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow6 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxName6 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxValue6 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow7 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxName7 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxValue7 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow8 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxName8 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxValue8 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow9 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxName9 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxValue9 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow10 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxName10 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsJZSG.ryxxValue10 }
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	<div id="image2_div" style="width: 95%;text-align: center;margin-top: 20px;">
		<c:if test="${requestScope.htmlGoodsJZSG.image2_1 ne null }">
			<img alt="" src="${requestScope.htmlGoodsJZSG.image2_1 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJZSG.image2_2 ne null }">
			<img alt="" src="${requestScope.htmlGoodsJZSG.image2_2 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJZSG.image2_3 ne null }">
			<img alt="" src="${requestScope.htmlGoodsJZSG.image2_3 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
	</div>
</div>
</body>
</html>