<%@page import="com.goodsPublic.util.StringUtils"%>
<%@page import="goodsPublic.entity.HtmlGoodsSPZS"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	HtmlGoodsSPZS htmlGoodsSPZS=(HtmlGoodsSPZS)request.getAttribute("htmlGoodsSPZS");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">
KindEditor.ready(function(K) {
	var editor1 = K.create('textarea[name="memo1"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	var editor2 = K.create('textarea[name="memo2"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	var editor3 = K.create('textarea[name="memo3"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	prettyPrint();
});

$(function(){
	var bodyWidth=$("body").css("width").substring(0,$("body").css("width").length-2);
	var middleDivWidth=$("#middle_div").css("width").substring(0,$("#middle_div").css("width").length-2);
	var middleDivHeight=$("#middle_div").css("height").substring(0,$("#middle_div").css("height").length-2);
	$("#right_div").css("margin-left",(parseInt(bodyWidth)+parseInt(middleDivWidth))/2+20+"px");
	$("#right_div").css("margin-top","-"+(parseInt(middleDivHeight)+40)+"px");
});

function showOptionDiv(o){
	$(o).parent().find("#but_div").css("display","block");
}

function hideOptionDiv(o){
	$(o).parent().find("#but_div").css("display","none");
}

function saveEditHtmlGoodsSPZS(){
	renameFile();
	
	var formData = new FormData($("#form1")[0]);
	 
	$.ajax({
		type:"post",
		url:"saveEditHtmlGoodsSPZS",
		dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.status==1){
				$("#saveStatus_div").css("display","block");
				setTimeout("hideSaveStatusDiv()",3000);
			}
			else{
				$("#saveStatus_div").css("display","none");
			}
			$("#saveStatus_div").text(data.msg);
		}
	});
	/*
	$.post("saveEditHtmlGoodsSPZS",
		$("#form1").serialize(),
		function(){
	
		}
	,"json");
	*/
}

function hideSaveStatusDiv(){
	$("#saveStatus_div").text("");
	$("#saveStatus_div").css("display","none");
}

function finishEditHtmlGoodsSPZS(){
	renameFile();
	document.getElementById("sub_but").click();
}

function openImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","block");
}

function openImage2ModBgDiv(){
	$("#image2ModBg_div").css("display","block");
}

function openImage3ModBgDiv(){
	$("#image3ModBg_div").css("display","block");
}

function deleteImage1Div(){
	$("#image1_div").remove();
}

function deleteImage2Div(){
	$("#image2_div").remove();
}

function deleteImage3Div(){
	$("#image3_div").remove();
}

function renameFile(){
	$("#uploadFile1_div input[type='file']").each(function(i){
		$(this).attr("name","file1_"+(i+1));
		//console.log($(this).attr("name"));
	});
	$("#uploadFile2_div input[type='file']").each(function(i){
		$(this).attr("name","file2_"+(i+1));
		//console.log($(this).attr("name"));
	});
	$("#uploadFile3_div input[type='file']").each(function(i){
		$(this).attr("name","file3_"+(i+1));
		//console.log($(this).attr("name"));
	});
}

function closeImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","none");
}

function closeImage2ModBgDiv(){
	$("#image2ModBg_div").css("display","none");
}

function closeImage3ModBgDiv(){
	$("#image3ModBg_div").css("display","none");
}

function uploadImage1(){
	var uuid=createUUID();
	$("#uuid_hid1").val(uuid);
	$("#uploadFile1_div").append("<input type=\"file\" id=\"uploadFile1_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic1(this)\"/>");
	document.getElementById("uploadFile1_inp").click();
}

function uploadImage2(){
	var uuid=createUUID();
	$("#uuid_hid2").val(uuid);
	$("#uploadFile2_div").append("<input type=\"file\" id=\"uploadFile2_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic2(this)\"/>");
	document.getElementById("uploadFile2_inp").click();
}

function uploadImage3(){
	var uuid=createUUID();
	$("#uuid_hid3").val(uuid);
	$("#uploadFile3_div").append("<input type=\"file\" id=\"uploadFile3_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic3(this)\"/>");
	document.getElementById("uploadFile3_inp").click();
}

function deleteImage(o){
	$(o).parent().remove();
}

