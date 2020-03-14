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
		onClick:function(){
			if(checkIfPaid())
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
            	return "<a onclick=\"getCategory('"+row.id+"','"+row.categoryId+"','"+row.categoryName+"')\">编辑</a>";
            }}
        ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{categoryId:"<div style=\"text-align:center;\">暂无分类</div>"});
				$(this).datagrid("mergeCells",{index:0,field:"categoryId",colspan:3});
				data.total=0;
			}
			resetTabStyle();
			reSizeCol();
			initEditDiv();
		}
	});
	
});

function resetTabStyle(){
	$(".datagrid-header td .datagrid-cell").each(function(){
		$(this).find("span").eq(0).css("margin-left","11px");
	});
	$(".datagrid-body td .datagrid-cell").each(function(){
		var html=$(this).html();
		$(this).html("<span style=\"margin-left:11px;\">"+html+"</span>");
	});
	
	$(".panel.datagrid").css("width","788px");
	$(".panel.datagrid").css("margin-left",initTab1WindowMarginLeft());//保持居中

	$(".panel.datagrid .panel-header .panel-title").css("color","#000");
	$(".panel.datagrid .panel-header .panel-title").css("font-size","15px");
	$(".panel.datagrid .panel-header .panel-title").css("padding-left","10px");
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

function getCategory(id,categoryId,categoryName){
	$("#id").val(id);
	$("#categoryId").val(categoryId);
	$("#categoryName").val(categoryName);
}

function initEditDiv(){
	var rowsCount=tab1.datagrid("getRows").length;
	var diaWidth=setFitWidthInParent("body");
	$("#edit_div").dialog({
		title:"添加/编辑分类",
		width:diaWidth,
		height:200,
		top:rowsCount*25+228,
		left:218,
		buttons:[
           {text:"提交",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   if(checkIfPaid())
        	   	  checkEdit();
           }}
        ]
	});
	
	$("#edit_div table").css("width","800px");
	$("#edit_div table td").css("padding-left","50px");
	$("#edit_div table td").css("font-size","15px");
	$("#edit_div table tr").css("height","45px");
	
	$("#edit_div table tr").mousemove(function(){
		$(this).css("background-color","#ddd");
	}).mouseout(function(){
		$(this).css("background-color","#fff");
	});

	$(".panel.window").css("padding","0px");
	$(".panel.window").css("width","783px");
	$(".panel.window").css("margin-top","40px");
	$(".panel.window").css("margin-left",initEditWindowMarginLeft());
	$(".window,.window .window-body").css("border-color","#ddd");
	$(".panel.window .panel-title").css("color","#000");
	$(".panel.window .panel-title").css("font-size","15px");
	$(".panel.window .panel-title").css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	

	//以下的是表格下面的面板
	$(".window-shadow").css("width","783px");
	$(".window-shadow").css("margin-top","40px");
	$(".window-shadow").css("margin-left",initEditWindowMarginLeft());
	
	$(".panel-body.panel-body-noborder.window-body").css("width",diaWidth-4+"px"); 
	$(".panel-body.panel-body-noborder.window-body").css("height","155px"); 
	
	$("#ok_but").css("left","45%");
	$("#ok_but").css("position","absolute");
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","15px");
}

function checkIfPaid(){
	var bool=false;
	$.ajaxSetup({async:false});
	$.post("checkIfPaid",
		{accountNumber:'${sessionScope.user.id}'},
		function(data){
			if(data.status=="ok"){
				bool=true;
			}
			else{
				alert(data.message);
				bool=false;
			}
		}
	,"json");
	return bool;
}

function checkEdit(){
	if(checkCategoryId()){
		if(checkCategoryName()){
			editCategory();
		}
	}
}

