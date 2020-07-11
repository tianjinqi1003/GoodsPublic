<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>商品</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/smyl/showHtmlGoods.css" />
</head>
<body>
<div class="main_div" id="main_div">
	<div class="productName_div">
		${requestScope.htmlGoodsSMYL.productName }
	</div>
	<div class="image1_div"  id="image1_div">
		<c:if test="${requestScope.htmlGoodsSMYL.image1_1 ne null }">
			<img class="image1_1_img" alt="" src="${requestScope.htmlGoodsSMYL.image1_1 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSMYL.image1_2 ne null }">
			<img class="image1_2_img" alt="" src="${requestScope.htmlGoodsSMYL.image1_2 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSMYL.image1_3 ne null }">
			<img class="image1_3_img" alt="" src="${requestScope.htmlGoodsSMYL.image1_3 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSMYL.image1_4 ne null }">
			<img class="image1_4_img" alt="" src="${requestScope.htmlGoodsSMYL.image1_4 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSMYL.image1_5 ne null }">
			<img class="image1_5_img" alt="" src="${requestScope.htmlGoodsSMYL.image1_5 }">
		</c:if>
	</div>
	<div class="spxq_div">
		<table class="spxq_tab" id="spxq_tab">
			<tr height="60">
				<td class="head_td" colspan="2">商品详情</td>
			</tr>
			
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow1 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName1 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue1 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow2 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName2 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow3 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName3 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue3 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow4 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName4 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue4 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow5 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName5 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue5 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow6 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName6 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue6 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow7 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName7 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue7 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow8 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName8 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue8 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow9 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName9 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue9 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow10 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName10 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue10 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow11 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName11 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue11 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow12 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName12 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue12 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow13 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName13 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue13 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow14 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName14 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue14 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.spxqIfShow15 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.spxqName15 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.spxqValue15 }
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	<div class="memo1_div">
		${requestScope.htmlGoodsSMYL.memo1 }
	</div>
	<div class="yhxx_div">
		<table class="yhxx_tab" id="yhxx_tab">
			<tr height="60">
				<td class="head_td" colspan="2">养护信息</td>
			</tr>
			
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow1 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName1 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue1 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow2 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName2 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow3 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName3 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue3 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow4 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName4 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue4 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow5 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName5 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue5 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow6 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName6 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue6 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow7 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName7 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue7 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow8 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName8 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue8 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow9 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName9 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue9 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow10 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName10 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue10 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow11 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName11 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue11 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow12 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName12 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue12 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow13 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName13 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue13 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow14 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName14 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue14 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.yhxxIfShow15 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSMYL.yhxxName15 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSMYL.yhxxValue15 }
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	<div class="memo2_div">
		${requestScope.htmlGoodsSMYL.memo2 }
	</div>
</div>
</body>
</html>