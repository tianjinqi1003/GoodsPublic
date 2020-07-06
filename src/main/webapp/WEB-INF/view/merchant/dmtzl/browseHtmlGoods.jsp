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
<link rel="stylesheet" href="<%=basePath %>/resource/css/dmtzl/browseHtmlGoods.css" />
<script type="text/javascript">
function editContent(goodsNumber,accountNumber){
	location.href="${pageContext.request.contextPath}/merchant/main/goEditModule?trade=dmtzl&goodsNumber="+goodsNumber+"&accountNumber="+accountNumber;
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
       saveLink.download = '${requestScope.htmlGoodsDMTZL.title }'+'.png';
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
			<img class="qrcode_img" alt="" src="${requestScope.htmlGoodsDMTZL.qrCode }" />
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
		<a class="createQrcode_a" href="${pageContext.request.contextPath}/merchant/main/goAddModule?trade=dmtzl">新建二维码</a>
		<a class="return_a" href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=dmtzl">返回列表页</a>
	</div>
	<div class="left_div" id="left_div">
		<div class="title_div">
			${requestScope.htmlGoodsDMTZL.title }
		</div>
		<div class="memo1_div">
			${requestScope.htmlGoodsDMTZL.memo1 }
		</div>
		<div class="embed1_div" id="embed1_div">
			<c:if test="${requestScope.htmlGoodsDMTZL.embed1_1 ne null }">
				<embed alt="" src="${requestScope.htmlGoodsDMTZL.embed1_1 }" style="width: 95%;height: 300px;margin-top: 25px;">
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
	<div class="right_div">
		<div class="qrcode_div">
			<div class="downloadQrcode1_div">
				<img class="qrcode_img" alt="" src="${requestScope.htmlGoodsDMTZL.qrCode }" />
				<div class="downloadQrcode2_div" onclick="openXzewmBgDiv(1)">下载二维码</div>
			</div>
		</div>
		<div class="line1_div"></div>
		<div class="option2_div">
			<div class="editContent_div" onclick="editContent(${requestScope.htmlGoodsDMTZL.goodsNumber },${requestScope.htmlGoodsDMTZL.accountNumber });">编辑内容</div>
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