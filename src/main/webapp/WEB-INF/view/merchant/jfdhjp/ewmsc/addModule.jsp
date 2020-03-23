<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加积分二维码</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
$(function(){
	$("#add_div").dialog({
		title:"添加积分二维码",
		width:setFitWidthInParent("body"),
		height:setFitHeightInParent(".layui-side"),
		top:60,
		left:200,
		buttons:[
           {text:"提交",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   checkAdd();
           }}
        ]
	});
	
	$("#add_div table").css("width","1000px");
	$("#add_div table").css("magin","-100px");
	$("#add_div table td").css("padding-left","50px");
	$("#add_div table td").css("padding-right","20px");
	$("#add_div table td").css("font-size","15px");
	$("#add_div table tr").css("height","45px");
	$("#add_div table tr").each(function(){
		$(this).find("td").eq(0).css("color","#006699");
		$(this).find("td").eq(0).css("border-right","#CAD9EA solid 1px");
		$(this).find("td").eq(0).css("font-weight","bold");
		$(this).find("td").eq(0).css("background-color","#FAFDFE");
	});

	$("#add_div table tr").mousemove(function(){
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
	
	$("#ok_but").css("left","45%");
	$("#ok_but").css("position","absolute");
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
	
	endTimeDTB=$("#endTime_dtb").datetimebox({
		width:200,
		editable:false
	});
});

function checkAdd(){
	document.getElementById("sub_but").click();
}

function checkForm(){
	if(checkIfLogined()){
		if(checkIfPaid()){
			if(checkScore()){
				if(checkEndTime()){
					return true;
				}
			}
		}
	}
	return false;
}

function focusScore(){
	var score = $("#score_inp").val();
	if(score=="积分不能为空"){
		$("#score_inp").val("");
		$("#score_inp").css("color", "#555555");
	}
}

function checkScore(){
	var score = $("#score_inp").val();
	if(score==null||score==""||score=="积分不能为空"){
		$("#score_inp").css("color","#E15748");
    	$("#score_inp").val("积分不能为空");
    	return false;
	}
	else{
		return true;
	}
}

function checkEndTime(){
	var endTime=endTimeDTB.datetimebox("getValue");
	if(endTime==""||endTime==null){
		alert("请选择活动到期时间！");
		return false;
	}
	else
		return true;
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

function showQrcodePic(obj){
	var $file = $(obj);
    var fileObj = $file[0];
    var windowURL = window.URL || window.webkitURL;
    var dataURL;
    var $img = $("#uploadImg");

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

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-200;
}

function setFitHeightInParent(o){
	var height=$(o).css("height");
	return height.substring(0,height.length-2)-98;
}

function initWindowMarginLeft(){
	var editDivWidth=$("#add_div").css("width");
	editDivWidth=editDivWidth.substring(0,editDivWidth.length-2);
	var pwWidth=$(".panel.window").css("width");
	pwWidth=pwWidth.substring(0,pwWidth.length-2);
	return ((editDivWidth-pwWidth)/2)+"px";
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
		<%@include file="../side.jsp"%>
		<div id="add_div">
			<form id="form1" name="form1" method="post" action="addScoreQrcode" onsubmit="return checkForm();" enctype="multipart/form-data">
			<input type="hidden" id="accountNumber" name="accountNumber" value="${sessionScope.user.id }"/>
			<table>
			   <tr style="border-bottom: #CAD9EA solid 1px;">
				 <td align="right">
					<span>商家logo</span>
				 </td>
				 <td style="padding-top: 7px;padding-bottom: 5px;">
					<img style='width: 100px; height: 100px' src="" class='uploadImg' id='uploadImg' /> 
					<input type="file" name="file" onchange="showQrcodePic(this)"/>
				 </td>
			   </tr>
			   <tr style="border-bottom: #CAD9EA solid 1px;">
				 <td align="right">
					<span>积分</span>
				 </td>
				 <td>
					<input id="score_inp" name="score" type="text" value="" maxlength="20" onfocus="focusScore()" onblur="checkScore()"/>
					<span style="color: #f00;">*</span>
				 </td>
			   </tr>
			   <tr style="border-bottom: #CAD9EA solid 1px;">
				 <td align="right">
					<span>活动到期时间</span>
				 </td>
				 <td>
					<input id="endTime_dtb" name="endTime" type="text" value="" maxlength="20" onblur="check"/>
					<span style="color: #f00;">*</span>
				 </td>
			   </tr>
			   <input type="submit" id="sub_but" name="button" value="提交内容" style="display: none;" />
			</table>
			</form>
		</div>
		<%@include file="../foot.jsp"%>
	</div>
<script>
	$(document).on("click", ".uploadImg", function () {
        var ele = this;
        //上传资讯图片
        var uploadInst = upload.render({
            elem: ele //绑定元素
            ,url: baseUrl + '/merchant/main/upload' //上传接口
            ,accept: 'images'
            ,exts: 'jpg|png|gif|bmp|jpeg'
            ,auto: true
            ,done: function(res){
                //上传完毕回调
                $("#imgUrl").val(res.data.src);
                <%--const rootDirectory = "${staticFilePath}";--%>
               // const rootDirectory = "http://120.27.5.36:8500/htkApp/";
                $(ele).attr('src',res.data.src);
            }
            ,error: function(){
                //请求异常回调
                layer_msg("exceptin", "上传图片失败");
            }
        });
    });
</script>
</body>
</html>