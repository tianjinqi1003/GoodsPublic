<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>商品发布</title>
<%@include file="js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">
var baseUrl = "${pageContext.request.contextPath}"
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
	if('${requestScope.json}'!=''){
		var json=JSON.parse('${requestScope.json}');
		if(json.status==0){
			var goodsNumber=json.data;
			var url=location.href.substring(0,location.href.indexOf("GoodsPublic")-1)+baseUrl+json.url+"?goodsNumber="+goodsNumber;
			$.post(baseUrl + "/merchant/main/createShowUrlQrcode",
				{url:url,goodsNumber:goodsNumber},
				function(json1){
					if(json1.status==0){
						$.messager.confirm("提示", json.msg+"，是否预览？", function(r){
							if (r){
								window.location.href=json1.url;
							}
						});
					}
				}
			,"json");
		}
	}
	
	$("#edit_div").dialog({
		title:"添加商品",
		width:setFitWidthInParent("body"),
		height:520,
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
	if(checkGoodsNumber()){
		if(checkTitle()){
			document.getElementById("sub_but").click();
		}
	}
}

function checkGoodsNumber(){
	var flag=false;
	var goodsNumber = $("#goodsNumber").val();
	if(goodsNumber==null||goodsNumber==""||goodsNumber=="商品编号不能为空"){
		$("#goodsNumber").css("color","#E15748");
    	$("#goodsNumber").val("商品编号不能为空");
    	flag=false;
	}
	else{
		$.ajaxSetup({async:false});
		$.post("checkGoodsNumber",
			{goodsNumber:goodsNumber},
			function(data){
				if(data.status==1){
					alert(data.msg);
					flag=false;
				}
				else
					flag=true;
			}
		,"json");
	}
	return flag;
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
			<form id="form1" name="form1" method="post" action="addGoodsPublic" enctype="multipart/form-data">
			<input type="hidden" id="accountNumber" name="accountNumber" value="${sessionScope.user.id }"/>
			<input type="hidden" id="category_id" name="category_id" value="${param.categoryId }"/>
			<table>
			  <tr>
				<td align="right">
					商品编号
				</td>
				<td>
					<input id="goodsNumber" name="goodsNumber" type="text" onfocus="focusGoodsNumber()" onblur="checkGoodsNumber()"/>
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					商品名称
				</td>
				<td>
					<input id="title" name="title" type="text" onfocus="focusTitle()" onblur="checkTitle()"/>
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					图片
				</td>
				<td>
					<img style='width: 100px; height: 100px' src="" class='uploadImg' id='uploadImg' />
					<input type="file" name="file" onchange="showQrcodePic(this)"/>
				</td>
			  </tr>
			  <tr>
				<td align="right">
					内容
				</td>
				<td>
					<br>
					<textarea id="htmlContent" name="htmlContent" cols="100" rows="8" style="width:700px;height:200px;visibility:hidden;"></textarea>
					<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
				</td>
			  </tr>
			</table>
			</form>
		</div>
		<%@include file="foot.jsp"%>
	</div>
</body>
</html>