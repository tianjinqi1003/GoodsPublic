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
$(function(){
	$("#add_but").linkbutton({
		iconCls:"icon-add",
		onclick:function(){
			location.href="<%=basePath%>merchant/main/goEditCategory";
		}
	});
	
	$("#remove_but").linkbutton({
		iconCls:"icon-remove",
		onclick:function(){
			deleteByIds();
		}
	});
	
	tab1=$("#tab1").datagrid({
		title:"分类查询",
		url:"queryCategoryList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		columns:[[
            {field:"categoryId",title:"类别编号",width:100,sortable:true},
            {field:"categoryName",title:"类别名称",width:100,sortable:true},
            {field:"id",title:"操作",width:100,formatter:function(value){
            	return "<a href=\"queryCompany.action?index=2&nav=2&id="+value+"&edit=true\">编辑</a>";
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
	//alert(ids.substring(1));
	var url = baseUrl + "/merchant/main/deleteCategory"
	$.post(url, {
		ids : ids.substring(1)
	}, function(result) {
		alert(result.msg)
		location.href = location.href;
	}, "json");
}
layui.use(['element'],function(){
	var element = layui.element;
});

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-250;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="side.jsp"%>
	<div style="margin-top:5px;margin-left: 210px;">
		<div id="toolbar">
			<a id="add_but">添加</a>
			<a id="remove_but">删除</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>