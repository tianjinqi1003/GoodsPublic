<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>积分二维码</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.bg_div{
	width: 100%;height:100%;
	background: rgba(0,0,0,0.65);
	position: fixed;
	display: none;
	z-index: 1001;
}
</style>
<script type="text/javascript" src="<%=basePath %>resource/js/pdf/jspdf.debug.js"></script>
<script type="text/javascript" src="<%=basePath %>resource/js/pdf/html2canvas.min.js"></script>
<script type="text/javascript">
var path='<%=basePath %>';
var accountNumber='${sessionScope.user.id }';
$(function(){
	initOutputPDFDiv();
	
	$("#add_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			if(checkIfPaid())
				location.href=path+"merchant/main/goAddModule?trade=jfdhjp";
		}
	});
	
	$("#batchAdd_but").linkbutton({
		iconCls:"icon-add",
		onClick:function(){
			if(checkIfPaid())
				location.href=path+"merchant/main/goBatchAddModule?trade=spzs&moduleType="+moduleType;
		}
	});
	
	$("#remove_but").linkbutton({
		iconCls:"icon-remove",
		onClick:function(){
			
		}
	});

	tab1=$("#tab1").datagrid({
		title:"积分二维码列表",
		url:"queryScoreQrcodeList",
		toolbar:"#toolbar",
		width:setFitWidthInParent("body"),
		pagination:true,
		pageSize:10,
		queryParams:{accountId:'${sessionScope.user.id}'},
		columns:[[
			{field:"qrcode",title:"二维码",width:200,formatter:function(value){
				return "<img alt=\"\" src=\""+value+"\" width=\"50\" height=\"50\" onclick=\"previewImg(this.src);\" />";
			}},
			{field:"score",title:"所含积分",width:200},
            {field:"createTime",title:"创建时间",width:200},
            {field:"endTime",title:"活动到期时间",width:200},
            {field:"uuid",title:"操作",width:150,formatter:function(value,row){
            	var str="<a href=\"${pageContext.request.contextPath}/merchant/main/goEditModule?trade=spzs&moduleType="+row.moduleType+"&goodsNumber="+row.goodsNumber+"&accountNumber="+row.accountNumber+"\">编辑</a>";
            	str+="&nbsp;&nbsp;<a onclick=\"showPreviewPDFDiv('"+row.shopLogo+"','"+row.score+"','"+row.endTime+"')\">导出pdf</a>";
            	return str;
            }}
	    ]],
        onLoadSuccess:function(data){
			if(data.total==0){
				$(this).datagrid("appendRow",{score:"<div style=\"text-align:center;\"><a href=\"${pageContext.request.contextPath}/merchant/main/goAddModule?trade=spzs&moduleType=redWine\">点击生成积分二维码</a><div>"});
				$(this).datagrid("mergeCells",{index:0,field:"score",colspan:5});
				data.total=0;
			}
			
			$(".panel-header .panel-title").css("color","#000");
			$(".panel-header .panel-title").css("font-size","15px");
			$(".panel-header .panel-title").css("padding-left","10px");
			$(".panel-header, .panel-body").css("border-color","#ddd");

			$(".datagrid-header td .datagrid-cell").each(function(){
				$(this).find("span").eq(0).css("margin-left","11px");
			});
			$(".datagrid-body td .datagrid-cell").each(function(){
				var html=$(this).html();
				$(this).html("<span style=\"margin-left:11px;\">"+html+"</span>");
			});
			reSizeCol();
		}
	});
});

function showPreviewPDFDiv(shopLogo,score,endTime){
	$("#bg_div").css("display","block");
	$("#previewPDF_div").dialog('open');
	
	$("#previewPDF_div #shopLogo_hid").val(shopLogo);
	$("#previewPDF_div #score_hid").val(score);
	$("#previewPDF_div #endTime_hid").val(endTime);
}

