<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>支付记录</title>
<%@include file="../merchant/js.jsp"%>
<script type="text/javascript">
$(function(){
	tab1=$("#tab1").datagrid({
		title:"支付记录列表",
		url:"queryAprList",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		queryParams:{accountId:'${param.accountId}'},
		columns:[[
            {field:"money",title:"支付金额"},
            {field:"payTime",title:"支付时间"},
            {field:"vipType",title:"购买版本",formatter:function(value){
            	var str;
            	switch(value){
            	case 1:
            		str="免费版";
            		break;
            	case 2:
            		str="基础版";
            		break;
            	case 3:
            		str="高级版";
            		break;
            	case 4:
            		str="行业版";
            		break;
            	}
            	return str;
            }},
            {field:"payType",title:"支付方式",formatter:function(value){
            	var str;
            	switch(value){
            	case 1:
            		str="支付宝";
            		break;
            	case 2:
            		str="微信";
            		break;
            	}
            	return str;
            }},
            {field:"endTime",title:"版本到期时间"}
        ]],
        onLoadSuccess:function(data){
        	console.log(data);
			if(data.total==0){
				$(this).datagrid("appendRow",{money:"<div style=\"text-align:center;\">暂无商户<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"money",colspan:5});
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

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-270;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../merchant/side.jsp"%>
	<div style="margin-top:20px;margin-left: 238px;">
		 <table id="tab1">
		 </table>
	</div>
	<%@include file="../merchant/foot.jsp"%>
</div>
</body>
</html>