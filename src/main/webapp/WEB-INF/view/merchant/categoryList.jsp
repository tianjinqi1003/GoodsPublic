<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分类查询</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
	var baseUrl = "${pageContext.request.contextPath}";
	function deleteByIds() {
		if ($("#tab1 input[type='checkbox']:checked").length == 0) {
			alert("请选择要删除的信息！");
			return false;
		}
		var ids = "";
		$("#tab1 input[type='checkbox']").each(function() {
			if ($(this).prop("checked")) {
				ids += "," + $(this).attr("id").substring(2);
			}
		});
		alert(ids.substring(1));
		var url = baseUrl + "/merchant/main/deleteCategory"
		$.post(url, {
			ids : ids.substring(1)
		}, function(result) {
			location.href = location.href;
		}, "json");
	}
	layui.use(['element'],function(){
		var element = layui.element;
	});
</script>
<style type="text/css">
.layui-body {
	justify-content: center;
	display: flex;
	height: 100%;
	background-color: #f3f3f4;
}

.mainContent {
	width: 70%;
	justify-content: center;
	display: flex;
	background-color: #fff;
}

.layui-btn {
	margin-top: 35px;
	margin-left: 10px;
	float: right;
}
.divContent{
	width: 70%;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@include file="side.jsp"%>
		<div class="layui-body">
			<div class="mainContent">
				<div class="divContent">
					<div class="layui-btn-container">
						<input type="button" value="添加" class="layui-btn"
							onclick="location.href='<%=basePath%>merchant/main/goEditCategory';" />
						<input type="button" class="layui-btn" value="删除"
							onclick="deleteByIds();" />
					</div>
					<div class="tableDiv">
						<table id="tab1" class="layui-table">
							<tr>
								<td>操作</td>
								<td>类别编号</td>
								<td>类别名称</td>
								<td>商户编号</td>
								<td>编辑</td>
							</tr>
							<c:forEach items="${requestScope.categoryList}"
								var="categoryInfo">
								<tr>
									<td><input type="checkbox" id="cb${categoryInfo.id }" /></td>
									<td>${categoryInfo.categoryId }</td>
									<td>${categoryInfo.categoryName }</td>
									<td>${categoryInfo.accountId }</td>
									<td><a
										href="<%=basePath%>merchant/main/goEditCategory?id=${categoryInfo.id }">编辑</a>
									</td>
									<!-- 
			<td>
				<input type="button" value="删除" onclick="deleteById(${categoryInfo.id });"/>
			</td>
			 -->
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
		<%@include file="foot.jsp"%>
	</div>
</body>
</html>