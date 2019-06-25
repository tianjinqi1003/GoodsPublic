<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>预览</title>
</head>
<body>
<div>预览</div>
	<div>
		${requestScope.htmlGoodsSPZS.memo1 }
	</div>
	<div id="image1_div">
		<img alt="" src="/GoodsPublic/resource/images/spzs/001.png" style="width: 200px;height: 200px;">
	</div>
<div>
	<table id="spxq_tab" style="width: 500px;">
		<tr height="60">
			<td colspan="2" style="text-align: center;background-color: #999;">商品详情</td>
		</tr>
		<tr height="50">
			<td>
				${requestScope.htmlGoodsSPZS.spxqName1 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue1 }
			</td>
		</tr>
		<tr height="50">
			<td>
				${requestScope.htmlGoodsSPZS.spxqName2 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue2 }
			</td>
		</tr>
		<tr height="50">
			<td>
				${requestScope.htmlGoodsSPZS.spxqName3 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue3 }
			</td>
		</tr>
		<tr height="50">
			<td>
				${requestScope.htmlGoodsSPZS.spxqName4 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue4 }
			</td>
		</tr>
		<tr height="50">
			<td>
				${requestScope.htmlGoodsSPZS.spxqName5 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue5 }
			</td>
		</tr>
		<tr height="50">
			<td>
				${requestScope.htmlGoodsSPZS.spxqName6 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue6 }
			</td>
		</tr>
	</table>
</div>
	<div>
		${requestScope.htmlGoodsSPZS.memo2 }
	</div>
	<div>
		${requestScope.htmlGoodsSPZS.memo3 }
	</div>
<div>
	<img alt="" src="${requestScope.htmlGoodsSPZS.qrCode }" />
</div>
</body>
</html>