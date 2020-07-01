<%@	page import="com.goodsPublic.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String memo1=(String)request.getAttribute("memo1");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/dmtts/addModule.css" />
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
	prettyPrint();
});

$(function(){
	var bodyWidth=$("body").css("width").substring(0,$("body").css("width").length-2);
	var middleDivWidth=$("#middle_div").css("width").substring(0,$("#middle_div").css("width").length-2);
	$("#right_div").css("margin-left",(parseInt(bodyWidth)+parseInt(middleDivWidth))/2+20+"px");

    //这里必须延迟1s，等图片加载完再重新设定右边div位置
    setTimeout(function(){
    	resetDivPosition();
    },"1000")
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

function addHtmlGoodsDMTTS(){
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
	resetDivPosition();
}

function deleteEmbed2Div(){
	$("#embed2_div").remove();
	$("#uploadFile2_div input[type='file']").remove();
	resetDivPosition();
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

function goBack(){
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=dmtts";
}

function checkForm(){
	if(checkIfLogined()){
		if(checkIfPaid()){
			return true;
		}
	}
	return false;
}

function checkIfLogined(){
	var bool=false;
	$.ajaxSetup({async:false});
	$.post("checkIfLogined",
		function(data){
			if(data.status=="ok"){
				bool=true;
			}
			else{
				$("#login_bg_div").css("display","block");
				bool=false;
			}
		}
	,"json");
	return bool;
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
</script>
</head>
<body>
<%@include file="../loginDialog.jsp"%>
<form id="form1" name="form1" method="post" action="addHtmlGoodsDMTTS" onsubmit="return checkForm();" enctype="multipart/form-data">
<div class="embed1ModBg_div" id="embed1ModBg_div">
	<div class="embed1Mod_div" id="embed1Mod_div">
		<div class="title_div">
			<span class="title_span">视频模块</span>
			<span class="close_span" onclick="closeEmbed1ModBgDiv();">关闭</span>
		</div>
		<div>
			<div class="embedShow_div" id="embedShow_div">
				<embed class="item_embed" id="embed1_1" alt="" src="/GoodsPublic/resource/embed/dmtts/40ea2ddfdf5f3a16546520a8c89fb7b7.H_9_3.mp4">
			</div>
			<div class="reupload_div" onclick="uploadEmbed1();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">重新上传</div>
			<div class="uploadFile1_div" id="uploadFile1_div">
				<input type="file" id="file1_1" name="file" onchange="showQrcodeEmbed1(this)" />
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
				<embed class="item_embed" id="embed2_1" alt="" src="/GoodsPublic/resource/embed/dmtts/notification.mp3">
			</div>
			<div class="reupload_div" onclick="uploadEmbed2();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">重新上传</div>
			<div class="uploadFile2_div" id="uploadFile2_div">
				<input type="file" id="file2_1" name="file" onchange="showQrcodeEmbed2(this)" />
			</div>
			<input type="hidden" id="uuid_hid1"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeEmbed2ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeEmbed2ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">多媒体图书</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div>
		<input class="title1_input" type="text" id="title1" name="title1" value="${requestScope.title1 }" placeholder="请输入标题"/>
	</div>
	<div class="embed1_div" id="embed1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openEmbed1ModBgDiv();">编辑</a>|
				<a onclick="deleteEmbed1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.embed1List }" var="embed1" varStatus="status">
			<embed class="item_embed" id="embed1_1" src="${embed1.url }"/>
			</c:forEach>
		</div>
	</div>
	<div class="memo1_div">
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(memo1) %></textarea>
	</div>
	<div>
		<input class="title2_input" type="text" id="title2" name="title2" value="${requestScope.title2 }" placeholder="请输入标题"/>
	</div>
	<div class="embed2_div" id="embed2_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openEmbed2ModBgDiv();">编辑</a>|
				<a onclick="deleteEmbed2Div();">删除</a>
			</div>
		</div>
		<div class="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.embed2List }" var="embed2" varStatus="status">
			<embed class="item_embed" id="embed2_1" src="${embed2.url }"/>
			</c:forEach>
		</div>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="uncreate_img" alt="" src="/GoodsPublic/resource/images/007.png">
	<div class="createQrcode_div" onclick="addHtmlGoodsDMTTS();">生成二维码</div>
</div>
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