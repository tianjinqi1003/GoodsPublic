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
<%@include file="../../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/spzs/productExplain/editModule.css" />
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

function resetDivPosition(){
	var middleDivHeight=$("#middle_div").css("height").substring(0,$("#middle_div").css("height").length-2);
	$("#right_div").css("margin-top","-"+(parseInt(middleDivHeight))+"px");
}

function showOptionDiv(o){
	$(o).parent().find("#but_div").css("display","block");
}

function hideOptionDiv(o){
	$(o).parent().find("#but_div").css("display","none");
}

function saveEditHtmlGoodsSPZS(){
	if(checkIfPaid()){
		renameFile();
		renameImage();
		
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
}

function checkIfPaid(){
	var bool=false;
	$.ajaxSetup({async:false});
	$.post("checkIfPaid",
		{accountNumber:'${sessionScope.user.id}'},
		function(data){
			if(data.status=="ok"){
				bool=true;
			}
			else{
				alert(data.message);
				bool=false;
			}
		}
	,"json");
	return bool;
}

function hideSaveStatusDiv(){
	$("#saveStatus_div").text("");
	$("#saveStatus_div").css("display","none");
}

function finishEditHtmlGoodsSPZS(){
	renameFile();
	renameImage();
	document.getElementById("sub_but").click();
}

function openImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","block");
}

function openImage2ModBgDiv(){
	$("#image2ModBg_div").css("display","block");
}

function openEmbed1ModBgDiv(){
	$("#embed1ModBg_div").css("display","block");
}

function deleteImage1Div(){
	$("#image1_div").remove();
	$("#uploadFile1_div input[type='file']").remove();
	$("#uploadFile1_div input[type='text']").remove();
	resetDivPosition();
}

function deleteImage2Div(){
	$("#image2_div").remove();
	$("#uploadFile2_div input[type='file']").remove();
	$("#uploadFile2_div input[type='text']").remove();
	resetDivPosition();
}

function deleteEmbed1Div(){
	$("#embed1_div").remove();
	$("#uploadFile3_div input[type='file']").remove();
	$("#uploadFile3_div input[type='text']").remove();
	resetDivPosition();
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

function renameImage(){
	$("#uploadFile1_div input[type='text']").each(function(i){
		$(this).attr("name","image1_"+(i+1));
		//console.log($(this).attr("name"));
	});
	$("#uploadFile2_div input[type='text']").each(function(i){
		$(this).attr("name","image2_"+(i+1));
		//console.log($(this).attr("name"));
	});
	$("#uploadFile3_div input[type='text']").each(function(i){
		$(this).attr("name","embed1_"+(i+1));
		//console.log($(this).attr("name"));
	});
}

function closeImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","none");
}

function closeImage2ModBgDiv(){
	$("#image2ModBg_div").css("display","none");
}

function closeEmbed1ModBgDiv(){
	$("#embed1ModBg_div").css("display","none");
}

function changeButStyle(o,flag){
	if(flag==1){
		$(o).css("color","#4caf50");
		$(o).css("border-color","#4caf50");
	}
	else{
		$(o).css("color","#999");
		$(o).css("border-color","#999");
	}
}

function uploadImage1(){
	var uuid=createUUID();
	$("#uuid_hid1").val(uuid);
	$("#uploadFile1_div").append("<input type=\"file\" id=\"uploadFile1_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic1(this)\"/>");
	$("#uploadFile1_div").append("<input type=\"text\" id=\"image"+uuid+"\" name=\"image"+uuid+"\" />");
	document.getElementById("uploadFile1_inp").click();
}

function uploadImage2(){
	var uuid=createUUID();
	$("#uuid_hid2").val(uuid);
	$("#uploadFile2_div").append("<input type=\"file\" id=\"uploadFile2_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic2(this)\"/>");
	$("#uploadFile2_div").append("<input type=\"text\" id=\"image"+uuid+"\" name=\"image"+uuid+"\" />");
	document.getElementById("uploadFile2_inp").click();
}

