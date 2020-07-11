<%@ page import="com.goodsPublic.util.StringUtils"%>
<%@ page import="goodsPublic.entity.HtmlGoodsSMYL"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	HtmlGoodsSMYL htmlGoodsSMYL=(HtmlGoodsSMYL)request.getAttribute("htmlGoodsSMYL");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/smyl/editModule.css" />
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

    //这里必须延迟1s，等图片加载完再重新设定右边div位置
    setTimeout(function(){
    	resetDivPosition();
    },"1000")
    
	initDefaultHtmlVal();
});

var dpn;
var disArr1=[];
var dm1Html,dm2Html;
var dSpxqIfShowArr=[];
var dSpxqNameArr=[];
var dSpxqValueArr=[];
function initDefaultHtmlVal(){
	dpn=$("#productName").val();
	for(var i=0;i<5;i++){
		disArr1[i]="";
		disArr1[i]=$("#image1_div #list_div img[id^='img']").eq(i).attr("src");
		console.log("reset"+i+"==="+disArr1[i]);
	}
	console.log(disArr1);
	$("#spxq_tab input[id^='spxqIfShow']").each(function(i){
		dSpxqIfShowArr[i]=$(this).val();
		var spxqName=$("#spxq_tab input[name^='spxqName']").eq(i).val();
		dSpxqNameArr[i]=spxqName;
		var spxqValue=$("#spxq_tab input[name^='spxqValue']").eq(i).val();
		//console.log("spxqValue==="+spxqValue);
		dSpxqValueArr[i]=spxqValue;
	});
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

function previewHtmlGoodsSMYL(){
	if(!compareHtmlVal()){//这是已经编辑过内容的情况
		//return false;
		saveEditHtmlGoodsSMYL();
		
		var goodsNumber='${requestScope.htmlGoodsSMYL.goodsNumber }';
		var accountId='${sessionScope.user.id }';
		$.post("getPreviewHtmlGoods",
			{trade:"smyl",goodsNumber:goodsNumber,accountId:accountId},
			function(data){
				console.log(data);
				var previewSMYL=data.previewSMYL;
				$("#preview_div #productName_div").text(previewSMYL.productName);
				
				var image1_1=previewSMYL.image1_1;
				if(image1_1==null){
					$("#preview_div #image1_1_img").css("display","none");
					$("#preview_div #image1_1_img").attr("src","");
				}
				else{
					$("#preview_div #image1_1_img").css("display","block");
					$("#preview_div #image1_1_img").attr("src",image1_1);
				}
				
				var image1_2=previewSMYL.image1_2;
				if(image1_2==null){
					$("#preview_div #image1_2_img").css("display","none");
					$("#preview_div #image1_2_img").attr("src","");
				}
				else{
					$("#preview_div #image1_2_img").css("display","block");
					$("#preview_div #image1_2_img").attr("src",image1_2);
				}
				
				var image1_3=previewSMYL.image1_3;
				if(image1_3==null){
					$("#preview_div #image1_3_img").css("display","none");
					$("#preview_div #image1_3_img").attr("src","");
				}
				else{
					$("#preview_div #image1_3_img").css("display","block");
					$("#preview_div #image1_3_img").attr("src",image1_3);
				}
				
				var image1_4=previewSMYL.image1_4;
				if(image1_4==null){
					$("#preview_div #image1_4_img").css("display","none");
					$("#preview_div #image1_4_img").attr("src","");
				}
				else{
					$("#preview_div #image1_4_img").css("display","block");
					$("#preview_div #image1_4_img").attr("src",image1_4);
				}
				
				var image1_5=previewSMYL.image1_5;
				if(image1_5==null){
					$("#preview_div #image1_5_img").css("display","none");
					$("#preview_div #image1_5_img").attr("src","");
				}
				else{
					$("#preview_div #image1_5_img").css("display","block");
					$("#preview_div #image1_5_img").attr("src",image1_5);
				}
				
				$("#preview_div #memo1_div").html(previewSMYL.memo1);
				
				var trs=$("#preview_div #spxq_tab tr");
				
				var tr=trs.eq(1);
				if(previewSMYL.spxqIfShow1)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				var tds=trs.eq(1).find("td");
				tds.eq(0).text(previewSMYL.spxqName1);
				tds.eq(1).text(previewSMYL.spxqValue1);
				
				tr=trs.eq(2);
				if(previewSMYL.spxqIfShow2)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName2);
				tds.eq(1).text(previewSMYL.spxqValue2);
				
				tr=trs.eq(3);
				if(previewSMYL.spxqIfShow3)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName3);
				tds.eq(1).text(previewSMYL.spxqValue3);
				
				tr=trs.eq(4);
				if(previewSMYL.spxqIfShow4)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName4);
				tds.eq(1).text(previewSMYL.spxqValue4);
				
				tr=trs.eq(5);
				if(previewSMYL.spxqIfShow5)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName5);
				tds.eq(1).text(previewSMYL.spxqValue5);
				
				tr=trs.eq(6);
				if(previewSMYL.spxqIfShow6)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName6);
				tds.eq(1).text(previewSMYL.spxqValue6);
				
				tr=trs.eq(7);
				if(previewSMYL.spxqIfShow7)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName7);
				tds.eq(1).text(previewSMYL.spxqValue7);
				
				tr=trs.eq(8);
				if(previewSMYL.spxqIfShow8)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName8);
				tds.eq(1).text(previewSMYL.spxqValue8);
				
				tr=trs.eq(9);
				if(previewSMYL.spxqIfShow9)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName9);
				tds.eq(1).text(previewSMYL.spxqValue9);
				
				tr=trs.eq(10);
				if(previewSMYL.spxqIfShow10)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName10);
				tds.eq(1).text(previewSMYL.spxqValue10);
				
				tr=trs.eq(11);
				if(previewSMYL.spxqIfShow11)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName11);
				tds.eq(1).text(previewSMYL.spxqValue11);
				
				tr=trs.eq(12);
				if(previewSMYL.spxqIfShow12)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName12);
				tds.eq(1).text(previewSMYL.spxqValue12);
				
				tr=trs.eq(13);
				if(previewSMYL.spxqIfShow13)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName13);
				tds.eq(1).text(previewSMYL.spxqValue13);
				
				tr=trs.eq(14);
				if(previewSMYL.spxqIfShow14)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName14);
				tds.eq(1).text(previewSMYL.spxqValue14);
				
				tr=trs.eq(15);
				if(previewSMYL.spxqIfShow15)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewSMYL.spxqName15);
				tds.eq(1).text(previewSMYL.spxqValue15);
				
				$("#preview_div #memo2_div").html(previewSMYL.memo2);
				
				initDefaultHtmlVal();
			}
		,"json");
	}
	else{
		$("#preview_div #productName_div").text(dpn);
		
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
		
		var trs=$("#preview_div #spxq_tab tr");
		
		for(var i=0;i<dSpxqIfShowArr.length;i++){
			var tr=trs.eq(i+1);
			if(dSpxqIfShowArr[i]=="true")
				tr.css("display","table-row");
			else
				tr.css("display","none");
		}
	}
	openPreviewBgDiv(1);
}

