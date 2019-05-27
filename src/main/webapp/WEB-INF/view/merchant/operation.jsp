<%@ page language="java" contentType="text/html; charset=utf-8" 
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		title:"添加商品&nbsp;|<a href=\"<%=basePath%>merchant/main/goGoodsList?categoryId=${param.categoryId}\" class=\"panel-title\">查看商品列表</a>",
		width:setFitWidthInParent("body"),
		height:setFitHeightInParent(".layui-side"),
		top:60,
		left:200,
		buttons:[
           {text:"提交",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkEdit();
           }}
        ]
	});
	
	$("#edit_div table").css("width","1000px");
	$("#edit_div table").css("magin","-100px");
	$("#edit_div table td").css("padding-left","50px");
	$("#edit_div table td").css("padding-right","20px");
	$("#edit_div table td").css("font-size","15px");
	$("#edit_div table tr").css("height","45px");
	$("#edit_div table tr").each(function(){
		$(this).find("td").eq(0).css("color","#006699");
		$(this).find("td").eq(0).css("border-right","#CAD9EA solid 1px");
		$(this).find("td").eq(0).css("font-weight","bold");
		$(this).find("td").eq(0).css("background-color","#F5FAFE");
	});
	
	$("#edit_div table tr").mousemove(function(){
		$(this).css("background-color","#ddd");
	}).mouseout(function(){
		$(this).css("background-color","#fff");
	});

	$(".panel.window").css("width","983px");
	$(".panel.window").css("margin-top","20px");
	$(".panel.window").css("margin-left",initWindowMarginLeft());
	$(".panel.window").css("background","linear-gradient(to bottom,#E7F4FD 0,#E7F4FD 20%)"); 
	$(".panel.window .panel-title").css("color","#000");
	$(".panel.window .panel-title").css("font-size","15px");
	$(".panel.window .panel-title").css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").css("width","1000px");
	$(".window-shadow").css("margin-top","20px");
	$(".window-shadow").css("margin-left",initWindowMarginLeft());
	$(".window-shadow").css("background","#E7F4FD");
	
	$(".window,.window .window-body").css("border-color","#ddd");
	
	$("#ok_but").css("left","45%");
	$("#ok_but").css("position","absolute");
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","15px");
	
	var editor=$(".ke-container.ke-container-default");
	editor.css("min-width","700px");
	editor.css("max-width","700px");
	editor.css("min-height","500px");
	editor.css("max-height","500px");
	//alert(editor.html());
});

function checkEdit(){
	if(checkGoodsNumber()){
		if(checkTitle()){
			document.getElementById("sub_but").click();
		}
	}
}