function initOutputPDFDiv(){
	$("#previewPDF_div").dialog({
		title:"pdf预览",
		width:setFitWidthInParent("body"),
		height:setFitHeightInParent(".layui-side"),
		buttons:[
           {text:"上一步",id:"pre_but",iconCls:"icon-ok",handler:function(){
        	   goStep(1);
           }},
           {text:"下一步",id:"next_but",iconCls:"icon-ok",handler:function(){
        	   goStep(2);
           }},
           {text:"导出jpg",id:"outputPdf_but",iconCls:"icon-ok",handler:function(){
        	   outputPdf();
           }}
        ]
	});
	
	$("#previewPDF_div").dialog('close');
	$("#previewPDF_div #tab1").css("width","1000px");
	$("#previewPDF_div #tab2").css("width","500px");
	$("#previewPDF_div table td").css("padding-left","20px");
	$("#previewPDF_div table td").css("padding-right","20px");
	$("#previewPDF_div table td").css("font-size","15px");
	$("#previewPDF_div table tr").css("height","45px");
	$("#previewPDF_div table tr").each(function(){
		$(this).find("td").eq(0).css("color","#006699");
		$(this).find("td").eq(0).css("border-right","#CAD9EA solid 1px");
		$(this).find("td").eq(0).css("font-weight","bold");
		$(this).find("td").eq(0).css("background-color","#FAFDFE");
	});

	$("#previewPDF_div table tr").mousemove(function(){
		$(this).css("background-color","#ddd");
	}).mouseout(function(){
		$(this).css("background-color","#fff");
	});

	$(".panel.window").css("width","983px");
	$(".panel.window").css("margin-top","20px");
	$(".panel.window").css("margin-left",initWindowMarginLeft());
	$(".panel.window .panel-title").css("color","#000");
	$(".panel.window .panel-title").css("font-size","15px");
	$(".panel.window .panel-title").css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").css("width","1000px");
	$(".window-shadow").css("margin-top","20px");
	$(".window-shadow").css("margin-left",initWindowMarginLeft());
	
	$(".window,.window .window-body").css("border-color","#ddd");

	$("#pre_but").css("left","30%");
	$("#pre_but").css("position","absolute");
	$("#next_but").css("left","45%");
	$("#next_but").css("position","absolute");
	$("#outputPdf_but").css("left","45%");
	$("#outputPdf_but").css("position","absolute");
	$("#outputPdf_but").css("display","none");
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
}

var marginTop=10;
var marginLeft=10;

function outputPdf(){
	var checked=$("#leftUp_rad").prop("checked");
	if(checked){
		$("#qrcode_div").css("width","500px");
		$("#qrcode_div").css("height","240px");
		$("#luta_div").css("border","0");
	}
	else{
		$("#qrcode_div").css("width","300px");
		$("#qrcode_div").css("height","400px");
		$("#qrcode_div #qrcode_img").css("margin-left","50px");
		$("#qrcode_div #rdta_div").css("margin-left","73px");
		$("#rdta_div").css("border","0");
	}
	$("#qrcode_img").css("border","0");
	
	var createCount=$("#createCount_inp").val();
	for(var i=0;i<createCount;i++){
		
		if(checked){
			if(i==0){
				
			}
			else if(i%3==1){
				marginTop=-262;
			    marginLeft+=530;
			}
			else if(i%3==0){
		    	marginTop+=282;
		    	marginLeft=10;
		    }
			else{
				marginLeft+=530;
			}
		}
		else{
			if(i==0){
				
			}
			else if(i%5==1){
				marginTop=-422;
			    marginLeft+=310;
			}
			else if(i%5==0){
		    	marginTop+=410;
		    	marginLeft=10;
		    }
			else{
				marginLeft+=310;
			}
		}
		
		var qrcodeDiv=$("#qrcode_div").clone();
		qrcodeDiv.attr("id","qrcode_div"+i);
		qrcodeDiv.css("margin-top",marginTop+"px");
		//qrcodeDiv.css("margin",marginTop+"px auto");
		qrcodeDiv.css("margin-left",marginLeft+"px");
	    $("#outputPdf_div").append(qrcodeDiv);
	}
	/*
	$("#outputPdf_div div[id^='qrcode_div']").each(function(i){
		createJFDHJPQrcode($(this),i);
	});
	*/


	//使用html2canvas 转换html为canvas
    html2canvas(document.getElementById('outputPdf_div')).then(function (canvas) {
       var imgUri = canvas.toDataURL("image/jpg").replace("image/jpg", "image/octet-stream"); // 获取生成的图片的url 　
       var saveLink = document.createElement('a');
       saveLink.href = imgUri;
       saveLink.download = 'downLoad.jpg';
       saveLink.click();
    });
	return false;

    var shopLogo=$("#shopLogo_hid").val();
    var score=$("#score_hid").val();
    var endTime=$("#endTime_hid").val();
    qrcodeUuidsStr=qrcodeUuidsStr.substring(1);
	qrcodeUrlsStr=qrcodeUrlsStr.substring(1);
    $.post("addBatchScoreQrcode",
	   {shopLogo:shopLogo,score:score,endTime:endTime,accountNumber:accountNumber,example:false,qrcodeUuidsStr:qrcodeUuidsStr,qrcodeUrlsStr:qrcodeUrlsStr},
	   function(data){
	   	  alert(data.info);
   	   }
    ,"json");
}