function compareHtmlVal(){
	var flag=true;
	var cpn=$("#productName").val();
	if(dpn!=cpn){
		flag=false;
		return flag;
	}
	
	var cisArr1=[];
	for(var i=0;i<5;i++){
		var imgSrc=$("#uploadFile1_div input[id^='image']").eq(i).val();
		if(disArr1[i]!=imgSrc){
			flag=false;
			return flag;
		}
	}

	$("#spxq_tab input[id^='spxqIfShow']").each(function(i){
		var spxqIfShow=$(this).val();
		var spxqName=$("#spxq_tab input[name^='spxqName']").eq(i).val();
		var spxqValue=$("#spxq_tab input[name^='spxqValue']").eq(i).val();
		if(spxqIfShow!=dSpxqIfShowArr[i]||spxqName!=dSpxqNameArr[i]||spxqValue!=dSpxqValueArr[i]){
			flag=false;
			return flag;
		}
	});
	
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
	
	return flag;
}

function saveEditHtmlGoodsSMYL(){
	if(checkIfPaid()){
		resetEditorHtml();
		renameFile();
		renameImage();
		
		var formData = new FormData($("#form1")[0]);
		 
		$.ajax({
			type:"post",
			url:"saveEditHtmlGoodsSMYL",
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

function finishEditHtmlGoodsSPZS(){
	renameFile();
	renameImage();
	document.getElementById("sub_but").click();
}

function openImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","block");
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
}

function renameImage(){
	$("#uploadFile1_div input[type='text']").each(function(i){
		$(this).attr("name","image1_"+(i+1));
		//console.log($(this).attr("name"));
	});
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

function uploadImage1(){
	var uuid=createUUID();
	$("#uuid_hid1").val(uuid);
	$("#uploadFile1_div").append("<input type=\"file\" id=\"uploadFile1_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic1(this)\"/>");
	$("#uploadFile1_div").append("<input type=\"text\" id=\"image"+uuid+"\" name=\"image"+uuid+"\" />");
	document.getElementById("uploadFile1_inp").click();
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
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=smyl";
}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="finishEdithtmlGoodsSMYL" onsubmit="return checkIfPaid();" enctype="multipart/form-data">
<div class="image1ModBg_div" id="image1ModBg_div">
	<div class="image1Mod_div" id="image1Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage1ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<c:if test="${requestScope.htmlGoodsSMYL.image1_1 ne null||requestScope.htmlGoodsSMYL.image1_2 ne null||requestScope.htmlGoodsSMYL.image1_3 ne null||requestScope.htmlGoodsSMYL.image1_4 ne null }">
				<tr>
					<c:if test="${requestScope.htmlGoodsSMYL.image1_1 ne null }">
					<td class="file_td" id="file_td1_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsSMYL.image1_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSMYL.image1_2 ne null }">
					<td class="file_td" id="file_td1_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_2"  alt="" src="${requestScope.htmlGoodsSMYL.image1_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSMYL.image1_3 ne null }">
					<td class="file_td" id="file_td1_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsSMYL.image1_3 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSMYL.image1_4 ne null }">
					<td class="file_td" id="file_td1_4">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsSMYL.image1_4 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsSMYL.image1_5 eq null }">
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
					</c:if>
				</tr>
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image1_5 ne null}">
				<tr>
					<c:if test="${requestScope.htmlGoodsSMYL.image1_5 ne null }">
					<td class="file_td" id="file_td1_5">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_5" alt="" src="${requestScope.htmlGoodsSMYL.image1_5 }">
					</td>
					</c:if>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
				</tr>
				</c:if>
			</table>
			<div class="uploadFile1_div" id="uploadFile1_div">
				<c:if test="${requestScope.htmlGoodsSMYL.image1_1 ne null }">
				<input type="file" id="file1_1" name="file1_1" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_1" name="image1_1" value="${requestScope.htmlGoodsSMYL.image1_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image1_2 ne null }">
				<input type="file" id="file1_2" name="file1_2" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_2" name="image1_2" value="${requestScope.htmlGoodsSMYL.image1_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image1_3 ne null }">
				<input type="file" id="file1_3" name="file1_3" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_3" name="image1_3" value="${requestScope.htmlGoodsSMYL.image1_3 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image1_4 ne null }">
				<input type="file" id="file1_4" name="file1_4" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_4" name="image1_4" value="${requestScope.htmlGoodsSMYL.image1_4 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsSMYL.image1_5 ne null }">
				<input type="file" id="file1_5" name="file1_5" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_5" name="image1_5" value="${requestScope.htmlGoodsSMYL.image1_5 }" />
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
		<div class="productName_div" id="productName_div"></div>
		<div class="image1_div"  id="image1_div">
			<img class="image1_1_img" id="image1_1_img" alt="" src="">
			<img class="image1_2_img" id="image1_2_img" alt="" src="">
			<img class="image1_3_img" id="image1_3_img" alt="" src="">
			<img class="image1_4_img" id="image1_4_img" alt="" src="">
			<img class="image1_5_img" id="image1_5_img" alt="" src="">
		</div>
		<div class="spxq_div">
			<table class="spxq_tab" id="spxq_tab">
				<tr height="60">
					<td class="head_td" colspan="2">商品详情</td>
				</tr>
				
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName1 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue1 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName2 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName3 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue3 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName4 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue4 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName5 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue5 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName6 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue6 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName7 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue7 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName8 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue8 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName9 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue9 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName10 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue10 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName11 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue11 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName12 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue12 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName13 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue13 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName14 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue14 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.spxqName15 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.spxqValue15 }
					</td>
				</tr>
			</table>
		</div>
		<div class="memo1_div" id="memo1_div">
			${requestScope.htmlGoodsSMYL.memo1 }
		</div>
		<div class="yhxx_div">
			<table class="yhxx_tab" id="yhxx_tab">
				<tr height="60">
					<td class="head_td" colspan="2">养护信息</td>
				</tr>
				
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName1 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue1 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName2 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName3 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue3 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName4 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue4 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName5 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue5 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName6 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue6 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName7 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue7 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName8 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue8 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName9 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue9 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName10 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue10 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName11 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue11 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName12 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue12 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName13 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue13 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName14 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue14 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsSMYL.yhxxName15 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsSMYL.yhxxValue15 }
					</td>
				</tr>
			</table>
		</div>
		<div class="memo2_div" id="memo2_div">
			${requestScope.htmlGoodsSMYL.memo2 }
		</div>
		<div style="width: 100%;height:40px;"></div>
	</div>
	<div class="smck_div" id="smck_div">
		<div class="tiShi_div">手机端实际效果可能存在差异，请扫码查看</div>
		<div class="qrCode_div">
			<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsSMYL.qrCode }">
		</div>
		<div class="jxbjBut_div" onclick="openPreviewBgDiv(0)">继续编辑</div>
	</div>
