<%@ page language="java" contentType="text/html; charset=utf-8" import="goodsPublic.entity.Goods"
    pageEncoding="utf-8"%>
<%
	Goods goods=(Goods)request.getAttribute("goods");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>编辑商品</title>
<%@include file="js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">
KindEditor.ready(function(K) {
	var editor1 = K.create('textarea[name="htmlContent"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	prettyPrint();
});

$(function(){
	$("#edit_div").dialog({
		title:"编辑商品",
		width:setFitWidthInParent("body"),
		height:500,
		top:65,
		left:210,
		buttons:[
           {text:"提交",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkEdit();
           }}
        ]
	});
	
	$("#edit_div table").css("width","100%");
	$("#edit_div table td").css("padding-left","50px");
	$("#edit_div table td").css("font-size","20px");
	$("#edit_div table tr").css("height","45px");
	
	$("#ok_but").css("left","45%");
	$("#ok_but").css("position","absolute");
	$(".dialog-button .l-btn-text").css("font-size","20px");
});

function checkEdit(){
	if(checkTitle()){
		document.getElementById("sub_but").click();
	}
}

function focusTitle(){
	var title = $("#title").val();
	if(title=="商品名称不能为空"){
		$("#title").val("");
		$("#title").css("color", "#555555");
	}
}

//验证商品名称
function checkTitle(){
	var title = $("#title").val();
	if(title==null||title==""||title=="商品名称不能为空"){
		$("#title").css("color","#E15748");
    	$("#title").val("商品名称不能为空");
    	return false;
	}
	else
		return true;
}

function showQrcodePic(obj){
	var $file = $(obj);
    var fileObj = $file[0];
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#uploadImg");

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);
    } else {
        dataURL = $file.val();
        var imgObj = document.getElementById("preview");
        // 两个坑:
        // 1、在设置filter属性时，元素必须已经存在在DOM树中，动态创建的Node，也需要在设置属性前加入到DOM中，先设置属性在加入，无效；
        // 2、src属性需要像下面的方式添加，上面的两种方式添加，无效；
        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
        imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;

    }
}

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
			<form id="form1" name="form1" method="post" action="editGoods" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${requestScope.goods.id }"/>
			<input type="hidden" id="accountNumber" name="accountNumber" value="${sessionScope.user.id }"/>
			<table>
			  <tr>
				<td align="right">
					类别编号
				</td>
				<td>
					<input id="category_id" name="category_id" type="text" value="${requestScope.goods.category_id }" onfocus="focusCategoryId()" onblur="checkCategoryId()"/>
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					商品名称
				</td>
				<td>
					<input id="title" name="title" type="text" value="${requestScope.goods.title }" maxlength="20" onfocus="focusTitle()" onblur="checkTitle()"/>
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					图片
				</td>
				<td>
					<img style='width: 100px; height: 100px' src="${requestScope.goods.imgUrl }" class='uploadImg' id='uploadImg' /> 
					<input type="file" name="file" onchange="showQrcodePic(this)"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					内容
				</td>
				<td>
					<br>
					<textarea id="htmlContent" name="htmlContent" cols="100" rows="8" style="width:700px;height:200px;visibility:hidden;"><%=htmlspecialchars(goods.getHtmlContent())%></textarea>
					<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
				</td>
			  </tr>
			</table>
			</form>
		</div>
		<%@include file="foot.jsp"%>
	</div>
<script>
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
                $("#imgUrl").val(res.data.src);
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

<%!
private String htmlspecialchars(String str) {
	str = str.replaceAll("&", "&amp;");
	str = str.replaceAll("<", "&lt;");
	str = str.replaceAll(">", "&gt;");
	str = str.replaceAll("\"", "&quot;");
	return str;
}
%>