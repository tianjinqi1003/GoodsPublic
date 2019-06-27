<%@page import="com.goodsPublic.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" 
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String memo1=(String)request.getAttribute("memo1");
	String memo2=(String)request.getAttribute("memo2");
	String memo3=(String)request.getAttribute("memo3");
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
	
});

function showOptionDiv(o){
	$(o).parent().find("#but_div").css("display","block");
}

function hideOptionDiv(o){
	$(o).parent().find("#but_div").css("display","none");
}

function addHtmlGoodsSPZS(){
	renameFile();
	document.getElementById("sub_but").click();
}

function openImageModBgDiv(){
	$("#image2ModBg_div").css("display","block");
}

function renameFile(){
	$("#uploadFile2_div input[type='file']").each(function(i){
		$(this).attr("name","file2_"+(i+1));
		//console.log($(this).attr("name"));
	});
}

function closeImageModBgDiv(){
	$("#image2ModBg_div").css("display","none");
}

function deleteImageDiv(){
	$("#image2_div").remove();
}

function uploadImage2(){
	var uuid=createUUID();
	$("#uuid_hid2").val(uuid);
	$("#uploadFile2_div").append("<input type=\"file\" id=\"uploadFile2_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic2(this)\"/>");
	document.getElementById("uploadFile2_inp").click();
}

function deleteImage(o){
	$(o).parent().remove();
}

function showQrcodePic2(obj){
	var uuid=$("#uuid_hid2").val();
	var file=$(obj);
	file.attr("id","file"+uuid);
	file.attr("name","file"+uuid);
	file.removeAttr("onchange");
	file.css("display","none");
	var fileHtml=file.prop("outerHTML");
	
	var imageTab=$("#imageMod_div table");
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
</script>
</head>
<body style="background-color: #eee;">
<form id="form1" name="form1" method="post" action="addHtmlGoodsSPZS" enctype="multipart/form-data">
<div id="image2ModBg_div" style="width:100%;height:100%;position: fixed;background:rgba(0,0,0,0.5);display:none;z-index: 1;">
	<div id="imageMod_div" style="width: 600px;margin: 0 auto;margin-top: 100px;background-color: #fff;">
		<div style="width: 100%;height: 50px;line-height: 50px;border-bottom: #999 solid 1px;">
			<span style="margin-left: 20px;">图片模块</span>
			<span style="float: right;margin-right: 20px;cursor: pointer;" onclick="closeImageModBgDiv();">关闭</span>
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
			<div style="width:80px;height:35px;line-height:35px;text-align:center;color:#fff;float:right;margin-top: 7px;margin-right:13px;background-color: #4caf50;border-radius:5px;" onclick="closeImageModBgDiv();">确&nbsp;认</div>
			<div style="width:80px;height:33px;line-height:33px;text-align:center;color:#999;float:right;margin-top: 7px;margin-right:13px;border: #999 solid 1px;border-radius:5px;" onclick="closeImageModBgDiv();">取&nbsp;消</div>
		</div>
	</div>
</div>

<div id="main_div" style="width: 650px;margin: 0 auto;background-color: #fff;">
	<div>
		<input type="text" id="productName" name="productName" placeholder="请输入标题" style="width: 100%;height: 40px;line-height: 40px;text-align: center;font-size: 20px;font-weight: bold;"/>
	</div>
	<div id="image1_div" style="width: 650px;text-align: center;">
		<c:forEach items="${requestScope.image1List }" var="image1" varStatus="status">
		<img alt="" src="${image1.value }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:forEach>
	</div>
	<div style="margin-top: 25px;">
		<textarea id="memo1" name="memo1" cols="100" rows="8" style="width:650px;height:150px;visibility:hidden;"><%=htmlspecialchars(memo1) %></textarea>
	</div>
	<div id="spxq_div" style="margin-top: 20px;">
		<table id="spxq_tab" style="width: 600px;margin: 0 auto;border: #eee solid 1px;">
			<tr style="height:60px;">
				<td colspan="2" style="text-align: center;background-color: #eee;">商品详情</td>
				<td style="text-align: center;background-color: #eee;">操作</td>
			</tr>
			<c:forEach items="${requestScope.spxqList }" var="spxq" varStatus="status">
			<tr id="tr${status.index+1 }" height="50">
				<input type="hidden" name="spxqName${status.index+1 }" value="${spxq.name }" />
				<td style="width:20%;border: #eee solid 1px;padding-left: 20px;">${spxq.name }</td>
				<td style="width:70%;border: #eee solid 1px;padding-left: 20px;">
					<input type="text" name="spxqValue${status.index+1 }" />
				</td>
				<td style="width:10%;border: #eee solid 1px;text-align: center;">
					<input type="hidden" id="spxqIfShow${status.index+1 }" name="spxqIfShow${status.index+1 }" value="true" />
					<input type="button" value="显示" onclick="changeSPXQTrIfShow(${status.index+1 },this)"/>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div style="margin-top: 20px;">
		<textarea id="memo2" name="memo2" cols="100" rows="8" style="width:650px;height:220px;visibility:hidden;"><%=htmlspecialchars(memo2) %></textarea>
	</div>
	<div id="image2_div" style="width: 650px;text-align: center;margin-top: 25px;">
		<div id="option_div" style="width:650px;position:absolute;" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div id="but_div" style="width:100px;height:30px;line-height:30px;margin:0 auto;margin-top: 50px;text-align:center;z-index: 1;background-color: #fff;border-radius:5px;display:none; ">
				<a onclick="openImageModBgDiv();">编辑</a>|
				<a onclick="deleteImageDiv();">删除</a>
			</div>
		</div>
		<div onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.image2List }" var="image2" varStatus="status">
			<img alt="" src="${image2.value }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:forEach>
		</div>
	</div>
	<div id="image3_div" style="width: 650px;text-align: center;margin-top: 25px;">
		<c:forEach items="${requestScope.image3List }" var="image3" varStatus="status">
		<img alt="" src="${image3.value }" style="width: 600px;height: 600px;margin-top: 25px;">
		</c:forEach>
	</div>
	<div style="margin-top: 20px;">
		<textarea id="memo3" name="memo3" cols="100" rows="8" style="width:650px;height:550px;visibility:hidden;"><%=htmlspecialchars(memo3) %></textarea>
	</div>
</div>
	<input type="hidden" id="accountNumber_hid" name="accountNumber" value="${sessionScope.user.id }" />
	<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
<div>
	<input type="button" value="生成二维码" onclick="addHtmlGoodsSPZS();"/>
</div>
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