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

function saveEditHtmlGoodsJZSG(){
	renameFile();
	
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

function hideSaveStatusDiv(){
	$("#saveStatus_div").text("");
	$("#saveStatus_div").css("display","none");
}

function finishEditHtmlGoodsJZSG(){
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
	$("#uploadFile1_div input[type='file']").remove();
	resetDivPosition();
}

function deleteImage2Div(){
	$("#image2_div").remove();
	$("#uploadFile2_div input[type='file']").remove();
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
	$("#uploadFile1_div input[type='file'][name='file"+uuid+"']").remove();
	resetDivPosition();
}

function deleteImage2(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image2_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
	$("#uploadFile2_div input[type='file'][name='file"+uuid+"']").remove();
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
	imageTab.find("#upload_td").before("<td id=\"file_td"+uuid+"\" style=\"width: 25%;\">"
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
<body>
<form id="form1" name="form1" method="post" action="finishEditHtmlGoodsJZSG" enctype="multipart/form-data">
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
						<img alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
					</td>
				</tr>
			</table>
			<div class="uploadFile1_div" id="uploadFile1_div">
				<input type="file" id="file1_1" name="file1_1" onchange="showQrcodePic1(this)" />
			</div>
			<input type="hidden" id="uuid_hid1"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeImage1ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeImage1ModBgDiv();">取&nbsp;消</div>
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
						<img alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage2();">
					</td>
				</tr>
			</table>
			<div class="uploadFile2_div" id="uploadFile2_div">
				<input type="file" id="file2_1" name="file2_1" onchange="showQrcodePic2(this)" />
			</div>
			<input type="hidden" id="uuid_hid2"/>
		</div>
		<div class="but_div" id="but_div">
			<div class="confirm_div" onclick="closeImage2ModBgDiv();">确&nbsp;认</div>
			<div class="cancel_div" onclick="closeImage2ModBgDiv();">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">红酒介绍-案例</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div>
		<input type="text" class="productName_input" id="productName" name="productName" placeholder="请输入标题" value="${requestScope.htmlGoodsJZSG.title }"/>
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
			<img class="item_img" alt="" src="${requestScope.htmlGoodsJZSG.image1_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.image1_3 ne null }">
			<img class="item_img" alt="" src="${requestScope.htmlGoodsJZSG.image1_3 }">
			</c:if>
		</div>
	</div>
	<div class="ryxx_div" id="ryxx_div">
		<table class="ryxx_tab" id="ryxx_tab">
			<tr class="item_tr" id="tr1" height="50">
				<input type="hidden" name="ryxxName1" value="${requestScope.htmlGoodsJZSG.ryxxName1 }" />
				<td class="name_td">${requestScope.htmlGoodsJZSG.ryxxName1 }</td>
				<td class="value_td">
					<input type="text" name="ryxxValue1" value="${requestScope.htmlGoodsJZSG.ryxxValue1 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow1" name="ryxxIfShow1" value="${requestScope.htmlGoodsJZSG.ryxxIfShow1 }" />
					<input type="button" value="${requestScope.htmlGoodsJZSG.ryxxIfShow1?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(1,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr2" height="50">
				<input type="hidden" name="ryxxName2" value="${requestScope.htmlGoodsJZSG.ryxxName2 }" />
				<td class="name_td">${requestScope.htmlGoodsJZSG.ryxxName2 }</td>
				<td class="value_td">
					<input type="text" name="ryxxValue2" value="${requestScope.htmlGoodsJZSG.ryxxValue2 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow2" name="ryxxIfShow2" value="${requestScope.htmlGoodsJZSG.ryxxIfShow2 }" />
					<input type="button" value="${requestScope.htmlGoodsJZSG.ryxxIfShow2?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(2,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr3" height="50">
				<input type="hidden" name="ryxxName3" value="${requestScope.htmlGoodsJZSG.ryxxName3 }" />
				<td class="name_td">${requestScope.htmlGoodsJZSG.ryxxName3 }</td>
				<td class="value_td">
					<input type="text" name="ryxxValue3" value="${requestScope.htmlGoodsJZSG.ryxxValue3 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow3" name="ryxxIfShow3" value="${requestScope.htmlGoodsJZSG.ryxxIfShow3 }" />
					<input type="button" value="${requestScope.htmlGoodsJZSG.ryxxIfShow3?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(3,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr4" height="50">
				<input type="hidden" name="ryxxName4" value="${requestScope.htmlGoodsJZSG.ryxxName4 }" />
				<td class="name_td">${requestScope.htmlGoodsJZSG.ryxxName4 }</td>
				<td class="value_td">
					<input type="text" name="ryxxValue4" value="${requestScope.htmlGoodsJZSG.ryxxValue4 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow4" name="ryxxIfShow4" value="${requestScope.htmlGoodsJZSG.ryxxIfShow4 }" />
					<input type="button" value="${requestScope.htmlGoodsJZSG.ryxxIfShow4?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(4,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr5" height="50">
				<input type="hidden" name="ryxxName5" value="${requestScope.htmlGoodsJZSG.ryxxName5 }" />
				<td class="name_td">${requestScope.htmlGoodsJZSG.ryxxName5 }</td>
				<td class="value_td">
					<input type="text" name="ryxxValue5" value="${requestScope.htmlGoodsJZSG.ryxxValue5 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow5" name="ryxxIfShow5" value="${requestScope.htmlGoodsJZSG.ryxxIfShow5 }" />
					<input type="button" value="${requestScope.htmlGoodsJZSG.ryxxIfShow5?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(5,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr6" height="50">
				<input type="hidden" name="ryxxName6" value="${requestScope.htmlGoodsJZSG.ryxxName6 }" />
				<td class="name_td">${requestScope.htmlGoodsJZSG.ryxxName6 }</td>
				<td class="value_td">
					<input type="text" name="ryxxValue6" value="${requestScope.htmlGoodsJZSG.ryxxValue6 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow6" name="ryxxIfShow6" value="${requestScope.htmlGoodsJZSG.ryxxIfShow6 }" />
					<input type="button" value="${requestScope.htmlGoodsJZSG.ryxxIfShow6?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(6,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr7" height="50">
				<input type="hidden" name="ryxxName7" value="${requestScope.htmlGoodsJZSG.ryxxName7 }" />
				<td class="name_td">${requestScope.htmlGoodsJZSG.ryxxName7 }</td>
				<td class="value_td">
					<input type="text" name="ryxxValue7" value="${requestScope.htmlGoodsJZSG.ryxxValue7 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow7" name="ryxxIfShow7" value="${requestScope.htmlGoodsJZSG.ryxxIfShow7 }" />
					<input type="button" value="${requestScope.htmlGoodsJZSG.ryxxIfShow7?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(7,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr8" height="50">
				<input type="hidden" name="ryxxName8" value="${requestScope.htmlGoodsJZSG.ryxxName8 }" />
				<td class="name_td">${requestScope.htmlGoodsJZSG.ryxxName8 }</td>
				<td class="value_td">
					<input type="text" name="ryxxValue8" value="${requestScope.htmlGoodsJZSG.ryxxValue8 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow8" name="ryxxIfShow8" value="${requestScope.htmlGoodsJZSG.ryxxIfShow8 }" />
					<input type="button" value="${requestScope.htmlGoodsJZSG.ryxxIfShow8?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(8,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr9" height="50">
				<input type="hidden" name="ryxxName9" value="${requestScope.htmlGoodsJZSG.ryxxName9 }" />
				<td class="name_td">${requestScope.htmlGoodsJZSG.ryxxName9 }</td>
				<td class="value_td">
					<input type="text" name="ryxxValue9" value="${requestScope.htmlGoodsJZSG.ryxxValue9 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow9" name="ryxxIfShow9" value="${requestScope.htmlGoodsJZSG.ryxxIfShow9 }" />
					<input type="button" value="${requestScope.htmlGoodsJZSG.ryxxIfShow9?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(9,this)"/>
				</td>
			</tr>
			
			<tr class="item_tr" id="tr10" height="50">
				<input type="hidden" name="ryxxName10" value="${requestScope.htmlGoodsJZSG.ryxxName10 }" />
				<td class="name_td">${requestScope.htmlGoodsJZSG.ryxxName10 }</td>
				<td class="value_td">
					<input type="text" name="ryxxValue10" value="${requestScope.htmlGoodsJZSG.ryxxValue10 }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="ryxxIfShow10" name="ryxxIfShow10" value="${requestScope.htmlGoodsJZSG.ryxxIfShow10 }" />
					<input type="button" value="${requestScope.htmlGoodsJZSG.ryxxIfShow10?'显示':'隐藏' }" onclick="changeRYXXTrIfShow(10,this)"/>
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
			<img class="item_img" alt="" src="${requestScope.htmlGoodsJZSG.image2_2 }">
			</c:if>
			<c:if test="${requestScope.htmlGoodsJZSG.image2_3 ne null }">
			<img class="item_img" alt="" src="${requestScope.htmlGoodsJZSG.image2_3 }">
			</c:if>
		</div>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsJZSG.qrCode }">
	<div class="preview_div">预览</div>
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