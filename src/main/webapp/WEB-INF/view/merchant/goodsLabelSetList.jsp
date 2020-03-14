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
	$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			if(checkIfPaid())
				location.href="goAddGoodsLabelSet";
		}
	});
	
	$("#remove_but").linkbutton({
		iconCls:"icon-remove",
		onClick:function(){
			if(checkIfPaid())
				deleteByKeys();
		}
	});
	
	tab1=$("#tab1").datagrid({
		title:"标签列表",
		url:"queryGoodsLabelSetList",
		toolbar:"#toolbar",
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
            {field:"isCheck",title:"是否要验证",width:100,formatter:function(value){
            	return value?"是":"否";
            }},
            {field:"id",title:"操作",width:100,formatter:function(value){
            	return "<a href=\"${pageContext.request.contextPath}/merchant/main/goEditGoodsLabelSet?id="+value+"\">编辑</a>";
            }}
        ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{goodsNumber:"<div style=\"text-align:center;\"><a href=\"${pageContext.request.contextPath}/merchant/main/operation?categoryId=${param.categoryId}\">点击添加模板</a><div>"});
				$(this).datagrid("mergeCells",{index:0,field:"label",colspan:6});
				data.total=0;
			}
			
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");

			$(".datagrid-header td .datagrid-cell").each(function(){
				$(this).find("span").eq(0).css("margin-left","11px");
			});
			$(".datagrid-body td .datagrid-cell").each(function(){
				var html=$(this).html();
				$(this).html("<span style=\"margin-left:11px;\">"+html+"</span>");
			});
			
			resetTabStyle();
			reSizeCol();
		}
	});
});

function resetTabStyle(){
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

function deleteByKeys() {
	var rows=tab1.datagrid("getSelections");
	if (rows.length == 0) {
		$.messager.alert("提示","请选择要删除的信息！","warning");
		return false;
	}
	
	$.messager.confirm("提示","确定要删除吗？",function(r){
		if(r){
			var keys = "";
			for (var i = 0; i < rows.length; i++) {
				keys += "," + rows[i].key;
			}
			keys=keys.substring(1);
			
			$.post("deleteLabelByKeys",
				{accountNumber:'${sessionScope.user.id}',keys:keys},
				function(result){
					if(result.status==1){
						$.messager.alert("提示",result.msg,"warning");
						location.href = location.href;
					}
					else{
						$.messager.alert("提示",result.msg,"warning");
					}
				}
			,"json");
			
		}
	});
}

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-270;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="side.jsp"%>
	<div id="tab1_div" style="margin-top:20px;margin-left: 238px;">
		<div id="toolbar" style="height:32px;line-height:32px;">
			<a id="add_but" style="margin-left: 13px;">添加</a>
			<a id="remove_but">删除</a>
		</div>
		 <table id="tab1">
		 </table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>