<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商户列表</title>
<%@include file="../merchant/js.jsp"%>
<script type="text/javascript">
$(function(){
	tab1=$("#tab1").datagrid({
		title:"商户列表",
		url:"queryAccountList",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		columns:[[
            {field:"phone",title:"手机号"},
            {field:"nickName",title:"昵称"},
            {field:"qrcodeCount",title:"二维码数量"},
            {field:"payMoney",title:"总支付金额"},
            {field:"payTime",title:"最后一次支付时间"},
            {field:"email",title:"邮箱"},
            {field:"role",title:"权限"},
            {field:"gmt_create",title:"注册时间"},
            {field:"id",title:"操作",formatter:function(value,row){
            	var status=row.accountStatus;
            	var str;
            	if(status=="-2")
            		str="开启";
            	else if(status=="0")
            		str="启用";
            	else if(status=="1")
            		str="禁用";
            	return "<a onclick=\"updateStatus('"+value+"','"+status+"')\">"+str+"</a>";
            }}
        ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{phone:"<div style=\"text-align:center;\">暂无商户<div>"});
				$(this).datagrid("mergeCells",{index:0,field:"phone",colspan:9});
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

function updateStatus(id,status){
	
	$.post("updateAccountStatus",
		{id:id,status:status},
		function(result){
			if(result.status==0){
				alert(result.msg);
				location.href=location.href;
			}
			else
				alert(result.msg);
		}
	,"json");
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