<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>商品</title>
<%@include file="../../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/spzs/whiteWine/showHtmlGoods.css" />
<script type="text/javascript">
$(function(){
	
});
</script>
</head>
<body>
<div class="main_div" id="main_div">
	<div class="productName_div">
		${requestScope.htmlGoodsSPZS.productName }
	</div>
	<div class="image1_div"  id="image1_div">
		<c:if test="${requestScope.htmlGoodsSPZS.image1_1 ne null }">
			<img class="image1_1_img" alt="" src="${requestScope.htmlGoodsSPZS.image1_1 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image1_2 ne null }">
			<img class="image1_2_img" alt="" src="${requestScope.htmlGoodsSPZS.image1_2 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image1_3 ne null }">
			<img class="image1_3_img" alt="" src="${requestScope.htmlGoodsSPZS.image1_3 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image1_4 ne null }">
			<img class="image1_4_img" alt="" src="${requestScope.htmlGoodsSPZS.image1_4 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image1_5 ne null }">
			<img class="image1_5_img" alt="" src="${requestScope.htmlGoodsSPZS.image1_5 }">
		</c:if>
	</div>
	<div class="memo1_div">
		${requestScope.htmlGoodsSPZS.memo1 }
	</div>
	
	<div class="spxq_div">
		<table class="spxq_tab" id="spxq_tab">
			<tr height="60">
				<td class="head_td" colspan="2">商品详情</td>
			</tr>
			
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow1 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSPZS.spxqName1 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSPZS.spxqValue1 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow2 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSPZS.spxqName2 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSPZS.spxqValue2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow3 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSPZS.spxqName3 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSPZS.spxqValue3 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow4 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSPZS.spxqName4 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSPZS.spxqValue4 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow5 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSPZS.spxqName5 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSPZS.spxqValue5 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow6 }">
			<tr height="50">
				<td class="name_td">
					${requestScope.htmlGoodsSPZS.spxqName6 }
				</td>
				<td class="value_td">
					${requestScope.htmlGoodsSPZS.spxqValue6 }
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	<div class="memo2_div">
		${requestScope.htmlGoodsSPZS.memo2 }
	</div>
	<div class="image2_div" id="image2_div">
		<c:if test="${requestScope.htmlGoodsSPZS.image2_1 ne null }">
			<img class="image2_1_img" alt="" src="${requestScope.htmlGoodsSPZS.image2_1 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image2_2 ne null }">
			<img class="image2_2_img" alt="" src="${requestScope.htmlGoodsSPZS.image2_2 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image2_3 ne null }">
			<img class="image2_3_img" alt="" src="${requestScope.htmlGoodsSPZS.image2_3 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image2_4 ne null }">
			<img class="image2_4_img" alt="" src="${requestScope.htmlGoodsSPZS.image2_4 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image2_5 ne null }">
			<img class="image2_5_img" alt="" src="${requestScope.htmlGoodsSPZS.image2_5 }">
		</c:if>
	</div>
	<div class="image3_div" id="image3_div">
		<c:if test="${requestScope.htmlGoodsSPZS.image3_1 ne null }">
			<img class="image3_1_img" alt="" src="${requestScope.htmlGoodsSPZS.image3_1 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image3_2 ne null }">
			<img class="image3_2_img" alt="" src="${requestScope.htmlGoodsSPZS.image3_2 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image3_3 ne null }">
			<img class="image3_3_img" alt="" src="${requestScope.htmlGoodsSPZS.image3_3 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image3_4 ne null }">
			<img class="image3_4_img" alt="" src="${requestScope.htmlGoodsSPZS.image3_4 }">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image3_5 ne null }">
			<img class="image3_5_img" alt="" src="${requestScope.htmlGoodsSPZS.image3_5 }">
		</c:if>
	</div>
	<div class="memo3_div">
		${requestScope.htmlGoodsSPZS.memo3 }
	</div>
</div>
</body>
</html>