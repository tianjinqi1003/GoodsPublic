<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>边框导航栏</title>
<style type="text/css">
.side {
	position: fixed;
	top: 50px;
	bottom: 0;
	height: 100%;
	justify-content: center;
	display: flex;
}

.head {
	align-items: center;
	position: relative;
	height: 50px;
	background-color: #20A0FF !important;
}

.headTitle, .headTitle>h1 {
	padding-left: 15px;
	margin: 0px auto;
}
</style>
</head>
<body>
	<div class="layui-header">
		<div class="layui-logo">二维码产品发布系统</div>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item">
				<a href="javascript:;"> 
					<img src="http://t.cn/RCzsdCq" class="layui-nav-img">
					${sessionScope.user.nickName }
				</a>
			</li>
			<li class="layui-nav-item">
				<a href="<%=basePath%>merchant/exit">退了</a>
			</li>
		</ul>
	</div>

	<div class="layui-side layui-bg-black">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree layui-inline" lay-filter="demo"
				style="margin-right: 10px;">
				<li class="layui-nav-item"><a
					href="<%=basePath%>merchant/main/index">首页</a></li>
				<li class="layui-nav-item"><a
					href="<%=basePath%>merchant/main/operation">商品发布</a></li>
				<li class="layui-nav-item"><a
					href="<%=basePath%>merchant/main/queryCategoryList">分类管理</a></li>
				<li class="layui-nav-item"><a href="javascript:;"
					class="getCategory">店内分类</a>
					<dl class="layui-nav-child">
						<!-- 
						<dd>
							<a href="javascript:;">选项一</a>
						</dd>
						<dd>
							<a href="javascript:;">选项二</a>
						</dd>
						<dd>
							<a href="javascript:;">选项三</a>
						</dd>
						 -->
						 <c:choose>
						 <c:when test="${empty sessionScope.categoryList}">
							 <dd>
							 	<a href="<%=basePath%>merchant/main/goEditCategory">暂无分类</a>
							 </dd>
						 </c:when>
						 <c:otherwise>
							 <c:forEach items="${sessionScope.categoryList }" var="item">
							 <dd>
								<a href="<%=basePath%>merchant/main/queryGoodsList?categoryId=${item.categoryId}">${item.categoryName }</a>
							 </dd>
							 </c:forEach>
						 </c:otherwise>
						 </c:choose>
					</dl>
				</li>
				<li class="layui-nav-item"><a href="<%=basePath%>merchant/main/goAccountInfo?accountId=${sessionScope.user.id }">商家信息</a></li>
			</ul>
		</div>
	</div>
	<script type="text/javascript">
		var baseUrl = "${pageContext.request.contextPath}"
		$(".getCategory").on("click", function() {
			var url = baseUrl+"/merchant/main/getCategory"
			$.post(url,function(result) {
				console.log(result)
			})
		})
	</script>
</body>
</html>