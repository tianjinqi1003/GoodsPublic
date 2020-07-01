<%@ page import="com.goodsPublic.util.StringUtils"%>
<%@ page import="goodsPublic.entity.HtmlGoodsDMTZL"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	HtmlGoodsDMTZL htmlGoodsDMTZL=(HtmlGoodsDMTZL)request.getAttribute("htmlGoodsDMTZL");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/dmtzl/editModule.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">
var editor1,editor2;
KindEditor.ready(function(K) {
	editor1 = K.create('textarea[name="memo1"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	editor2 = K.create('textarea[name="memo2"]', {
		cssPath : '<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css',
		uploadJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/upload_json.jsp',
		fileManagerJson : '<%=basePath %>/resource/js/kindeditor-4.1.10/jsp/file_manager_json.jsp',
		allowFileManager : true
	});
	prettyPrint();
});

var bodyWidth;
$(function(){
	bodyWidth=$("body").css("width").substring(0,$("body").css("width").length-2);
	var middleDivWidth=$("#middle_div").css("width").substring(0,$("#middle_div").css("width").length-2);
	$("#right_div").css("margin-left",(parseInt(bodyWidth)+parseInt(middleDivWidth))/2+20+"px");

    //这里必须延迟0.1s，等图片加载完再重新设定右边div位置
    setTimeout(function(){
    	resetDivPosition();
    },"1000")
    
	initDefaultHtmlVal();
});

var dpn;
var disArr1=[];
var dm1Html,dm2Html;
function initDefaultHtmlVal(){
	dpn=$("#middle_div #title").val();
	for(var i=0;i<5;i++){
		disArr1[i]="";
		disArr1[i]=$("#image1_div #list_div img[id^='img']").eq(i).attr("src");
	}
	setTimeout(function(){
		dm1Html=editor1.html();
		dm2Html=editor2.html();
	},"1000");
}

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

function previewHtmlGoodsDMTZL(){
	if(!compareHtmlVal()){//这是已经编辑过内容的情况
		saveEdithtmlGoodsDMTZL();
		
		var goodsNumber='${requestScope.htmlGoodsDMTZL.goodsNumber }';
		var accountId='${sessionScope.user.id }';
		$.post("getPreviewHtmlGoods",
			{trade:"dmtzl",goodsNumber:goodsNumber,accountId:accountId},
			function(data){
				console.log("==="+JSON.stringify(data));
				var previewDMTZL=data.previewDMTZL;
				$("#preview_div #title_div").text(previewDMTZL.title);
				
				$("#preview_div #memo1_div").html(previewDMTZL.memo1);
				
				$("#preview_div #memo2_div").html(previewDMTZL.memo2);
				
				var image1_1=previewDMTZL.image1_1;
				if(image1_1==null){
					$("#preview_div #image1_1_img").css("display","none");
					$("#preview_div #image1_1_img").attr("src","");
				}
				else{
					$("#preview_div #image1_1_img").css("display","block");
					$("#preview_div #image1_1_img").attr("src",image1_1);
				}
				
				var image1_2=previewDMTZL.image1_2;
				if(image1_2==null){
					$("#preview_div #image1_2_img").css("display","none");
					$("#preview_div #image1_2_img").attr("src","");
				}
				else{
					$("#preview_div #image1_2_img").css("display","block");
					$("#preview_div #image1_2_img").attr("src",image1_2);
				}
				
				var image1_3=previewDMTZL.image1_3;
				if(image1_3==null){
					$("#preview_div #image1_3_img").css("display","none");
					$("#preview_div #image1_3_img").attr("src","");
				}
				else{
					$("#preview_div #image1_3_img").css("display","block");
					$("#preview_div #image1_3_img").attr("src",image1_3);
				}
				
				var image1_4=previewDMTZL.image1_4;
				if(image1_4==null){
					$("#preview_div #image1_4_img").css("display","none");
					$("#preview_div #image1_4_img").attr("src","");
				}
				else{
					$("#preview_div #image1_4_img").css("display","block");
					$("#preview_div #image1_4_img").attr("src",image1_4);
				}
				
				var image1_5=previewDMTZL.image1_5;
				if(image1_5==null){
					$("#preview_div #image1_5_img").css("display","none");
					$("#preview_div #image1_5_img").attr("src","");
				}
				else{
					$("#preview_div #image1_5_img").css("display","block");
					$("#preview_div #image1_5_img").attr("src",image1_5);
				}
				
				initDefaultHtmlVal();
			}
		,"json");
	}
	else{
		$("#preview_div #title_div").text(dpn);
		
		var image1_1_src=disArr1[0];
		if(image1_1_src==undefined||image1_1_src==""){
			$("#preview_div #image1_div #image1_1_img").css("display","none");
			$("#preview_div #image1_div #image1_1_img").attr("src","");
		}
		else{
			$("#preview_div #image1_div #image1_1_img").css("display","block");
			$("#preview_div #image1_div #image1_1_img").attr("src",image1_1_src);
		}
		
		var image1_2_src=disArr1[1];
		if(image1_2_src==undefined||image1_2_src==""){
			$("#preview_div #image1_div #image1_2_img").css("display","none");
			$("#preview_div #image1_div #image1_2_img").attr("src","");
		}
		else{
			$("#preview_div #image1_div #image1_2_img").css("display","block");
			$("#preview_div #image1_div #image1_2_img").attr("src",image1_2_src);
		}
		
		var image1_3_src=disArr1[2];
		if(image1_3_src==undefined||image1_3_src==""){
			$("#preview_div #image1_div #image1_3_img").css("display","none");
			$("#preview_div #image1_div #image1_3_img").attr("src","");
		}
		else{
			$("#preview_div #image1_div #image1_3_img").css("display","block");
			$("#preview_div #image1_div #image1_3_img").attr("src",image1_3_src);
		}
		
		var image1_4_src=disArr1[3];
		if(image1_4_src==undefined||image1_4_src==""){
			$("#preview_div #image1_div #image1_4_img").css("display","none");
			$("#preview_div #image1_div #image1_4_img").attr("src","");
		}
		else{
			$("#preview_div #image1_div #image1_4_img").css("display","block");
			$("#preview_div #image1_div #image1_4_img").attr("src",image1_4_src);
		}
		
		var image1_5_src=disArr1[4];
		if(image1_5_src==undefined||image1_5_src==""){
			$("#preview_div #image1_div #image1_5_img").css("display","none");
			$("#preview_div #image1_div #image1_5_img").attr("src","");
		}
		else{
			$("#preview_div #image1_div #image1_5_img").css("display","block");
			$("#preview_div #image1_div #image1_5_img").attr("src",image1_5_src);
		}
	}
	openPreviewBgDiv(1);
}