var qrcodeUuidsStr="";
var qrcodeUrlsStr="";
function createJFDHJPQrcode(qrcodeDiv,qrcodeIndex){
   $.ajaxSetup({async:false});
   $.post("createJFDHJPQrcode",
	   {accountNumber:accountNumber,qrcodeIndex:qrcodeIndex},
	   function(data){
		   var uuid=data.uuid;
		   var qrcodeUrl=data.qrcodeUrl;
		   qrcodeUuidsStr+=","+uuid;
		   qrcodeUrlsStr+=","+qrcodeUrl;
		   qrcodeDiv.attr("uuid",uuid);
		   qrcodeDiv.find("img[id='qrcode_img']").attr("src",qrcodeUrl);
   	   }
   ,"json");
}

function goStep(stepIndex){
	switch(stepIndex){
	case 1:
 		$("#previewPDF_div").css("height","527px");
		$("#previewPDF_div #tab1").css("display","block");
 		$("#previewPDF_div #tab1").css("height","443px");
	    $("#previewPDF_div #tab2").css("display","none");
 	    
 		$(".panel.window").css("width","983px");
 		$(".panel.window").css("height","586px");
 		$(".panel.window").css("margin-left",initWindowMarginLeft());
 		$(".window-shadow").css("width","1000px");
 		$(".window-shadow").css("height","586px");
 		$(".window-shadow").css("margin-left",initWindowMarginLeft());
 		$(".dialog-content").css("height","490px");
	    
 	    $("#previewPDF_div #next_but").css("display","block");
 	    $("#previewPDF_div #outputPdf_but").css("display","none");
		break;
	case 2:
 		$("#previewPDF_div").css("height","100px");
		$("#previewPDF_div #tab1").css("display","none");
 	    $("#previewPDF_div #tab2").css("display","block");
 		$("#previewPDF_div #tab2").css("height","60px");
 	    
 		$(".panel.window").css("width","480px");
 		$(".panel.window").css("height","150px");
 		$(".panel.window").css("margin-left",initWindowMarginLeft());
 		$(".window-shadow").css("width","500px");
 		$(".window-shadow").css("height","162px");
 		$(".window-shadow").css("margin-left",initWindowMarginLeft());
 		$(".dialog-content").css("height","60px");
 	    
 	    $("#previewPDF_div #next_but").css("display","none");
 	    $("#previewPDF_div #outputPdf_but").css("display","block");
 		$("#previewPDF_div #outputPdf_but").css("left","55%");
		break;
	case 3:
		break;
	}
}

function checkCreateCount(){
	var createCount = $("#createCount_inp").val();
	if(createCount==""||createCount==null){
		alert("请输入生成数量！");
		return false;
	}
	else
		return true;
}

//重设列宽
function reSizeCol(){
	var width=$(".panel.datagrid").css("width");
	width=width.substring(0,width.length-2);
	var cols=$(".datagrid-htable tr td");
	var colCount=cols.length;
	width=width-colCount*2;
	cols.css("width",width/colCount+"px");
	cols=$(".datagrid-btable tr").eq(0).find("td");
	colCount=cols.length;
	cols.css("width",width/colCount+"px");
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

function showTextLocArea(){
	var text=$("#text_ta").val();
	var checked=$("#leftUp_rad").prop("checked");
	if(checked){
		$("#luta_div").css("border","#999 dotted 1px");
		$("#luta_span").text(text);
		$("#rdta_div").css("border","0");
		$("#rdta_div").text("");
	}
	else{
		$("#luta_div").css("border","0");
		$("#luta_span").text("");
		$("#rdta_div").css("border","#999 dotted 1px");
		$("#rdta_div").text(text);
	}
}

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-270;
}

function setFitHeightInParent(o){
	var height=$(o).css("height");
	return height.substring(0,height.length-2)-98;
}

