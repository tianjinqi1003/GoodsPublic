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
		title:"商品列表&nbsp;|<a href=\"<%=basePath%>merchant/main/operation?categoryId=${param.categoryId}\" class=\"panel-title\">发布新商品</a>",
		url:"queryGoodsList",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		queryParams:{accountId:'${sessionScope.user.id}',categoryId:'${param.categoryId}'},
		columns:[[
            {field:"goodsNumber",title:"编号",width:100},
            {field:"title",title:"标题",width:100,formatter:function(value,row){
            	return "<a href=\"${pageContext.request.contextPath}/merchant/main/show?goodsNumber="+row.goodsNumber+"\">"+value+"</a>";
            }},
            {field:"imgUrl",title:"图标",width:100,formatter:function(value){
            	return "<img alt=\"\" src=\""+value+"\" width=\"50\" height=\"50\" onclick=\"previewImg(this.src);\" />";
            }},
            {field:"qrCode",title:"二维码",width:100,formatter:function(value){
            	return "<img alt=\"\" src=\""+value+"\" width=\"50\" height=\"50\" onclick=\"previewImg(this.src);\" />";
            }},
            {field:"id",title:"操作",width:100,formatter:function(value){
            	return "<a href=\"${pageContext.request.contextPath}/merchant/main/goEditGoods?id="+value+"&categoryId=${param.categoryId}\">编辑</a>";
            }}
        ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{goodsNumber:"<div style=\"text-align:center;\"><a href=\"${pageContext.request.contextPath}/merchant/main/operation?categoryId=${param.categoryId}\">点击添加商品</a><div>"});
				$(this).datagrid("mergeCells",{index:0,field:"goodsNumber",colspan:5});
				data.total=0;
			}
			
			$(".panel-header").css("background","linear-gradient(to bottom,#F4F4F4 0,#F4F4F4 20%)");
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
			
			reSizeCol();
		}
	});
	
	$("#previewDiv").css("margin-top",($(document).height()/2-150)+"px");
});

//重设列宽
function reSizeCol(){
	var width=$(".panel.datagrid").css("width");
	width=width.substring(0,width.length-2);
	var cols=$(".datagrid-htable tr td");
	var colCount=cols.length;
	width=width-colCount*2;
	cols.css("width",width/colCount+"px");
	cols=$(".datagrid-btable tr").eq(0).find("td");
	colCount=cols.length;
	cols.css("width",width/colCount+"px");
}

//预览图片
function previewImg(src) {
	$("#previewDiv").css("display", "block");
	$("#previewDiv img").attr("src", src);
}

//关闭预览
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
<div id="previewDiv" style="width: 100%;height: 300px;position:absolute;text-align: center;display: none;z-index: 998;" onclick="unPreviewImg(this);">
	<img alt="" src="" style="width: 300px; height: 300px; margin: 0 auto;" />
</div>
<div class="layui-layout layui-layout-admin">
	<%@include file="side.jsp"%>
	<div style="margin-top:5px;margin-left: 210px;">
		 <table id="tab1">
		 </table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>