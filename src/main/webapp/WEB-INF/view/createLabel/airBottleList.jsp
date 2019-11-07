<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>历史记录查询</title>
<%@include file="../merchant/js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
$(function(){
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			var qpbh=$("#qpbh_inp").val();
			tab1.datagrid("load",{qpbh:qpbh});
		}
	});
	$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			location.href=path+"createLabel/toCreateBatch";
		}
	});
	
	$("#remove_but").linkbutton({
		iconCls:"icon-remove",
		onClick:function(){
			deleteByIds();
		}
	});
	
	tab1=$("#tab1").datagrid({
		title:"历史记录查询",
		url:"queryAirBottleList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		columns:[[
            {field:"cpxh",title:"产品型号",width:100,sortable:true},
            {field:"qpbh",title:"气瓶编号",width:100,sortable:true},
            {field:"gcrj",title:"公称容积",width:100,sortable:true},
            {field:"ndbh",title:"内胆壁厚",width:100,sortable:true},
            {field:"zl",title:"重量",width:100,sortable:true},
            {field:"scrj",title:"实测容积",width:100,sortable:true},
            {field:"qpzjxh",title:"气瓶支架型号",width:100,sortable:true},
            {field:"zzrq",title:"制造日期",width:100,sortable:true},
            {field:"qpzzdw",title:"气瓶制造单位",width:100,sortable:true},
            {field:"id",title:"操作",width:100,formatter:function(value,row){
            	//return "<a href=\"${pageContext.request.contextPath}/merchant/main/goEditCategory?id="+value+"\">编辑</a>";
            	return "<a onclick=\"getCategory('"+row.id+"','"+row.categoryId+"','"+row.categoryName+"')\">编辑</a>";
            }}
        ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{cpxh:"<div style=\"text-align:center;\">暂无分类</div>"});
				$(this).datagrid("mergeCells",{index:0,field:"cpxh",colspan:10});
				data.total=0;
			}
			
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
	<div id="tab1_div" style="margin-top:20px;margin-left: 200px;">
		<div id="toolbar">
			气瓶编号：<input type="text" id="qpbh_inp"/>
			<a id="search_but">查询</a>
			<a id="add_but">创建批次</a>
			<a id="remove_but">删除</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>