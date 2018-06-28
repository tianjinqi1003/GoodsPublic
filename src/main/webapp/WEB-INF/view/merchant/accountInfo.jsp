<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家信息</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
$(function(){
	$("#edit_div").dialog({
		title:"基本信息",
		width:setFitWidthInParent("body"),
		height:500,
		top:65,
		left:210
	});
	
	$("#edit_div table").css("width","50%");
	$("#edit_div table td").css("padding-left","50px");
	$("#edit_div table td").css("font-size","20px");
	$("#edit_div table tr").css("height","45px");
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
	<div id="edit_div">
		  <table>
			  <tr>
				<td align="right">
					昵称
				</td>
				<td>
					${requestScope.accountMsg.nickName }
				</td>
			  </tr>
			  <tr>
				<td align="right">
					手机号
				</td>
				<td>
					${requestScope.accountMsg.phone }
				</td>
			  </tr>
			  <tr>
				<td align="right">
					邮箱
				</td>
				<td>
					${requestScope.accountMsg.email }
				</td>
			  </tr>
		  </table>
	</div>
	<%@include file="foot.jsp"%>
</div>
</body>
</html>