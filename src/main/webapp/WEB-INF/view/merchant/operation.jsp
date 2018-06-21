<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>商品发布</title>
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

.uploadImg {
	display: block;
	width: 175px;
	height: 175px;
	border: 1px dashed #ccc;
	cursor: pointer;
	margin: 6px 0px;
}

.uploadImg img {
	width: 100%;
	height: 100%;
}

.uploadImg input {
	display: none;
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
							<div class="formList">
								<div class="formLine clearfix">
									<div class="layui-form-item">
										<label class="layui-form-label">*商品名称</label>
										<div class="layui-input-block">
											<input type="text" name="title" required
												lay-verify="required" placeholder="请输入商品名称"
												autocomplete="off" class="layui-input" maxlength="20">
										</div>
									</div>
								</div>
							</div>
							<div class="formList">
								<div class="formLine clearfix">
									<div class="layui-form-item">
										<label class="layui-form-label">*商品编号</label>
										<div class="layui-input-block">
											<input type="text" name="goodsNumber" required
												lay-verify="required" placeholder="请输入商品编号"
												autocomplete="off" class="layui-input" maxlength="20">
										</div>
									</div>
								</div>
							</div>
							<div class="layui-form-item">
								<label class="layui-form-label">店铺分类</label>
								<div class="layui-input-inline select-input">
									<select id="shopCategory" lay-verify="required">
									</select>
								</div>
							</div>
							<div class="layui-form-item layui-form-text">
								<label class="layui-form-label">图片</label>
								<div class="layui-input-block">
									<div
										style='border: 1px dashed #ccc; max-width: 180px; border-radius: 3px;'>
										<label style='cursor: pointer'> 
										<img
											style='width: 100px; height: 100px' src="" class='uploadImg'
											id='uploadImg' /> <input hidden='hidden' name='imgUrl'
											id='imgUrl_' />
										</label>
									</div>
								</div>
							</div>
							<!-- 内容主体区域 -->
							<div class="layui-form-item">
								<textarea id="demo" style="display: none;" name="htmlContent"></textarea>
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
						var url = baseUrl + "/merchant/main/addGoodsPublic"
						$.post(url, data.field, function(result) {
							var json=JSON.parse(result); 
							if(json.status==1){
								layer.open({
									title:"发布失败"
									,content: '失败原因：'+json.msg
								})
							}else{
								var url=location.href.substring(0,location.href.indexOf("GoodsPublic")-1)+baseUrl+json.url+"?goodsNumber="+json.data;
								$.post(baseUrl + "/merchant/main/createShowUrlQrcode",
									{url:url,goodsNumber:json.data},
									function(json1){
										if(json1.status==0){
											layer.open({
												title : "是否预览",
												btn : [ 'yes', 'no' ],
												content:json.msg,
												yes : function() {
													console.log(json.data)
													console.log(json.url)
													window.location.href=json1.url;
													//window.location.href=baseUrl+json.url+"?goodsNumber="+json.data
												},
												no:function(){
													
												}
											})
										}
									}
								,"json");
							}
						})
						return false;
					})
					layedit.set({
						uploadImage : {
							url : baseUrl + '/merchant/main/upload',
							type : 'post'
						}
					});
					editIndex = layedit.build('demo', {
						height : 500
					}); //建立编辑器
				});
		 $(document).on("click", ".uploadImg", function () {
		        var ele = this;
		        //上传资讯图片
		        var uploadInst = upload.render({
		            elem: ele //绑定元素
		            ,url: baseUrl + '/merchant/main/upload' //上传接口
		            ,accept: 'images'
		            ,exts: 'jpg|png|gif|bmp|jpeg'
		            ,auto: true
		            ,done: function(res){
		                //上传完毕回调
		                $("#imgUrl_").val(res.data.src);
		                <%--const rootDirectory = "${staticFilePath}";--%>
		               // const rootDirectory = "http://120.27.5.36:8500/htkApp/";
		                $(ele).attr('src',res.data.src);
		            }
		            ,error: function(){
		                //请求异常回调
		                layer_msg("exceptin", "上传图片失败");
		            }
		        });
		    });
	</script>
</body>
</html>