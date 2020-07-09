<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>预览</title>
<%@include file="../js.jsp"%>
<script type="text/javascript" src="<%=basePath %>resource/js/pdf/jspdf.debug.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/js/pdf/html2canvas.min.js"></script>
<link rel="stylesheet" href="<%=basePath %>/resource/css/jzsg/browseHtmlGoods.css" />
<script type="text/javascript">
function editContent(userNumber,accountNumber){
	location.href="${pageContext.request.contextPath}/merchant/main/goEditModule?trade=jzsg&userNumber="+userNumber+"&accountNumber="+accountNumber;
}

function openXzewmBgDiv(flag){
	$("#xzewmBg_div").css("display",flag==1?"block":"none");
}

function downloadQrocdeImg(){
	//使用html2canvas 转换html为canvas
    html2canvas($("#xzewmBg_div #qrcodeImg_div")).then(function (canvas) {
       var imgUri = canvas.toDataURL("image/jpg").replace("image/jpg", "image/octet-stream"); // 获取生成的图片的url 　
       var saveLink = document.createElement('a');
       saveLink.href = imgUri;
       saveLink.download = '${requestScope.htmlGoodsJZSG.title }'+'.png';
       saveLink.click();
    });
}
</script>
</head>
<body>
<div class="xzewmBg_div" id="xzewmBg_div">
	<div class="xzewm_div">
		<div class="close_div">
			<span class="close_span" onclick="openXzewmBgDiv(0)">关闭</span>
		</div>
		<div class="qrcodeImg_div" id="qrcodeImg_div">
			<img class="qrcode_img" alt="" src="${requestScope.htmlGoodsJZSG.qrCode }" />
		</div>
		<div class="xzBut_div" onclick="downloadQrocdeImg()">
			<div>
				<span class="xz_text_span">下载</span>
			</div>
			<div>
				<span class="xs_text_span">230*230像素</span>
			</div>
		</div>
	</div>
</div>

<div class="main_div" id="main_div">
	<div class="top_div">
		<img class="createSuccess_img" alt="" src="/GoodsPublic/resource/images/006.png">
		<span class="createSuccess_span">生码成功！</span>
		<a class="createQrcode_a" href="${pageContext.request.contextPath}/merchant/main/goAddModule?trade=jzsg">新建二维码</a>
		<a class="return_a" href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=jzsg">返回列表页</a>
	</div>
	<div class="left_div" id="left_div">
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
		<div class="ryxx_div">
			<table class="ryxx_tab" id="ryxx_tab">
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
	<div class="right_div">
		<div class="qrcode_div">
			<div class="downloadQrcode1_div">
				<img class="qrcode_img" alt="" src="${requestScope.htmlGoodsJZSG.qrCode }" />
				<div class="downloadQrcode2_div" onclick="openXzewmBgDiv(1)">下载二维码</div>
			</div>
		</div>
		<div class="line1_div"></div>
		<div class="option2_div">
			<div class="editContent_div" onclick="editContent(${requestScope.htmlGoodsJZSG.userNumber },${requestScope.htmlGoodsJZSG.accountNumber });">编辑内容</div>
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