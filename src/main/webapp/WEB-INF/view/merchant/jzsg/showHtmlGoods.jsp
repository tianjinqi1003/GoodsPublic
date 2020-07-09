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
<link rel="stylesheet" href="<%=basePath %>/resource/css/jzsg/showHtmlGoods.css" />
<script type="text/javascript">
$(function(){
	
});
</script>
</head>
<body>
<div class="main_div" id="main_div">
	<div class="title_div">
		${requestScope.htmlGoodsJZSG.title }
	</div>
	<div class="image1_div" id="image1_div">
		<c:if test="${requestScope.htmlGoodsJZSG.image1_1 ne null }">
			<img class="image1_1_img" alt="" src="${requestScope.htmlGoodsJZSG.image1_1 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJZSG.image1_2 ne null }">
			<img class="image1_2_img" alt="" src="${requestScope.htmlGoodsJZSG.image1_2 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJZSG.image1_3 ne null }">
			<img class="image1_3_img" alt="" src="${requestScope.htmlGoodsJZSG.image1_3 }">
		</c:if>
	</div>
	
	<div class="spxq_div">
		<table class="spxq_tab" id="spxq_tab">
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow1 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName1 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue1 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow2 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName2 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow3 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName3 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue3 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow4 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName4 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue4 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow5 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName5 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue5 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow6 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName6 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue6 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow7 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName7 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue7 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow8 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName8 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue8 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow9 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName9 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue9 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow10 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName10 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue10 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow11 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName11 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue11 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow12 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName12 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue12 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow13 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName13 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue13 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow14 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName14 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue14 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.ryxxIfShow15 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsJZSG.ryxxName15 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsJZSG.ryxxValue15 }
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	<div class="image2_div" id="image2_div">
		<c:if test="${requestScope.htmlGoodsJZSG.image2_1 ne null }">
			<img class="image2_1_img" alt="" src="${requestScope.htmlGoodsJZSG.image2_1 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJZSG.image2_2 ne null }">
			<img class="image2_2_img" alt="" src="${requestScope.htmlGoodsJZSG.image2_2 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJZSG.image2_3 ne null }">
			<img class="image2_3_img" alt="" src="${requestScope.htmlGoodsJZSG.image2_3 }">
		</c:if>
	</div>
</div>
</body>
</html>