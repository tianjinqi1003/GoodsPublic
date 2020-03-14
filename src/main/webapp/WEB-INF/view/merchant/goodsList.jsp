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
				title:"商品列表&nbsp;|<a href=\"<%=basePath%>merchant/main/operation?categoryId=${param.categoryId}&accountId=${sessionScope.user.id}\" class=\"panel-title\">发布新商品</a>&nbsp;|&nbsp;&nbsp;<span style=\"cursor:pointer;\" onclick=\"deleteGoods();\">删除商品</span>",
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
					
					$(".panel-header .panel-title").css("color","#000");
					$(".panel-header .panel-title").css("font-size","15px");
					$(".panel-header .panel-title").css("padding-left","10px");
					$(".panel-header, .panel-body").css("border-color","#ddd");

					resetColumnsHtml();

					//因为这个报表是自定义标签，所以必须上面重置html格式后才可以执行下面的设置行头间距代码
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
			
			$("#previewDiv").css("margin-top",($(document).height()/2-150)+"px");
		}
	,"json");
});

function deleteGoods() {
	var rows=tab1.datagrid("getSelections");
	if (rows.length == 0) {
		$.messager.alert("提示","请选择要删除的信息！","warning");
		return false;
	}
	
	var ids = "";
	for (var i = 0; i < rows.length; i++) {
		ids += "," + rows[i].id;
	}
	ids=ids.substring(1);
	deleteByIds(ids);
}

function deleteByIds(ids){
	if(checkIfPaid()){
		$.messager.confirm("提示","确定要删除吗？",function(r){
			if(r){
				$.post("deleteGoodsByIds",
					{ids:ids},
					function(result){
						if(result.status==1){
							tab1.datagrid("reload");
						}
						alert(result.msg);
					}
				,"json");
			}
		});
	}
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
					tdDiv.html("<a href=\"${pageContext.request.contextPath}/merchant/main/show?goodsNumber="+goodsNumber+"&accountId="+'${sessionScope.user.id}'+"\">"+tdValue+"</a>");
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
	return width.substring(0,width.length-2)-270;
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
	<div id="tab1_div" style="margin-top:20px;margin-left: 238px;">
		 <table id="tab1">
		 </table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>