<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>预览</title>
<%@include file="../js.jsp"%>
</head>
<body style="background-color: #eee;">
<div id="main_div" style="width: 650px;margin: 0 auto;background-color: #fff;">
	<div style="width: 100%;height: 40px;line-height: 40px;text-align: center;font-size: 20px;font-weight: bold;">
		${requestScope.htmlGoodsSPZS.productName }
	</div>
	<div id="image1_div" style="width: 650px;text-align: center;">
		<c:if test="${requestScope.htmlGoodsSPZS.image1_1 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image1_1 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image1_2 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image1_2 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image1_3 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image1_3 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image1_4 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image1_4 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image1_5 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image1_5 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
	</div>
	<div style="width:650px;margin-top: 20px;">
		${requestScope.htmlGoodsSPZS.memo1 }
	</div>
	<div style="margin-top: 20px;">
		<table id="spxq_tab" style="width: 600px;margin: 0 auto;border: #eee solid 1px;">
			<tr height="60">
				<td colspan="2" style="text-align: center;background-color: #eee;">商品详情</td>
			</tr>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow1 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqName1 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqValue1 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow2 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqName2 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqValue2 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow3 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqName3 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqValue3 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow4 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqName4 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqValue4 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow5 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqName5 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqValue5 }
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.spxqIfShow6 }">
			<tr height="50">
				<td style="width:25%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqName6 }
				</td>
				<td style="width:75%;border: #eee solid 1px;padding-left: 20px;">
					${requestScope.htmlGoodsSPZS.spxqValue6 }
				</td>
			</tr>
			</c:if>
		</table>
	</div>
	<div style="width:650px;margin-top: 20px;">
		${requestScope.htmlGoodsSPZS.memo2 }
	</div>
	<div id="image2_div" style="width: 650px;text-align: center;margin-top: 20px;">
		<c:if test="${requestScope.htmlGoodsSPZS.image2_1 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image2_1 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image2_2 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image2_2 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image2_3 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image2_3 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image2_4 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image2_4 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image2_5 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image2_5 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
	</div>
	<div id="image3_div" style="width: 650px;text-align: center;margin-top: 20px;">
		<c:if test="${requestScope.htmlGoodsSPZS.image3_1 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image3_1 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image3_2 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image3_2 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image3_3 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image3_3 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image3_4 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image3_4 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
		<c:if test="${requestScope.htmlGoodsSPZS.image3_5 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image3_5 }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:if>
	</div>
	<div style="width:650px;margin-top: 20px;">
		${requestScope.htmlGoodsSPZS.memo3 }
	</div>
	<div>
		<img alt="" src="${requestScope.htmlGoodsSPZS.qrCode }" />
	</div>
</div>
</body>
</html>