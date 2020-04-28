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
<link rel="stylesheet" href="<%=basePath %>/resource/css/spzs/redWine/editModule.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">
var editor1,editor2,editor3;
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
	editor3 = K.create('textarea[name="memo3"]', {
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
	var middleDivHeight=$("#middle_div").css("height").substring(0,$("#middle_div").css("height").length-2);
	$("#right_div").css("margin-left",(parseInt(bodyWidth)+parseInt(middleDivWidth))/2+20+"px");
	$("#right_div").css("margin-top","-"+(parseInt(middleDivHeight)+40)+"px");
	
	initDefaultHtmlVal();
});

var dpn;
var disArr1=[];
var disArr2=[];
var disArr3=[];
var dm1Html,dm2Html,dm3Html;
var dSpxqIfShowArr=[];
var dSpxqValueArr=[];
function initDefaultHtmlVal(){
	dpn=$("#productName").val();
	$("#uploadFile1_div input[id^='image']").each(function(i){
		disArr1[i]=$(this).val();
	});
	$("#spxq_tab input[id^='spxqIfShow']").each(function(i){
		dSpxqIfShowArr[i]=$(this).val();
		var spxqValue=$("#spxq_tab input[name^='spxqValue']").eq(i).val();
		//console.log("spxqValue==="+spxqValue);
		dSpxqValueArr[i]=spxqValue;
	});
	$("#uploadFile2_div input[id^='image']").each(function(i){
		disArr2[i]=$(this).val();
	});
	$("#uploadFile3_div input[id^='image']").each(function(i){
		disArr3[i]=$(this).val();
	});
	setTimeout(function(){
		dm1Html=editor1.html();
		dm2Html=editor2.html();
		dm3Html=editor3.html();
		//console.log(dm1Html);
	},"100");
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

function previewHtmlGoodsSPZS(){
	if(!compareHtmlVal()){
		initDefaultHtmlVal();
		saveEditHtmlGoodsSPZS();
		
		var moduleType='${requestScope.htmlGoodsSPZS.moduleType }';
		var goodsNumber='${requestScope.htmlGoodsSPZS.goodsNumber }';
		var accountId='${sessionScope.user.id }';
		$.post("getPreviewHtmlGoods",
			{trade:"spzs",moduleType:moduleType,goodsNumber:goodsNumber,accountId:accountId},
			function(data){
				console.log(data);
				var previewSPZS=data.previewSPZS;
				$("#preview_div #productName_div").text(previewSPZS.productName);
				
				var image1_1=previewSPZS.image1_1;
				if(image1_1==null){
					$("#preview_div #image1_1_img").css("display","none");
					$("#preview_div #image1_1_img").attr("src","");
				}
				else{
					$("#preview_div #image1_1_img").css("display","block");
					$("#preview_div #image1_1_img").attr("src",image1_1);
				}
				
				var image1_2=previewSPZS.image1_2;
				if(image1_2==null){
					$("#preview_div #image1_2_img").css("display","none");
					$("#preview_div #image1_2_img").attr("src","");
				}
				else{
					$("#preview_div #image1_2_img").css("display","block");
					$("#preview_div #image1_2_img").attr("src",image1_2);
				}
				
				var image1_3=previewSPZS.image1_3;
				if(image1_3==null){
					$("#preview_div #image1_3_img").css("display","none");
					$("#preview_div #image1_3_img").attr("src","");
				}
				else{
					$("#preview_div #image1_3_img").css("display","block");
					$("#preview_div #image1_3_img").attr("src",image1_3);
				}
				
				var image1_4=previewSPZS.image1_4;
				if(image1_4==null){
					$("#preview_div #image1_4_img").css("display","none");
					$("#preview_div #image1_4_img").attr("src","");
				}
				else{
					$("#preview_div #image1_4_img").css("display","block");
					$("#preview_div #image1_4_img").attr("src",image1_4);
				}
				
				var image1_5=previewSPZS.image1_5;
				if(image1_5==null){
					$("#preview_div #image1_5_img").css("display","none");
					$("#preview_div #image1_5_img").attr("src","");
				}
				else{
					$("#preview_div #image1_5_img").css("display","block");
					$("#preview_div #image1_5_img").attr("src",image1_5);
				}
				
				var image2_1=previewSPZS.image2_1;
				if(image2_1==null){
					$("#preview_div #image2_1_img").css("display","none");
					$("#preview_div #image2_1_img").attr("src","");
				}
				else{
					$("#preview_div #image2_1_img").css("display","block");
					$("#preview_div #image2_1_img").attr("src",image2_1);
				}
				
				var image2_2=previewSPZS.image2_2;
				if(image2_2==null){
					$("#preview_div #image2_2_img").css("display","none");
					$("#preview_div #image2_2_img").attr("src","");
				}
				else{
					$("#preview_div #image2_2_img").css("display","block");
					$("#preview_div #image2_2_img").attr("src",image2_2);
				}
				
				var image2_3=previewSPZS.image2_3;
				if(image2_3==null){
					$("#preview_div #image2_3_img").css("display","none");
					$("#preview_div #image2_3_img").attr("src","");
				}
				else{
					$("#preview_div #image2_3_img").css("display","block");
					$("#preview_div #image2_3_img").attr("src",image2_3);
				}
				
				var image2_4=previewSPZS.image2_4;
				if(image2_4==null){
					$("#preview_div #image2_4_img").css("display","none");
					$("#preview_div #image2_4_img").attr("src","");
				}
				else{
					$("#preview_div #image2_4_img").css("display","block");
					$("#preview_div #image2_4_img").attr("src",image2_4);
				}
				
				var image2_5=previewSPZS.image2_5;
				if(image2_5==null){
					$("#preview_div #image2_5_img").css("display","none");
					$("#preview_div #image2_5_img").attr("src","");
				}
				else{
					$("#preview_div #image2_5_img").css("display","block");
					$("#preview_div #image2_5_img").attr("src",image2_5);
				}
				
				var image3_1=previewSPZS.image3_1;
				if(image3_1==null){
					$("#preview_div #image3_1_img").css("display","none");
					$("#preview_div #image3_1_img").attr("src","");
				}
				else{
					$("#preview_div #image3_1_img").css("display","block");
					$("#preview_div #image3_1_img").attr("src",image3_1);
				}
				
				var image3_2=previewSPZS.image3_2;
				if(image3_2==null){
					$("#preview_div #image3_2_img").css("display","none");
					$("#preview_div #image3_2_img").attr("src","");
				}
				else{
					$("#preview_div #image3_2_img").css("display","block");
					$("#preview_div #image3_2_img").attr("src",image3_2);
				}
				
				var image3_3=previewSPZS.image3_3;
				if(image3_3==null){
					$("#preview_div #image3_3_img").css("display","none");
					$("#preview_div #image3_3_img").attr("src","");
				}
				else{
					$("#preview_div #image3_3_img").css("display","block");
					$("#preview_div #image3_3_img").attr("src",image3_3);
				}
				
				var image3_4=previewSPZS.image3_4;
				if(image3_4==null){
					$("#preview_div #image3_4_img").css("display","none");
					$("#preview_div #image3_4_img").attr("src","");
				}
				else{
					$("#preview_div #image3_4_img").css("display","block");
					$("#preview_div #image3_4_img").attr("src",image3_4);
				}
				
				var image3_5=previewSPZS.image3_5;
				if(image3_5==null){
					$("#preview_div #image3_5_img").css("display","none");
					$("#preview_div #image3_5_img").attr("src","");
				}
				else{
					$("#preview_div #image3_5_img").css("display","block");
					$("#preview_div #image3_5_img").attr("src",image3_5);
				}
				openPreviewBgDiv(1);
			}
		,"json");
	}
}

function compareHtmlVal(){
	var flag=true;
	var cpn=$("#productName").val();
	if(dpn!=cpn){
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
	
	var cm1Html=editor1.html();
	if(dm1Html!=cm1Html){
		flag=false;
		return flag;
	}

	$("#spxq_tab input[id^='spxqIfShow']").each(function(i){
		var spxqIfShow=$(this).val();
		var spxqValue=$("#spxq_tab input[name^='spxqValue']").eq(i).val();
		if(spxqIfShow!=dSpxqIfShowArr[i]||spxqValue!=dSpxqValueArr[i]){
			flag=false;
			return flag;
		}
	});

	var cm2Html=editor2.html();
	if(dm2Html!=cm2Html){
		flag=false;
		return flag;
	}

	var cisArr2=[];
	$("#uploadFile2_div input[id^='image']").each(function(i){
		var imgSrc=$(this).val();
		if(disArr2[i]!=imgSrc){
			flag=false;
			return flag;
		}
	});

	var cisArr3=[];
	$("#uploadFile3_div input[id^='image']").each(function(i){
		var imgSrc=$(this).val();
		if(disArr3[i]!=imgSrc){
			flag=false;
			return flag;
		}
	});
	
	var cm3Html=editor3.html();
	/*
	console.log("dm3Html==="+dm3Html);
	console.log("cm3Html==="+cm3Html);
	console.log("==="+(dm3Html==cm3Html));
	*/
	if(dm3Html!=cm3Html){
		flag=false;
		return flag;
	}
	return flag;
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

function openImage3ModBgDiv(){
	$("#image3ModBg_div").css("display","block");
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

function deleteImage3Div(){
	$("#image3_div").remove();
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
		$(this).attr("name","image3_"+(i+1));
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

function uploadImage3(){
	var uuid=createUUID();
	$("#uuid_hid3").val(uuid);
	$("#uploadFile3_div").append("<input type=\"file\" id=\"uploadFile3_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic3(this)\"/>");
	$("#uploadFile3_div").append("<input type=\"text\" id=\"image"+uuid+"\" name=\"image"+uuid+"\" />");
	document.getElementById("uploadFile3_inp").click();
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

function deleteImage3(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image3_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
	$("#uploadFile3_div input[type='file'][name='file"+uuid+"']").remove();
	$("#uploadFile3_div input[type='text'][name='image"+uuid+"']").remove();

	var imageTab=$("#image3Mod_div table");
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

function showQrcodePic3(obj){
	var uuid=$("#uuid_hid3").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	var tdHtml="<td class=\"file_td\" id=\"file_td"+uuid+"\">"
				+"<img class=\"delete_img\" alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" onclick=\"deleteImage3(this);\">"
				+"<img class=\"item_img\" id=\"img"+uuid+"\" alt=\"\">"
				+fileHtml
			+"</td>";
	
	var imageTab=$("#image3Mod_div table");
	//var length=imageTab.find("td[id^='file_td']").length;
	var tdLength=imageTab.find("td").length;
    if(tdLength%4==0){
    	var tr=imageTab.find("tr").eq(imageTab.find("tr").length-1);
    	tr.append(tdHtml)
    	imageTab.append("<tr>"+$("#image3Mod_div table #upload_td").prop("outerHTML")+"</tr>");
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
    var $img = $("#image3Mod_div table #img"+uuid);

    if (fileObj && fileObj.files && fileObj.files[0]) {
        dataURL = windowURL.createObjectURL(fileObj.files[0]);
        $img.attr("src", dataURL);

        var listDiv=$("#image3_div #list_div");
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

function openPreviewBgDiv(flag){
	$("#previewBg_div").css("display",flag==1?"block":"none");
	
	var preDivWidth=$("#preview_div").css("width").substring(0,$("#preview_div").css("width").length-2);
	var preDivHeight=$("#preview_div").css("height").substring(0,$("#preview_div").css("height").length-2);
	$("#smck_div").css("margin-left",(parseInt(bodyWidth)+parseInt(preDivWidth))/2+20+"px");
	$("#smck_div").css("margin-top","-"+(parseInt(preDivHeight))+"px");
	$("#previewBg_div").css("height",(parseInt(preDivHeight)+80)+"px");
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

<div class="image3ModBg_div" id="image3ModBg_div">
	<div class="image3Mod_div" id="image3Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage3ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<c:if test="${requestScope.htmlGoodsSPZS.image3_1 ne null||requestScope.htmlGoodsSPZS.image3_2 ne null||requestScope.htmlGoodsSPZS.image3_3 ne null||requestScope.htmlGoodsSPZS.image3_4 ne null }">
				<tr>
					<c:if test="${requestScope.htmlGoodsSPZS.image3_1 ne null }">
					<td class="file_td" id="file_td3_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage3(this);">
						<img class="item_img" id="img3_1" alt="" src="${requestScope.htmlGoodsSPZS.image3_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image3_2 ne null }">
					<td class="file_td" id="file_td3_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage3(this);">
						<img class="item_img" id="img3_2" alt="" src="${requestScope.htmlGoodsSPZS.image3_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image3_3 ne null }">
					<td class="file_td" id="file_td3_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage3(this);">
						<img class="item_img" id="img3_3" alt="" src="${requestScope.htmlGoodsSPZS.image3_3 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image3_4 ne null }">
					<td class="file_td" id="file_td3_4">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage3(this);">
						<img class="item_img" id="img3_4" alt="" src="${requestScope.htmlGoodsSPZS.image3_4 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSPZS.image3_5 eq null }">
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage3();">
					</td>
					</c:if>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image3_5 ne null}">
				<tr>
					<c:if test="${requestScope.htmlGoodsSPZS.image3_5 ne null }">
					<td class="file_td" id="file_td3_5">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage3(this);">
						<img class="item_img" id="img3_5" alt="" src="${requestScope.htmlGoodsSPZS.image3_5 }">
					</td>
					</c:if>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage3();">
					</td>
				</tr>
				</c:if>
			</table>
			<div class="uploadFile3_div" id="uploadFile3_div">
				<c:if test="${requestScope.htmlGoodsSPZS.image3_1 ne null }">
				<input type="file" id="file3_1" name="file3_1" onchange="showQrcodePic3(this)" />
				<input type="text" id="image3_1" name="image3_1" value="${requestScope.htmlGoodsSPZS.image3_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image3_2 ne null }">
				<input type="file" id="file3_2" name="file3_2" onchange="showQrcodePic3(this)" />
				<input type="text" id="image3_2" name="image3_2" value="${requestScope.htmlGoodsSPZS.image3_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image3_3 ne null }">
				<input type="file" id="file3_3" name="file3_3" onchange="showQrcodePic3(this)" />
				<input type="text" id="image3_3" name="image3_3" value="${requestScope.htmlGoodsSPZS.image3_3 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image3_4 ne null }">
				<input type="file" id="file3_4" name="file3_4" onchange="showQrcodePic3(this)" />
				<input type="text" id="image3_4" name="image3_4" value="${requestScope.htmlGoodsSPZS.image3_4 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSPZS.image3_5 ne null }">
				<input type="file" id="file3_5" name="file3_5" onchange="showQrcodePic3(this)" />
				<input type="text" id="image3_5" name="image3_5" value="${requestScope.htmlGoodsSPZS.image3_5 }" />
				</c:if>
			</div>
			<input type="hidden" id="uuid_hid3"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeImage3ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeImage3ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="previewBg_div" id="previewBg_div">
	<div class="preview_div" id="preview_div">
		<div class="productName_div" id="productName_div"></div>
		<div class="image1_div"  id="image1_div">
			<img class="image1_1_img" id="image1_1_img" alt="" src="${requestScope.htmlGoodsSPZS.image1_1 }">
			<img class="image1_2_img" id="image1_2_img" alt="" src="${requestScope.htmlGoodsSPZS.image1_2 }">
			<img class="image1_3_img" id="image1_3_img" alt="" src="${requestScope.htmlGoodsSPZS.image1_3 }">
			<img class="image1_4_img" id="image1_4_img" alt="" src="${requestScope.htmlGoodsSPZS.image1_4 }">
			<img class="image1_5_img" id="image1_5_img" alt="" src="${requestScope.htmlGoodsSPZS.image1_5 }">
		</div>
		<div class="memo1_div">
			${requestScope.htmlGoodsSPZS.memo1 }
		</div>
		
		<div class="spxq_div">
			<table class="spxq_tab" id="spxq_tab">
				<tr height="60">
					<td class="head_td" colspan="2">商品详情</td>
				</tr>
				
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSPZS.spxqName1 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSPZS.spxqValue1 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSPZS.spxqName2 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSPZS.spxqValue2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSPZS.spxqName3 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSPZS.spxqValue3 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSPZS.spxqName4 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSPZS.spxqValue4 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSPZS.spxqName5 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSPZS.spxqValue5 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSPZS.spxqName6 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSPZS.spxqValue6 }
					</td>
				</tr>
			</table>
		</div>
		<div class="memo2_div">
			${requestScope.htmlGoodsSPZS.memo2 }
		</div>
		<div class="image2_div" id="image2_div">
			<img class="image2_1_img" id="image2_1_img" alt="" src="${requestScope.htmlGoodsSPZS.image2_1 }">
			<img class="image2_2_img" id="image2_2_img" alt="" src="${requestScope.htmlGoodsSPZS.image2_2 }">
			<img class="image2_3_img" id="image2_3_img" alt="" src="${requestScope.htmlGoodsSPZS.image2_3 }">
			<img class="image2_4_img" id="image2_4_img" alt="" src="${requestScope.htmlGoodsSPZS.image2_4 }">
			<img class="image2_5_img" id="image2_5_img" alt="" src="${requestScope.htmlGoodsSPZS.image2_5 }">
		</div>
		<div class="image3_div" id="image3_div">
			<img class="image3_1_img" id="image3_1_img" alt="" src="${requestScope.htmlGoodsSPZS.image3_1 }">
			<img class="image3_2_img" id="image3_2_img" alt="" src="${requestScope.htmlGoodsSPZS.image3_2 }">
			<img class="image3_3_img" id="image3_3_img" alt="" src="${requestScope.htmlGoodsSPZS.image3_3 }">
			<img class="image3_4_img" id="image3_4_img" alt="" src="${requestScope.htmlGoodsSPZS.image3_4 }">
			<img class="image3_5_img" id="image3_5_img" alt="" src="${requestScope.htmlGoodsSPZS.image3_5 }">
		</div>
		<div class="memo3_div">
			${requestScope.htmlGoodsSPZS.memo3 }
		</div>
		<div style="width: 100%;height:40px;"></div>
	</div>
	<div class="smck_div" id="smck_div">
		<div class="tiShi_div">手机端实际效果可能存在差异，请扫码查看</div>
		<div class="qrCode_div">
			<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsSPZS.qrCode }">
		</div>
		<div class="jxbjBut_div" onclick="openPreviewBgDiv(0)">继续编辑</div>
	</div>
</div>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">红酒-案例</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div>
		<input type="text" class="productName_input" id="productName" name="productName" placeholder="请输入标题" value="${requestScope.htmlGoodsSPZS.productName }"/>
	</div>
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
	<div class="memo1_div">
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsSPZS.getMemo1()) %></textarea>
	</div>
	<div class="spxq_div" id="spxq_div">
		<table class="spxq_tab" id="spxq_tab">
			<tr class="head_tr">
				<td class="spxq_td" colspan="2">商品详情</td>
				<td class="cz_td">操作</td>
			</tr>
			
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
	<div class="image3_div" id="image3_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage3ModBgDiv();">编辑</a>|
				<a onclick="deleteImage3Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsSPZS.image3_1 ne null }">
			<img class="item_img" id="img3_1" alt="" src="${requestScope.htmlGoodsSPZS.image3_1 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image3_2 ne null }">
			<img class="item_img" id="img3_2" alt="" src="${requestScope.htmlGoodsSPZS.image3_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image3_3 ne null }">
			<img class="item_img" id="img3_3" alt="" src="${requestScope.htmlGoodsSPZS.image3_3 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image3_4 ne null }">
			<img class="item_img" id="img3_4" alt="" src="${requestScope.htmlGoodsSPZS.image3_4 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSPZS.image3_5 ne null }">
			<img class="item_img" id="img3_5" alt="" src="${requestScope.htmlGoodsSPZS.image3_5 }">
			</c:if>
		</div>
	</div>
	<div class="memo3_div">
		<textarea class="memo3_ta" id="memo3" name="memo3" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsSPZS.getMemo3()) %></textarea>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsSPZS.qrCode }">
	<div class="preview_div" onclick="previewHtmlGoodsSPZS();">预览</div>
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