<%@ page import="com.goodsPublic.util.StringUtils"%>
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
<link rel="stylesheet" href="<%=basePath %>/resource/css/hdqd/batchAddModule.css" />
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

var path='<%=basePath %>';
var stepIndex=1;
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

function addBatchHtmlGoodsHDQD(){
	var jsonStr="[";
	var colCount;
	var valTds;
	var rowCount=$("#qrsjbsc_div #excel_tab .content_tr").length;
	$("#qrsjbsc_div #excel_tab .content_tr").each(function(i){
		jsonStr+="{";
		valTds=$(this).find(".val_td");
		colCount=valTds.length;
		valTds.each(function(j){
			if(j<colCount-1)
				jsonStr+="\"value"+(j+1)+"\":\""+$(this).attr("text")+"\",";
			else
				jsonStr+="\"value"+(j+1)+"\":\""+$(this).attr("text")+"\"";
		});
		if(i<rowCount-1)
			jsonStr+="},";
		else
			jsonStr+="}";
	});
	jsonStr+="]";
	$("#jaStr").val(jsonStr);
	console.log(jsonStr);
	//return false;
	
	renameFile();
	var formData = new FormData($("#form2")[0]);
	 
	$.ajax({
		type:"post",
		url:"addBatchHtmlGoodsHDQD",
		//dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (data){
			if(data.message=="ok"){
				alert(data.info);
				goBack();
			}
			else{
				alert(data.info);
			}
		}
	});
	//document.getElementById("sub_but").click();
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
	
	$("#hdap_tab input[id^='hdapIfShow']").each(function(){
		$(this).attr("value",false);
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
	
	var imageTab=$("#image1Mod_div table");
	var length=imageTab.find("td[id^='file_td']").length;
	imageTab.find("#upload_td").before("<td class=\"file_td\" id=\"file_td"+uuid+"\" style=\"width: 25%;\">"
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

function changeHDAPTrIfShow(index,o){
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

function nextStep(flag){
	if(flag==1)
		stepIndex++;
	else if(flag==-1)
		stepIndex--;
	else if(flag==0)
		stepIndex=1;
	
	if(stepIndex==1){
		var hdsjArr=[];
		var txtTdStr="";
		var noTxtTdStr="";
		$("input[id^='hdapIfShow']").each(function(i){
			var checked=$(this).val();
			if(checked=="true"){
				hdsjArr.push($("input[name^='hdapName']").eq(i).val());
			}
		});
		var conStr="";
		for(var i=1;i<=hdsjArr.length;i++){
			txtTdStr="";
			noTxtTdStr="";
			conStr+="<tr class=\"content_tr\">";
				txtTdStr+="<td>"+substringName(hdsjArr[i-1])+"</td>";
				txtTdStr+="<td>项目"+i+"</td>";
				txtTdStr+="<td>地点"+i+"</td>";
				noTxtTdStr+="<td></td><td></td><td></td>";
				conStr+=txtTdStr+noTxtTdStr;
			conStr+="</tr>";
		}
		console.log(conStr);
		
		var excelTab=$("#xzmb_div #excel_tab");
		excelTab.empty();
		excelTab.append(conStr);
		
		$("#first_div").text("1");
		$("#first_div").css("color","#fff");
		$("#first_div").css("background","#4caf50");
		$("#first_div").css("border","1px solid #4caf50");
		$("#xzmb_span").css("color","#000");

		$("#second_div").text("2");
		$("#second_div").css("color","rgba(0,0,0,.45)");
		$("#second_div").css("background","#fff");
		$("#second_div").css("border","1px solid #bbb");
		$("#sc_span").css("color","rgba(0,0,0,.45)");
		
		$("#third_div").css("color","rgba(0,0,0,.45)");
		$("#third_div").css("background","#fff");
		$("#third_div").css("border","1px solid #bbb");
		$("#qrsj_span").css("color","rgba(0,0,0,.45)");
		
		$("#xzmb_div").css("display","block");
		$("#scwj_div").css("display","none");
		$("#qrsjbsc_div").css("display","none");
	}
	else if(stepIndex==2){
		$("#first_div").text("√");
		$("#first_div").css("color","#4caf50");
		$("#first_div").css("background","#fff");
		$("#first_div").css("border","1px solid #4caf50");
		$("#xzmb_span").css("color","rgba(0,0,0,.45)");
		
		$("#second_div").css("color","#fff");
		$("#second_div").css("background","#4caf50");
		$("#second_div").css("border","1px solid #4caf50");
		$("#sc_span").css("color","#000");
		
		$("#xzmb_div").css("display","none");
		$("#scwj_div").css("display","block");
		
		$("#scwj_div #main_div").css("display","block");
		$("#scwj_div #but_div").css("display","block");
		$("#scwj_div #warn_div").css("display","none");
		$("#scwj_div #sffgmb_div").css("display","none");
	}
	else if(stepIndex==3){
		$("#second_div").text("√");
		$("#second_div").css("color","#4caf50");
		$("#second_div").css("background","#fff");
		$("#second_div").css("border","1px solid #4caf50");
		$("#sc_span").css("color","rgba(0,0,0,.45)");
		
		$("#third_div").css("color","#fff");
		$("#third_div").css("background","#4caf50");
		$("#third_div").css("border","1px solid #4caf50");
		$("#qrsj_span").css("color","#000");

		$("#scwj_div").css("display","none");
		$("#qrsjbsc_div").css("display","block");
	}
}

function substringName(name){
	if(name.length>4){
		name=name.substring(0,4)+"...";
	}
	return name;
}

function openUploadExcelDialog(flag){
	$("#uploadExcelBg_div").css("display",flag==1?"block":"none");
	nextStep(0);
}

var hdapJA;
function uploadExcel(){
	var formData = new FormData($("#form1")[0]);
	 
	$.ajax({
		type:"post",
		url:path+"merchant/excel/loadExcelData",
		//dataType: "json",
		data:formData,
		cache: false,
		processData: false,
		contentType: false,
		success: function (result){
			var resultJO=JSON.parse(result);
			var ja=resultJO.data;
			if(resultJO.status==1){
				if(checkExcelKey(ja[0]))
					initQrsjbscExcelTab();
			}
			else{
				alert(resultJO.msg);
			}
		}
	});
}

function initQrsjbscExcelTab(){
	nextStep(1);
	var excelTab=$("#qrsjbsc_div #excel_tab");
	excelTab.empty();
	var jo=hdapJA[0];
	var trStr="<thead><tr class=\"xh_tr\"><th></th>";
	for(var it in jo){
		//console.log(it.substring(5));
		//console.log(jo[it]);
		trStr+="<th>"+String.fromCharCode(65+parseInt(it.substring(5)))+"</th>";
	}
	trStr+="</tr></thead>";
	console.log(trStr);
	trStr+="<tbody>";
	
	for(var i=0;i<hdapJA.length;i++){
		var jo=hdapJA[i];
		trStr+="<tr class=\"content_tr\">";
		trStr+="<td class=\"num_td\">"+(i+1)+"</td>";
		for(var key in jo){
			trStr+="<td class=\"val_td\" text=\""+jo[key]+"\">"+substringName(jo[key])+"</td>";
		}
		trStr+="</tr>";
	}
	trStr+="</tbody>";
	excelTab.append(trStr);
	
	var dataCount=$("#qrsjbsc_div #excel_tab .content_tr").length;
	$("#qrsjbsc_div #dataCount_span").text(dataCount);
	$("#qrsjbsc_div #qrcodeCount_span").text(1);
	
	resetQrsjbscExcelTabStyle();
}

function resetQrsjbscExcelTabStyle(){
	var colCount=$("#qrsjbsc_div #excel_tab .tit_tr .val_td").length;
	if(colCount<6){
		$("#qrsjbsc_div #excel_tab .tit_tr .val_td").css("width",(650/colCount)+"px");
	}
	var rowCount=$("#qrsjbsc_div #excel_tab .content_tr").length;
	if(rowCount<6){
		var tbody=$("#qrsjbsc_div #excel_tab tbody");
		var trStr="";
		var jo=hdapJA[0];
		for(var i=0;i<6-rowCount;i++){
			trStr+="<tr class=\"noContent_tr\">";
			trStr+="<td class=\"num_td\"></td>";
			for(var key in jo){
				trStr+="<td class=\"val_td\"></td>";
			}
			trStr+="</tr>";
			trStr+="";
		}
		tbody.append(trStr);
	}
	var tdCount=$("#qrsjbsc_div #excel_tab .tit_tr td").length;
	$("#qrsjbsc_div #excel_tab").css("width",93*tdCount+"px");
}

function checkExcelKey(jo){
	hdapJA=jo["sheetContentJA"];
	var colCount=3;
	var keyCount=0;
	var mbezdStr="模版Excel字段：时间、项目、地点";
	var scezdStr="上传Excel字段：";
	var sheetJO=jo["sheetContentJA"][0];
	for(var key in sheetJO){
		keyCount++;
		scezdStr+=sheetJO[key]+"、";
	}
	//console.log(colCount+","+keyCount);
	if(colCount==keyCount)
		return true;
	else{
		$("#scwj_div #main_div").css("display","none");
		$("#scwj_div #but_div").css("display","none");
		$("#scwj_div #warn_div").css("display","block");
		$("#scwj_div #sffgmb_div").css("display","block");
		
		mbezdStr=mbezdStr.substring(0,mbezdStr.length-1);
		scezdStr=scezdStr.substring(0,scezdStr.length-1);
		mbezdStr+="等"+colCount+"个字段";
		scezdStr+="等"+keyCount+"个字段";
		
		$("#scwj_div #mbezd_div").text(mbezdStr);
		$("#scwj_div #scezd_div").text(scezdStr);
		return false;
	}
}

function downloadExcelModule(){
	var hdsjArr=[];
	$("input[id^='hdapIfShow']").each(function(i){
		var checked=$(this).val();
		if(checked=="true"){
			hdsjArr.push($("input[name^='hdapName']").eq(i).val());
		}
	});
	
	var jsonStr="[";
	var rowCount=hdsjArr.length;
	jsonStr+="{\"sheetName\":\"活动安排\",\"sheetContent\":[";
	for(var i=0;i<rowCount;i++){
		jsonStr+="{";
		jsonStr+="\"value0\":\""+hdsjArr[i]+"\",";
		jsonStr+="\"value1\":\"项目"+(i+1)+"\",";
		jsonStr+="\"value2\":\"地点"+(i+1)+"\"";
		
		if(i<rowCount-1)
			jsonStr+="},";
		else
			jsonStr+="}";
	}
	jsonStr+="]}";
	jsonStr+="]";
	console.log(jsonStr);
	//return false;
	location.href=path+"merchant/excel/downloadExcelModule?trade=hdqd&jsonStr="+encodeURI(jsonStr);
}

function chooseExcel(){
	document.getElementById("excel_file").click();
}
</script>
</head>
<body>
<div class="uploadExcelBg_div" id="uploadExcelBg_div">
	<div class="uploadExcel_div">
		<span class="close_span" onclick="openUploadExcelDialog(0)">×</span>
		<div class="step_div">
			<div class="first_div" id="first_div">1</div>
			<span class="xzmb_span" id="xzmb_span">下载Excel模版</span>
			<div class="line1_div"></div>
			<div class="second_div" id="second_div">2</div>
			<span class="sc_span" id="sc_span">上传Excel</span>
			<div class="line2_div"></div>
			<div class="third_div" id="third_div">3</div>
			<span class="qrsj_span">确认数据并生成</span>
		</div>
		
		<div class="xzmb_div" id="xzmb_div">
			<div class="mbxgTxt_div">Excel模版效果：（此处最多只预览6个字段）</div>
			<div class="mbxgContent_div">
				<div class="left_div">
					<img class="excel_img" src="<%=basePath %>/resource/images/spzs/excel_bg.19fbdf2a.jpg" alt="">
					<table class="excel_tab" id="excel_tab">
					</table>
					<div class="ckxgBut_div">查看二维码效果</div>
				</div>
				
				<div class="right_div">
					<div class="qxz_div">请下载Excel模版，按左图格式填入信息</div>
					<div class="dyh_div">第一行作为标题</div>
					<div class="deh_div">第二行开始填入信息，每行信息都会生成一个二维码</div>
					<div class="xzmbBut_div" onclick="downloadExcelModule()">下载Excel模版</div>
					<div class="ckzysx_div">查看Excel填写注意事项</div>
				</div>
				
			</div>
			<div class="wyth_div">
				<div class="wythBut_div" onclick="nextStep(1)">我已填好Excel，下一步</div>
			</div>
		</div>
		
		<div class="scwj_div" id="scwj_div">
			<div class="main_div" id="main_div">
				<form id="form1">
				<input type="file"  id="excel_file" name="excel_file" onchange="uploadExcel(this)" style="display: none;"/>
				</form>
				<div class="uploadBut_div" id="uploadBut_div" onclick="chooseExcel()">上传 Excel</div>
				<div class="downloadBut_div" onclick="downloadExcelModule()">下载Excel模版</div>
			</div>
			<div class="but_div" id="but_div">
				<div class="preBut_div" onclick="nextStep(-1)">上一步</div>
			</div>
			<div class="warn_div" id="warn_div">
				<div class="slbxd_div">上传的Excel列数与模版中Excel内容的字段数量不相等</div>
				<div class="mbezd_div" id="mbezd_div">模版Excel字段：工号、姓名、班组、工种、身份证号、联系电话、血型、进场...等12个字段</div>
				<div class="scezd_div" id="scezd_div">上传Excel字段：班组、工种、身份证号、联系电话、血型、进场时间、特种作...等10个字段</div>
				<div class="xzExcelMb_div" onclick="downloadExcelModule()">下载Excel模版</div>
			</div>
			<div class="sffgmb_div" id="sffgmb_div">
				<div class="sffg_div">是否将上传的Excel字段覆盖模版Excel字段?</div>
				<div class="but_div">
					<div class="cxscBut_div" onclick="chooseExcel()">否，重新上传</div>
					<div class="fgmbnrBut_div" onclick="initQrsjbscExcelTab()">是，覆盖Excel模版内容</div>
				</div>
			</div>
		</div>
		
		<div class="qrsjbsc_div" id="qrsjbsc_div">
			<div class="ylsjTxt_div">
				预览数据：本次共上传<span class="num_span" id="dataCount_span">4</span>条数据， 将生成<span class="num_span" id="qrcodeCount_span">4</span>个二维码
				<span class="reUpload_span" onclick="nextStep(0)">重新上传</span>
			</div>
			<div class="tab_div">
				<table class="excel_tab" id="excel_tab">
					<thead>
						<tr class="xh_tr">
							<th>1</th>
							<th>1</th>
							<th>1</th>
						</tr>
					</thead>
					<tbody>
						<tr class="tit_tr">
							<td>
								<div style="width:55px;height:25px;line-height:25px;text-align:center;margin:2px auto 0; background: #4caf50;color: #fff;border-radius: 4px;">标题行</div>
    						</td>
							<td>2</td>
							<td>2</td>
						</tr>
						<tr class="content_tr">
							<td class="num_td">3</td>
							<td class="val_td">3</td>
							<td>3</td>
						</tr>
						<tr class="content_tr">
							<td class="num_td">3</td>
							<td class="val_td">3</td>
							<td>3</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="ksscBut_div" onclick="addBatchHtmlGoodsHDQD()">开始生成</div>
		</div>
	</div>
</div>

<%@include file="../loginDialog.jsp"%>
<form id="form2" name="form2" method="post" action="addHtmlGoodsJZSG" onsubmit="return checkForm();" enctype="multipart/form-data">
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
						<img class="item_img" id="img1_1" alt="" src="/GoodsPublic/resource/images/jzsg/bf0b334d871019cf3b2359e22b405d1c.png">
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
	<div class="title_div">活动签到信息展示</div>
	<div class="myQrcode_div">我的二维码&nbsp;${sessionScope.user.userName }</div>
</div>
<div class="middle_div" id="middle_div">
	<div>
		<input class="title_input" type="text" id="title" name="title" placeholder="请输入标题" />
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
	<div class="memo1_div">
		<textarea class="memo1_ta" id="memo1" name="memo1" cols="100" rows="8"><%=htmlspecialchars(memo1) %></textarea>
	</div>
	<div class="hdap_div" id="hdap_div">
		<table class="hdap_tab" id="hdap_tab">
			<c:forEach items="${requestScope.hdapList }" var="hdap" varStatus="status">
			<tr class="item_tr" id="tr${status.index+1 }" height="50">
				<td class="name_td">
					<input type="text" name="hdapName${status.index+1 }" value="${hdap.name }" size="10" />
				</td>
				<td class="value_td">
					默认显示Excel导入内容
				</td>
				<td class="value2_td">
					默认显示Excel导入内容
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow${status.index+1 }" name="hdapIfShow${status.index+1 }" value="true" />
					<input type="button" class="hdapIfShow_inp" value="显示" onclick="changeHDAPTrIfShow(${status.index+1 },this)"/>
				</td>
			</tr>
			</c:forEach>
			<c:forEach begin="6" end="15" varStatus="status">
			<tr class="item_tr" id="tr${status.index }" height="50">
				<td class="name_td">
					<input type="text" name="hdapName${status.index }" value="未设置" size="10" />
				</td>
				<td class="value_td">
					默认显示Excel导入内容
				</td>
				<td class="value2_td">
					默认显示Excel导入内容
				</td>
				<td class="cz_td">
					<input type="hidden" id="hdapIfShow${status.index }" name="hdapIfShow${status.index }" value="true" />
					<input type="button" class="hdapIfShow_inp" value="显示" onclick="changeHDAPTrIfShow(${status.index },this)"/>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div class="space_div"></div>
</div>
<div class="right_div" id="right_div">
	<img class="uncreate_img" alt="" src="/GoodsPublic/resource/images/007.png">
	<div class="scscypm_div" onclick="openUploadExcelDialog(1);">上传Excel生成一批码</div>
</div>
	<input type="hidden" id="accountNumber_hid" name="accountNumber" value="${sessionScope.user.id }" />
	<input type="hidden" name="from" value="${param.from}"/>
	<input type="hidden" id="jaStr" name="jaStr"/>
	<!-- 
	<input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
	 -->
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