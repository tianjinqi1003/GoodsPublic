<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>建筑施工模版列表</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
$(function(){
	$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			if(checkIfPaid())
				location.href=path+"merchant/main/goAddModule?trade=jzsg";
		}
	});
	
	$("#batchAdd_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			if(checkIfPaid())
				location.href=path+"merchant/main/goBatchAddModule?trade=jzsg";
		}
	});
	
	$("#remove_but").linkbutton({
		iconCls:"icon-remove",
		onClick:function(){
			deleteHtmlGoodsJZSG();
		}
	});
	
	tab1=$("#tab1").datagrid({
		title:"建筑施工模版查询",
		url:"queryHtmlGoodsJZSGList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		queryParams:{accountId:'${sessionScope.user.id}'},
		columns:[[
			{field:"title",title:"标题",width:200},
            {field:"gmtCreate",title:"创建时间",width:200},
            {field:"id",title:"操作",width:150,formatter:function(value,row){
            	var str="<a href=\"${pageContext.request.contextPath}/merchant/main/goBrowseHtmlGoodsJZSG?userNumber="+row.userNumber+"&accountNumber="+row.accountNumber+"\">详情</a>"
            	+"&nbsp;|&nbsp;<a href=\"${pageContext.request.contextPath}/merchant/main/goEditModule?trade=jzsg&userNumber="+row.userNumber+"&accountNumber="+row.accountNumber+"\">编辑</a>"
            	+"&nbsp;|&nbsp;<a onclick=\"deleteByIds("+value+")\">删除</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{title:"<div style=\"text-align:center;\"><a href=\"${pageContext.request.contextPath}/merchant/main/goAddModule?trade=jzsg\">点击生成建筑施工模版</a><div>"});
				$(this).datagrid("mergeCells",{index:0,field:"title",colspan:3});
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
			reSizeCol();
		}
	});
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

function deleteHtmlGoodsJZSG() {
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
				$.post("deleteHtmlGoodsJZSGByIds",
					{ids:ids,accountNumber:'${sessionScope.user.id}'},
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

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-270;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../side.jsp"%>
	<div id="tab1_div" style="margin-top:20px;margin-left: 238px;">
		<div id="toolbar" style="height:32px;line-height:32px;">
			<a id="add_but" style="margin-left: 13px;">添加</a>
			<a id="batchAdd_but">Excel批量生成</a>
			<a id="remove_but">删除</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../foot.jsp"%>
</div>
</body>
</html>