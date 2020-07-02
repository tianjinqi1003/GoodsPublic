<%@ page import="com.goodsPublic.util.StringUtils"%>
<%@ page import="goodsPublic.entity.HtmlGoodsDMTTS"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	HtmlGoodsDMTTS htmlGoodsDMTTS=(HtmlGoodsDMTTS)request.getAttribute("htmlGoodsDMTTS");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/dmtts/editModule.css" />
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

    //这里必须延迟0.1s，等图片加载完再重新设定右边div位置
    setTimeout(function(){
    	resetDivPosition();
    },"1000")
    
	initDefaultHtmlVal();
});

var dpn1,dpn2;
var dm1Html;
function initDefaultHtmlVal(){
	dpn1=$("#middle_div #title1").val();
	setTimeout(function(){
		dm1Html=editor1.html();
	},"1000");
	dpn2=$("#middle_div #title2").val();
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

function previewHtmlGoodsDMTTS(){
	if(!compareHtmlVal()){//这是已经编辑过内容的情况
		saveEdithtmlGoodsDMTTS();
		
		var goodsNumber='${requestScope.htmlGoodsDMTTS.goodsNumber }';
		var accountId='${sessionScope.user.id }';
		$.post("getPreviewHtmlGoods",
			{trade:"dmtts",goodsNumber:goodsNumber,accountId:accountId},
			function(data){
				console.log("==="+JSON.stringify(data));
				var previewDMTTS=data.previewDMTTS;
				console.log(JSON.stringify(previewDMTTS));
				$("#preview_div #title1_div").text(previewDMTTS.title1);
				
				$("#preview_div #memo1_div").html(previewDMTTS.memo1);
				
				$("#preview_div #title2_div").text(previewDMTTS.title2);
				
				initDefaultHtmlVal();
			}
		,"json");
	}
	else{
		$("#preview_div #title1_div").text(dpn1);
		$("#preview_div #title2_div").text(dpn2);
	}
	openPreviewBgDiv(1);
}

function compareHtmlVal(){
	var flag=true;
	var cpn1=$("#middle_div #title1").val();
	if(dpn1!=cpn1){
		flag=false;
		return flag;
	}
	
	var cm1Html=editor1.html();
	if(dm1Html!=cm1Html){
		flag=false;
		return flag;
	}

	var cpn2=$("#middle_div #title2").val();
	if(dpn2!=cpn2){
		flag=false;
		return flag;
	}
	return flag;
}

function saveEdithtmlGoodsDMTTS(){
	if(checkIfPaid()){
		resetEditorHtml();
		renameFile();
		
		var formData = new FormData($("#form1")[0]);
		 
		$.ajax({
			type:"post",
			url:"saveEditHtmlGoodsDMTTS",
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

function finishEdithtmlGoodsDMTTS(){
	renameFile();
	document.getElementById("sub_but").click();
}

function openEmbed1ModBgDiv(){
	$("#embed1ModBg_div").css("display","block");
}

function openEmbed2ModBgDiv(){
	$("#embed2ModBg_div").css("display","block");
}

function deleteEmbed1Div(){
	$("#embed1_div").remove();
	$("#uploadFile1_div input[type='file']").remove();
	$("#uploadFile1_div input[type='text']").remove();
	resetDivPosition();
}

function deleteEmbed2Div(){
	$("#embed2_div").remove();
	$("#uploadFile2_div input[type='file']").remove();
	$("#uploadFile2_div input[type='text']").remove();
	resetDivPosition();
}

function resetEditorHtml(){
	$("#memo1").val(editor1.html());
}

function renameFile(){
	$("#uploadFile1_div input[type='file']").each(function(i){
		$(this).attr("name","file1_"+(i+1));
	});
	$("#uploadFile2_div input[type='file']").each(function(i){
		$(this).attr("name","file2_"+(i+1));
	});
}

function closeEmbed1ModBgDiv(){
	$("#embed1ModBg_div").css("display","none");
}

function closeEmbed2ModBgDiv(){
	$("#embed2ModBg_div").css("display","none");
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
	$("#uploadFile1_div").html("<input type=\"file\" id=\"uploadFile1_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodeEmbed1(this)\"/>");
	document.getElementById("uploadFile1_inp").click();
}

function uploadEmbed2(){
	var uuid=createUUID();
	$("#uuid_hid2").val(uuid);
	$("#uploadFile2_div").html("<input type=\"file\" id=\"uploadFile2_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodeEmbed2(this)\"/>");
	document.getElementById("uploadFile2_inp").click();
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

function showQrcodeEmbed2(obj){
	var uuid=$("#uuid_hid2").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	
	var embedShowDiv=$("#embed2Mod_div #embedShow_div");
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
        
        $("#embed2_div #embed2_1").replaceWith("<"+embedTag+" class=\"item_embed\" id=\"embed2_1\" src=\""+dataURL+"\"/>");
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
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=dmtts";
}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="finishEditHtmlGoodsDMTTS" onsubmit="return checkIfPaid();" enctype="multipart/form-data">
<div class="embed1ModBg_div" id="embed1ModBg_div">
	<div class="embed1Mod_div" id="embed1Mod_div">
		<div class="title_div">
			<span class="title_span">视频模块</span>
			<span class="close_span" onclick="closeEmbed1ModBgDiv();">关闭</span>
		</div>
		<div>
			<div class="embedShow_div" id="embedShow_div">
				<embed class="item_embed" id="embed1_1" alt="" src="${requestScope.htmlGoodsDMTTS.embed1_1 }">
			</div>
			<div class="reupload_div" onclick="uploadEmbed1();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">重新上传</div>
			<div class="uploadFile1_div" id="uploadFile1_div">
				<c:if test="${requestScope.htmlGoodsDMTTS.embed1_1 ne null }">
				<input type="file" id="file1_1" name="file1_1" onchange="showQrcodeEmbed1(this)" />
				<input type="text" id="embed1_1" name="embed1_1" value="${requestScope.htmlGoodsDMTTS.embed1_1 }" />
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
<div class="embed2ModBg_div" id="embed2ModBg_div">
	<div class="embed2Mod_div" id="embed2Mod_div">
		<div class="title_div">
			<span class="title_span">音频模块</span>
			<span class="close_span" onclick="closeEmbed2ModBgDiv();">关闭</span>
		</div>
		<div>
			<div class="embedShow_div" id="embedShow_div">
				<embed class="item_embed" id="embed2_1" alt="" src="${requestScope.htmlGoodsDMTTS.embed2_1 }">
			</div>
			<div class="reupload_div" onclick="uploadEmbed2();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">重新上传</div>
			<div class="uploadFile2_div" id="uploadFile2_div">
				<c:if test="${requestScope.htmlGoodsDMTTS.embed2_1 ne null }">
				<input type="file" id="file2_1" name="file2_1" onchange="showQrcodeEmbed2(this)" />
				<input type="text" id="embed2_1" name="embed2_1" value="${requestScope.htmlGoodsDMTTS.embed2_1 }" />
				</c:if>
			</div>
			<input type="hidden" id="uuid_hid2"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeEmbed2ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeEmbed2ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="previewBg_div" id="previewBg_div">
	<div class="preview_div" id="preview_div">
		<div class="title1_div" id="title1_div"></div>
		<div class="embed1_div" id="embed1_div">
			<embed class="embed1_1_embed" id="embed1_1_embed" alt="" src="${requestScope.htmlGoodsDMTTS.embed1_1 }"/>
		</div>
		<div class="memo1_div" id="memo1_div">
			${requestScope.htmlGoodsDMTTS.memo1 }
		</div>
		<div class="title2_div" id="title2_div"></div>
		<div class="embed2_div" id="embed2_div">
			<embed class="embed2_1_embed" id="embed2_1_embed" alt="" src="${requestScope.htmlGoodsDMTTS.embed2_1 }"/>
		</div>
		<div style="width: 100%;height:40px;"></div>
	</div>
	<div class="smck_div" id="smck_div">
		<div class="tiShi_div">手机端实际效果可能存在差异，请扫码查看</div>
		<div class="qrCode_div">
			<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsDMTTS.qrCode }">
		</div>
		<div class="jxbjBut_div" onclick="openPreviewBgDiv(0)">继续编辑</div>
	</div>
</div>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">多媒体图书</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>

<div class="middle_div" id="middle_div" style="">
	<div>
		<input class="title1_input" type="text" id="title1" name="title1" placeholder="请输入标题" value="${requestScope.htmlGoodsDMTTS.title1 }"/>
	</div>
	<div class="embed1_div" id="embed1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openEmbed1ModBgDiv();">编辑</a>|
				<a onclick="deleteEmbed1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsDMTTS.embed1_1 ne null }">
			<embed class="item_embed" id="embed1_1" alt="" src="${requestScope.htmlGoodsDMTTS.embed1_1 }"/>
			</c:if>
		</div>
	</div>
	<div class="memo1_div">
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(htmlGoodsDMTTS.getMemo1()) %></textarea>
	</div>
	<div>
		<input class="title2_input" type="text" id="title2" name="title2" value="${htmlGoodsDMTTS.title2 }" placeholder="请输入标题"/>
	</div>
	<div class="embed2_div" id="embed2_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openEmbed2ModBgDiv();">编辑</a>|
				<a onclick="deleteEmbed2Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:if test="${requestScope.htmlGoodsDMTTS.embed1_1 ne null }">
			<embed class="item_embed" id="embed2_1" alt="" src="${requestScope.htmlGoodsDMTTS.embed2_1 }"/>
			</c:if>
		</div>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsDMTTS.qrCode }">
	<div class="preview_div" onclick="previewHtmlGoodsDMTTS();">预览</div>
	<div class="save_div" onclick="saveEdithtmlGoodsDMTTS();">保存</div>
	<div class="finishEdit_div" onclick="finishEdithtmlGoodsDMTTS();">完成编辑</div>
	<div class="saveStatus_div" id="saveStatus_div"></div>
</div>
	<input type="hidden" id="id" name="id" value="${requestScope.htmlGoodsDMTTS.id }" />
	<input type="hidden" id="goodsNumber" name="goodsNumber" value="${requestScope.htmlGoodsDMTTS.goodsNumber }" />
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