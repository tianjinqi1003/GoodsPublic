<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
$(function(){
	var bodyWidth=$("body").css("width").substring(0,$("body").css("width").length-2);
	var middleDivWidth=$("#middle_div").css("width").substring(0,$("#middle_div").css("width").length-2);
	var middleDivHeight=$("#middle_div").css("height").substring(0,$("#middle_div").css("height").length-2);
	$("#right_div").css("margin-left",(parseInt(bodyWidth)+parseInt(middleDivWidth))/2+20+"px");
	$("#right_div").css("margin-top","-"+parseInt(middleDivHeight)+"px");
});

function showOptionDiv(o){
	$(o).parent().find("#but_div").css("display","block");
}

function hideOptionDiv(o){
	$(o).parent().find("#but_div").css("display","none");
}

function addHtmlGoodsJZSG(){
	renameFile();
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
}

function deleteImage2Div(){
	$("#image2_div").remove();
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

function closeImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","none");
}

function closeImage2ModBgDiv(){
	$("#image2ModBg_div").css("display","none");
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

function deleteImage1(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image1_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
}

function deleteImage2(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image2_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
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
	imageTab.find("#upload_td").before("<td id=\"file_td"+uuid+"\" style=\"width: 25%;\">"
			+"<img alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" style=\"position: absolute;margin-top: 5px;margin-left: 80px;\" onclick=\"deleteImage1(this);\">"
			+"<img id=\"img"+uuid+"\" style=\"width: 120px;height: 120px;\" alt=\"\">"
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
        listDiv.append("<img id=\"img"+uuid+"\" alt=\"\" src=\""+dataURL+"\" style=\"width: 600px;height: 600px;margin-top: 25px;\">");
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
			+"<img alt=\"\" src=\"/GoodsPublic/resource/images/004.png\" style=\"position: absolute;margin-top: 5px;margin-left: 80px;\" onclick=\"deleteImage2(this);\">"
			+"<img id=\"img"+uuid+"\" style=\"width: 120px;height: 120px;\" alt=\"\">"
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
        listDiv.append("<img id=\"img"+uuid+"\" alt=\"\" src=\""+dataURL+"\" style=\"width: 600px;height: 600px;margin-top: 25px;\">");
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

function goBack(){
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=jzsg";
}
</script>
</head>
<body style="background-color: #fbfbfb;">
<form id="form1" name="form1" method="post" action="addHtmlGoodsJZSG" enctype="multipart/form-data">
<div id="image1ModBg_div" style="width:100%;height:100%;position: fixed;background:rgba(0,0,0,0.5);display:none;z-index: 1;">
	<div id="image1Mod_div" style="width: 600px;margin: 0 auto;margin-top: 100px;background-color: #fff;">
		<div style="width: 100%;height: 50px;line-height: 50px;border-bottom: #999 solid 1px;">
			<span style="margin-left: 20px;">图片模块</span>
			<span style="float: right;margin-right: 20px;cursor: pointer;" onclick="closeImage1ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table style="width: 550px;margin:0 auto;margin-top: 20px;border: #eee solid 1px;">
				<tr>
					<td id="file_td1_1" style="width: 25%;">
						<img alt="" src="/GoodsPublic/resource/images/004.png" style="position: absolute;margin-top: 5px;margin-left: 80px;" onclick="deleteImage1(this);">
						<img id="img1_1" style="width: 120px;height: 120px;" alt="" src="/GoodsPublic/resource/images/jzsg/bf0b334d871019cf3b2359e22b405d1c.png">
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
					<td id="file_td2_1" style="width: 25%;">
						<img alt="" src="/GoodsPublic/resource/images/004.png" style="position: absolute;margin-top: 5px;margin-left: 80px;" onclick="deleteImage2(this);">
						<img id="img2_1" style="width: 120px;height: 120px;" alt="" src="/GoodsPublic/resource/images/jzsg/43a339cd90f1a6b00c0c256d49d6a119.png">
					</td>
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

<div style="width: 100%;height: 50px;line-height: 50px;background-color: #fff;">
	<div style="float:left;width: 70px;height: 30px;line-height: 30px;text-align:center;margin-top:10px;margin-left:20px;border:1px solid #eee;border-radius:3px;" onclick="goBack();">&lt返回</div>
	<div style="width:200px;margin:0 auto;font-size:18px;font-weight: bold;text-align: center;">施工人员信息展示</div>
	<div style="float:right;height: 30px;line-height: 30px;text-align:center;margin-top:-40px;margin-right:20px;border-radius:3px;">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div id="middle_div" style="width: 650px;margin: 0 auto;margin-top: 25px;background-color: #fff;">
	<div>
		<input type="text" id="title" name="title" placeholder="请输入标题" style="width: 100%;height: 40px;line-height: 40px;text-align: center;font-size: 20px;font-weight: bold;"/>
	</div>
	<div id="image1_div" style="width: 650px;text-align: center;">
		<div id="option_div" style="width:650px;position:absolute;" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div id="but_div" style="width:100px;height:30px;line-height:30px;margin:0 auto;margin-top: 50px;text-align:center;z-index: 1;background-color: #fff;border-radius:5px;display:none; ">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.image1List }" var="image1" varStatus="status">
			<img id="img1_1" alt="" src="${image1.value }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:forEach>
		</div>
	</div>
	<div id="ryxx_div" style="margin-top: 20px;">
		<table id="ryxx_tab" style="width: 600px;margin: 0 auto;border: #eee solid 1px;">
			<c:forEach items="${requestScope.ryxxList }" var="ryxx" varStatus="status">
			<tr id="tr${status.index+1 }" height="50">
				<input type="hidden" name="ryxxName${status.index+1 }" value="${ryxx.name }" />
				<td style="width:20%;border: #eee solid 1px;padding-left: 20px;">${ryxx.name }</td>
				<td style="width:70%;border: #eee solid 1px;padding-left: 20px;">
					<input type="text" name="ryxxValue${status.index+1 }" />
				</td>
				<td style="width:10%;border: #eee solid 1px;text-align: center;">
					<input type="hidden" id="ryxxIfShow${status.index+1 }" name="ryxxIfShow${status.index+1 }" value="true" />
					<input type="button" value="显示" onclick="changeRYXXTrIfShow(${status.index+1 },this)"/>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div id="image2_div" style="width: 650px;text-align: center;margin-top: 25px;">
		<div id="option_div" style="width:650px;position:absolute;" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div id="but_div" style="width:100px;height:30px;line-height:30px;margin:0 auto;margin-top: 50px;text-align:center;z-index: 1;background-color: #fff;border-radius:5px;display:none; ">
				<a onclick="openImage2ModBgDiv();">编辑</a>|
				<a onclick="deleteImage2Div();">删除</a>
			</div>
		</div>
		<div id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.image2List }" var="image2" varStatus="status">
			<img id="img2_1" alt="" src="${image2.value }" style="width: 600px;height: 600px;margin-top: 25px;">
			</c:forEach>
		</div>
	</div>
</div>
<div id="right_div" style="width: 150px;height: 200px;text-align: center;">
	<img style="width: 120px;height: 120px;" alt="" src="/GoodsPublic/resource/images/007.png">
	<div style="width: 100px;height: 30px;line-height: 30px;text-align:center;margin:0 auto;margin-top:15px;color:#fff;background-color:#4caf50;border-radius:3px;" onclick="addHtmlGoodsJZSG();">生成二维码</div>
</div>
	<input type="hidden" id="accountNumber_hid" name="accountNumber" value="${sessionScope.user.id }" />
	<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
</form>
</body>
</html>