</div>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">园林树木-案例</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div>
		<input type="text" class="productName_input" id="productName" name="productName" placeholder="请输入标题" value="${requestScope.htmlGoodsSMYL.productName }"/>
	</div>
	<div class="image1_div" id="image1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsSMYL.image1_1 ne null }">
			<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsSMYL.image1_1 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.image1_2 ne null }">
			<img class="item_img" id="img1_2" alt="" src="${requestScope.htmlGoodsSMYL.image1_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.image1_3 ne null }">
			<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsSMYL.image1_3 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.image1_4 ne null }">
			<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsSMYL.image1_4 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsSMYL.image1_5 ne null }">
			<img class="item_img" id="img1_5" alt="" src="${requestScope.htmlGoodsSMYL.image1_5 }">
			</c:if>
		</div>
	</div>
	<div class="spxq_div" id="spxq_div">
		<table class="spxq_tab" id="spxq_tab">
			<tr class="head_tr">
				<td class="spxq_td" colspan="2">商品详情</td>
				<td class="cz_td">操作</td>
			</tr>
			
			<tr class="item_tr" id="tr1" height="50">
				<td class="name_td">
					<input type="text" name="spxqName1" value="${requestScope.htmlGoodsSMYL.spxqName1 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue1" value="${requestScope.htmlGoodsSMYL.spxqValue1 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow1" name="spxqIfShow1" value="${requestScope.htmlGoodsSMYL.spxqIfShow1 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow1?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(1,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr2" height="50">
				<td class="name_td">
					<input type="text" name="spxqName2" value="${requestScope.htmlGoodsSMYL.spxqName2 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue2" value="${requestScope.htmlGoodsSMYL.spxqValue2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow2" name="spxqIfShow2" value="${requestScope.htmlGoodsSMYL.spxqIfShow2 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow2?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(2,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr3" height="50">
				<td class="name_td">
					<input type="text" name="spxqName3" value="${requestScope.htmlGoodsSMYL.spxqName3 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue3" value="${requestScope.htmlGoodsSMYL.spxqValue3 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow3" name="spxqIfShow3" value="${requestScope.htmlGoodsSMYL.spxqIfShow3 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow3?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(3,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr4" height="50">
				<td class="name_td">
					<input type="text" name="spxqName4" value="${requestScope.htmlGoodsSMYL.spxqName4 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue4" value="${requestScope.htmlGoodsSMYL.spxqValue4 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow4" name="spxqIfShow4" value="${requestScope.htmlGoodsSMYL.spxqIfShow4 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow4?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(4,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr5" height="50">
				<td class="name_td">
					<input type="text" name="spxqName5" value="${requestScope.htmlGoodsSMYL.spxqName5 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue5" value="${requestScope.htmlGoodsSMYL.spxqValue5 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow5" name="spxqIfShow5" value="${requestScope.htmlGoodsSMYL.spxqIfShow5 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow5?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(5,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr6" height="50">
				<td class="name_td">
					<input type="text" name="spxqName6" value="${requestScope.htmlGoodsSMYL.spxqName6 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue6" value="${requestScope.htmlGoodsSMYL.spxqValue6 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow6" name="spxqIfShow6" value="${requestScope.htmlGoodsSMYL.spxqIfShow6 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow6?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(6,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr7" height="50">
				<td class="name_td">
					<input type="text" name="spxqName7" value="${requestScope.htmlGoodsSMYL.spxqName7 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue7" value="${requestScope.htmlGoodsSMYL.spxqValue7 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow7" name="spxqIfShow7" value="${requestScope.htmlGoodsSMYL.spxqIfShow7 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow7?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(7,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr8" height="50">
				<td class="name_td">
					<input type="text" name="spxqName8" value="${requestScope.htmlGoodsSMYL.spxqName8 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue8" value="${requestScope.htmlGoodsSMYL.spxqValue8 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow8" name="spxqIfShow8" value="${requestScope.htmlGoodsSMYL.spxqIfShow8 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow8?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(8,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr9" height="50">
				<td class="name_td">
					<input type="text" name="spxqName9" value="${requestScope.htmlGoodsSMYL.spxqName9 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue9" value="${requestScope.htmlGoodsSMYL.spxqValue9 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow9" name="spxqIfShow9" value="${requestScope.htmlGoodsSMYL.spxqIfShow9 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow9?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(9,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr10" height="50">
				<td class="name_td">
					<input type="text" name="spxqName10" value="${requestScope.htmlGoodsSMYL.spxqName10 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue10" value="${requestScope.htmlGoodsSMYL.spxqValue10 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow10" name="spxqIfShow10" value="${requestScope.htmlGoodsSMYL.spxqIfShow10 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow10?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(10,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr11" height="50">
				<td class="name_td">
					<input type="text" name="spxqName11" value="${requestScope.htmlGoodsSMYL.spxqName11 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue11" value="${requestScope.htmlGoodsSMYL.spxqValue11 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow11" name="spxqIfShow11" value="${requestScope.htmlGoodsSMYL.spxqIfShow11 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow11?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(11,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr12" height="50">
				<td class="name_td">
					<input type="text" name="spxqName12" value="${requestScope.htmlGoodsSMYL.spxqName12 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue12" value="${requestScope.htmlGoodsSMYL.spxqValue12 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow12" name="spxqIfShow12" value="${requestScope.htmlGoodsSMYL.spxqIfShow12 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow12?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(12,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr13" height="50">
				<td class="name_td">
					<input type="text" name="spxqName13" value="${requestScope.htmlGoodsSMYL.spxqName13 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue13" value="${requestScope.htmlGoodsSMYL.spxqValue13 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow13" name="spxqIfShow13" value="${requestScope.htmlGoodsSMYL.spxqIfShow13 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow13?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(13,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr14" height="50">
				<td class="name_td">
					<input type="text" name="spxqName14" value="${requestScope.htmlGoodsSMYL.spxqName14 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue14" value="${requestScope.htmlGoodsSMYL.spxqValue14 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow14" name="spxqIfShow14" value="${requestScope.htmlGoodsSMYL.spxqIfShow14 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow14?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(14,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr15" height="50">
				<td class="name_td">
					<input type="text" name="spxqName15" value="${requestScope.htmlGoodsSMYL.spxqName15 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue15" value="${requestScope.htmlGoodsSMYL.spxqValue15 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow15" name="spxqIfShow15" value="${requestScope.htmlGoodsSMYL.spxqIfShow15 }" />
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsSMYL.spxqIfShow15?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(15,this)"/>
				</td>
			</tr>
			
		</table>
	</div>
	<div class="memo1_div">
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsSMYL.getMemo1()) %></textarea>
	</div>
	<div class="yhxx_div" id="yhxx_div">
		<table class="yhxx_tab" id="yhxx_tab">
			<tr class="head_tr">
				<td class="yhxx_td" colspan="2">商品详情</td>
				<td class="cz_td">操作</td>
			</tr>
			
			<tr class="item_tr" id="tr1" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName1" value="${requestScope.htmlGoodsSMYL.yhxxName1 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue1" value="${requestScope.htmlGoodsSMYL.yhxxValue1 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow1" name="yhxxIfShow1" value="${requestScope.htmlGoodsSMYL.yhxxIfShow1 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow1?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(1,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr2" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName2" value="${requestScope.htmlGoodsSMYL.yhxxName2 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue2" value="${requestScope.htmlGoodsSMYL.yhxxValue2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow2" name="yhxxIfShow2" value="${requestScope.htmlGoodsSMYL.yhxxIfShow2 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow2?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(2,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr3" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName3" value="${requestScope.htmlGoodsSMYL.yhxxName3 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue3" value="${requestScope.htmlGoodsSMYL.yhxxValue3 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow3" name="yhxxIfShow3" value="${requestScope.htmlGoodsSMYL.yhxxIfShow3 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow3?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(3,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr4" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName4" value="${requestScope.htmlGoodsSMYL.yhxxName4 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue4" value="${requestScope.htmlGoodsSMYL.yhxxValue4 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow4" name="yhxxIfShow4" value="${requestScope.htmlGoodsSMYL.yhxxIfShow4 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow4?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(4,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr5" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName5" value="${requestScope.htmlGoodsSMYL.yhxxName5 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue5" value="${requestScope.htmlGoodsSMYL.yhxxValue5 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow5" name="yhxxIfShow5" value="${requestScope.htmlGoodsSMYL.yhxxIfShow5 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow5?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(5,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr6" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName6" value="${requestScope.htmlGoodsSMYL.yhxxName6 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue6" value="${requestScope.htmlGoodsSMYL.yhxxValue6 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow6" name="yhxxIfShow6" value="${requestScope.htmlGoodsSMYL.yhxxIfShow6 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow6?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(6,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr7" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName7" value="${requestScope.htmlGoodsSMYL.yhxxName7 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue7" value="${requestScope.htmlGoodsSMYL.yhxxValue7 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow7" name="yhxxIfShow7" value="${requestScope.htmlGoodsSMYL.yhxxIfShow7 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow7?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(7,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr8" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName8" value="${requestScope.htmlGoodsSMYL.yhxxName8 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue8" value="${requestScope.htmlGoodsSMYL.yhxxValue8 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow8" name="yhxxIfShow8" value="${requestScope.htmlGoodsSMYL.yhxxIfShow8 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow8?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(8,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr9" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName9" value="${requestScope.htmlGoodsSMYL.yhxxName9 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue9" value="${requestScope.htmlGoodsSMYL.yhxxValue9 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow9" name="yhxxIfShow9" value="${requestScope.htmlGoodsSMYL.yhxxIfShow9 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow9?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(9,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr10" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName10" value="${requestScope.htmlGoodsSMYL.yhxxName10 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue10" value="${requestScope.htmlGoodsSMYL.yhxxValue10 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow10" name="yhxxIfShow10" value="${requestScope.htmlGoodsSMYL.yhxxIfShow10 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow10?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(10,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr11" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName11" value="${requestScope.htmlGoodsSMYL.yhxxName11 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue11" value="${requestScope.htmlGoodsSMYL.yhxxValue11 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow11" name="yhxxIfShow11" value="${requestScope.htmlGoodsSMYL.yhxxIfShow11 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow11?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(11,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr12" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName12" value="${requestScope.htmlGoodsSMYL.yhxxName12 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue12" value="${requestScope.htmlGoodsSMYL.yhxxValue12 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow12" name="yhxxIfShow12" value="${requestScope.htmlGoodsSMYL.yhxxIfShow12 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow12?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(12,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr13" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName13" value="${requestScope.htmlGoodsSMYL.yhxxName13 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue13" value="${requestScope.htmlGoodsSMYL.yhxxValue13 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow13" name="yhxxIfShow13" value="${requestScope.htmlGoodsSMYL.yhxxIfShow13 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow13?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(13,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr14" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName14" value="${requestScope.htmlGoodsSMYL.yhxxName14 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue14" value="${requestScope.htmlGoodsSMYL.yhxxValue14 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow14" name="yhxxIfShow14" value="${requestScope.htmlGoodsSMYL.yhxxIfShow14 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow14?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(14,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr15" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName15" value="${requestScope.htmlGoodsSMYL.yhxxName15 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue15" value="${requestScope.htmlGoodsSMYL.yhxxValue15 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow15" name="yhxxIfShow15" value="${requestScope.htmlGoodsSMYL.yhxxIfShow15 }" />
					<input type="button" class="yhxxIfShow_inp" value="${requestScope.htmlGoodsSMYL.yhxxIfShow15?'显示':'隐藏' }" onclick="changeSPXQTrIfShow(15,this)"/>
				</td>
			</tr>
			
		</table>
	</div>
	<div class="memo2_div">
		<textarea class="memo2_ta" id="memo2" name="memo2" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsSMYL.getMemo2()) %></textarea>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsSMYL.qrCode }">
	<div class="preview_div" onclick="previewHtmlGoodsSMYL();">预览</div>
	<div class="save_div" onclick="saveEdithtmlGoodsSMYL();">保存</div>
	<div class="finishEdit_div" onclick="finishEdithtmlGoodsSMYL();">完成编辑</div>
	<div class="saveStatus_div" id="saveStatus_div"></div>
</div>
	<input type="hidden" id="id" name="id" value="${requestScope.htmlGoodsSMYL.id }" />
	<input type="hidden" id="goodsNumber" name="goodsNumber" value="${requestScope.htmlGoodsSMYL.goodsNumber }" />
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