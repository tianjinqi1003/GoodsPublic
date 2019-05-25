<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>标签列表</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
$(function(){
	tab1=$("#tab1").datagrid({
		title:"标签列表",
		url:"queryGoodsLabelSetList",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		queryParams:{accountNumber:'${sessionScope.user.id}'},
		columns:[[
            {field:"label",title:"标签名称",width:100},
            {field:"module",title:"所属模块",width:100,formatter:function(value){
            	var text;
            	switch(value){
            	case "operation":
            		text="商品添加";
            		break;
            	case "editGoods":
            		text="商品编辑";
            		break;
            	case "goodsList":
            		text="商品列表";
            		break;
            	}
            	return text;
            }},
            {field:"isShow",title:"是否显示",width:100,formatter:function(value){
            	return value?"是":"否";
            }},
            {field:"isPublic",title:"是否公有",width:100,formatter:function(value){
            	return value?"是":"否";
            }},
            {field:"id",title:"操作",width:100,formatter:function(value){
            	return "<a href=\"${pageContext.request.contextPath}/merchant/main/goEditGoodsLabelSet?id="+value+"\">编辑</a>";
            }}
        ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{goodsNumber:"<div style=\"text-align:center;\"><a href=\"${pageContext.request.contextPath}/merchant/main/operation?categoryId=${param.categoryId}\">点击添加模板</a><div>"});
				$(this).datagrid("mergeCells",{index:0,field:"key",colspan:5});
				data.total=0;
			}
			
			$(".panel-header").css("background","linear-gradient(to bottom,#F4F4F4 0,#F4F4F4 20%)");
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
			
			resetTabStyle();
			reSizeCol();
		}
	});
});

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

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-210;
}

function initTab1WindowMarginLeft(){
	var tab1DivWidth=$("#tab1_div").css("width");
	tab1DivWidth=tab1DivWidth.substring(0,tab1DivWidth.length-2);
	var pdWidth=$(".panel.datagrid").css("width");
	pdWidth=pdWidth.substring(0,pdWidth.length-2);
	return ((tab1DivWidth-pdWidth)/2)+"px";
}
</script>
</head>
<body>
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