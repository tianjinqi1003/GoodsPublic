<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商品列表</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
$(function(){
	tab1=$("#tab1").datagrid({
		title:"商品列表",
		url:"queryGoodsList",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		queryParams:{accountId:'${sessionScope.user.id}',categoryId:'${param.categoryId}'},
		columns:[[
            {field:"goodsNumber",title:"编号",width:100},
            {field:"title",title:"标题",width:100},
            {field:"imgUrl",title:"图标",width:100,formatter:function(value){
            	return "<img alt=\"\" src=\""+value+"\" width=\"50\" height=\"50\" onmousemove=\"previewImg(this.src);\" />";
            }},
            {field:"qrCode",title:"二维码",width:100,formatter:function(value){
            	return "<img alt=\"\" src=\""+value+"\" width=\"50\" height=\"50\" onmousemove=\"previewImg(this.src);\" />";
            }},
            {field:"id",title:"操作",width:100,formatter:function(value){
            	return "<a href=\"${pageContext.request.contextPath}/merchant/main/goEditGoods?id="+value+"&categoryId=${param.categoryId}\">编辑</a>";
            }}
        ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{CompanyId:"<div style=\"text-align:center;\">暂无数据<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"CompanyId",colspan:3});
				data.total=0;
			}
		}
	});
});

function previewImg(src) {
	$("#previewDiv").css("display", "block");
	$("#previewDiv img").attr("src", src);
}

function unPreviewImg(o) {
	$(o).css("display", "none");
	$(o).find("img").attr("src", "");
}
layui.use([ 'element' ], function() {
	var element = layui.element;
});

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-250;
}
</script>
<style type="text/css">
</style>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="side.jsp"%>
	<div style="margin-top:5px;margin-left: 210px;">
		<!-- 
					<table class="layui-table">
						<tr>
							<td>编号</td>
							<td>标题</td>
							<td>图标</td>
							<td>二维码</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${requestScope.goodsList }" var="goods">
							<tr>
								<td>${goods.goodsNumber }</td>
								<td>${goods.title }</td>
								<td><img alt="" src="${goods.imgUrl }" width="50"
									height="50" onmousemove="previewImg(this.src);" /></td>
								<td><img alt="" src="${goods.qrCode }" width="50"
									height="50" onmousemove="previewImg(this.src);" /></td>
								<td><a
									href="<%=basePath%>merchant/main/goEditGoods?id=${goods.id}&categoryId=${param.categoryId}">编辑</a></td>
							</tr>
						</c:forEach>
					</table>
					 -->
		 <table id="tab1">
		 </table>
	<%@include file="foot.jsp"%>
</div>
<div id="previewDiv"
	style="width: 300px; height: 300px; margin: 0 auto; margin-top: -200px; position:relative; z-index: 998; display: none;"
	onmouseout="unPreviewImg(this);">
	<img alt="" src="/GoodsPublic/upload/1529719265643.jpg" width="300"
		height="300" />
</div>
</body>
</html>