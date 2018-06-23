<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商品列表</title>
<%@include file="js.jsp"%>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@include file="side.jsp"%>
		<div class="layui-body">
			<div class="mainContent">
				<div class="divContent">
					<table class="layui-table">
						<tr>
							<td>类别编号</td>
							<td>编号</td>
							<td>标题</td>
							<td>图标</td>
							<td>二维码</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${requestScope.goodsList }" var="goods">
						<tr>
							<td>${goods.category_id }</td>
							<td>${goods.goodsNumber }</td>
							<td>${goods.title }</td>
							<td>
								<img alt="" src="${goods.imgUrl }" width="50" height="50"/>
							</td>
							<td>${goods.qrCode }</td>
							<td><a href="<%=basePath%>merchant/main/goEditGoods?id=${goods.id}">编辑</a></td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<%@include file="foot.jsp"%>
	</div>

</body>
</html>