<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>价格方案</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
function goBuy(price){
	if(price==0){
		location.href="${pageContext.request.contextPath}/merchant/regist";
	}
	else{
	  $.ajax({
		 url:"${pageContext.request.contextPath}/merchant/checkIfLogin",
		 dataType:'jsonp',
		 processData: false, 
		 jsonp:'callback',
		 jsonpCallback:"jsonpCallback",
		 type:'get',
		 success:function(data){
		   var json=JSON.parse(data);
		   console.log(json);
		   if(json.status==0){
				location.href="${pageContext.request.contextPath}/merchant/main/goFeeBuy?price="+price;
		   }
		   else{
			  $("#login_bg_div").css("display","block");
			  $("#login_bg_div #price_hid").val(price);
		   }
		 },
		 error:function(XMLHttpRequest, textStatus, errorThrown) {
		   alert(XMLHttpRequest);
		   alert(XMLHttpRequest.status);
		   alert(XMLHttpRequest.readyState);
		   alert(textStatus);
		 }
	  });
	}
}
</script>
<style type="text/css">
body{
	font-family: Arial,"Microsoft Yahei";
	background-color: #eee;
}
.list_div{
	width: 1032px;height:300px;margin: 0 auto;text-align: center;
}
.list_div .item_div{
	width: 220px;height:380px;float: left;background-color: #fff;box-shadow: 0 2px 8px 0 rgba(0,0,0,.08);
}
.list_div .jcb_div,.list_div .gjb_div,.list_div .hyb_div{
	margin-left: 50px;
}
.list_div .item_div .p-t-md_div{
	font-size: 22px;
    font-weight: 500;
    margin-top: 30px;
    color: #363636;
}
.list_div .item_div .p-b-md_div {
    color: #999;
    font-size: 14px;
    margin-top: 5px;
}
.list_div .item_div .price_div {
    margin-top: 30px;
}
.list_div .item_div .fuhao_span {
    color: #999;
}
.list_div .item_div .jine_span {
    font-size: 18px;
    color: #363636;
}
.list_div .item_div .text-intro_div {
    width: 100%;
    height: 60px;
}
.list_div .item_div .text_div1 {
    text-align: center;
    color: #666;
    font-size: 12px;
    margin-top: 15px;
}
.list_div .item_div .text_div2 {
    text-align: center;
    color: #666;
    font-size: 12px;
    margin-top: 5px;
}
.list_div .item_div .buy_div {
    width: 112px;
    height: 38px;
    line-height: 38px;
    margin: 50px auto 0;
    font-size: 15px;
    color: #f57c00;
    border: #f57c00 solid 1px;
    border-radius: 5px;
    cursor: pointer;
}
.list_div .item_div .buy_div:hover{
	color:#fff;
	background-color:#f57c00;
}
</style>
</head>
<body>
<div class="list_div">
	<div class="item_div">
		<div class="p-t-md_div">免费版</div>
		<div class="p-b-md_div">免费试用</div>
		<div class="price_div">
			<span class="fuhao_span">￥</span>
			<span class="jine_span">0元/年</span>
		</div>
		<div class="text-intro_div">
			<div class="text_div1">二维码生成数量不限</div>
			<div class="text_div2">限时7天</div>
		</div>
		<div class="buy_div" onclick="goBuy(0);">
			立即购买
		</div>
	</div>
	<div class="item_div jcb_div">
		<div class="p-t-md_div">基础版</div>
		<div class="p-b-md_div">内容展示简单应用</div>
		<div class="price_div">
			<span class="fuhao_span">￥</span>
			<span class="jine_span">600元/年</span>
		</div>
		<div class="text-intro_div">
			<div class="text_div1">去除辰麒所有标识，开放所有模</div>
			<div class="text_div2">版和定制功能，客服一对一辅导</div>
		</div>
		<div class="buy_div" onclick="goBuy(600);">
			立即购买
		</div>
	</div>
	<div class="item_div gjb_div">
		<div class="p-t-md_div">高级版</div>
		<div class="p-b-md_div">内容展示多人协作</div>
		<div class="price_div">
			<span class="fuhao_span">￥</span>
			<span class="jine_span">1270元/年</span>
		</div>
		<div class="text-intro_div">
			<div class="text_div1">多管理员账号协作建码/数据管</div>
			<div class="text_div2">理，更大容量/少量个性化定制</div>
		</div>
		<div class="buy_div" onclick="goBuy(1270);">
			立即购买
		</div>
	</div>
	<div class="item_div hyb_div">
		<div class="p-t-md_div">行业版</div>
		<div class="p-b-md_div">行业专属二维码应用</div>
		<div class="price_div">
			<span class="fuhao_span">￥</span>
			<span class="jine_span">2670元/年</span>
		</div>
		<div class="text-intro_div">
			<div class="text_div1">多管理员账号协作建码/数据管</div>
			<div class="text_div2">理，根据客户需求定制功能开发</div>
		</div>
		<div class="buy_div" onclick="goBuy(2670);">
			立即购买
		</div>
	</div>
	<!-- 
	<div>
		<img alt="" src="http://192.168.230.1:8088/GoodsPublic/merchant/main/createQRCode?orderId=20150806125346">
	</div>
	 -->
</div>
</body>
</html>