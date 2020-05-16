<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript">
function goPage(navNum){
	var url;
	switch(navNum){
	case 1:
		url="goAdminCreateQrcode?nav="+navNum;
		break;
	case 2:
		url="goAdminQrcodeList?nav="+navNum;
		break;
	case 3:
		url="goAdminMine?nav="+navNum;
		break;
	}
	location.href=url;
}
</script>
<style type="text/css">
.nav_div{
	width: 100%;height: 50px;bottom: 0;border-top: #eee solid 1px;background-color: #fff;position: fixed;
}
.nav_div .item_div{
	width: 33%;height: 50px;
}
.nav_div .zjgx_div{
	margin-top: -50px;margin-left: 33%;
}
.nav_div .mine_div{
	margin-top: -50px;margin-left: 66%;
}
.nav_div .item_div .navImg_div{
	width: 20px;height:20px;line-height:20px;margin: 2px auto 0;
}
.nav_div .item_div .nav_img{
	width: 20px;height:20px;
}
.nav_div .item_div .but_div{
	width: 100%;height:25px;line-height:25px;color: #999;font-size: 12px;text-align: center;
}
.nav_div .item_div .selected{
	color: #00A3FF;
}
</style>
<title>Insert title here</title>
</head>
<body>
<div class="nav_div">
	<div class="item_div" onclick="goPage(1)">
		<div class="navImg_div">
			<img class="nav_img" alt="" src="http://www.qrcodesy.com:8080/GoodsPublic/resource/images/qrcode.png">
		</div>
		<div class="but_div ${param.nav eq 1?'selected':'' }">立即生码</div>
	</div>
	<div class="item_div zjgx_div" onclick="goPage(2)">
		<div class="navImg_div">
			<img class="nav_img" alt="" src="http://www.qrcodesy.com:8080/GoodsPublic/resource/images/qrcode.png">
		</div>
		<div class="but_div ${param.nav eq 2?'selected':'' }">最近更新</div>
	</div>
	<div class="item_div mine_div" onclick="goPage(3)">
		<div class="navImg_div">
			<img class="nav_img" alt="" src="http://www.qrcodesy.com:8080/GoodsPublic/resource/images/qrcode.png">
		</div>
		<div class="but_div ${param.nav eq 3?'selected':'' }">我的</div>
	</div>
</div>
</body>
</html>