function focusGoodsNumber(){
	var goodsNumber = $("#goodsNumber").val();
	if(goodsNumber=="商品编号不能为空"){
		$("#goodsNumber").val("");
		$("#goodsNumber").css("color", "#555555");
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
	return width.substring(0,width.length-2)-200;
}

function setFitHeightInParent(o){
	var height=$(o).css("height");
	return height.substring(0,height.length-2)-98;
}

function initWindowMarginLeft(){
	var editDivWidth=$("#edit_div").css("width");
	editDivWidth=editDivWidth.substring(0,editDivWidth.length-2);
	var pwWidth=$(".panel.window").css("width");
	pwWidth=pwWidth.substring(0,pwWidth.length-2);
	return ((editDivWidth-pwWidth)/2)+"px";
}
</script>
</head>
<body>
	<div class="layui-layout layui-layout-admin">
		<%@include file="side.jsp"%>
		<div id="edit_div">
			<!-- 因为页面套用了标签模板，必须在请求后面附加参数，以便提交完成后返回页面能显示模板 -->
			<form id="form1" name="form1" method="post" action="addGoodsPublic?categoryId=${param.categoryId }&accountId=${sessionScope.user.id}" enctype="multipart/form-data">
			<input type="hidden" id="accountNumber" name="accountNumber" value="${sessionScope.user.id }"/>
			<input type="hidden" id="category_id" name="category_id" value="${param.categoryId }"/>
			<table>
			  <c:forEach items="${requestScope.glsList }" var="goodsLabelSet">
			  	  <c:if test="${goodsLabelSet.isShow }">
					  <c:choose>
					  	  <c:when test="${goodsLabelSet.key eq 'imgUrl' }">
						  	  <tr style="border-bottom: #CAD9EA solid 1px;">
								<td align="right">
									<span style="color:${goodsLabelSet.isPublic?'#00F5FF':'#006699' };">${goodsLabelSet.label }</span>
								</td>
								<td style="padding-top: 7px;padding-bottom: 5px;">
									<img style='width: 100px; height: 100px' src="" class='uploadImg' id='uploadImg' />
									<input type="file" name="file" onchange="showQrcodePic(this)"/>
								</td>
							  </tr>
					  	  </c:when>
						  <c:when test="${goodsLabelSet.key eq 'htmlContent' }">
						  	<tr style="border-bottom: #CAD9EA solid 1px;">
								<td align="right">
									<span style="color:${goodsLabelSet.isPublic?'#00F5FF':'#006699' };">${goodsLabelSet.label }</span>
									<div style="font-size: 10px;color: #f00;">（最多可以输入6000字）</div>
								</td>
								<td>
									<br>
									<textarea id="htmlContent" name="htmlContent" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"></textarea>
									<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
								</td>
							  </tr>
						  </c:when>
						  <c:otherwise>
							  <tr style="border-bottom: #CAD9EA solid 1px;">
								<td align="right">
									<span style="color:${goodsLabelSet.isPublic?'#00F5FF':'#006699' };">${goodsLabelSet.label }</span>
								</td>
								<td>
									<input id="${goodsLabelSet.key }" name="${goodsLabelSet.key }" type="text" onfocus="focus${fn:toUpperCase(fn:substring(goodsLabelSet.key,0,1)) }${fn:substring(goodsLabelSet.key,1,goodsLabelSet.key.length()) }()" onblur="check${fn:toUpperCase(fn:substring(goodsLabelSet.key,0,1)) }${fn:substring(goodsLabelSet.key,1,goodsLabelSet.key.length()) }()"/>
									<span style="color: #f00;">*</span>
								</td>
							  </tr>
						  </c:otherwise>
					  </c:choose>
				  </c:if>
			  </c:forEach>
			  <!-- 
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					${requestScope.goodsAttrSet.goodsNumber }
				</td>
				<td>
					<input id="goodsNumber" name="goodsNumber" type="text" onfocus="focusGoodsNumber()" onblur="checkGoodsNumber()"/>
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					${requestScope.goodsAttrSet.title }
				</td>
				<td>
					<input id="title" name="title" type="text" onfocus="focusTitle()" onblur="checkTitle()"/>
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					${requestScope.goodsAttrSet.imgUrl }
				</td>
				<td style="padding-top: 7px;padding-bottom: 5px;">
					<img style='width: 100px; height: 100px' src="" class='uploadImg' id='uploadImg' />
					<input type="file" name="file" onchange="showQrcodePic(this)"/>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					${requestScope.goodsAttrSet.htmlContent }
					<div style="font-size: 10px;color: #f00;">（最多可以输入6000字）</div>
				</td>
				<td>
					<br>
					<textarea id="htmlContent" name="htmlContent" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"></textarea>
					<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
				</td>
			  </tr>
			<div style="height: 1px;width: 100%;background-color: #CAD9EA;margin-top: -515px;"></div>
			<div style="height: 1px;width: 100%;background-color: #CAD9EA;margin-top: -120px;"></div>
			<div style="height: 1px;width: 100%;background-color: #CAD9EA;margin-top: -46px;"></div>
			 -->
			</table>
			</form>
		</div>
		<%@include file="foot.jsp"%>
	</div>
</body>
</html>