<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>预览</title>
<%@include file="../../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/spzs/homeTextiles/browseHtmlGoods.css" />
<script type="text/javascript">
function editContent(moduleType,goodsNumber,accountNumber){
	location.href="${pageContext.request.contextPath}/merchant/main/goEditModule?trade=spzs&moduleType="+moduleType+"&goodsNumber="+goodsNumber+"&accountNumber="+accountNumber;
}
</script>
</head>
<body>
<div class="main_div" id="main_div">
	<div class="top_div">
		<img class="createSuccess_img" alt="" src="/GoodsPublic/resource/images/006.png">
		<span class="createSuccess_span">生码成功！</span>
		<a class="createQrcode_a" href="${pageContext.request.contextPath}/merchant/main/goAddModule?trade=spzs">新建二维码</a>
		<a class="return_a" href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=spzs">返回列表页</a>
	</div>
	<div class="left_div" id="left_div">
		<div class="productName_div">
			${requestScope.htmlGoodsSPZS.productName }
		</div>
		<div class="image1_div" id="image1_div">
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
		<div class="spxq_div">
			<table class="spxq_tab" id="spxq_tab">
				<tr height="60">
					<td class="head_td" colspan="2">产品参数</td>
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
				<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow7 }">
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSPZS.spxqName7 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSPZS.spxqValue7 }
					</td>
				</tr>
				</c:if>
			</table>
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
		<div class="image4_div" id="image4_div">
			<c:if test="${requestScope.htmlGoodsSPZS.image4_1 ne null }">
				<img class="image4_1_img" alt="" src="${requestScope.htmlGoodsSPZS.image4_1 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image4_2 ne null }">
				<img class="image4_2_img" alt="" src="${requestScope.htmlGoodsSPZS.image4_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image4_3 ne null }">
				<img class="image4_3_img" alt="" src="${requestScope.htmlGoodsSPZS.image4_3 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image4_4 ne null }">
				<img class="image4_4_img" alt="" src="${requestScope.htmlGoodsSPZS.image4_4 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image4_5 ne null }">
				<img class="image4_5_img" alt="" src="${requestScope.htmlGoodsSPZS.image4_5 }">
			</c:if>
		</div>
	</div>
	<div class="right_div">
		<div class="qrcode_div">
			<div class="downloadQrcode1_div">
				<img class="qrcode_img" alt="" src="${requestScope.htmlGoodsSPZS.qrCode }" />
				<div class="downloadQrcode2_div">下载二维码</div>
			</div>
			<!-- 
			<div class="option1_div">
				<div class="pbdy_div">
					<a class="pbdy_a">排版打印</a>
				</div>
				<div class="xzqtgs_div">
					<a class="xzqtgs_a">下载其他格式</a>
				</div>
				<div class="ewmmh_div">
					<a class="ewmmh_a">二维码美化</a>
				</div>
				<div class="hgmhmb_div">
					<a class="hgmhmb_a">换个美化模板</a>
				</div>
			</div>
			 -->
		</div>
		<div class="line1_div"></div>
		<div class="option2_div">
			<div class="editContent_div" onclick="editContent('${requestScope.htmlGoodsSPZS.moduleType }',${requestScope.htmlGoodsSPZS.goodsNumber },${requestScope.htmlGoodsSPZS.accountNumber });">编辑内容</div>
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