function deleteImage1(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image1_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
	$("#uploadFile1_div input[type='file'][name='file"+uuid+"']").remove();
	$("#uploadFile1_div input[type='text'][name='image"+uuid+"']").remove();

	var imageTab=$("#image1Mod_div table");
	var tdArr1=imageTab.find("td");
	imageTab.empty();
	for(var i=0;i<tdArr1.length;i++){
		var tdArr2=imageTab.find("td");
		if(tdArr2.length==0||tdArr2.length%4==0)
			imageTab.append("<tr></tr>");
		imageTab.find("tr").eq(imageTab.find("tr").length-1).append(tdArr1[i]);
	}
	
	resetDivPosition();
}

function deleteImage2(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image2_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
	$("#uploadFile2_div input[type='file'][name='file"+uuid+"']").remove();
	$("#uploadFile2_div input[type='text'][name='image"+uuid+"']").remove();
	
	var imageTab=$("#image2Mod_div table");
	var tdArr1=imageTab.find("td");
	imageTab.empty();
	for(var i=0;i<tdArr1.length;i++){
		var tdArr2=imageTab.find("td");
		if(tdArr2.length==0||tdArr2.length%4==0)
			imageTab.append("<tr></tr>");
		imageTab.find("tr").eq(imageTab.find("tr").length-1).append(tdArr1[i]);
	}
	
	resetDivPosition();
}

