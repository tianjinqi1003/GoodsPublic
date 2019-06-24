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
	<table id="spxq_tab">
		<tr>
			<td>
				${requestScope.htmlGoodsSPZS.spxqName1 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue1 }
			</td>
		</tr>
		<tr>
			<td>
				${requestScope.htmlGoodsSPZS.spxqName2 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue2 }
			</td>
		</tr>
		<tr>
			<td>
				${requestScope.htmlGoodsSPZS.spxqName3 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue3 }
			</td>
		</tr>
		<tr>
			<td>
				${requestScope.htmlGoodsSPZS.spxqName4 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue4 }
			</td>
		</tr>
		<tr>
			<td>
				${requestScope.htmlGoodsSPZS.spxqName5 }
			</td>
			<td>
				${requestScope.htmlGoodsSPZS.spxqValue5 }
			</td>
		</tr>
		<tr>
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
	<img alt="" src="${requestScope.htmlGoodsSPZS.qrCode }" />
</div>
</body>
</html>