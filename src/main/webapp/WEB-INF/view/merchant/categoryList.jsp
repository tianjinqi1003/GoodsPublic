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
            {field:"id",title:"操作",width:100,formatter:function(value,row){
            	//return "<a href=\"${pageContext.request.contextPath}/merchant/main/goEditCategory?id="+value+"\">编辑</a>";
            	return "<a onclick=\"getCategory('"+row.categoryId+"','"+row.categoryName+"')\">编辑</a>";
            }}
        ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{CompanyId:"<div style=\"text-align:center;\">暂无数据<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"CompanyId",colspan:3});
				data.total=0;
			}
			initEditDiv();
		}
	});
	
});

function getCategory(categoryId,categoryName){
	$("#categoryId").val(categoryId);
	$("#categoryName").val(categoryName);
}

function initEditDiv(){
	var rowsCount=tab1.datagrid("getRows").length;
	$("#edit_div").dialog({
		title:"添加分类",
		width:setFitWidthInParent("body"),
		height:200,
		top:rowsCount*25+200,
		left:210,
		buttons:[
           {text:"添加",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkReg();
           }}
        ]
	});
	
	$("#edit_div table").css("width","100%");
	$("#edit_div table td").css("padding-left","50px");
	$("#edit_div table td").css("font-size","20px");
	$("#edit_div table tr").css("height","45px");
	
	$("#ok_but").css("left","45%");
	$("#ok_but").css("position","absolute");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

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
	<div id="tab1_div" style="margin-top:5px;margin-left: 210px;">
		<div id="toolbar">
			<a id="remove_but">删除</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	
	<div id="edit_div">
		<input type="hidden" id="id" value="${sessionScope.user.id }"/>
		<table>
		  <tr>
			<td align="right">
				类别编号：
			</td>
			<td>
				<input id="categoryId" type="text" value="" onfocus="focusCategoryId()" onblur="checkCategoryId()"/>
				<span style="color: #f00;">*</span>
			</td>
		  </tr>
		  <tr>
			<td align="right">
				类别名称：
			</td>
			<td>
				<input id="categoryName" type="text" value="" maxlength="20" onfocus="focusCategoryName()" onblur="checkCategoryName()"/>
				<span style="color: #f00;">*</span>
			</td>
		  </tr>
		</table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>