function showQrcodePic1(obj){
	var uuid=$("#uuid_hid1").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	
	var imageTab=$("#image1Mod_div table");
	var length=imageTab.find("td[id^='file_td']").length;
	imageTab.find("#upload_td").before("<td id=\"file_td0\" style=\"width: 25%;\">"
			+"<img alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" style=\"position: absolute;margin-top: 5px;margin-left: 80px;\" onclick=\"deleteImage(this);\">"
			+"<img id=\"img"+uuid+"\" style=\"width: 120px;height: 120px;\" alt=\"\">"
			+fileHtml
		+"</td>");

	var $file = $(obj);
    var fileObj = $file[0];
    file=$file;
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#img"+uuid);

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

function showQrcodePic2(obj){
	var uuid=$("#uuid_hid2").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	
	var imageTab=$("#image2Mod_div table");
	var length=imageTab.find("td[id^='file_td']").length;
	imageTab.find("#upload_td").before("<td id=\"file_td0\" style=\"width: 25%;\">"
			+"<img alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" style=\"position: absolute;margin-top: 5px;margin-left: 80px;\" onclick=\"deleteImage(this);\">"
			+"<img id=\"img"+uuid+"\" style=\"width: 120px;height: 120px;\" alt=\"\">"
			//+"<input type=\"file\" id=\"file2_1\" name=\"file"+uuid+"\" onchange=\"showQrcodePic2(this)\" style=\"display: none;\"/>"
			+fileHtml
		+"</td>");

	var $file = $(obj);
    var fileObj = $file[0];
    file=$file;
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#img"+uuid);

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

function showQrcodePic3(obj){
	var uuid=$("#uuid_hid3").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	
	var imageTab=$("#image3Mod_div table");
	var length=imageTab.find("td[id^='file_td']").length;
	imageTab.find("#upload_td").before("<td id=\"file_td0\" style=\"width: 25%;\">"
			+"<img alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" style=\"position: absolute;margin-top: 5px;margin-left: 80px;\" onclick=\"deleteImage(this);\">"
			+"<img id=\"img"+uuid+"\" style=\"width: 120px;height: 120px;\" alt=\"\">"
			+fileHtml
		+"</td>");

	var $file = $(obj);
    var fileObj = $file[0];
    file=$file;
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#img"+uuid);

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

function createUUID() {
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";
 
    var uuid = s.join("");
    return uuid;
}

function changeSPXQTrIfShow(index,o){
	var ifShow=$("#spxqIfShow"+index).val();
	if(ifShow=="true"){
		$("#spxqIfShow"+index).val(false);
		$(o).val("隐藏");
	}
	else{
		$("#spxqIfShow"+index).val(true);
		$(o).val("显示");
	}
}

function goBack(){
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsSPZSList;";
}
</script>
</head>
<body style="background-color: #fbfbfb;">
<form id="form1" name="form1" method="post" action="finishEditHtmlGoodsSPZS" enctype="multipart/form-data">
<div id="image1ModBg_div" style="width:100%;height:100%;position: fixed;background:rgba(0,0,0,0.5);display:none;z-index: 1;">
	<div id="image1Mod_div" style="width: 600px;margin: 0 auto;margin-top: 100px;background-color: #fff;">
		<div style="width: 100%;height: 50px;line-height: 50px;border-bottom: #999 solid 1px;">
			<span style="margin-left: 20px;">图片模块</span>
			<span style="float: right;margin-right: 20px;cursor: pointer;" onclick="closeImage1ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table style="width: 550px;margin:0 auto;margin-top: 20px;border: #eee solid 1px;">
				<tr>
					<td id="file_td0" style="width: 25%;">
						<img alt="" src="/GoodsPublic/resource/images/004.png" style="position: absolute;margin-top: 5px;margin-left: 80px;" onclick="deleteImage(this);">
						<img id="img1_1" style="width: 120px;height: 120px;" alt="" src="/GoodsPublic/resource/images/spzs/22ad5cebe49933335608eeb6356e6ab9.png">
					</td>
					<td id="upload_td">
						<img alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
				</tr>
			</table>
			<div id="uploadFile1_div" style="display: none;">
				<input type="file" id="file1_1" name="file" onchange="showQrcodePic1(this)" />
			</div>
			<input type="hidden" id="uuid_hid1"/>
		</div>
		<div id="but_div" style="width: 100%;height: 50px;line-height: 50px;margin-top: 20px;border-top: #999 solid 1px;">
			<div style="width:80px;height:35px;line-height:35px;text-align:center;color:#fff;float:right;margin-top: 7px;margin-right:13px;background-color: #4caf50;border-radius:5px;" onclick="closeImage1ModBgDiv();">确&nbsp;认</div>
			<div style="width:80px;height:33px;line-height:33px;text-align:center;color:#999;float:right;margin-top: 7px;margin-right:13px;border: #999 solid 1px;border-radius:5px;" onclick="closeImage1ModBgDiv();">取&nbsp;消</div>
		</div>
	</div>
</div>

<div id="image2ModBg_div" style="width:100%;height:100%;position: fixed;background:rgba(0,0,0,0.5);display:none;z-index: 1;">
	<div id="image2Mod_div" style="width: 600px;margin: 0 auto;margin-top: 100px;background-color: #fff;">
		<div style="width: 100%;height: 50px;line-height: 50px;border-bottom: #999 solid 1px;">
			<span style="margin-left: 20px;">图片模块</span>
			<span style="float: right;margin-right: 20px;cursor: pointer;" onclick="closeImage2ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table style="width: 550px;margin:0 auto;margin-top: 20px;border: #eee solid 1px;">
				<tr>
					<td id="file_td0" style="width: 25%;">
						<img alt="" src="/GoodsPublic/resource/images/004.png" style="position: absolute;margin-top: 5px;margin-left: 80px;" onclick="deleteImage(this);">
						<img id="img2_1" style="width: 120px;height: 120px;" alt="" src="/GoodsPublic/resource/images/spzs/41116eb627d54a623813c01bcadd05ce.png">
						<!-- 
						<input type="file" id="file2_1" name="file2_1" onchange="showQrcodePic2(this)" style="display: none;"/>
						 -->
					</td>
					<!-- 
					<td style="width: 25%;">
						<img alt="" src="/GoodsPublic/resource/images/004.png" style="position: absolute;margin-top: 5px;margin-left: 80px;" onclick="deleteImage(this);">
						<img alt="" src="/GoodsPublic/resource/images/spzs/573ab1fc91d98528915519d96dc2e6ec.png">
						<input type="file" id="image2_2" onchange="showQrcodePic2(this)" style="display: none;"/>
					</td>
					 -->
					<td id="upload_td">
						<img alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage2();">
					</td>
				</tr>
			</table>
			<div id="uploadFile2_div" style="display: none;">
				<input type="file" id="file2_1" name="file" onchange="showQrcodePic2(this)" />
			</div>
			<input type="hidden" id="uuid_hid2"/>
		</div>
		<div id="but_div" style="width: 100%;height: 50px;line-height: 50px;margin-top: 20px;border-top: #999 solid 1px;">
			<div style="width:80px;height:35px;line-height:35px;text-align:center;color:#fff;float:right;margin-top: 7px;margin-right:13px;background-color: #4caf50;border-radius:5px;" onclick="closeImage2ModBgDiv();">确&nbsp;认</div>
			<div style="width:80px;height:33px;line-height:33px;text-align:center;color:#999;float:right;margin-top: 7px;margin-right:13px;border: #999 solid 1px;border-radius:5px;" onclick="closeImage2ModBgDiv();">取&nbsp;消</div>
		</div>
	</div>
</div>

<div id="image3ModBg_div" style="width:100%;height:100%;position: fixed;background:rgba(0,0,0,0.5);display:none;z-index: 1;">
	<div id="image3Mod_div" style="width: 600px;margin: 0 auto;margin-top: 100px;background-color: #fff;">
		<div style="width: 100%;height: 50px;line-height: 50px;border-bottom: #999 solid 1px;">
			<span style="margin-left: 20px;">图片模块</span>
			<span style="float: right;margin-right: 20px;cursor: pointer;" onclick="closeImage3ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table style="width: 550px;margin:0 auto;margin-top: 20px;border: #eee solid 1px;">
				<tr>
					<td id="file_td0" style="width: 25%;">
						<img alt="" src="/GoodsPublic/resource/images/004.png" style="position: absolute;margin-top: 5px;margin-left: 80px;" onclick="deleteImage(this);">
						<img id="img3_1" style="width: 120px;height: 120px;" alt="" src="/GoodsPublic/resource/images/spzs/\573ab1fc91d98528915519d96dc2e6ec.png">
					</td>
					<td id="upload_td">
						<img alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage3();">
					</td>
				</tr>
			</table>
			<div id="uploadFile3_div" style="display: none;">
				<input type="file" id="file3_1" name="file" onchange="showQrcodePic3(this)" />
			</div>
			<input type="hidden" id="uuid_hid3"/>
		</div>
		<div id="but_div" style="width: 100%;height: 50px;line-height: 50px;margin-top: 20px;border-top: #999 solid 1px;">
			<div style="width:80px;height:35px;line-height:35px;text-align:center;color:#fff;float:right;margin-top: 7px;margin-right:13px;background-color: #4caf50;border-radius:5px;" onclick="closeImage3ModBgDiv();">确&nbsp;认</div>
			<div style="width:80px;height:33px;line-height:33px;text-align:center;color:#999;float:right;margin-top: 7px;margin-right:13px;border: #999 solid 1px;border-radius:5px;" onclick="closeImage3ModBgDiv();">取&nbsp;消</div>
		</div>
	</div>
</div>

<div style="width: 100%;height: 50px;line-height: 50px;background-color: #fff;">
	<div style="float:left;width: 70px;height: 30px;line-height: 30px;text-align:center;margin-top:10px;margin-left:20px;border:1px solid #eee;border-radius:3px;" onclick="goBack();">&lt返回</div>
	<div style="width:200px;margin:0 auto;font-size:18px;font-weight: bold;text-align: center;">红酒介绍-案例</div>
	<div style="float:right;height: 30px;line-height: 30px;text-align:center;margin-top:-40px;margin-right:20px;border-radius:3px;">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div id="middle_div" style="width: 650px;margin: 0 auto;margin-top: 25px;background-color: #fff;">
	<div>
		<input type="text" id="productName" name="productName" placeholder="请输入标题" value="${requestScope.htmlGoodsSPZS.productName }" style="width: 100%;height: 40px;line-height: 40px;text-align: center;font-size: 20px;font-weight: bold;"/>
	</div>
	<div id="image1_div" style="width: 650px;text-align: center;">
		<div id="option_div" style="width:650px;position:absolute;" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div id="but_div" style="width:100px;height:30px;line-height:30px;margin:0 auto;margin-top: 50px;text-align:center;z-index: 1;background-color: #fff;border-radius:5px;display:none; ">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsSPZS.image1_1 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image1_1 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image1_2 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image1_2 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image1_3 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image1_3 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image1_4 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image1_4 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image1_5 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image1_5 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
		</div>
	</div>
	<div style="margin-top: 25px;">
		<textarea id="memo1" name="memo1" cols="100" rows="8" style="width:650px;height:150px;visibility:hidden;"><%=htmlspecialchars(htmlGoodsSPZS.getMemo1()) %></textarea>
	</div>
	<div id="spxq_div" style="margin-top: 20px;">
		<table id="spxq_tab" style="width: 600px;margin: 0 auto;border: #eee solid 1px;">
			<tr style="height:60px;">
				<td colspan="2" style="text-align: center;background-color: #fbfbfb;">商品详情</td>
				<td style="text-align: center;background-color: #fbfbfb;">操作</td>
			</tr>
			
			<tr id="tr1" height="50">
				<input type="hidden" name="spxqName1" value="${requestScope.htmlGoodsSPZS.spxqName1 }" />
				<td style="width:20%;border: #eee solid 1px;padding-left: 20px;">${requestScope.htmlGoodsSPZS.spxqName1 }</td>
				<td style="width:70%;border: #eee solid 1px;padding-left: 20px;">
					<input type="text" name="spxqValue1" value="${requestScope.htmlGoodsSPZS.spxqValue1 }" />
				</td>
				<td style="width:10%;border: #eee solid 1px;text-align: center;">
					<input type="hidden" id="spxqIfShow1" name="spxqIfShow1" value="${requestScope.htmlGoodsSPZS.spxqIfShow1 }" />
					<input type="button" value="${requestScope.htmlGoodsSPZS.spxqIfShow1?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(1,this)"/>
				</td>
			</tr>
			
			<tr id="tr2" height="50">
				<input type="hidden" name="spxqName2" value="${requestScope.htmlGoodsSPZS.spxqName2 }" />
				<td style="width:20%;border: #eee solid 1px;padding-left: 20px;">${requestScope.htmlGoodsSPZS.spxqName2 }</td>
				<td style="width:70%;border: #eee solid 1px;padding-left: 20px;">
					<input type="text" name="spxqValue2" value="${requestScope.htmlGoodsSPZS.spxqValue2 }" />
				</td>
				<td style="width:10%;border: #eee solid 1px;text-align: center;">
					<input type="hidden" id="spxqIfShow2" name="spxqIfShow2" value="${requestScope.htmlGoodsSPZS.spxqIfShow2 }" />
					<input type="button" value="${requestScope.htmlGoodsSPZS.spxqIfShow2?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(2,this)"/>
				</td>
			</tr>
			
			<tr id="tr3" height="50">
				<input type="hidden" name="spxqName3" value="${requestScope.htmlGoodsSPZS.spxqName3 }" />
				<td style="width:20%;border: #eee solid 1px;padding-left: 20px;">${requestScope.htmlGoodsSPZS.spxqName3 }</td>
				<td style="width:70%;border: #eee solid 1px;padding-left: 20px;">
					<input type="text" name="spxqValue3" value="${requestScope.htmlGoodsSPZS.spxqValue3 }" />
				</td>
				<td style="width:10%;border: #eee solid 1px;text-align: center;">
					<input type="hidden" id="spxqIfShow3" name="spxqIfShow3" value="${requestScope.htmlGoodsSPZS.spxqIfShow3 }" />
					<input type="button" value="${requestScope.htmlGoodsSPZS.spxqIfShow3?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(3,this)"/>
				</td>
			</tr>
			
			<tr id="tr4" height="50">
				<input type="hidden" name="spxqName4" value="${requestScope.htmlGoodsSPZS.spxqName4 }" />
				<td style="width:20%;border: #eee solid 1px;padding-left: 20px;">${requestScope.htmlGoodsSPZS.spxqName4 }</td>
				<td style="width:70%;border: #eee solid 1px;padding-left: 20px;">
					<input type="text" name="spxqValue4" value="${requestScope.htmlGoodsSPZS.spxqValue4 }" />
				</td>
				<td style="width:10%;border: #eee solid 1px;text-align: center;">
					<input type="hidden" id="spxqIfShow4" name="spxqIfShow4" value="${requestScope.htmlGoodsSPZS.spxqIfShow4 }" />
					<input type="button" value="${requestScope.htmlGoodsSPZS.spxqIfShow4?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(4,this)"/>
				</td>
			</tr>
			
			<tr id="tr5" height="50">
				<input type="hidden" name="spxqName5" value="${requestScope.htmlGoodsSPZS.spxqName5 }" />
				<td style="width:20%;border: #eee solid 1px;padding-left: 20px;">${requestScope.htmlGoodsSPZS.spxqName5 }</td>
				<td style="width:70%;border: #eee solid 1px;padding-left: 20px;">
					<input type="text" name="spxqValue5" value="${requestScope.htmlGoodsSPZS.spxqValue5 }" />
				</td>
				<td style="width:10%;border: #eee solid 1px;text-align: center;">
					<input type="hidden" id="spxqIfShow5" name="spxqIfShow5" value="${requestScope.htmlGoodsSPZS.spxqIfShow5 }" />
					<input type="button" value="${requestScope.htmlGoodsSPZS.spxqIfShow5?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(5,this)"/>
				</td>
			</tr>
			
			<tr id="tr6" height="50">
				<input type="hidden" name="spxqName6" value="${requestScope.htmlGoodsSPZS.spxqName6 }" />
				<td style="width:20%;border: #eee solid 1px;padding-left: 20px;">${requestScope.htmlGoodsSPZS.spxqName6 }</td>
				<td style="width:70%;border: #eee solid 1px;padding-left: 20px;">
					<input type="text" name="spxqValue6" value="${requestScope.htmlGoodsSPZS.spxqValue6 }" />
				</td>
				<td style="width:10%;border: #eee solid 1px;text-align: center;">
					<input type="hidden" id="spxqIfShow6" name="spxqIfShow6" value="${requestScope.htmlGoodsSPZS.spxqIfShow6 }" />
					<input type="button" value="${requestScope.htmlGoodsSPZS.spxqIfShow6?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(6,this)"/>
				</td>
			</tr>
			
		</table>
	</div>
	<div style="margin-top: 20px;">
		<textarea id="memo2" name="memo2" cols="100" rows="8" style="width:650px;height:220px;visibility:hidden;"><%=htmlspecialchars(htmlGoodsSPZS.getMemo2()) %></textarea>
	</div>
	<div id="image2_div" style="width: 650px;text-align: center;margin-top: 25px;">
		<div id="option_div" style="width:650px;position:absolute;" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div id="but_div" style="width:100px;height:30px;line-height:30px;margin:0 auto;margin-top: 50px;text-align:center;z-index: 1;background-color: #fff;border-radius:5px;display:none; ">
				<a onclick="openImage2ModBgDiv();">编辑</a>|
				<a onclick="deleteImage2Div();">删除</a>
			</div>
		</div>
		<div onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsSPZS.image2_1 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image2_1 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image2_2 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image2_2 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image2_3 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image2_3 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image2_4 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image2_4 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image2_5 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image2_5 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
		</div>
	</div>
	<div id="image3_div" style="width: 650px;text-align: center;margin-top: 25px;">
		<div id="option_div" style="width:650px;position:absolute;" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div id="but_div" style="width:100px;height:30px;line-height:30px;margin:0 auto;margin-top: 50px;text-align:center;z-index: 1;background-color: #fff;border-radius:5px;display:none; ">
				<a onclick="openImage3ModBgDiv();">编辑</a>|
				<a onclick="deleteImage3Div();">删除</a>
			</div>
		</div>
		<div onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsSPZS.image3_1 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image3_1 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image3_2 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image3_2 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image3_3 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image3_3 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image3_4 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image3_4 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image3_5 ne null }">
			<img alt="" src="${requestScope.htmlGoodsSPZS.image3_5 }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:if>
		</div>
	</div>
	<div style="margin-top: 20px;">
		<textarea id="memo3" name="memo3" cols="100" rows="8" style="width:650px;height:550px;visibility:hidden;"><%=htmlspecialchars(htmlGoodsSPZS.getMemo3()) %></textarea>
	</div>
</div>
<div id="right_div" style="width: 150px;height: 200px;text-align: center;">
	<img style="width: 120px;height: 120px;" alt="" src="${requestScope.htmlGoodsSPZS.qrCode }">
	<div style="width: 100px;height: 30px;line-height: 30px;text-align:center;margin:0 auto;margin-top:15px;border:1px solid #eee;background-color:#fff;border-radius:3px;">预览</div>
	<div style="width: 100px;height: 30px;line-height: 30px;text-align:center;margin:0 auto;margin-top:15px;border:1px solid #eee;background-color:#fff;border-radius:3px;" onclick="saveEditHtmlGoodsSPZS();">保存</div>
	<div style="width: 100px;height: 30px;line-height: 30px;text-align:center;margin:0 auto;margin-top:15px;color:#fff;background-color:#4caf50;border-radius:3px;" onclick="finishEditHtmlGoodsSPZS();">完成编辑</div>
	<div id="saveStatus_div" style="width: 100px;height: 30px;line-height: 30px;text-align:center;margin:0 auto;margin-top:15px;color:#4caf50;display: none;"></div>
</div>
	<input type="hidden" id="id" name="id" value="${requestScope.htmlGoodsSPZS.id }" />
	<input type="hidden" id="goodsNumber" name="goodsNumber" value="${requestScope.htmlGoodsSPZS.goodsNumber }" />
	<input type="hidden" id="accountNumber_hid" name="accountNumber" value="${sessionScope.user.id }" />
	<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
</form>
</body>
</html>
<%!
private String htmlspecialchars(String str) {
	//System.out.println(str);
	if(!StringUtils.isEmpty(str)){
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
	}
	return str;
}
%>