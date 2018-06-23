<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商家信息</title>
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
<script type="text/javascript">
layui.use(['element'],function(){
	var element = layui.element;
});
</script>
</head>
<body>
	<div class="layui-layout layui-layout-admin">
		<%@include file="side.jsp"%>
		<div class="layui-body">
			<div class="mainContent">
				<div class="formContent">
					<form method="post" enctype="multipart/form-data"
						class="layui-form">
						<div class="layui-form-item">
							<h3>基本信息</h3>
							<div class="formList">
								<div class="formLine clearfix">
									<div class="layui-form-item">
										<label class="layui-form-label">昵称</label>
										<div class="layui-input-block">
											<label class="layui-form-label">${requestScope.accountMsg.nickName }</label>
										</div>
									</div>
								</div>
							</div>
							<div class="formList">
								<div class="formLine clearfix">
									<div class="layui-form-item">
										<label class="layui-form-label">手机号</label>
										<div class="layui-input-block">
											<label class="layui-form-label">${requestScope.accountMsg.phone }</label>
										</div>
									</div>
								</div>
							</div>
							<div class="formList">
								<div class="formLine clearfix">
									<div class="layui-form-item">
										<label class="layui-form-label">邮箱</label>
										<div class="layui-input-block">
											<label class="layui-form-label">${requestScope.accountMsg.email }</label>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<%@include file="foot.jsp"%>
	</div>
</body>
</html>