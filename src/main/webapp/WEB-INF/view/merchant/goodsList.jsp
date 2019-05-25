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
	$.post("getGoodsListColumns",
		{accountId:'${sessionScope.user.id}'},
		function(data){
			var columns = new Array();
			var glsList = data.glsList;
			for(var i=0;i<glsList.length;i++){
				var gls=glsList[i];
				var column={field:gls.key,title:gls.label,width:100};
				columns.push(column);
			}
			
			tab1=$("#tab1").datagrid({
				title:"商品列表&nbsp;|<a href=\"<%=basePath%>merchant/main/operation?categoryId=${param.categoryId}&accountId=${sessionScope.user.id}\" class=\"panel-title\">发布新商品</a>",
				url:"queryGoodsList",
				width:setFitWidthInParent("body"),
				pagination:true,
				pageSize:10,
				queryParams:{accountId:'${sessionScope.user.id}',categoryId:'${param.categoryId}'},
				columns:[columns],
				/*
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
		            	return "<a href=\"${pageContext.request.contextPath}/merchant/main/goEditGoods?id="+value+"&categoryId=${param.categoryId}&accountId=${sessionScope.user.id}\">编辑</a>";
		            }}
		        ]],
		        */
		        onLoadSuccess:function(data){
					if(data.total==0){
						$(this).datagrid("appendRow",{goodsNumber:"<div style=\"text-align:center;\"><a href=\"${pageContext.request.contextPath}/merchant/main/operation?categoryId=${param.categoryId}&accountId=${sessionScope.user.id}\">点击添加商品</a><div>"});
						$(this).datagrid("mergeCells",{index:0,field:columns[0].field,colspan:columns.length});
						data.total=0;
					}
					
					$(".panel-header").css("background","linear-gradient(to bottom,#F4F4F4 0,#F4F4F4 20%)");
					$(".panel-header .panel-title").css("color","#000");
					$(".panel-header .panel-title").css("font-size","15px");
					$(".panel-header .panel-title").css("padding-left","10px");
					$(".panel-header, .panel-body").css("border-color","#ddd");

					resetColumnsHtml();
					resetTabStyle();
					reSizeCol();
				}
			});
			
			$("#previewDiv").css("margin-top",($(document).height()/2-150)+"px");
		}
	,"json");
});

function resetColumnsHtml(){
	var fields = $("#tab1").datagrid('getColumnFields');
	for(var i=0;i<fields.length;i++){
		console.log(JSON.stringify(fields[i]));
	}
	/*
	$("#tab1_div tr.datagrid-row").each(function(i){
		console.log($("#tab1_div tr.datagrid-row[datagrid-row-index=0] td[field='title'] div").html());
	});
	*/
	$("#tab1_div tr.datagrid-header-row td").each(function(columnIndex){
		$("#tab1_div tr.datagrid-row").each(function(rowIndex){
			var tdDiv=$("#tab1_div tr.datagrid-row[datagrid-row-index="+rowIndex+"] td[field='"+fields[columnIndex]+"'] div");
			var tdValue=tdDiv.text();
			switch(fields[columnIndex]){
				case "title":
					var goodsNumber=$("#tab1_div tr.datagrid-row[datagrid-row-index="+rowIndex+"] td[field='goodsNumber'] div").text();
					tdDiv.html("<a href=\"${pageContext.request.contextPath}/merchant/main/show?goodsNumber="+goodsNumber+"\">"+tdValue+"</a>");
					break;
				case "imgUrl":
				case "qrCode":
					tdDiv.html("<img alt=\"\" src=\""+tdValue+"\" width=\"50\" height=\"50\" onclick=\"previewImg(this.src);\" />");
					break;
				case "id":
					tdDiv.html("<a href=\"${pageContext.request.contextPath}/merchant/main/goEditGoods?id="+tdValue+"&categoryId=${param.categoryId}&accountId=${sessionScope.user.id}\">编辑</a>");
					break;
			}
		});
	});
}

function resetTabStyle(){
	$(".panel.datagrid").css("margin-left",initTab1WindowMarginLeft());

	$(".panel.datagrid .panel-header").css("background","linear-gradient(to bottom,#E7F4FD 0,#E7F4FD 20%)");
	$(".panel.datagrid .panel-header .panel-title").css("color","#000");
	$(".panel.datagrid .panel-header .panel-title").css("font-size","15px");
	$(".panel.datagrid .panel-header .panel-title").css("padding-left","10px");
	
	$(".panel.datagrid .datagrid-toolbar").css("background","#F5FAFE");
	$(".panel.datagrid .datagrid-header-row").css("background","#E7F4FD");
	$(".panel.datagrid .datagrid-pager.pagination").css("background","#F5FAFE");
}

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

function initTab1WindowMarginLeft(){
	var tab1DivWidth=$("#tab1_div").css("width");
	tab1DivWidth=tab1DivWidth.substring(0,tab1DivWidth.length-2);
	var pdWidth=$(".panel.datagrid").css("width");
	pdWidth=pdWidth.substring(0,pdWidth.length-2);
	return ((tab1DivWidth-pdWidth)/2)+"px";
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
	<div id="tab1_div" style="margin-top:20px;margin-left: 210px;">
		 <table id="tab1">
		 </table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>