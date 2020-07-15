<%@ page import="com.goodsPublic.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String memo1=(String)request.getAttribute("memo1");
	String memo2=(String)request.getAttribute("memo2");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<%@include file="../js.jsp"%>
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/themes/default/default.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/js/kindeditor-4.1.10/plugins/code/prettify.css" />
<link rel="stylesheet" href="<%=basePath %>/resource/css/smyl/addModule.css" />
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
	prettyPrint();
});

$(function(){
	var bodyWidth=$("body").css("width").substring(0,$("body").css("width").length-2);
	var middleDivWidth=$("#middle_div").css("width").substring(0,$("#middle_div").css("width").length-2);
	$("#right_div").css("margin-left",(parseInt(bodyWidth)+parseInt(middleDivWidth))/2+20+"px");

    //这里必须延迟0.1s，等图片加载完再重新设定右边div位置
    setTimeout(function(){
    	resetDivPosition();
    },"100")
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

function addHtmlGoodsSMYL(){
	renameFile();
	document.getElementById("sub_but").click();
}

function openImage1ModBgDiv(){
	$("#image1ModBg_div").css("display","block");
}

function deleteImage1Div(){
	$("#image1_div").remove();
	$("#uploadFile1_div input[type='file']").remove();
	resetDivPosition();
}

function renameFile(){
	$("#uploadFile1_div input[type='file']").each(function(i){
		$(this).attr("name","file1_"+(i+1));
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
	if($("#image1Mod_div table td[class='file_td']").length>=5){
		alert("最多上传5张图片!");
		return false;
	}
	var uuid=createUUID();
	$("#uuid_hid1").val(uuid);
	$("#uploadFile1_div").append("<input type=\"file\" id=\"uploadFile1_inp\" name=\"file"+uuid+"\" onchange=\"showQrcodePic1(this)\"/>");
	document.getElementById("uploadFile1_inp").click();
}

function deleteImage1(o){
	var td=$(o).parent();
	var uuid=td.attr("id").substring(7);
	$("#image1_div #list_div img[id='img"+uuid+"']").remove();
	td.remove();
	$("#uploadFile1_div input[type='file'][name='file"+uuid+"']").remove();
	
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

function changeYHXXTrIfShow(index,o){
	var ifShow=$("#yhxxIfShow"+index).val();
	if(ifShow=="true"){
		$("#yhxxIfShow"+index).val(false);
		$(o).val("隐藏");
	}
	else{
		$("#yhxxIfShow"+index).val(true);
		$(o).val("显示");
	}
}

function goBack(){
	location.href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=smyl";
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
				//alert(data.message);
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
<form id="form1" name="form1" method="post" action="addHtmlGoodsSMYL" onsubmit="return checkForm();" enctype="multipart/form-data">
<div class="image1ModBg_div" id="image1ModBg_div">
	<div class="image1Mod_div" id="image1Mod_div">
		<div class="title_div">
			<span class="title_span">图片模块</span>
			<span class="close_span" onclick="closeImage1ModBgDiv();">关闭</span>
		</div>
		<div id="tab_div">
			<table>
				<tr>
					<td class="file_td" id="file_td1_1">
						<img class="delete_img" alt="" src="/GoodsPublic/resource/images/004.png" onclick="deleteImage1(this);">
						<img class="item_img" id="img1_1" alt="" src="/GoodsPublic/resource/images/smyl/202007150001.png">
					</td>
					<td id="upload_td">
						<img class="upload_img" alt="" src="/GoodsPublic/resource/images/005.png" onclick="uploadImage1();">
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
			<div class="cancel_div" onclick="closeImage1ModBgDiv();" onmousemove="changeButStyle(this,1);" onmouseout="changeButStyle(this,0);">取&nbsp;消</div>
		</div>
	</div>
</div>

<div class="top_div">
	<div class="return_div" onclick="goBack();">&lt返回</div>
	<div class="title_div">树木园林-案例</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div>
		<input class="productName_input" type="text" id="productName" name="productName" value="${requestScope.productName }" placeholder="请输入标题"/>
	</div>
	<div class="image1_div" id="image1_div">
		<div class="option_div" id="option_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<div class="but_div" id="but_div">
				<a onclick="openImage1ModBgDiv();">编辑</a>|
				<a onclick="deleteImage1Div();">删除</a>
			</div>
		</div>
		<div class="list_div" id="list_div" onmousemove="showOptionDiv(this);" onmouseout="hideOptionDiv(this);">
			<c:forEach items="${requestScope.image1List }" var="image1" varStatus="status">
			<img class="item_img" id="img1_1" alt="" src="${image1.value }">
			</c:forEach>
		</div>
	</div>
	<div class="spxq_div" id="spxq_div">
		<table class="spxq_tab" id="spxq_tab">
			<tr class="head_tr">
				<td class="spxq_td" colspan="2">商品详情</td>
				<td class="cz_td">操作</td>
			</tr>
			<c:forEach items="${requestScope.spxqList }" var="spxq" varStatus="status">
			<tr class="item_tr" id="tr${status.index+1 }" height="50">
				<td class="name_td">
					<input type="text" name="spxqName${status.index+1 }" value="${spxq.name }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue${status.index+1 }" value="${spxq.value }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow${status.index+1 }" name="spxqIfShow${status.index+1 }" value="true" />
					<input type="button" class="spxqIfShow_inp" value="显示" onclick="changeSPXQTrIfShow(${status.index+1 },this)"/>
				</td>
			</tr>
			</c:forEach>
			<c:forEach begin="8" end="15" varStatus="status">
			<tr class="item_tr" id="tr${status.index }" height="50">
				<td class="name_td">
					<input type="text" name="spxqName${status.index }" size="10" maxlength="80" />
				</td>
				<td class="value_td">
					<input type="text" name="spxqValue${status.index }" maxlength="80" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="spxqIfShow${status.index }" name="spxqIfShow${status.index }" value="true" />
					<input type="button" class="spxqIfShow_inp" value="显示" onclick="changeSPXQTrIfShow(${status.index },this)"/>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div class="memo1_div">
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(memo1) %></textarea>
	</div>
	<div class="yhxx_div" id="yhxx_div">
		<table class="yhxx_tab" id="yhxx_tab">
			<tr class="head_tr">
				<td class="yhxx_td" colspan="2">养护信息</td>
				<td class="cz_td">操作</td>
			</tr>
			<c:forEach items="${requestScope.yhxxList }" var="yhxx" varStatus="status">
			<tr class="item_tr" id="tr${status.index+1 }" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName${status.index+1 }" value="${yhxx.name }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue${status.index+1 }" value="${yhxx.value }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow${status.index+1 }" name="yhxxIfShow${status.index+1 }" value="true" />
					<input type="button" class="yhxxIfShow_inp" value="显示" onclick="changeYHXXTrIfShow(${status.index+1 },this)"/>
				</td>
			</tr>
			</c:forEach>
			<c:forEach begin="4" end="15" varStatus="status">
			<tr class="item_tr" id="tr${status.index }" height="50">
				<td class="name_td">
					<input type="text" name="yhxxName${status.index }" size="10" />
				</td>
				<td class="value_td">
					<input type="text" name="yhxxValue${status.index }" />
				</td>
				<td class="cz_td">
					<input type="hidden" id="yhxxIfShow${status.index }" name="yhxxIfShow${status.index }" value="true" />
					<input type="button" class="yhxxIfShow_inp" value="显示" onclick="changeYHXXTrIfShow(${status.index },this)"/>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div class="memo2_div">
		<textarea class="memo2_ta" id="memo2" name="memo2" cols="100" rows="8" ><%=htmlspecialchars(memo2) %></textarea>
	</div>
</div>
<div class="right_div" id="right_div">
	<img class="uncreate_img" alt="" src="/GoodsPublic/resource/images/007.png">
	<div class="createQrcode_div" onclick="addHtmlGoodsSMYL();">生成二维码</div>
</div>
	<input type="hidden" id="accountNumber_hid" name="accountNumber" value="${sessionScope.user.id }" />
	<input type="hidden" name="from" value="${param.from}"/>
	<input type="hidden" name="moduleType" value="${param.moduleType}"/>
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