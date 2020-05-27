<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<%@include file="../js.jsp"%>
<script type="text/javascript">
var accountId='${sessionScope.user.id}';
$(function(){
	initQrcodeListDiv();
});

function initQrcodeListDiv(){
	var searchTxt=$("#search_inp").val();
	$.post("selectAdminQrcodeList",
		{searchTxt:searchTxt,accountId:accountId},
		function(data){
			console.log(data);
			var qrcodeListDiv=$("#qrcodeList_div");
			qrcodeListDiv.empty();
			if(data.status=="ok"){
				var qrcodeList=data.list;
				for(var i=0;i<qrcodeList.length;i++){
					var qrcode=qrcodeList[i];
					qrcodeListDiv.append("<div class=\"item_div\" onclick=\"openPreQrcodeBgDiv(1,'"+qrcode.qrcode+"')\">"
							+"<div class=\"name_div\">"+(qrcode.name==""?"暂无":qrcode.name)+"</div>"
							+"<div class=\"createTime_div\">"+qrcode.createTime+"</div>"
							+"<img class=\"qrcode_img\" alt=\"\" src=\"http://www.qrcodesy.com:8080/GoodsPublic/resource/images/qrcode.png\">"
						+"</div>");
				}
			}
		}
	,"json");
}

function openPreQrcodeBgDiv(flag,src){
	if(flag==1){
		$("#preQrcodeBg_div").css("display","block");
		$("#preQrcodeBg_div #qrcode_img").attr("src",src);
	}
	else{
		$("#preQrcodeBg_div").css("display","none");
		$("#preQrcodeBg_div #qrcode_img").attr("src","");
	}
}
</script>
<title>二维码列表</title>
<style type="text/css">
.preQrcodeBg_div{
	width: 100%;height:100%;background: rgba(0,0,0,0.65);position: fixed;display: none;
}
.preQrcode_div{
	width: 300px;height: 300px;margin: 100px auto;padding: 1px;
}
.preQrcode_div .close_span{
	color: #fff;float: right;margin-right: 10px;
}
.preQrcode_div .qrcode_div{
	width: 200px;height: 200px;margin: 30px auto 0;
}
.preQrcode_div .qrcode_img{
	width: 200px;height: 200px;
}

.ewmlbTit_div{
	height: 30px;line-height: 30px;text-align: center;font-weight: bold;
}
.search_div{
	width: 90%;height: 30px;background-color: #f9f9f9;margin: auto;
}
.search_img{
	margin-left: 5px;width: 20px;height: 20px;
}
.search_inp{
	width:320px;height: 25px;border: 0;background-color: #f9f9f9;
}
.qrcodeList_div{
	border-top: 1px solid #eee;margin-top: 10px;
}
.qrcodeList_div .item_div{
	height:60px;border-bottom: 1px solid #eee;padding: 1px;
}
.qrcodeList_div .item_div .name_div{
	margin-top: 5px;margin-left: 10px;
}
.qrcodeList_div .item_div .createTime_div{
	margin-top: 5px;margin-left: 10px;
}
.qrcodeList_div .item_div .qrcode_img{
	width: 30px;height: 30px;float: right;margin-top: -25px;margin-right: 20px;
}
.space_div{
	width: 100%;height:50px;
}
</style>
</head>
<body>
<div class="preQrcodeBg_div" id="preQrcodeBg_div">
	<div class="preQrcode_div" >
		<span class="close_span" onclick="openPreQrcodeBgDiv(0)">X</span>
		<div class="qrcode_div">
			<img class="qrcode_img" id="qrcode_img" alt="" src="">
		</div>
	</div>
</div>
<div class="ewmlbTit_div">二维码列表</div>
<div class="search_div">
	<img class="search_img" alt="" src="<%=basePath %>resource/images/jfdhjp/005.png" onclick="initQrcodeListDiv()">
	<input class="search_inp" id="search_inp" type="text" placeholder="搜索"/>
</div>
<div class="qrcodeList_div" id="qrcodeList_div">
	<div class="item_div">
		<div class="name_div">aaa</div>
		<div class="createTime_div">111111</div>
		<img class="qrcode_img" alt="" src="http://www.qrcodesy.com:8080/GoodsPublic/resource/images/qrcode.png">
	</div>
</div>
<div class="space_div"></div>
<%@include file="nav.jsp"%>
</body>
</html>