function compareHtmlVal(){
	var flag=true;
	var cpn=$("#middle_div #title").val();
	if(dpn!=cpn){
		flag=false;
		return flag;
	}
	
	var cm1Html=editor1.html();
	if(dm1Html!=cm1Html){
		flag=false;
		return flag;
	}

	var cm2Html=editor2.html();
	if(dm2Html!=cm2Html){
		flag=false;
		return flag;
	}
	
	var cisArr1=[];
	$("#uploadFile1_div input[id^='image']").each(function(i){
		var imgSrc=$(this).val();
		if(disArr1[i]!=imgSrc){
			flag=false;
			return flag;
		}
	});
	
	return flag;
}

function saveEdithtmlGoodsDMTZL(){
	if(checkIfPaid()){
		resetEditorHtml();
		renameFile();
		renameImage();
		
		var formData = new FormData($("#form1")[0]);
		 
		$.ajax({
			type:"post",
			url:"saveEditHtmlGoodsDMTZL",
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

function finishEdithtmlGoodsDMTZL(){
	renameFile();
	renameImage();
	document.getElementById("sub_but").click();
}

function openEmbed1ModBgDiv(){
	$("#embed1ModBg_div").css("display","block");
}

function openImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","block");
}

function deleteEmbed1Div(){
	$("#embed1_div").remove();
	$("#uploadFile2_div input[type='file']").remove();
	$("#uploadFile2_div input[type='text']").remove();
	resetDivPosition();
}

function deleteImage1Div(){
	$("#image1_div").remove();
	$("#uploadFile1_div input[type='file']").remove();
	$("#uploadFile1_div input[type='text']").remove();
	resetDivPosition();
}

function resetEditorHtml(){
	$("#memo1").val(editor1.html());
	$("#memo2").val(editor2.html());
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
}

function renameImage(){
	$("#uploadFile1_div input[type='text']").each(function(i){
		$(this).attr("name","image1_"+(i+1));
		//console.log($(this).attr("name"));
	});
}

function closeEmbed1ModBgDiv(){
	$("#embed1ModBg_div").css("display","none");
}

function closeImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","none");
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

function uploadEmbed1(){
	var uuid=createUUID();
	$("#uuid_hid1").val(uuid);
	$("#uploadFile2_div").html("<input type=\"file\" id=\"uploadFile2_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodeEmbed1(this)\"/>");
	document.getElementById("uploadFile2_inp").click();
}

function uploadImage1(){
	if($("#image1Mod_div table td[class='file_td']").length>=5){
		alert("最多上传5张图片!");
		return false;
	}
	var uuid=createUUID();
	$("#uuid_hid1").val(uuid);
	$("#uploadFile1_div").append("<input type=\"file\" id=\"uploadFile1_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic1(this)\"/>");
	$("#uploadFile1_div").append("<input type=\"text\" id=\"image"+uuid+"\" name=\"image"+uuid+"\" />");
	document.getElementById("uploadFile1_inp").click();
}

function deleteImage(o){
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

function showQrcodeEmbed1(obj){
	var uuid=$("#uuid_hid1").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	
	var embedShowDiv=$("#embed1Mod_div #embedShow_div");
	var embedTag;
	if (!!window.ActiveXObject || "ActiveXObject" in window)
		embedTag="embed";
	else
		embedTag="iframe";
	embedShowDiv.html("<"+embedTag+" class=\"item_embed\" id=\"embed"+uuid+"\" alt=\"\">"
			+fileHtml);

	var $file = $(obj);
    var fileObj = $file[0];
    file=$file;
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $embed = $("#embed"+uuid);

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $embed.attr("src", dataURL);
        
        $("#embed1_div #embed1_1").replaceWith("<"+embedTag+" class=\"item_embed\" id=\"embed1_1\" src=\""+dataURL+"\"/>");
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

function showQrcodePic1(obj){
	var uuid=$("#uuid_hid1").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	var tdHtml="<td class=\"file_td\" id=\"file_td"+uuid+"\" style=\"width: 25%;\">"
				+"<img class=\"delete_img\" alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" onclick=\"deleteImage(this);\">"
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

        //这里必须延迟0.1s，等图片加载完再重新设定右边div位置
        setTimeout(function(){
        	resetDivPosition();
        },"100")
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

function openPreviewBgDiv(flag){
	$("#previewBg_div").css("display",flag==1?"block":"none");
	
	var preDivWidth=$("#preview_div").css("width").substring(0,$("#preview_div").css("width").length-2);
	var preDivHeight=$("#preview_div").css("height").substring(0,$("#preview_div").css("height").length-2);
	$("#smck_div").css("margin-left",(parseInt(bodyWidth)+parseInt(preDivWidth))/2+20+"px");
	$("#smck_div").css("margin-top","-"+(parseInt(preDivHeight))+"px");
	$("#previewBg_div").css("height",(parseInt(preDivHeight)+80)+"px");
}

function goBack(){
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=dmtzl";
}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="finishEditHtmlGoodsDMTZL" onsubmit="return checkIfPaid();" enctype="multipart/form-data">
<div class="embed1ModBg_div" id="embed1ModBg_div">
	<div class="embed1Mod_div" id="embed1Mod_div">
		<div class="title_div">
			<span class="title_span">视频模块</span>
			<span class="close_span" onclick="closeEmbed1ModBgDiv();">关闭</span>
		</div>
		<div>
			<div class="embedShow_div" id="embedShow_div">
				<embed class="item_embed" id="embed1_1" alt="" src="${requestScope.htmlGoodsDMTZL.embed1_1 }">
			</div>
			<div class="reupload_div" onclick="uploadEmbed1();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">重新上传</div>
			<div class="uploadFile2_div" id="uploadFile2_div">
				<c:if test="${requestScope.htmlGoodsDMTZL.embed1_1 ne null }">
				<input type="file" id="file2_1" name="file2_1" onchange="showQrcodeEmbed1(this)" />
				<input type="text" id="embed1_1" name="embed1_1" value="${requestScope.htmlGoodsDMTZL.embed1_1 }" />
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

<div class="image1ModBg_div" id="image1ModBg_div">
	<div class="image1Mod_div" id="image1Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage1ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<c:if test="${requestScope.htmlGoodsDMTZL.image1_1 ne null||requestScope.htmlGoodsDMTZL.image1_2 ne null||requestScope.htmlGoodsDMTZL.image1_3 ne null||requestScope.htmlGoodsDMTZL.image1_4 ne null }">
				<tr>
					<c:if test="${requestScope.htmlGoodsDMTZL.image1_1 ne null }">
					<td class="file_td" id="file_td1_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage(this);">
						<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsDMTZL.image1_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsDMTZL.image1_2 ne null }">
					<td class="file_td" id="file_td1_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage(this);">
						<img class="item_img" id="img1_2" alt="" src="${requestScope.htmlGoodsDMTZL.image1_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsDMTZL.image1_3 ne null }">
					<td class="file_td" id="file_td1_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage(this);">
						<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsDMTZL.image1_3 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsDMTZL.image1_4 ne null }">
					<td class="file_td" id="file_td1_4">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage(this);">
						<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsDMTZL.image1_4 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsDMTZL.image1_5 eq null }">
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
					</c:if>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsDMTZL.image1_5 ne null}">
				<tr>
					<c:if test="${requestScope.htmlGoodsDMTZL.image1_5 ne null }">
					<td class="file_td" id="file_td1_5">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage(this);">
						<img class="item_img" id="img1_5" alt="" src="${requestScope.htmlGoodsDMTZL.image1_5 }">
					</td>
					</c:if>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
				</tr>
				</c:if>
			</table>
			<div class="uploadFile1_div" id="uploadFile1_div">
				<c:if test="${requestScope.htmlGoodsDMTZL.image1_1 ne null }">
				<input type="file" id="file1_1" name="file1_1" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_1" name="image1_1" value="${requestScope.htmlGoodsDMTZL.image1_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsDMTZL.image1_2 ne null }">
				<input type="file" id="file1_2" name="file1_2" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_2" name="image1_2" value="${requestScope.htmlGoodsDMTZL.image1_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsDMTZL.image1_3 ne null }">
				<input type="file" id="file1_3" name="file1_3" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_3" name="image1_3" value="${requestScope.htmlGoodsDMTZL.image1_3 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsDMTZL.image1_4 ne null }">
				<input type="file" id="file1_4" name="file1_4" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_4" name="image1_4" value="${requestScope.htmlGoodsDMTZL.image1_4 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsDMTZL.image1_5 ne null }">
				<input type="file" id="file1_5" name="file1_5" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_5" name="image1_5" value="${requestScope.htmlGoodsDMTZL.image1_5 }" />
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

<div class="previewBg_div" id="previewBg_div">
	<div class="preview_div" id="preview_div">
		<div class="title_div" id="title_div"></div>
		<div class="memo1_div" id="memo1_div">
			${requestScope.htmlGoodsDMTZL.memo1 }
		</div>
		<div class="embed1_div" id="embed1_div">
			<embed class="embed1_1_embed" id="embed1_1_embed" alt="" src="${requestScope.htmlGoodsDMTZL.embed1_1 }"/>
		</div>
		<div class="memo2_div" id="memo2_div">
			${requestScope.htmlGoodsDMTZL.memo2 }
		</div>
		<div class="image1_div"  id="image1_div">
			<img class="image1_1_img" id="image1_1_img" alt="" src="">
			<img class="image1_2_img" id="image1_2_img" alt="" src="">
			<img class="image1_3_img" id="image1_3_img" alt="" src="">
			<img class="image1_4_img" id="image1_4_img" alt="" src="">
			<img class="image1_5_img" id="image1_5_img" alt="" src="">
		</div>
		<div style="width: 100%;height:40px;"></div>
	</div>
	<div class="smck_div" id="smck_div">
		<div class="tiShi_div">手机端实际效果可能存在差异，请扫码查看</div>
		<div class="qrCode_div">
			<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsDMTZL.qrCode }">
		</div>
		<div class="jxbjBut_div" onclick="openPreviewBgDiv(0)">继续编辑</div>
	</div>
</div>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">多媒体资料</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div" style="">
	<div>
		<input class="title_input" type="text" id="title" name="title" placeholder="请输入标题" value="${requestScope.htmlGoodsDMTZL.title }"/>
	</div>
	<div class="memo1_div">
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsDMTZL.getMemo1()) %></textarea>
	</div>
	<div class="embed1_div" id="embed1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openEmbed1ModBgDiv();">编辑</a>|
				<a onclick="deleteEmbed1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsDMTZL.embed1_1 ne null }">
			<embed class="item_embed" id="embed1_1" alt="" src="${requestScope.htmlGoodsDMTZL.embed1_1 }"/>
			</c:if>
		</div>
	</div>
	<div class="memo2_div">
		<textarea class="memo1_ta" id="memo2" name="memo2" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsDMTZL.getMemo2()) %></textarea>
	</div>
	<div class="image1_div" id="image1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsDMTZL.image1_1 ne null }">
			<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsDMTZL.image1_1 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsDMTZL.image1_2 ne null }">
			<img class="item_img" id="img1_2" alt="" src="${requestScope.htmlGoodsDMTZL.image1_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsDMTZL.image1_3 ne null }">
			<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsDMTZL.image1_3 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsDMTZL.image1_4 ne null }">
			<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsDMTZL.image1_4 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsDMTZL.image1_5 ne null }">
			<img class="item_img" id="img1_5" alt="" src="${requestScope.htmlGoodsDMTZL.image1_5 }">
			</c:if>
		</div>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsDMTZL.qrCode }">
	<div class="preview_div" onclick="previewHtmlGoodsDMTZL();">预览</div>
	<div class="save_div" onclick="saveEdithtmlGoodsDMTZL();">保存</div>
	<div class="finishEdit_div" onclick="finishEdithtmlGoodsDMTZL();">完成编辑</div>
	<div class="saveStatus_div" id="saveStatus_div"></div>
</div>
	<input type="hidden" id="id" name="id" value="${requestScope.htmlGoodsDMTZL.id }" />
	<input type="hidden" id="goodsNumber" name="goodsNumber" value="${requestScope.htmlGoodsDMTZL.goodsNumber }" />
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