function initWindowMarginLeft(){
	var editDivWidth=$("#previewPDF_div").css("width");
	editDivWidth=editDivWidth.substring(0,editDivWidth.length-2);
	var pwWidth=$(".panel.window").css("width");
	pwWidth=pwWidth.substring(0,pwWidth.length-2);
	return ((editDivWidth-pwWidth)/2)+"px";
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<div class="bg_div" id="bg_div">
		<div id="previewPDF_div">
			<input type="hidden" id="shopLogo_hid"/>
			<input type="hidden" id="score_hid"/>
			<input type="hidden" id="endTime_hid"/>
			<table id="tab1">
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right" style="width:40%;">
					<div style="height: 45px;">
						<span style="margin-left:-252px;position: absolute;">文字位置：</span>
						<div style="width:150px;margin-left: 150px;position: absolute;">
							左上&nbsp;<input type="radio" id="leftUp_rad" name="textLoc" checked="checked" onclick="showTextLocArea()"/>&nbsp;&nbsp;&nbsp;
							右下&nbsp;<input type="radio" id="rightDown_rad" name="textLoc" onclick="showTextLocArea()"/>
						</div>
					</div>
					<div style="height: 200px;">
						<span style="margin-top: 25px;margin-left:-252px;position: absolute;">文字内容：</span>
						<textarea rows="10" cols="20" id="text_ta" maxlength="200" onkeyup="showTextLocArea();" style="margin-left: -172px;position: absolute;"></textarea>
					</div>
					<div style="height: 45px;">
						文字方位：
						<a class="easyui-linkbutton" onclick="resetPDFHtmlLocation('cpxh_span','up')">上移</a>
						<a class="easyui-linkbutton" onclick="resetPDFHtmlLocation('cpxh_span','down')">下移</a>
						<a class="easyui-linkbutton" onclick="resetPDFHtmlLocation('cpxh_span','left')">左移</a>
						<a class="easyui-linkbutton" onclick="resetPDFHtmlLocation('cpxh_span','right')">右移</a>
					</div>
					<div style="height: 45px;">
						二维码位置：
						<a class="easyui-linkbutton" onclick="resetPDFHtmlLocation('qpbh_span','up')">上移</a>
						<a class="easyui-linkbutton" onclick="resetPDFHtmlLocation('qpbh_span','down')">下移</a>
						<a class="easyui-linkbutton" onclick="resetPDFHtmlLocation('qpbh_span','left')">左移</a>
						<a class="easyui-linkbutton" onclick="resetPDFHtmlLocation('qpbh_span','right')">右移</a>
					</div>
				</td>
				<td>
					<div id="qrcode_div" style="width: 500px;height:400px;margin: 20px 0 20px;border: #999 solid 1px;">
						<div id="luta_div" style="width: 200px;height:120px;margin-top:60px;margin-left:20px;word-wrap:break-word;border: #999 dotted 1px;">
							<span id="luta_span" style="font-size: 20px;"></span>
						</div>
						<img id="qrcode_img" alt="" src="/GoodsPublic/upload/jfdhjp/20200330132119.jpg" style="width: 200px;height:200px;margin-top: -162px;margin-left: 250px;border: #999 dotted 1px;">
						<div id="rdta_div" style="width: 152px;height:130px;margin-top:16px;margin-left:273px;word-wrap:break-word;border: #999 dotted 0px;"></div>
					</div>
				</td>
			  </tr>
			</table>
			
			<table id="tab2" style="display: none;">
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right" style="width:40%;">
					二维码数量：
				</td>
				<td>
					<div style="width: 250px;">
						<input id="createCount_inp" name="createCount" type="number" value="1" maxlength="20" onblur="checkCreateCount()"/>
						<span style="color: #f00;">*</span>
					</div>
				</td>
			  </tr>
			</table>
		</div>
	</div>
	
	<%@include file="../../side.jsp"%>
	
	<div id="tab1_div" style="margin-top:20px;margin-left: 238px;">
		<div id="toolbar" style="height:32px;line-height:32px;">
			<a id="add_but" style="margin-left: 13px;">添加</a>
			<a id="batchAdd_but">Excel批量生成</a>
			<a id="remove_but">删除</a>
		</div>
		<table id="tab1">
		</table>
	</div>
	<%@include file="../../foot.jsp"%>
	
	<!-- background-color: yellow; -->
	<div id="outputPdf_div" style="width: 1600px;height:2264px;margin:0 auto;padding: 1px;display: block;">
	</div>
</div>
</body>
</html>