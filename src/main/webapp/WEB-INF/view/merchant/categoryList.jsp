<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分类查询</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
var baseUrl = "${pageContext.request.contextPath}";
function deleteById(id){
	var url = baseUrl + "/merchant/main/deleteCategory"
	$.post(url,
		{id:id},
		function(result){
			location.href=location.href;
		}
	,"json");
}
</script>
</head>
<body>
	<%@include file="side.jsp"%>
	<%@include file="foot.jsp"%>
	<a href="<%=basePath%>merchant/main/goEditCategory" style="margin-left: 250px;">添加</a>
	<table style="margin-left: 250px;">
		<tr>
			<td>类别编号</td>
			<td>类别名称</td>
			<td>商户编号</td>
			<td>编辑</td>
			<td>删除</td>
		</tr>
		<c:forEach items="${requestScope.categoryList}" var="categoryInfo">
		<tr>
			<td>${categoryInfo.categoryId }</td>
			<td>${categoryInfo.categoryName }</td>
			<td>${categoryInfo.accountId }</td>
			<td>
				<a href="<%=basePath%>merchant/main/goEditCategory?id=${categoryInfo.id }">编辑</a>
			</td>
			<td>
				<input type="button" value="删除" onclick="deleteById(${categoryInfo.id });"/>
			</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>