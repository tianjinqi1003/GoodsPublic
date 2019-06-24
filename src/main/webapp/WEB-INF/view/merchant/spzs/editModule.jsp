<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
function addHtmlGoodsSPZS(){
	document.getElementById("sub_but").click();
}
</script>
</head>
<body>
<div>编辑</div>
<form id="form1" name="form1" method="post" action="addHtmlGoodsSPZS" enctype="multipart/form-data">
<div>
	<table id="spxq_tab">
	<c:forEach items="${requestScope.spxqList }" var="spxq" varStatus="status">
		<tr>
			<input type="hidden" name="spxqName${status.index+1 }" value="${spxq.name }" />
			<input type="hidden" name="spxqValue${status.index+1 }" value="${spxq.value }" />
			<td>
				${spxq.name }
			</td>
			<td>
				${spxq.value }
			</td>
		</tr>
	</c:forEach>
	</table>
</div>
	<input type="hidden" id="accountNumber_hid" name="accountNumber" value="${sessionScope.user.id }" />
	<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
<div>
	<input type="button" value="生成二维码" onclick="addHtmlGoodsSPZS();"/>
</div>
</form>
</body>
</html>