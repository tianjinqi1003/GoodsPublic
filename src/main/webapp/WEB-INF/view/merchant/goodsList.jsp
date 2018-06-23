<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商品列表</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
function previewImg(src){
	$("#previewDiv").css("display","block");
	$("#previewDiv img").attr("src",src);
}

function unPreviewImg(o){
	$(o).css("display","none");
	$(o).find("img").attr("src","");
}
</script>
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
								<img alt="" src="${goods.imgUrl }" width="50" height="50" onmousemove="previewImg(this.src);"/>
							</td>
							<td>
								<img alt="" src="${goods.qrCode }" width="50" height="50" onmousemove="previewImg(this.src);"/>
							</td>
							<td><a href="<%=basePath%>merchant/main/goEditGoods?id=${goods.id}&categoryId=${param.categoryId}">编辑</a></td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<%@include file="foot.jsp"%>
	</div>
	<div id="previewDiv" style="width: 300px;height: 300px;margin: 0 auto;margin-top: 100px;position: relative;z-index: 998;display: none;" onmouseout="unPreviewImg(this);">
		<img alt="" src="/GoodsPublic/upload/1529719265643.jpg" width="300" height="300"/>
	</div>
</body>
</html>