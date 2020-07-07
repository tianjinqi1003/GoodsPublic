<%@ page import="com.goodsPublic.util.StringUtils"%>
<%@ page import="goodsPublic.entity.HtmlGoodsHDQD"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	HtmlGoodsHDQD htmlGoodsHDQD=(HtmlGoodsHDQD)request.getAttribute("htmlGoodsHDQD");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/hdqd/editModule.css" />
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/kindeditor.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<script charset="utf-8" src="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.js"></script>
<script type="text/javascript">
var editor1;
KindEditor.ready(function(K) {
	editor1 = K.create('textarea[name="memo1"]', {
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
var dm1Html;
var dHdapIfShowArr=[];
var dHdapNameArr=[];
var dHdapValueArr=[];
var dHdapValue2Arr=[];
function initDefaultHtmlVal(){
	dpn=$("#middle_div #title").val();
	$("#uploadFile1_div input[id^='image']").each(function(i){
		disArr1[i]=$(this).val();
	});
	
	$("#middle_div #hdap_tab input[id^='hdapIfShow']").each(function(i){
		dHdapIfShowArr[i]=$(this).val();
		var hdapName=$("#middle_div #hdap_tab input[name^='hdapName']").eq(i).val();
		dHdapNameArr[i]=hdapName;
		var hdapValue=$("#middle_div #hdap_tab td[class='value_td']").eq(i).find("input").val();
		dHdapValueArr[i]=hdapValue;
		var hdapValue2=$("#middle_div #hdap_tab td[class='value2_td']").eq(i).find("input").val();
		//console.log("hdapValue2==="+hdapValue2);
		dHdapValue2Arr[i]=hdapValue2;
	});
	
	setTimeout(function(){
		dm1Html=editor1.html();
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

function previewHtmlGoodsHDQD(){
	if(!compareHtmlVal()){//这是已经编辑过内容的情况
		saveEdithtmlGoodsHDQD();
		
		var goodsNumber='${requestScope.htmlGoodsHDQD.goodsNumber }';
		var accountId='${sessionScope.user.id }';
		$.post("getPreviewHtmlGoods",
			{trade:"hdqd",goodsNumber:goodsNumber,accountId:accountId},
			function(data){
				//console.log("==="+JSON.stringify(data));
				var previewHDQD=data.previewHDQD;
				$("#preview_div #title_div").text(previewHDQD.title);
				
				var image1_1=previewHDQD.image1_1;
				if(image1_1==null){
					$("#preview_div #image1_1_img").css("display","none");
					$("#preview_div #image1_1_img").attr("src","");
				}
				else{
					$("#preview_div #image1_1_img").css("display","block");
					$("#preview_div #image1_1_img").attr("src",image1_1);
				}
				
				var image1_2=previewHDQD.image1_2;
				if(image1_2==null){
					$("#preview_div #image1_2_img").css("display","none");
					$("#preview_div #image1_2_img").attr("src","");
				}
				else{
					$("#preview_div #image1_2_img").css("display","block");
					$("#preview_div #image1_2_img").attr("src",image1_2);
				}
				
				var image1_3=previewHDQD.image1_3;
				if(image1_3==null){
					$("#preview_div #image1_3_img").css("display","none");
					$("#preview_div #image1_3_img").attr("src","");
				}
				else{
					$("#preview_div #image1_3_img").css("display","block");
					$("#preview_div #image1_3_img").attr("src",image1_3);
				}
				
				var image1_4=previewHDQD.image1_4;
				if(image1_4==null){
					$("#preview_div #image1_4_img").css("display","none");
					$("#preview_div #image1_4_img").attr("src","");
				}
				else{
					$("#preview_div #image1_4_img").css("display","block");
					$("#preview_div #image1_4_img").attr("src",image1_4);
				}
				
				var image1_5=previewHDQD.image1_5;
				if(image1_5==null){
					$("#preview_div #image1_5_img").css("display","none");
					$("#preview_div #image1_5_img").attr("src","");
				}
				else{
					$("#preview_div #image1_5_img").css("display","block");
					$("#preview_div #image1_5_img").attr("src",image1_5);
				}
				
				$("#preview_div #memo1_div").html(previewHDQD.memo1);
				
				var trs=$("#preview_div #hdap_tab tr");
				
				var tr=trs.eq(0);
				if(previewHDQD.hdapIfShow1)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				var tds=tr.find("td");
				tds.eq(0).text(previewHDQD.hdapName1);
				tds.eq(1).text(previewHDQD.hdapValue1_1);
				tds.eq(2).text(previewHDQD.hdapValue1_2);
				
				tr=trs.eq(1);
				if(previewHDQD.hdapIfShow2)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewHDQD.hdapName2);
				tds.eq(1).text(previewHDQD.hdapValue2_1);
				tds.eq(2).text(previewHDQD.hdapValue2_2);
				
				tr=trs.eq(2);
				if(previewHDQD.hdapIfShow3)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewHDQD.hdapName3);
				tds.eq(1).text(previewHDQD.hdapValue3_1);
				tds.eq(2).text(previewHDQD.hdapValue3_2);
				
				tr=trs.eq(3);
				if(previewHDQD.hdapIfShow4)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewHDQD.hdapName4);
				tds.eq(1).text(previewHDQD.hdapValue4_1);
				tds.eq(2).text(previewHDQD.hdapValue4_2);
				
				tr=trs.eq(4);
				if(previewHDQD.hdapIfShow5)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewHDQD.hdapName5);
				tds.eq(1).text(previewHDQD.hdapValue5_1);
				tds.eq(2).text(previewHDQD.hdapValue5_2);
				
				tr=trs.eq(5);
				if(previewHDQD.hdapIfShow6)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewHDQD.hdapName6);
				tds.eq(1).text(previewHDQD.hdapValue6_1);
				tds.eq(2).text(previewHDQD.hdapValue6_2);
				
				tr=trs.eq(6);
				if(previewHDQD.hdapIfShow7)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewHDQD.hdapName7);
				tds.eq(1).text(previewHDQD.hdapValue7_1);
				tds.eq(2).text(previewHDQD.hdapValue7_2);
				
				tr=trs.eq(7);
				if(previewHDQD.hdapIfShow8)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewHDQD.hdapName8);
				tds.eq(1).text(previewHDQD.hdapValue8_1);
				tds.eq(2).text(previewHDQD.hdapValue8_2);
				
				tr=trs.eq(8);
				if(previewHDQD.hdapIfShow9)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewHDQD.hdapName9);
				tds.eq(1).text(previewHDQD.hdapValue9_1);
				tds.eq(2).text(previewHDQD.hdapValue9_2);
				
				tr=trs.eq(9);
				if(previewHDQD.hdapIfShow10)
					tr.css("display","table-row");
				else
					tr.css("display","none");
				tds=tr.find("td");
				tds.eq(0).text(previewHDQD.hdapName10);
				tds.eq(1).text(previewHDQD.hdapValue10_1);
				tds.eq(2).text(previewHDQD.hdapValue10_2);
				
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
		
		var trs=$("#preview_div #hdap_tab tr");
		
		for(var i=0;i<dHdapIfShowArr.length;i++){
			var tr=trs.eq(i);
			if(dHdapIfShowArr[i]=="true")
				tr.css("display","table-row");
			else
				tr.css("display","none");
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
	
	var cm1Html=editor1.html();
	if(dm1Html!=cm1Html){
		flag=false;
		return flag;
	}

	$("#middle_div #hdap_tab input[id^='hdapIfShow']").each(function(i){
		var hdapIfShow=$(this).val();
		var hdapName=$("#middle_div #hdap_tab input[name^='hdapName']").eq(i).val();
		var hdapValue=$("#middle_div #hdap_tab td[class='value_td']").eq(i).find("input").val();
		var hdapValue2=$("#middle_div #hdap_tab td[class='value2_td']").eq(i).find("input").val();
		if(hdapIfShow!=dHdapIfShowArr[i]||hdapName!=dHdapNameArr[i]||hdapValue!=dHdapValueArr[i]||hdapValue2!=dHdapValue2Arr[i]){
			flag=false;
			return flag;
		}
	});

	return flag;
}

function saveEdithtmlGoodsHDQD(){
	if(checkIfPaid()){
		resetEditorHtml();
		renameFile();
		renameImage();
		
		var formData = new FormData($("#form1")[0]);
		 
		$.ajax({
			type:"post",
			url:"saveEdithtmlGoodsHDQD",
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

function finishEditHtmlGoodsHDQD(){
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

function changeHdapTrIfShow(index,o){
	var ifShow=$("#hdapIfShow"+index).val();
	if(ifShow=="true"){
		$("#hdapIfShow"+index).val(false);
		$(o).val("隐藏");
	}
	else{
		$("#hdapIfShow"+index).val(true);
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
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=hdqd";
}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="finishEditHtmlGoodsHDQD" onsubmit="return checkIfPaid();" enctype="multipart/form-data">
<div class="image1ModBg_div" id="image1ModBg_div">
	<div class="image1Mod_div" id="image1Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage1ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<tr>
					<c:if test="${requestScope.htmlGoodsHDQD.image1_1 ne null }">
					<td class="file_td" id="file_td1_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsHDQD.image1_1 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsHDQD.image1_2 ne null }">
					<td class="file_td" id="file_td1_2">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_2" alt="" src="${requestScope.htmlGoodsHDQD.image1_2 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsHDQD.image1_3 ne null }">
					<td class="file_td" id="file_td1_3">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsHDQD.image1_3 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsHDQD.image1_4 ne null }">
					<td class="file_td" id="file_td1_4">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsHDQD.image1_4 }">
					</td>
					</c:if>
					<c:if test="${requestScope.htmlGoodsHDQD.image1_5 ne null }">
					<td class="file_td" id="file_td1_5">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_5" alt="" src="${requestScope.htmlGoodsHDQD.image1_5 }">
					</td>
					</c:if>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
				</tr>
			</table>
			<div class="uploadFile1_div" id="uploadFile1_div">
				<c:if test="${requestScope.htmlGoodsHDQD.image1_1 ne null }">
				<input type="file" id="file1_1" name="file1_1" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_1" name="image1_1" value="${requestScope.htmlGoodsHDQD.image1_1 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsHDQD.image1_2 ne null }">
				<input type="file" id="file1_2" name="file1_2" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_2" name="image1_2" value="${requestScope.htmlGoodsHDQD.image1_2 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsHDQD.image1_3 ne null }">
				<input type="file" id="file1_3" name="file1_3" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_3" name="image1_3" value="${requestScope.htmlGoodsHDQD.image1_3 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsHDQD.image1_4 ne null }">
				<input type="file" id="file1_4" name="file1_4" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_4" name="image1_4" value="${requestScope.htmlGoodsHDQD.image1_4 }" />
				</c:if>
				<c:if test="${requestScope.htmlGoodsHDQD.image1_5 ne null }">
				<input type="file" id="file1_5" name="file1_5" onchange="showQrcodePic1(this)" />
				<input type="text" id="image1_5" name="image1_5" value="${requestScope.htmlGoodsHDQD.image1_5 }" />
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
		<div class="image1_div"  id="image1_div">
			<img class="image1_1_img" id="image1_1_img" alt="" src="">
			<img class="image1_2_img" id="image1_2_img" alt="" src="">
			<img class="image1_3_img" id="image1_3_img" alt="" src="">
			<img class="image1_4_img" id="image1_4_img" alt="" src="">
			<img class="image1_5_img" id="image1_5_img" alt="" src="">
		</div>
		<div class="memo1_div" id="memo1_div">
			${requestScope.htmlGoodsHDQD.memo1 }
		</div>
		
		<div class="hdap_div">
			<table class="hdap_tab" id="hdap_tab">
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsHDQD.hdapName1 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsHDQD.hdapValue1_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue1_2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsHDQD.hdapName2 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsHDQD.hdapValue2_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue2_2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsHDQD.hdapName3 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsHDQD.hdapValue3_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue3_2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsHDQD.hdapName4 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsHDQD.hdapValue4_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue4_2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsHDQD.hdapName5 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsHDQD.hdapValue5_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue5_2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsHDQD.hdapName6 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsHDQD.hdapValue6_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue6_2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsHDQD.hdapName7 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsHDQD.hdapValue7_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue7_2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsHDQD.hdapName8 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsHDQD.hdapValue8_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue8_2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsHDQD.hdapName9 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsHDQD.hdapValue9_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue9_2 }
					</td>
				</tr>
				<tr height="50">
					<td class="name_td">
						${requestScope.htmlGoodsHDQD.hdapName10 }
					</td>
					<td class="value_td">
						${requestScope.htmlGoodsHDQD.hdapValue10_1 }
					</td>
					<td class="value2_td">
						${requestScope.htmlGoodsHDQD.hdapValue10_2 }
					</td>
				</tr>
			</table>
		</div>
		<div style="width: 100%;height:40px;"></div>
	</div>
	<div class="smck_div" id="smck_div">
		<div class="tiShi_div">手机端实际效果可能存在差异，请扫码查看</div>
		<div class="qrCode_div">
			<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsHDQD.qrCode }">
		</div>
		<div class="jxbjBut_div" onclick="openPreviewBgDiv(0)">继续编辑</div>
	</div>
</div>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">活动签到-案例</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div>
		<input type="text" class="title_input" id="title" name="title" placeholder="请输入标题" value="${requestScope.htmlGoodsHDQD.title }"/>
	</div>
	<div class="image1_div" id="image1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsHDQD.image1_1 ne null }">
			<img class="item_img" id="img1_1" alt="" src="${requestScope.htmlGoodsHDQD.image1_1 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.image1_2 ne null }">
			<img class="item_img" id="img1_2" alt="" src="${requestScope.htmlGoodsHDQD.image1_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.image1_3 ne null }">
			<img class="item_img" id="img1_3" alt="" src="${requestScope.htmlGoodsHDQD.image1_3 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.image1_4 ne null }">
			<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsHDQD.image1_4 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsHDQD.image1_5 ne null }">
			<img class="item_img" id="img1_4" alt="" src="${requestScope.htmlGoodsHDQD.image1_5 }">
			</c:if>
		</div>
	</div>
	<div class="memo1_div">
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsHDQD.getMemo1()) %></textarea>
	</div>
	<div class="hdap_div" id="hdap_div">
		<table class="hdap_tab" id="hdap_tab">
			<tr class="item_tr" id="tr1" height="50">
				<td class="name_td">
					<input type="text" name="hdapName1" value="${requestScope.htmlGoodsHDQD.hdapName1 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue1_1" value="${requestScope.htmlGoodsHDQD.hdapValue1_1 }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue1_2" value="${requestScope.htmlGoodsHDQD.hdapValue1_2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow1" name="hdapIfShow1" value="${requestScope.htmlGoodsHDQD.hdapIfShow1 }" />
					<input type="button" class="hdapIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow1?'显示':'隐藏' }" onclick="changeHdapTrIfShow(1,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr2" height="50">
				<td class="name_td">
					<input type="text" name="hdapName2" value="${requestScope.htmlGoodsHDQD.hdapName2 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue2_1" value="${requestScope.htmlGoodsHDQD.hdapValue2_1 }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue2_2" value="${requestScope.htmlGoodsHDQD.hdapValue2_2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow2" name="hdapIfShow2" value="${requestScope.htmlGoodsHDQD.hdapIfShow2 }" />
					<input type="button" class="hdapIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow2?'显示':'隐藏' }" onclick="changeHdapTrIfShow(2,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr3" height="50">
				<td class="name_td">
					<input type="text" name="hdapName3" value="${requestScope.htmlGoodsHDQD.hdapName3 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue3_1" value="${requestScope.htmlGoodsHDQD.hdapValue3_1 }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue3_2" value="${requestScope.htmlGoodsHDQD.hdapValue3_2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow3" name="hdapIfShow3" value="${requestScope.htmlGoodsHDQD.hdapIfShow3 }" />
					<input type="button" class="hdapIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow3?'显示':'隐藏' }" onclick="changeHdapTrIfShow(3,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr4" height="50">
				<td class="name_td">
					<input type="text" name="hdapName4" value="${requestScope.htmlGoodsHDQD.hdapName4 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue4_1" value="${requestScope.htmlGoodsHDQD.hdapValue4_1 }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue4_2" value="${requestScope.htmlGoodsHDQD.hdapValue4_2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow4" name="hdapIfShow4" value="${requestScope.htmlGoodsHDQD.hdapIfShow4 }" />
					<input type="button" class="hdapIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow4?'显示':'隐藏' }" onclick="changeHdapTrIfShow(4,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr5" height="50">
				<td class="name_td">
					<input type="text" name="hdapName5" value="${requestScope.htmlGoodsHDQD.hdapName5 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue5_1" value="${requestScope.htmlGoodsHDQD.hdapValue5_1 }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue5_2" value="${requestScope.htmlGoodsHDQD.hdapValue5_2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow5" name="hdapIfShow5" value="${requestScope.htmlGoodsHDQD.hdapIfShow5 }" />
					<input type="button" class="hdapIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow5?'显示':'隐藏' }" onclick="changeHdapTrIfShow(5,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr6" height="50">
				<td class="name_td">
					<input type="text" name="hdapName6" value="${requestScope.htmlGoodsHDQD.hdapName6 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue6_1" value="${requestScope.htmlGoodsHDQD.hdapValue6_1 }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue6_2" value="${requestScope.htmlGoodsHDQD.hdapValue6_2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow6" name="hdapIfShow6" value="${requestScope.htmlGoodsHDQD.hdapIfShow6 }" />
					<input type="button" class="hdapIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow6?'显示':'隐藏' }" onclick="changeHdapTrIfShow(6,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr7" height="50">
				<td class="name_td">
					<input type="text" name="hdapName7" value="${requestScope.htmlGoodsHDQD.hdapName7 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue7_1" value="${requestScope.htmlGoodsHDQD.hdapValue7_1 }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue7_2" value="${requestScope.htmlGoodsHDQD.hdapValue7_2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow7" name="hdapIfShow7" value="${requestScope.htmlGoodsHDQD.hdapIfShow7 }" />
					<input type="button" class="hdapIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow7?'显示':'隐藏' }" onclick="changeHdapTrIfShow(7,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr8" height="50">
				<td class="name_td">
					<input type="text" name="hdapName8" value="${requestScope.htmlGoodsHDQD.hdapName8 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue8_1" value="${requestScope.htmlGoodsHDQD.hdapValue8_1 }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue8_2" value="${requestScope.htmlGoodsHDQD.hdapValue8_2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow8" name="hdapIfShow8" value="${requestScope.htmlGoodsHDQD.hdapIfShow8 }" />
					<input type="button" class="hdapIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow8?'显示':'隐藏' }" onclick="changeHdapTrIfShow(8,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr9" height="50">
				<td class="name_td">
					<input type="text" name="hdapName9" value="${requestScope.htmlGoodsHDQD.hdapName9 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue9_1" value="${requestScope.htmlGoodsHDQD.hdapValue9_1 }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue9_2" value="${requestScope.htmlGoodsHDQD.hdapValue9_2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow9" name="hdapIfShow9" value="${requestScope.htmlGoodsHDQD.hdapIfShow9 }" />
					<input type="button" class="hdapIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow9?'显示':'隐藏' }" onclick="changeHdapTrIfShow(9,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr10" height="50">
				<td class="name_td">
					<input type="text" name="hdapName10" value="${requestScope.htmlGoodsHDQD.hdapName10 }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="hdapValue10_1" value="${requestScope.htmlGoodsHDQD.hdapValue10_1 }" />
				</td>
				<td class="value2_td">
					<input type="text" name="hdapValue10_2" value="${requestScope.htmlGoodsHDQD.hdapValue10_2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow10" name="hdapIfShow10" value="${requestScope.htmlGoodsHDQD.hdapIfShow10 }" />
					<input type="button" class="hdapIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow10?'显示':'隐藏' }" onclick="changeHdapTrIfShow(10,this)"/>
				</td>
			</tr>
			
		</table>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsHDQD.qrCode }">
	<div class="preview_div" onclick="previewHtmlGoodsHDQD();">预览</div>
	<div class="save_div" onclick="saveEdithtmlGoodsHDQD();">保存</div>
	<div class="finishEdit_div" onclick="finishEditHtmlGoodsHDQD();">完成编辑</div>
	<div class="saveStatus_div" id="saveStatus_div"></div>
</div>
	<input type="hidden" id="id" name="id" value="${requestScope.htmlGoodsHDQD.id }" />
	<input type="hidden" id="goodsNumber" name="goodsNumber" value="${requestScope.htmlGoodsHDQD.goodsNumber }" />
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