<%@ page language="java" contentType="text/html; charset=utf-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑模板</title>
<%@include file="js.jsp"%>
<script type="text/javascript">
$(function(){
	$("#edit_div").dialog({
		title:"编辑模板",
		width:setFitWidthInParent("body"),
		height:setFitHeightInParent(".layui-side"),
		top:60,
		left:200,
		buttons:[
           {text:"提交",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   if(checkIfPaid())
        	   	  checkEdit();
           }}
        ]
	});
	
	$("#edit_div table").css("width","1000px");
	$("#edit_div table").css("magin","-100px");
	$("#edit_div table td").css("padding-left","50px");
	$("#edit_div table td").css("padding-right","20px");
	$("#edit_div table td").css("font-size","15px");
	$("#edit_div table tr").css("height","45px");
	$("#edit_div table tr").each(function(){
		$(this).find("td").eq(0).css("color","#006699");
		$(this).find("td").eq(0).css("border-right","#CAD9EA solid 1px");
		$(this).find("td").eq(0).css("font-weight","bold");
		$(this).find("td").eq(0).css("background-color","#F5FAFE");
	});

	$("#edit_div table tr").mousemove(function(){
		$(this).css("background-color","#ddd");
	}).mouseout(function(){
		$(this).css("background-color","#fff");
	});

	$(".panel.window").css("width","983px");
	$(".panel.window").css("margin-top","20px");
	$(".panel.window").css("margin-left",initWindowMarginLeft());
	$(".panel.window").css("background","linear-gradient(to bottom,#E7F4FD 0,#E7F4FD 20%)"); 
	$(".panel.window .panel-title").css("color","#000");
	$(".panel.window .panel-title").css("font-size","15px");
	$(".panel.window .panel-title").css("padding-left","10px");
	
	$(".panel-header, .panel-body").css("border-color","#ddd");
	
	//以下的是表格下面的面板
	$(".window-shadow").css("width","1000px");
	$(".window-shadow").css("margin-top","20px");
	$(".window-shadow").css("margin-left",initWindowMarginLeft());
	$(".window-shadow").css("background","#E7F4FD");
	
	$(".window,.window .window-body").css("border-color","#ddd");
	
	$("#ok_but").css("left","45%");
	$("#ok_but").css("position","absolute");
	$(".dialog-button").css("background-color","#fff");
	$(".dialog-button .l-btn-text").css("font-size","20px");
	
	$("#module").combobox({
		valueField:"value",
		textField:"text",
		data:[{"value":"","text":"请选择"},{"value":"operation","text":"商品添加"},{"value":"editGoods","text":"商品编辑"},{"value":"goodsList","text":"商品列表"}],
		disabled:true,
		onLoadSuccess:function(){
			$(this).combobox("setValue", '${requestScope.goodsLabelSet.module }');
		}
	});
	
	$("#isShow").combobox({
		valueField:"value",
		textField:"text",
		data:[{"value":"","text":"请选择"},{"value":"true","text":"是"},{"value":"false","text":"否"}],
		onLoadSuccess:function(){
			$(this).combobox("setValue", '${requestScope.goodsLabelSet.isShow }');
		}
	});
	
	$("#isPublic").combobox({
		valueField:"value",
		textField:"text",
		data:[{"value":"","text":"请选择"},{"value":"true","text":"是"},{"value":"false","text":"否"}],
		onLoadSuccess:function(){
			$(this).combobox("setValue", '${requestScope.goodsLabelSet.isPublic }');
		}
	});
	
	$("#isCheck").combobox({
		valueField:"value",
		textField:"text",
		data:[{"value":"","text":"请选择"},{"value":"true","text":"是"},{"value":"false","text":"否"}],
		onLoadSuccess:function(){
			$(this).combobox("setValue", '${requestScope.goodsLabelSet.isCheck }');
		}
	});
});

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

function checkEdit(){
	if(checkLabel()){
		if(checkModule()){
			if(checkIsShow()){
				if(checkIsPublic()){
					if(checkIsCheck()){
						if(checkSort()){
							editGoodsLabelSet();
						}
					}
				}
			}
		}
	}
}

function editGoodsLabelSet(){
	var id=$("#id").val();
	var key=$("#key").val();
	var accountNumber=$("#accountNumber").val();
	var label=$("#label").val();
	var module = $("#module").combobox("getValue");
	var isShow = $("#isShow").combobox("getValue");
	var isPublic = $("#isPublic").combobox("getValue");
	var isCheck = $("#isCheck").combobox("getValue");
	var sort = $("#sort").val();
	
	$.post("editGoodsLabelSet",
		{id:id,key:key,accountNumber:accountNumber,label:label,module:module,isShow:isShow,isPublic:isPublic,isCheck:isCheck,sort:sort},
		function(data){
			if(data.message=="ok"){
				alert(data.info);
				history.go(-1);
			}
			else{
				alert(data.info);
			}
		}
	,"json");
}

