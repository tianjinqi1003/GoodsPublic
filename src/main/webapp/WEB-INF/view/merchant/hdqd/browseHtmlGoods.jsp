<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>预览</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/hdqd/browseHtmlGoods.css" />
<script type="text/javascript">
function editContent(goodsNumber,accountNumber){
	location.href="${pageContext.request.contextPath}/merchant/main/goEditModule?trade=hdqd&goodsNumber="+goodsNumber+"&accountNumber="+accountNumber;
}
</script>
</head>
<body>
<div class="main_div" id="main_div">
	<div class="top_div">
		<img class="createSuccess_img" alt="" src="/GoodsPublic/resource/images/006.png">
		<span class="createSuccess_span">生码成功！</span>
		<a class="createQrcode_a" href="${pageContext.request.contextPath}/merchant/main/goAddModule?trade=hdqd">新建二维码</a>
		<a class="return_a" href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=hdqd">返回列表页</a>
	</div>
	<div class="left_div" id="left_div">
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
					<td class="value1_td">
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
					<td class="value1_td">
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
					<td class="value1_td">
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
					<td class="value1_td">
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
					<td class="value1_td">
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
					<td class="value1_td">
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
					<td class="value1_td">
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
					<td class="value1_td">
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
					<td class="value1_td">
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
					<td class="value1_td">
						${requestScope.htmlGoodsHDQD.hdapValue10_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue10_2 }
					</td>
				</tr>
				</c:if>
			</table>
		</div>
	</div>
	<div class="right_div">
		<div class="qrcode_div">
			<div class="downloadQrcode1_div">
				<img class="qrcode_img" alt="" src="${requestScope.htmlGoodsHDQD.qrCode }" />
				<div class="downloadQrcode2_div">下载二维码</div>
			</div>
		</div>
		<div class="line1_div"></div>
		<div class="option2_div">
			<div class="editContent_div" onclick="editContent(${requestScope.htmlGoodsHDQD.goodsNumber },${requestScope.htmlGoodsHDQD.accountNumber });">编辑内容</div>
			<div class="option3_div">
				<a class="createCopy_a">创建副本</a>
				<a class="delete_a">删除</a>
			</div>
		</div>
		<div class="line2_div"></div>
	</div>
</div>
</body>
</html>