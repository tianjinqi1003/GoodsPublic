<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>编辑类别</title>
<%@include file="js.jsp"%>
<style type="text/css">
.mainContent {
	justify-content: center;
	display: flex;
	height: 100%;
	background-color: #f3f3f4;
}

.formContent {
	width: 60%;
	justify-content: center;
	display: flex;
	background-color: #fff;
}
</style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
		<%@include file="side.jsp"%>
		<div class="layui-body">
			<div class="mainContent">
				<div class="formContent">
					<form method="post" enctype="multipart/form-data"
						class="layui-form">
						<div class="layui-form-item">
							<h3>基本信息</h3>
							<input type="hidden" name="id" value="${categoryInfo.id }" required>
							<input type="hidden" name="accountId" value="${sessionScope.user.id }" required>
							<div class="formList">
								<div class="formLine clearfix">
									<div class="layui-form-item">
										<label class="layui-form-label">*类别编号</label>
										<div class="layui-input-block">
											<input type="text" name="categoryId" value="${categoryInfo.categoryId }" required
												lay-verify="required" placeholder="请输入类别编号"
												autocomplete="off" class="layui-input" maxlength="20">
										</div>
									</div>
								</div>
							</div>
							<div class="formList">
								<div class="formLine clearfix">
									<div class="layui-form-item">
										<label class="layui-form-label">*类别名称</label>
										<div class="layui-input-block">
											<input type="text" name="categoryName" value="${categoryInfo.categoryName }" required
												lay-verify="required" placeholder="请输入类别名称"
												autocomplete="off" class="layui-input" maxlength="20">
										</div>
									</div>
								</div>
							</div>
							<div class="layui-form-item"></div>
							<div class="layui-input-block">
								<button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
								<button type="reset" class="layui-btn layui-btn-primary">重置</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<%@include file="foot.jsp"%>
	</div>
	<script>
		//JavaScript代码区域
		var baseUrl = "${pageContext.request.contextPath}"
		var editIndex;
		layui.use([ 'element', 'upload', 'layedit', 'form', "layer" ],
				function() {
					var layer = layui.layer;
					var element = layui.element;
					 //监听导航点击
					layedit = layui.layedit, upload = layui.upload,
							form = layui.form;
					form.on('submit(formDemo)', function(data) {
						console.log(data.elem) //被执行事件的元素DOM对象，一般为button对象
						console.log(data.form) //被执行提交的form对象，一般在存在form标签时才会返回
						if (editIndex !== undefined) {
							data.field.htmlContent = layedit
									.getContent(editIndex);
						}
						console.log(data.field) //当前容器的全部表单字段，名值对形式：{name: value}
						layedit.getContent(editIndex);
						var url = baseUrl + "/merchant/main/editCategory"
						$.post(url, data.field, function(result) {
							var json=JSON.parse(result); 
							if(json.status==1){
								layer.open({
									title:"编辑失败"
									,content: '失败原因：'+json.msg
								})
							}else{
								layer.open({
									title : "编辑成功",
									btn : [ 'yes', 'no' ],
									content:json.msg,
									yes : function() {
										console.log(json.data)
										console.log(json.url)
										window.location.href=baseUrl+json.url
									},
									no:function(){
										
									}
								})
							}
						})
						return false;
					})
				});
	</script>
</body>
</html>