function focusLabel(){
	var label = $("#label").val();
	if(label=="标签名称不能为空"){
		$("#label").val("");
		$("#label").css("color", "#555555");
	}
}

//验证标签名称
function checkLabel(){
	var label = $("#label").val();
	if(label==null||label==""||label=="标签名称不能为空"){
		$("#label").css("color","#E15748");
    	$("#label").val("标签名称不能为空");
    	return false;
	}
	else
		return true;
}

//验证模块
function checkModule(){
	var module = $("#module").combobox("getValue");
	if(module==null||module==""){
	  	alert("请选择模块");
	  	return false;
	}
	else
		return true;
}

//验证是否显示
function checkIsShow(){
	var isShow = $("#isShow").combobox("getValue");
	if(isShow==null||isShow==""){
	  	alert("请选择是否显示");
	  	return false;
	}
	else
		return true;
}

//验证是否公有
function checkIsPublic(){
	var isPublic = $("#isPublic").combobox("getValue");
	if(isPublic==null||isPublic==""){
	  	alert("请选择是否公有");
	  	return false;
	}
	else
		return true;
}

//验证是否要验证
function checkIsCheck(){
	var isCheck = $("#isCheck").combobox("getValue");
	if(isCheck==null||isCheck==""){
	  	alert("请选择是否要验证");
	  	return false;
	}
	else
		return true;
}

function focusSort(){
	var sort = $("#sort").val();
	if(sort=="排序不能为空"){
		$("#sort").val("");
		$("#sort").css("color", "#555555");
	}
}

//验证排序
function checkSort(){
	var sort = $("#sort").val();
	if(sort==null||sort==""||sort=="排序不能为空"){
		$("#sort").css("color","#E15748");
    	$("#sort").val("排序不能为空");
    	return false;
	}
	else
		return true;
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
	var editDivWidth=$("#edit_div").css("width");
	editDivWidth=editDivWidth.substring(0,editDivWidth.length-2);
	var pwWidth=$(".panel.window").css("width");
	pwWidth=pwWidth.substring(0,pwWidth.length-2);
	return ((editDivWidth-pwWidth)/2)+"px";
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
		<%@include file="side.jsp"%>
		<div id="edit_div">
			<form id="form1" name="form1" method="post" action="editGoodsLabelSet" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${requestScope.goodsLabelSet.id }"/>
			<input type="hidden" id="accountNumber" name="accountNumber" value="${sessionScope.user.id }"/>
			<table>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					属性名称
				</td>
				<td>
					<span>${requestScope.goodsLabelSet.key }</span>
					<input type="hidden" id="key" name="key" value="${requestScope.goodsLabelSet.key }"/>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					标签名称
				</td>
				<td>
					<input id="label" name="label" type="text" value="${requestScope.goodsLabelSet.label }" onfocus="focusLabel()" onblur="checkLabel()"/>
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					所属模块
				</td>
				<td>
					<input id="module" name="module" />
					<span style="color: #f00;">*</span>
					<input type="hidden" id="module" name="module" value="${requestScope.goodsLabelSet.module }"/>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					是否显示
				</td>
				<td>
					<input id="isShow" name="isShow" />
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					是否公有
				</td>
				<td>
					<input id="isPublic" name="isPublic" />
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					是否要验证
				</td>
				<td>
					<input id="isCheck" name="isCheck" />
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			  <tr style="border-bottom: #CAD9EA solid 1px;">
				<td align="right">
					排序
				</td>
				<td>
					<input id="sort" name="sort" type="text" size="4" value="${requestScope.goodsLabelSet.sort }" onfocus="focusSort()" onblur="checkSort()"/>
					<span style="color: #f00;">*</span>
				</td>
			  </tr>
			</table>
			<!-- 
			<div style="height: 1px;width: 100%;background-color: #CAD9EA;margin-top: -214px;"></div>
			<div style="height: 1px;width: 100%;background-color: #CAD9EA;margin-top: -120px;"></div>
			<div style="height: 1px;width: 100%;background-color: #CAD9EA;margin-top: -46px;"></div>
			 -->
			</form>
		</div>
		<%@include file="foot.jsp"%>
	</div>
</body>
</html>