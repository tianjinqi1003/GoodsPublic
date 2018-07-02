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
            {field:"phone",title:"手机号",width:100},
            {field:"nickName",title:"昵称",width:100},
            {field:"email",title:"邮箱",width:100},
            {field:"role",title:"权限",width:100},
            {field:"gmt_create",title:"注册时间",width:100},
            {field:"id",title:"操作",width:100,formatter:function(value,row){
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
				$(this).datagrid("mergeCells",{index:0,field:"phone",colspan:6});
				data.total=0;
			}
		}
	});
});

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
	return width.substring(0,width.length-2)-250;
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../merchant/side.jsp"%>
	<div style="margin-top:5px;margin-left: 210px;">
		 <table id="tab1">
		 </table>
	</div>
	<%@include file="../merchant/foot.jsp"%>
</div>
</body>
</html>