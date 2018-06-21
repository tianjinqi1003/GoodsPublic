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
			<h1>这个是用来展示的首页</h1>
			<div id="addCategory">创建商品分类</div>
		</div>
		<%@include file="foot.jsp"%>
	</div>
	<script>
		layui.use([ 'element', "layer" ], function() {
			var layer = layui.layer;
			var element = layui.element;
			$("#addCategory").on("click",function(){
				layer.open({
					title:"添加分类",
					content:$("#motaikunag"),
					area:"50%",
					 btn: ['添加','取消'],
					 yes:function(index,layero){
						 console.log(index)
						 console.log(layero)
						console.log("这个是添加按钮")
					},
					btn2:function(index){
						console.log(index)
						console.log("这个是取消按钮")
					}
				})
				//TODO
				//这里制作弹出框，然后添加创建商品分类的部分
			})
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