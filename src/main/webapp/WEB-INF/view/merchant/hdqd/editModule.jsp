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

    //这里必须延迟0.1s，等图片加载完再重新设定右边div位置
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

function saveEdithtmlGoodsHDQD(){
	if(checkIfPaid()){
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
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow1?'显示':'隐藏' }" onclick="changeHdapTrIfShow(1,this)"/>
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
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow2?'显示':'隐藏' }" onclick="changeHdapTrIfShow(2,this)"/>
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
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow3?'显示':'隐藏' }" onclick="changeHdapTrIfShow(3,this)"/>
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
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow4?'显示':'隐藏' }" onclick="changeHdapTrIfShow(4,this)"/>
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
					<input type="button" class="spxqIfShow_inp" value="${requestScope.htmlGoodsHDQD.hdapIfShow5?'显示':'隐藏' }" onclick="changeHdapTrIfShow(5,this)"/>
				</td>
			</tr>
			
		</table>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="qrCode_img" alt="" src="${requestScope.htmlGoodsHDQD.qrCode }">
	<div class="preview_div">预览</div>
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