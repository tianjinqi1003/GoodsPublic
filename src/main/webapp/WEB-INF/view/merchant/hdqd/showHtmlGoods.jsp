<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>活动签到</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/hdqd/showHtmlGoods.css" />
<script type="text/javascript">
$(function(){
	
});
</script>
</head>
<body>
<div class="main_div" id="main_div">
	<div class="title_div">
		${requestScope.htmlGoodsHDQD.title }
	</div>
	<div class="image1_div" id="image1_div">
		<c:if test="${requestScope.htmlGoodsHDQD.image1_1 ne null }">
			<img class="image1_1_img" alt="" src="${requestScope.htmlGoodsHDQD.image1_1 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsHDQD.image1_2 ne null }">
			<img class="image1_2_img" alt="" src="${requestScope.htmlGoodsHDQD.image1_2 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsHDQD.image1_3 ne null }">
			<img class="image1_3_img" alt="" src="${requestScope.htmlGoodsHDQD.image1_3 }">
		</c:if>
	</div>
	
	<div class="memo1_div">
		${requestScope.htmlGoodsHDQD.memo1 }
	</div>
	
	<div class="hdap_div">
		<table class="hdap_tab" id="hdap_tab">
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow1 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName1 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue1_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue1_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow2 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName2 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue2_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue2_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow3 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName3 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue3_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue3_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow4 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName4 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue4_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue4_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow5 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName5 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue5_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue5_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow6 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName6 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue6_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue6_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow7 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName7 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue7_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue7_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow8 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName8 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue8_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue8_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow9 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName9 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue9_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue9_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow10 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName10 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue10_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue10_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow11 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName11 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue11_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue11_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow12 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName12 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue12_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue12_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow13 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName13 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue13_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue13_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow14 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName14 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue14_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue14_2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.hdapIfShow15 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsHDQD.hdapName15 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsHDQD.hdapValue15_1 }
				</td>
				<td class="value2_td">
					${requestScope.htmlGoodsHDQD.hdapValue15_2 }
				</td>
			</tr>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>