function showQrcodePic1(obj){
	var uuid=$("#uuid_hid1").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	var tdHtml="<td class=\"file_td\" id=\"file_td"+uuid+"\">"
				+"<img class=\"delete_img\" alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" onclick=\"deleteImage1(this);\">"
				+"<img class=\"item_img\" id=\"img"+uuid+"\" alt=\"\">"
				+fileHtml
			+"</td>";
	
	var imageTab=$("#image1Mod_div table");
	//var length=imageTab.find("td[id^='file_td']").length;
    var tdLength=imageTab.find("td").length;
    if(tdLength%4==0){
    	var tr=imageTab.find("tr").eq(imageTab.find("tr").length-1);
    	tr.append(tdHtml)
    	imageTab.append("<tr>"+$("#image1Mod_div table #upload_td").prop("outerHTML")+"</tr>");
    	tr.find("td[id^='upload_td']").remove();
    }
    else{
		imageTab.find("#upload_td").before(tdHtml);
    }

	var $file = $(obj);
    var fileObj = $file[0];
    file=$file;
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#image1Mod_div table #img"+uuid);

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);

        var listDiv=$("#image1_div #list_div");
        listDiv.append("<img class=\"item_img\" id=\"img"+uuid+"\" alt=\"\" src=\""+dataURL+"\">");
        
    	resetDivPosition();
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
	var tdHtml="<td class=\"file_td\" id=\"file_td"+uuid+"\">"
				+"<img class=\"delete_img\" alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" onclick=\"deleteImage2(this);\">"
				+"<img class=\"item_img\" id=\"img"+uuid+"\" alt=\"\">"
				+fileHtml
			+"</td>";
	
	var imageTab=$("#image2Mod_div table");
	//var length=imageTab.find("td[id^='file_td']").length;
    var tdLength=imageTab.find("td").length;
    if(tdLength%4==0){
    	var tr=imageTab.find("tr").eq(imageTab.find("tr").length-1);
    	tr.append(tdHtml)
    	imageTab.append("<tr>"+$("#image2Mod_div table #upload_td").prop("outerHTML")+"</tr>");
    	tr.find("td[id^='upload_td']").remove();
    }
    else{
		imageTab.find("#upload_td").before(tdHtml);
    }

	var $file = $(obj);
    var fileObj = $file[0];
    file=$file;
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#image2Mod_div table #img"+uuid);

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);

        var listDiv=$("#image2_div #list_div");
        listDiv.append("<img class=\"item_img\" id=\"img"+uuid+"\" alt=\"\" src=\""+dataURL+"\">");

    	resetDivPosition();
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
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=spzs&moduleType="+'${param.moduleType}';
}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="finishEditHtmlGoodsSPZS" onsubmit="return checkIfPaid();" enctype="multipart/form-data">
<div class="image1ModBg_div" id="image1ModBg_div">
	<div class="image1Mod_div" id="image1Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage1ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<c:if test="${requestScope.htmlGoodsSPZS.image1_1 ne null||requestScope.htmlGoodsSPZS.image1_2 ne null||requestScope.htmlGoodsSPZS.image1_3 ne null||requestScope.htmlGoodsSPZS.image1_4 ne null }">
				<tr>
					<c:if test="${requestScope.htmlGoodsSPZS.image1_1 ne null }">
					<td class="file_td" id="file_td1_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsSPZS.image1_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image1_2 ne null }">
					<td class="file_td" id="file_td1_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_2"  alt="" src="${requestScope.htmlGoodsSPZS.image1_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image1_3 ne null }">
					<td class="file_td" id="file_td1_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsSPZS.image1_3 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image1_4 ne null }">
					<td class="file_td" id="file_td1_4">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsSPZS.image1_4 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image1_5 eq null }">
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
					</c:if>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image1_5 ne null}">
				<tr>
					<c:if test="${requestScope.htmlGoodsSPZS.image1_5 ne null }">
					<td class="file_td" id="file_td1_5">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_5" alt="" src="${requestScope.htmlGoodsSPZS.image1_5 }">
					</td>
					</c:if>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
				</tr>
				</c:if>
			</table>
			<div class="uploadFile1_div" id="uploadFile1_div">
				<c:if test="${requestScope.htmlGoodsSPZS.image1_1 ne null }">
				<input type="file" id="file1_1" name="file1_1" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_1" name="image1_1" value="${requestScope.htmlGoodsSPZS.image1_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image1_2 ne null }">
				<input type="file" id="file1_2" name="file1_2" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_2" name="image1_2" value="${requestScope.htmlGoodsSPZS.image1_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image1_3 ne null }">
				<input type="file" id="file1_3" name="file1_3" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_3" name="image1_3" value="${requestScope.htmlGoodsSPZS.image1_3 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image1_4 ne null }">
				<input type="file" id="file1_4" name="file1_4" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_4" name="image1_4" value="${requestScope.htmlGoodsSPZS.image1_4 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image1_5 ne null }">
				<input type="file" id="file1_5" name="file1_5" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_5" name="image1_5" value="${requestScope.htmlGoodsSPZS.image1_5 }" />
				</c:if>
			</div>
			<input type="hidden" id="uuid_hid1"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeImage1ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeImage1ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="image2ModBg_div" id="image2ModBg_div">
	<div class="image2Mod_div" id="image2Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage2ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<c:if test="${requestScope.htmlGoodsSPZS.image2_1 ne null||requestScope.htmlGoodsSPZS.image2_2 ne null||requestScope.htmlGoodsSPZS.image2_3 ne null||requestScope.htmlGoodsSPZS.image2_4 ne null }">
				<tr>
					<c:if test="${requestScope.htmlGoodsSPZS.image2_1 ne null }">
					<td class="file_td" id="file_td2_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_1" alt="" src="${requestScope.htmlGoodsSPZS.image2_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image2_2 ne null }">
					<td class="file_td" id="file_td2_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_2" style="width: 120px;height: 120px;" alt="" src="${requestScope.htmlGoodsSPZS.image2_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image2_3 ne null }">
					<td class="file_td" id="file_td2_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_3" style="width: 120px;height: 120px;" alt="" src="${requestScope.htmlGoodsSPZS.image2_3 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image2_4 ne null }">
					<td class="file_td" id="file_td2_4">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_4" style="width: 120px;height: 120px;" alt="" src="${requestScope.htmlGoodsSPZS.image2_4 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image2_5 eq null }">
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage2();">
					</td>
					</c:if>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image2_5 ne null}">
				<tr>
					<c:if test="${requestScope.htmlGoodsSPZS.image2_5 ne null }">
					<td class="file_td" id="file_td2_5">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_5" alt="" src="${requestScope.htmlGoodsSPZS.image2_5 }">
					</td>
					</c:if>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage2();">
					</td>
				</tr>
				</c:if>
			</table>
			<div class="uploadFile2_div" id="uploadFile2_div">
				<c:if test="${requestScope.htmlGoodsSPZS.image2_1 ne null }">
				<input type="file" id="file2_1" name="file2_1" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_1" name="image2_1" value="${requestScope.htmlGoodsSPZS.image2_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image2_2 ne null }">
				<input type="file" id="file2_2" name="file2_2" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_2" name="image2_2" value="${requestScope.htmlGoodsSPZS.image2_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image2_3 ne null }">
				<input type="file" id="file2_3" name="file2_3" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_3" name="image2_3" value="${requestScope.htmlGoodsSPZS.image2_3 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image2_4 ne null }">
				<input type="file" id="file2_4" name="file2_4" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_4" name="image2_4" value="${requestScope.htmlGoodsSPZS.image2_4 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image2_5 ne null }">
				<input type="file" id="file2_5" name="file2_5" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_5" name="image2_5" value="${requestScope.htmlGoodsSPZS.image2_5 }" />
				</c:if>
			</div>
			<input type="hidden" id="uuid_hid2"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeImage2ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeImage2ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="embed1ModBg_div" id="embed1ModBg_div">
	<div class="embed1Mod_div" id="embed1Mod_div">
		<div class="title_div">
			<span class="title_span">视频模块</span>
			<span class="close_span" onclick="closeEmbed1ModBgDiv();">关闭</span>
		</div>
		<div>
			<div class="embedShow_div" id="embedShow_div">
				<embed class="item_embed" id="embed1_1" alt="" src="${requestScope.htmlGoodsSPZS.embed1_1 }">
			</div>
			<div class="reupload_div" onclick="uploadEmbed1();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">重新上传</div>
			<div class="uploadFile3_div" id="uploadFile3_div">
				<c:if test="${requestScope.htmlGoodsSPZS.embed1_1 ne null }">
				<input type="file" id="file3_1" name="file3_1" onchange="showQrcodeEmbed1(this)" />
				<input type="text" id="embed1_1" name="embed1_1" value="${requestScope.htmlGoodsSPZS.embed1_1 }" />
				</c:if>
			</div>
			<input type="hidden" id="uuid_hid1"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeEmbed1ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeEmbed1ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">说明书-案例</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div class="image1_div" id="image1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsSPZS.image1_1 ne null }">
			<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsSPZS.image1_1 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image1_2 ne null }">
			<img class="item_img" id="img1_2" alt="" src="${requestScope.htmlGoodsSPZS.image1_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image1_3 ne null }">
			<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsSPZS.image1_3 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image1_4 ne null }">
			<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsSPZS.image1_4 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image1_5 ne null }">
			<img class="item_img" id="img1_5" alt="" src="${requestScope.htmlGoodsSPZS.image1_5 }">
			</c:if>
		</div>
	</div>
	<div class="productName_div">
		<input type="text" class="productName_input" id="productName" name="productName" placeholder="请输入标题" value="${requestScope.htmlGoodsSPZS.productName }"/>
	</div>
	<div class="memo1_div">
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsSPZS.getMemo1()) %></textarea>
	</div>
	<div class="spxq_div" id="spxq_div">
		<table class="spxq_tab" id="spxq_tab">
			<tr class="item_tr" id="tr1" height="50">
				<input type="hidden" name="spxqName1" value="${requestScope.htmlGoodsSPZS.spxqName1 }" />
				<td class="name_td">${requestScope.htmlGoodsSPZS.spxqName1 }</td>
				<td class="value_td">
					<input type="text" name="spxqValue1" value="${requestScope.htmlGoodsSPZS.spxqValue1 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow1" name="spxqIfShow1" value="${requestScope.htmlGoodsSPZS.spxqIfShow1 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSPZS.spxqIfShow1?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(1,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr2" height="50">
				<input type="hidden" name="spxqName2" value="${requestScope.htmlGoodsSPZS.spxqName2 }" />
				<td class="name_td">${requestScope.htmlGoodsSPZS.spxqName2 }</td>
				<td class="value_td">
					<input type="text" name="spxqValue2" value="${requestScope.htmlGoodsSPZS.spxqValue2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow2" name="spxqIfShow2" value="${requestScope.htmlGoodsSPZS.spxqIfShow2 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSPZS.spxqIfShow2?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(2,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr3" height="50">
				<input type="hidden" name="spxqName3" value="${requestScope.htmlGoodsSPZS.spxqName3 }" />
				<td class="name_td">${requestScope.htmlGoodsSPZS.spxqName3 }</td>
				<td class="value_td">
					<input type="text" name="spxqValue3" value="${requestScope.htmlGoodsSPZS.spxqValue3 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow3" name="spxqIfShow3" value="${requestScope.htmlGoodsSPZS.spxqIfShow3 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSPZS.spxqIfShow3?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(3,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr4" height="50">
				<input type="hidden" name="spxqName4" value="${requestScope.htmlGoodsSPZS.spxqName4 }" />
				<td class="name_td">${requestScope.htmlGoodsSPZS.spxqName4 }</td>
				<td class="value_td">
					<input type="text" name="spxqValue4" value="${requestScope.htmlGoodsSPZS.spxqValue4 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow4" name="spxqIfShow4" value="${requestScope.htmlGoodsSPZS.spxqIfShow4 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSPZS.spxqIfShow4?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(4,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr5" height="50">
				<input type="hidden" name="spxqName5" value="${requestScope.htmlGoodsSPZS.spxqName5 }" />
				<td class="name_td">${requestScope.htmlGoodsSPZS.spxqName5 }</td>
				<td class="value_td">
					<input type="text" name="spxqValue5" value="${requestScope.htmlGoodsSPZS.spxqValue5 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow5" name="spxqIfShow5" value="${requestScope.htmlGoodsSPZS.spxqIfShow5 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSPZS.spxqIfShow5?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(5,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr6" height="50">
				<input type="hidden" name="spxqName6" value="${requestScope.htmlGoodsSPZS.spxqName6 }" />
				<td class="name_td">${requestScope.htmlGoodsSPZS.spxqName6 }</td>
				<td class="value_td">
					<input type="text" name="spxqValue6" value="${requestScope.htmlGoodsSPZS.spxqValue6 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow6" name="spxqIfShow6" value="${requestScope.htmlGoodsSPZS.spxqIfShow6 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSPZS.spxqIfShow6?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(6,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr7" height="50">
				<input type="hidden" name="spxqName7" value="${requestScope.htmlGoodsSPZS.spxqName7 }" />
				<td class="name_td">${requestScope.htmlGoodsSPZS.spxqName7 }</td>
				<td class="value_td">
					<input type="text" name="spxqValue7" value="${requestScope.htmlGoodsSPZS.spxqValue7 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow7" name="spxqIfShow7" value="${requestScope.htmlGoodsSPZS.spxqIfShow7 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSPZS.spxqIfShow7?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(7,this)"/>
				</td>
			</tr>
			
		</table>
	</div>
	<div class="memo2_div">
		<textarea class="memo2_ta" id="memo2" name="memo2" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsSPZS.getMemo2()) %></textarea>
	</div>
	<div class="image2_div" id="image2_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage2ModBgDiv();">编辑</a>|
				<a onclick="deleteImage2Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsSPZS.image2_1 ne null }">
			<img class="item_img" id="img2_1" alt="" src="${requestScope.htmlGoodsSPZS.image2_1 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image2_2 ne null }">
			<img class="item_img" id="img2_2" alt="" src="${requestScope.htmlGoodsSPZS.image2_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image2_3 ne null }">
			<img class="item_img" id="img2_3" alt="" src="${requestScope.htmlGoodsSPZS.image2_3 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image2_4 ne null }">
			<img class="item_img" id="img2_4" alt="" src="${requestScope.htmlGoodsSPZS.image2_4 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image2_5 ne null }">
			<img class="item_img" id="img2_5" alt="" src="${requestScope.htmlGoodsSPZS.image2_5 }">
			</c:if>
		</div>
	</div>
	<div class="memo3_div">
		<textarea class="memo3_ta" id="memo3" name="memo3" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsSPZS.getMemo3()) %></textarea>
	</div>
	<div class="embed1_div" id="embed1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openEmbed1ModBgDiv();">编辑</a>|
				<a onclick="deleteEmbed1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsSPZS.embed1_1 ne null }">
			<embed class="item_embed" id="embed1_1" alt="" src="${requestScope.htmlGoodsSPZS.embed1_1 }"/>
			</c:if>
		</div>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsSPZS.qrCode }">
	<div class="preview_div">预览</div>
	<div class="save_div" onclick="saveEditHtmlGoodsSPZS();">保存</div>
	<div class="finishEdit_div" onclick="finishEditHtmlGoodsSPZS();">完成编辑</div>
	<div class="saveStatus_div" id="saveStatus_div"></div>
</div>
	<input type="hidden" id="id" name="id" value="${requestScope.htmlGoodsSPZS.id }" />
	<input type="hidden" id="moduleType" name="moduleType" value="${requestScope.htmlGoodsSPZS.moduleType }" />
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