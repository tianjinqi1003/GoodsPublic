<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>首页</title>
<%@include file="js.jsp"%>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<%@include file="side.jsp"%>
		<div class="layui-body">
			<div></div>
			<div></div>
		</div>
		<%@include file="foot.jsp"%>
	</div>
	<script>
		layui.use([ 'element', "layer" ], function() {
			var layer = layui.layer;
			var element = layui.element;
		});
	</script>
</body>
<div id="motaikunag" style="display: none;">
	<div class="layui-row">
		<div class="layui-col-md9">你的内容 9/12</div>
		<div class="layui-col-md3">你的内容 3/12</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md3">名字</div>
		<div class="layui-col-md9">
			<input type="text" name="testname" value="">
		</div>
	</div>

	<br /> <input type="button" onclick="javascript:alert('点击按钮')"
		title="点我" value="点我">
</div>
</html>