function editCategory(){
	var id=$("#id").val();
	var accountId=$("#accountId").val();
	var categoryId=$("#categoryId").val();
	var categoryName=$("#categoryName").val();
	$.post("editCategory",
		{id:id,accountId:accountId,categoryId:categoryId,categoryName:categoryName},
		function(data){
			if(data.status==1){
				$.messager.alert("编辑失败",data.msg,"info");
			}
			else{
				$.messager.confirm("编辑成功", data.msg, function(r){
					if (r){
						location.href=location.href;
					}
				});
			}
		}
	,"json");
}

function focusCategoryId(){
	var categoryId = $("#categoryId").val();
	if(categoryId=="类别编号不能为空"){
		$("#categoryId").val("");
		$("#categoryId").css("color", "#555555");
	}
}

//验证类别编号
function checkCategoryId(){
	var categoryId = $("#categoryId").val();
	if(categoryId==null||categoryId==""||categoryId=="类别编号不能为空"){
		$("#categoryId").css("color","#E15748");
    	$("#categoryId").val("类别编号不能为空");
    	return false;
	}
	else
		return true;
}

function focusCategoryName(){
	var categoryName = $("#categoryName").val();
	if(categoryName=="类别名称不能为空"){
		$("#categoryName").val("");
		$("#categoryName").css("color", "#555555");
	}
}

//验证类别名称
function checkCategoryName(){
	var categoryName = $("#categoryName").val();
	if(categoryName==null||categoryName==""||categoryName=="类别名称不能为空"){
		$("#categoryName").css("color","#E15748");
    	$("#categoryName").val("类别名称不能为空");
    	return false;
	}
	else
		return true;
}

var baseUrl = "${pageContext.request.contextPath}";
function deleteByIds() {
	var rows=tab1.datagrid("getSelections");
	if (rows.length == 0) {
		$.messager.alert("提示","请选择要删除的信息！","warning");
		return false;
	}
	
	$.messager.confirm("提示","确定要删除吗？",function(r){
		if(r){
			var ids = "";
			var categoryIds = "";
			for (var i = 0; i < rows.length; i++) {
				ids += "," + rows[i].id;
				categoryIds += "," + rows[i].categoryId;
			}
			ids=ids.substring(1);
			categoryIds=categoryIds.substring(1);
			
			$.ajaxSetup({async:false});
			$.post(baseUrl + "/merchant/main/checkGoodsCount",
				{accountNumber:'${sessionScope.user.id}',categoryIds:categoryIds,ids:ids},
				function(result){
					if(result.status==1){
						$.messager.confirm("提示",result.msg,function(r){
							if(r){
								var url = baseUrl + "/merchant/main/deleteCategory"
								$.post(url, {
									ids : result.data
								}, function(result) {
									alert(result.msg);
									location.href = location.href;
								}, "json");
							}
						});
					}
				}
			,"json");
			
		}
	});
}
layui.use(['element'],function(){
	var element = layui.element;
});

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

function initEditWindowMarginLeft(){
	var editDivWidth=$("#edit_div").css("width");
	editDivWidth=editDivWidth.substring(0,editDivWidth.length-2);
	var pwWidth=$(".panel.window").css("width");
	pwWidth=pwWidth.substring(0,pwWidth.length-2);
	return ((editDivWidth-pwWidth)/2)+"px";
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="side.jsp"%>
	<div id="tab1_div" style="margin-top:20px;margin-left: 220px;">
		<div id="toolbar" style="height:32px;line-height:32px;">
			<a id="remove_but" style="margin-left: 13px;">删除</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	
	<div id="edit_div">
		<input type="hidden" id="id" value=""/>
		<input type="hidden" id="accountId" value="${sessionScope.user.id }"/>
		<table>
		  <tr>
			<td align="right">
				类别编号：
			</td>
			<td>
				<input id="categoryId" type="text" value="" maxlength="11" onfocus="focusCategoryId()" onblur="checkCategoryId()"/>
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
		<div style="height: 1px;width: 100%;background-color: #CAD9EA;margin-top: -45px;"></div>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>