<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>建筑施工模板列表</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
var path='<%=basePath %>';
$(function(){
	$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			location.href=path+"merchant/main/goAddModule?trade=jzsg";
		}
	});
	
	$("#remove_but").linkbutton({
		iconCls:"icon-remove",
		onClick:function(){
			deleteHtmlGoodsSPZS();
		}
	});
	
	tab1=$("#tab1").datagrid({
		title:"建筑施工模板查询",
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
				$(this).datagrid("appendRow",{title:"<div style=\"text-align:center;\"><a href=\"${pageContext.request.contextPath}/merchant/main/goAddModule?trade=jzsg\">点击生成建筑施工模板</a><div>"});
				$(this).datagrid("mergeCells",{index:0,field:"title",colspan:3});
				data.total=0;
			}
			
			$(".panel-header").css("background","linear-gradient(to bottom,#F4F4F4 0,#F4F4F4 20%)");
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");
		}
	});
});

function deleteHtmlGoodsSPZS() {
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
	$.messager.confirm("提示","确定要删除吗？",function(r){
		if(r){
			$.post("deleteHtmlGoodsSPZSByIds",
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

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-210;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../side.jsp"%>
	<div id="tab1_div" style="margin-top:20px;margin-left: 200px;">
		<div id="toolbar">
			<a id="add_but">添加</a>
			<a id="remove_but">删除</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../foot.jsp"%>
</div>
</body>
</html>