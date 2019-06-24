<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商品展示模板列表</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
$(function(){
	$("#remove_but").linkbutton({
		iconCls:"icon-remove",
		onClick:function(){
			//deleteByIds();
		}
	});
	
	tab1=$("#tab1").datagrid({
		title:"商品模板查询",
		url:"queryHtmlGoodsSPZSList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		queryParams:{trade:'${param.trade}',accountId:'${sessionScope.user.id}'},
		columns:[[
			{field:"productName",title:"名称",width:100},
            {field:"gmtCreate",title:"创建时间",width:100},
            {field:"id",title:"操作",width:100}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{productName:"<div style=\"text-align:center;\"><a href=\"${pageContext.request.contextPath}/merchant/main/goEditModule?trade=${param.trade}\">点击生成商品模板</a><div>"});
				$(this).datagrid("mergeCells",{index:0,field:"productName",colspan:3});
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
			<a id="remove_but">删除</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../foot.jsp"%>
</div>
</body>
</html>