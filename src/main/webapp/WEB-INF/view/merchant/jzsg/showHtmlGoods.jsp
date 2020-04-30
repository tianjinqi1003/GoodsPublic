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
	//以下代码是按照原图比例缩放网页上的图片
	$("#image1_div img").each(function(){
		var width=$(this).css("width");
		width=width.substring(0,width.length-2);
		var src=$(this).attr("src");
		if(src.indexOf("jzsg/bf0b334d871019cf3b2359e22b405d1c")!=-1){
			$(this).css("height",width+"px");
		}
	});

	$("#image2_div img").each(function(){
		var width=$(this).css("width");
		width=width.substring(0,width.length-2);
		var src=$(this).attr("src");
		if(src.indexOf("jzsg/43a339cd90f1a6b00c0c256d49d6a119")!=-1){
			$(this).css("height",width*0.644+"px");
		}
	});
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
			<img class="image1_2_img" alt="" src="${requestScope.htmlGoodsJZSG.image1_2 }" style="width: 95%;height: 300px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsJZSG.image1_3 ne null }">
			<img class="image1_3_img" alt="" src="${requestScope.htmlGoodsJZSG.image1_3 }" style="width: 95%;height: 300px;margin-top: 25px;">
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