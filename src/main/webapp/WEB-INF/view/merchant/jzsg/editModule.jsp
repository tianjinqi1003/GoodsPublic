<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/css/jzsg/editModule.css" />
<script type="text/javascript">
var bodyWidth;
$(function(){
	bodyWidth=$("body").css("width").substring(0,$("body").css("width").length-2);
	var middleDivWidth=$("#middle_div").css("width").substring(0,$("#middle_div").css("width").length-2);
	$("#right_div").css("margin-left",(parseInt(bodyWidth)+parseInt(middleDivWidth))/2+20+"px");

    //这里必须延迟1s，等图片加载完再重新设定右边div位置
    setTimeout(function(){
    	resetDivPosition();
    },"1000")
    
    initDefaultHtmlVal();
});

var dpn;
var disArr1=[];
var disArr2=[];
var dRyxxIfShowArr=[];
var dRyxxNameArr=[];
var dRyxxValueArr=[];
function initDefaultHtmlVal(){
	dpn=$("#middle_div #title").val();
	for(var i=0;i<5;i++){
		disArr1[i]="";
		disArr1[i]=$("#image1_div #list_div img[id^='img']").eq(i).attr("src");
		console.log("reset"+i+"==="+disArr1[i]);
	}
	$("#ryxx_tab input[id^='ryxxIfShow']").each(function(i){
		dRyxxIfShowArr[i]=$(this).val();
		var spxqName=$("#ryxx_tab input[name^='ryxxName']").eq(i).val();
		dRyxxNameArr[i]=spxqName;
		var spxqValue=$("#ryxx_tab input[name^='ryxxValue']").eq(i).val();
		//console.log("spxqValue==="+spxqValue);
		dRyxxValueArr[i]=spxqValue;
	});
	$("#uploadFile2_div input[id^='image']").each(function(i){
		disArr2[i]=$(this).val();
	});
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

function previewhtmlGoodsJZSG(){
	if(!compareHtmlVal()){//这是已经编辑过内容的情况
		saveEditHtmlGoodsJZSG();
		
		var userNumber='${requestScope.htmlGoodsJZSG.userNumber }';
		var accountId='${sessionScope.user.id }';
		$.post("getPreviewHtmlGoods",
			{trade:"jzsg",userNumber:userNumber,accountId:accountId},
			function(data){
				console.log(data);
				var previewJZSG=data.previewJZSG;
				$("#preview_div #title_div").text(previewJZSG.title);
				
				var image1_1=previewJZSG.image1_1;
				if(image1_1==null){
					$("#preview_div #image1_1_img").css("display","none");
					$("#preview_div #image1_1_img").attr("src","");
				}
				else{
					$("#preview_div #image1_1_img").css("display","block");
					$("#preview_div #image1_1_img").attr("src",image1_1);
				}
				
				var image1_2=previewJZSG.image1_2;
				if(image1_2==null){
					$("#preview_div #image1_2_img").css("display","none");
					$("#preview_div #image1_2_img").attr("src","");
				}
				else{
					$("#preview_div #image1_2_img").css("display","block");
					$("#preview_div #image1_2_img").attr("src",image1_2);
				}
				
				var image1_3=previewJZSG.image1_3;
				if(image1_3==null){
					$("#preview_div #image1_3_img").css("display","none");
					$("#preview_div #image1_3_img").attr("src","");
				}
				else{
					$("#preview_div #image1_3_img").css("display","block");
					$("#preview_div #image1_3_img").attr("src",image1_3);
				}
				
				var trs=$("#preview_div #ryxx_tab tr");
				
				var tr=trs.eq(1);
				if(previewJZSG.ryxxIfShow1)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				var tds=trs.eq(1).find("td");
				tds.eq(0).text(previewJZSG.ryxxName1);
				tds.eq(1).text(previewJZSG.ryxxValue1);
				
				tr=trs.eq(2);
				if(previewJZSG.ryxxIfShow2)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName2);
				tds.eq(1).text(previewJZSG.ryxxValue2);
				
				tr=trs.eq(3);
				if(previewJZSG.ryxxIfShow3)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName3);
				tds.eq(1).text(previewJZSG.ryxxValue3);
				
				tr=trs.eq(4);
				if(previewJZSG.ryxxIfShow4)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName4);
				tds.eq(1).text(previewJZSG.ryxxValue4);
				
				tr=trs.eq(5);
				if(previewJZSG.ryxxIfShow5)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName5);
				tds.eq(1).text(previewJZSG.ryxxValue5);
				
				tr=trs.eq(6);
				if(previewJZSG.ryxxIfShow6)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName6);
				tds.eq(1).text(previewJZSG.ryxxValue6);
				
				tr=trs.eq(7);
				if(previewJZSG.ryxxIfShow7)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName7);
				tds.eq(1).text(previewJZSG.ryxxValue7);
				
				tr=trs.eq(8);
				if(previewJZSG.ryxxIfShow8)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName8);
				tds.eq(1).text(previewJZSG.ryxxValue8);
				
				tr=trs.eq(9);
				if(previewJZSG.ryxxIfShow9)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName9);
				tds.eq(1).text(previewJZSG.ryxxValue9);
				
				tr=trs.eq(10);
				if(previewJZSG.ryxxIfShow10)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName10);
				tds.eq(1).text(previewJZSG.ryxxValue10);
				
				tr=trs.eq(11);
				if(previewJZSG.ryxxIfShow11)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName11);
				tds.eq(1).text(previewJZSG.ryxxValue11);
				
				tr=trs.eq(12);
				if(previewJZSG.ryxxIfShow12)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName12);
				tds.eq(1).text(previewJZSG.ryxxValue12);
				
				tr=trs.eq(13);
				if(previewJZSG.ryxxIfShow13)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName13);
				tds.eq(1).text(previewJZSG.ryxxValue13);
				
				tr=trs.eq(14);
				if(previewJZSG.ryxxIfShow14)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName14);
				tds.eq(1).text(previewJZSG.ryxxValue14);
				
				tr=trs.eq(15);
				if(previewJZSG.ryxxIfShow15)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewJZSG.ryxxName15);
				tds.eq(1).text(previewJZSG.ryxxValue15);
				
				var image2_1=previewJZSG.image2_1;
				if(image2_1==null){
					$("#preview_div #image2_1_img").css("display","none");
					$("#preview_div #image2_1_img").attr("src","");
				}
				else{
					$("#preview_div #image2_1_img").css("display","block");
					$("#preview_div #image2_1_img").attr("src",image2_1);
				}
				
				var image2_2=previewJZSG.image2_2;
				if(image2_2==null){
					$("#preview_div #image2_2_img").css("display","none");
					$("#preview_div #image2_2_img").attr("src","");
				}
				else{
					$("#preview_div #image2_2_img").css("display","block");
					$("#preview_div #image2_2_img").attr("src",image2_2);
				}
				
				var image2_3=previewJZSG.image2_3;
				if(image2_3==null){
					$("#preview_div #image2_3_img").css("display","none");
					$("#preview_div #image2_3_img").attr("src","");
				}
				else{
					$("#preview_div #image2_3_img").css("display","block");
					$("#preview_div #image2_3_img").attr("src",image2_3);
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
		
		var trs=$("#preview_div #ryxx_tab tr");
		
		for(var i=0;i<dRyxxIfShowArr.length;i++){
			var tr=trs.eq(i+1);
			if(dRyxxIfShowArr[i]=="true")
				tr.css("display","table-row");
			else
				tr.css("display","none");
		}
		
		var image2_1_src=disArr2[0];
		if(image2_1_src==undefined||image2_1_src==""){
			$("#preview_div #image2_div #image2_1_img").css("display","none");
			$("#preview_div #image2_div #image2_1_img").attr("src","");
		}
		else{
			$("#preview_div #image2_div #image2_1_img").css("display","block");
			$("#preview_div #image2_div #image2_1_img").attr("src",image2_1_src);
		}
		
		var image2_2_src=disArr2[1];
		if(image2_2_src==undefined||image2_2_src==""){
			$("#preview_div #image2_div #image2_2_img").css("display","none");
			$("#preview_div #image2_div #image2_2_img").attr("src","");
		}
		else{
			$("#preview_div #image2_div #image2_2_img").css("display","block");
			$("#preview_div #image2_div #image2_2_img").attr("src",image2_2_src);
		}
		
		var image2_3_src=disArr2[2];
		if(image2_3_src==undefined||image2_3_src==""){
			$("#preview_div #image2_div #image2_3_img").css("display","none");
			$("#preview_div #image2_div #image2_3_img").attr("src","");
		}
		else{
			$("#preview_div #image2_div #image2_3_img").css("display","block");
			$("#preview_div #image2_div #image2_3_img").attr("src",image2_3_src);
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
	
	var cisArr1=[];
	$("#uploadFile1_div input[id^='image']").each(function(i){
		var imgSrc=$(this).val();
		if(disArr1[i]!=imgSrc){
			flag=false;
			return flag;
		}
	});

	$("#ryxx_tab input[id^='ryxxIfShow']").each(function(i){
		var ryxxIfShow=$(this).val();
		var ryxxName=$("#ryxx_tab input[name^='ryxxName']").eq(i).val();
		var ryxxValue=$("#ryxx_tab input[name^='ryxxValue']").eq(i).val();
		if(ryxxIfShow!=dRyxxIfShowArr[i]||ryxxName!=dRyxxNameArr[i]||ryxxValue!=dRyxxValueArr[i]){
			flag=false;
			return flag;
		}
	});

	var cisArr2=[];
	$("#uploadFile2_div input[id^='image']").each(function(i){
		var imgSrc=$(this).val();
		if(disArr2[i]!=imgSrc){
			flag=false;
			return flag;
		}
	});
	
	return flag;
}

function saveEditHtmlGoodsJZSG(){
	if(checkIfPaid()){
		renameFile();
		renameImage();
		
		var formData = new FormData($("#form1")[0]);
		 
		$.ajax({
			type:"post",
			url:"saveEditHtmlGoodsJZSG",
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

function finishEditHtmlGoodsJZSG(){
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
	$("#uploadFile2_div input[type='text']").each(function(i){
		$(this).attr("name","image2_"+(i+1));
		//console.log($(this).attr("name"));
	});
}

function closeImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","none");
}

function closeImage2ModBgDiv(){
	$("#image2ModBg_div").css("display","none");
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
	if($("#image1Mod_div table td[class='file_td']").length>=3){
		alert("最多上传3张图片!");
		return false;
	}
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
	
	var imageTab=$("#image1Mod_div table");
	var length=imageTab.find("td[id^='file_td']").length;
	imageTab.find("#upload_td").before("<td class=\"file_td\" id=\"file_td"+uuid+"\" style=\"width: 25%;\">"
			+"<img class=\"delete_img\" alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" onclick=\"deleteImage1(this);\">"
			+"<img class=\"item_img\" id=\"img"+uuid+"\" alt=\"\">"
			+fileHtml
		+"</td>");

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
	imageTab.find("#upload_td").before("<td id=\"file_td"+uuid+"\" style=\"width: 25%;\">"
			+"<img class=\"delete_img\" alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" onclick=\"deleteImage2(this);\">"
			+"<img class=\"item_img\" id=\"img"+uuid+"\" alt=\"\">"
			+fileHtml
		+"</td>");

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

function changeRYXXTrIfShow(index,o){
	var ifShow=$("#ryxxIfShow"+index).val();
	if(ifShow=="true"){
		$("#ryxxIfShow"+index).val(false);
		$(o).val("隐藏");
	}
	else{
		$("#ryxxIfShow"+index).val(true);
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
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=jzsg";
}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="finishEditHtmlGoodsJZSG" onsubmit="return checkIfPaid();" enctype="multipart/form-data">
<div class="image1ModBg_div" id="image1ModBg_div">
	<div class="image1Mod_div" id="image1Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage1ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<tr>
					<c:if test="${requestScope.htmlGoodsJZSG.image1_1 ne null }">
					<td class="file_td" id="file_td1_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsJZSG.image1_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJZSG.image1_2 ne null }">
					<td class="file_td" id="file_td1_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_2" alt="" src="${requestScope.htmlGoodsJZSG.image1_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJZSG.image1_3 ne null }">
					<td class="file_td" id="file_td1_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsJZSG.image1_3 }">
					</td>
					</c:if>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
				</tr>
			</table>
			<div class="uploadFile1_div" id="uploadFile1_div">
				<c:if test="${requestScope.htmlGoodsJZSG.image1_1 ne null }">
				<input type="file" id="file1_1" name="file1_1" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_1" name="image1_1" value="${requestScope.htmlGoodsJZSG.image1_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJZSG.image1_2 ne null }">
				<input type="file" id="file1_2" name="file1_2" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_2" name="image1_2" value="${requestScope.htmlGoodsJZSG.image1_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJZSG.image1_3 ne null }">
				<input type="file" id="file1_3" name="file1_3" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_3" name="image1_3" value="${requestScope.htmlGoodsJZSG.image1_3 }" />
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
				<tr>
					<c:if test="${requestScope.htmlGoodsJZSG.image2_1 ne null }">
					<td class="file_td" id="file_td2_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_1" alt="" src="${requestScope.htmlGoodsJZSG.image2_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJZSG.image2_2 ne null }">
					<td class="file_td" id="file_td2_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_2" alt="" src="${requestScope.htmlGoodsJZSG.image2_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsJZSG.image2_3 ne null }">
					<td class="file_td" id="file_td2_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage2(this);">
						<img class="item_img" id="img2_3" alt="" src="${requestScope.htmlGoodsJZSG.image2_3 }">
					</td>
					</c:if>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage2();">
					</td>
				</tr>
			</table>
			<div class="uploadFile2_div" id="uploadFile2_div">
				<c:if test="${requestScope.htmlGoodsJZSG.image2_1 ne null }">
				<input type="file" id="file2_1" name="file2_1" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_1" name="image2_1" value="${requestScope.htmlGoodsJZSG.image2_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJZSG.image2_2 ne null }">
				<input type="file" id="file2_2" name="file2_2" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_2" name="image2_2" value="${requestScope.htmlGoodsJZSG.image2_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsJZSG.image2_3 ne null }">
				<input type="file" id="file2_3" name="file2_3" onchange="showQrcodePic2(this)" />
				<input type="text" id="image2_3" name="image2_3" value="${requestScope.htmlGoodsJZSG.image2_3 }" />
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

<div class="previewBg_div" id="previewBg_div">
	<div class="preview_div" id="preview_div">
		<div class="title_div" id="title_div"></div>
		<div class="image1_div"  id="image1_div">
			<img class="image1_1_img" id="image1_1_img" alt="" src="">
			<img class="image1_2_img" id="image1_2_img" alt="" src="">
			<img class="image1_3_img" id="image1_3_img" alt="" src="">
		</div>
		
		<div class="ryxx_div">
			<table class="ryxx_tab" id="ryxx_tab">
				<tr height="60">
					<td class="head_td" colspan="2">商品详情</td>
				</tr>
				
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName1 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue1 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName2 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName3 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue3 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName4 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue4 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName5 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue5 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName6 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue6 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName7 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue7 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName8 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue8 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName9 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue9 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName10 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue10 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName11 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue11 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName12 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue12 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName13 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue13 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName14 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue14 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsJZSG.ryxxName15 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsJZSG.ryxxValue15 }
					</td>
				</tr>
			</table>
		</div>
		<div class="image2_div" id="image2_div">
			<img class="image2_1_img" id="image2_1_img" alt="" src="${requestScope.htmlGoodsJZSG.image2_1 }">
			<img class="image2_2_img" id="image2_2_img" alt="" src="${requestScope.htmlGoodsJZSG.image2_2 }">
			<img class="image2_3_img" id="image2_3_img" alt="" src="${requestScope.htmlGoodsJZSG.image2_3 }">
		</div>
		<div style="width: 100%;height:40px;"></div>
	</div>
	<div class="smck_div" id="smck_div">
		<div class="tiShi_div">手机端实际效果可能存在差异，请扫码查看</div>
		<div class="qrCode_div">
			<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsJZSG.qrCode }">
		</div>
		<div class="jxbjBut_div" onclick="openPreviewBgDiv(0)">继续编辑</div>
	</div>
</div>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">建筑施工-案例</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div>
		<input type="text" class="title_input" id="title" name="title" placeholder="请输入标题" value="${requestScope.htmlGoodsJZSG.title }"/>
	</div>
	<div class="image1_div" id="image1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsJZSG.image1_1 ne null }">
			<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsJZSG.image1_1 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.image1_2 ne null }">
			<img class="item_img" id="img1_2" alt="" src="${requestScope.htmlGoodsJZSG.image1_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.image1_3 ne null }">
			<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsJZSG.image1_3 }">
			</c:if>
		</div>
	</div>
	<div class="ryxx_div" id="ryxx_div">
		<table class="ryxx_tab" id="ryxx_tab">
			<tr class="item_tr" id="tr1" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName1" value="${requestScope.htmlGoodsJZSG.ryxxName1 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue1" value="${requestScope.htmlGoodsJZSG.ryxxValue1 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow1" name="ryxxIfShow1" value="${requestScope.htmlGoodsJZSG.ryxxIfShow1 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow1?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(1,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr2" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName2" value="${requestScope.htmlGoodsJZSG.ryxxName2 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue2" value="${requestScope.htmlGoodsJZSG.ryxxValue2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow2" name="ryxxIfShow2" value="${requestScope.htmlGoodsJZSG.ryxxIfShow2 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow2?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(2,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr3" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName3" value="${requestScope.htmlGoodsJZSG.ryxxName3 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue3" value="${requestScope.htmlGoodsJZSG.ryxxValue3 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow3" name="ryxxIfShow3" value="${requestScope.htmlGoodsJZSG.ryxxIfShow3 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow3?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(3,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr4" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName4" value="${requestScope.htmlGoodsJZSG.ryxxName4 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue4" value="${requestScope.htmlGoodsJZSG.ryxxValue4 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow4" name="ryxxIfShow4" value="${requestScope.htmlGoodsJZSG.ryxxIfShow4 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow4?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(4,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr5" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName5" value="${requestScope.htmlGoodsJZSG.ryxxName5 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue5" value="${requestScope.htmlGoodsJZSG.ryxxValue5 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow5" name="ryxxIfShow5" value="${requestScope.htmlGoodsJZSG.ryxxIfShow5 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow5?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(5,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr6" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName6" value="${requestScope.htmlGoodsJZSG.ryxxName6 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue6" value="${requestScope.htmlGoodsJZSG.ryxxValue6 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow6" name="ryxxIfShow6" value="${requestScope.htmlGoodsJZSG.ryxxIfShow6 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow6?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(6,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr7" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName7" value="${requestScope.htmlGoodsJZSG.ryxxName7 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue7" value="${requestScope.htmlGoodsJZSG.ryxxValue7 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow7" name="ryxxIfShow7" value="${requestScope.htmlGoodsJZSG.ryxxIfShow7 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow7?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(7,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr8" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName8" value="${requestScope.htmlGoodsJZSG.ryxxName8 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue8" value="${requestScope.htmlGoodsJZSG.ryxxValue8 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow8" name="ryxxIfShow8" value="${requestScope.htmlGoodsJZSG.ryxxIfShow8 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow8?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(8,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr9" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName9" value="${requestScope.htmlGoodsJZSG.ryxxName9 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue9" value="${requestScope.htmlGoodsJZSG.ryxxValue9 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow9" name="ryxxIfShow9" value="${requestScope.htmlGoodsJZSG.ryxxIfShow9 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow9?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(9,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr10" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName10" value="${requestScope.htmlGoodsJZSG.ryxxName10 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue10" value="${requestScope.htmlGoodsJZSG.ryxxValue10 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow10" name="ryxxIfShow10" value="${requestScope.htmlGoodsJZSG.ryxxIfShow10 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow10?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(10,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr11" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName11" value="${requestScope.htmlGoodsJZSG.ryxxName11 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue11" value="${requestScope.htmlGoodsJZSG.ryxxValue11 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow11" name="ryxxIfShow11" value="${requestScope.htmlGoodsJZSG.ryxxIfShow11 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow11?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(11,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr12" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName12" value="${requestScope.htmlGoodsJZSG.ryxxName12 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue12" value="${requestScope.htmlGoodsJZSG.ryxxValue12 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow12" name="ryxxIfShow12" value="${requestScope.htmlGoodsJZSG.ryxxIfShow12 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow12?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(12,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr13" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName13" value="${requestScope.htmlGoodsJZSG.ryxxName13 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue13" value="${requestScope.htmlGoodsJZSG.ryxxValue13 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow13" name="ryxxIfShow13" value="${requestScope.htmlGoodsJZSG.ryxxIfShow13 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow13?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(13,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr14" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName14" value="${requestScope.htmlGoodsJZSG.ryxxName14 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue14" value="${requestScope.htmlGoodsJZSG.ryxxValue14 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow14" name="ryxxIfShow14" value="${requestScope.htmlGoodsJZSG.ryxxIfShow14 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow14?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(14,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr15" height="50">
				<td class="name_td">
					<input type="text" name="ryxxName15" value="${requestScope.htmlGoodsJZSG.ryxxName15 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="ryxxValue15" value="${requestScope.htmlGoodsJZSG.ryxxValue15 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow15" name="ryxxIfShow15" value="${requestScope.htmlGoodsJZSG.ryxxIfShow15 }" />
					<input type="button" class="ryxxIfShow_inp" value="${requestScope.htmlGoodsJZSG.ryxxIfShow15?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(15,this)"/>
				</td>
			</tr>
			
		</table>
	</div>
	<div class="image2_div" id="image2_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage2ModBgDiv();">编辑</a>|
				<a onclick="deleteImage2Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsJZSG.image2_1 ne null }">
			<img class="item_img" id="img2_1" alt="" src="${requestScope.htmlGoodsJZSG.image2_1 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.image2_2 ne null }">
			<img class="item_img" id="img2_2" alt="" src="${requestScope.htmlGoodsJZSG.image2_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.image2_3 ne null }">
			<img class="item_img" id="img2_3" alt="" src="${requestScope.htmlGoodsJZSG.image2_3 }">
			</c:if>
		</div>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsJZSG.qrCode }">
	<div class="preview_div" onclick="previewhtmlGoodsJZSG();">预览</div>
	<div class="save_div" onclick="saveEditHtmlGoodsJZSG();">保存</div>
	<div class="finishEdit_div" onclick="finishEditHtmlGoodsJZSG();">完成编辑</div>
	<div class="saveStatus_div" id="saveStatus_div"></div>
</div>
	<input type="hidden" id="id" name="id" value="${requestScope.htmlGoodsJZSG.id }" />
	<input type="hidden" id="userNumber" name="userNumber" value="${requestScope.htmlGoodsJZSG.userNumber }" />
	<input type="hidden" id="accountNumber_hid" name="accountNumber" value="${sessionScope.user.id }" />
	<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
</form>
</body>
</html>