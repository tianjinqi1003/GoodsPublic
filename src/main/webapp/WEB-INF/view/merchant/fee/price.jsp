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
	location.href="${pageContext.request.contextPath}/merchant/main/goFeeBuy?price="+price;
}
</script>
</head>
<body style="background-color: #eee;">
<div style="width: 1020px;height:300px;margin: 0 auto;">
	<div style="width: 200px;height:300px;background-color: #fff;">
		<div style="width:150px; color: #999;margin: 0 auto;padding-top:20px;text-align: center;">一个月</div>
		<div style="width:150px; color: #999;margin: 0 auto;margin-top:15px;text-align: center;">￥<span style="color: #000;font-size: 30px;">60</span></div>
		<div style="width: 100px;height: 40px;line-height: 40px;text-align:center;color:#f57c00;margin: 0 auto;margin-top:20px;border:#f57c00 solid 1px;border-radius:5px;cursor: pointer;" onclick="goBuy(60);">
			立即购买
		</div>
	</div>
	<div style="width: 200px;height:300px;margin-top:-300px;margin-left:205px;background-color: #fff;">
		<div style="width:150px; color: #999;margin: 0 auto;padding-top:20px;text-align: center;">三个月</div>
		<div style="width:150px; color: #999;margin: 0 auto;margin-top:15px;text-align: center;">￥<span style="color: #000;font-size: 30px;">150</span></div>
		<div style="width: 100px;height: 40px;line-height: 40px;text-align:center;color:#f57c00;margin: 0 auto;margin-top:20px;border:#f57c00 solid 1px;border-radius:5px;cursor: pointer;" onclick="goBuy(150);">
			立即购买
		</div>
	</div>
	<div style="width: 200px;height:300px;margin-top:-300px;margin-left:410px;background-color: #fff;">
		<div style="width:150px; color: #999;margin: 0 auto;padding-top:20px;text-align: center;">一年</div>
		<div style="width:150px; color: #999;margin: 0 auto;margin-top:15px;text-align: center;">￥<span style="color: #000;font-size: 30px;">600</span></div>
		<div style="width: 100px;height: 40px;line-height: 40px;text-align:center;color:#f57c00;margin: 0 auto;margin-top:20px;border:#f57c00 solid 1px;border-radius:5px;cursor: pointer;" onclick="goBuy(600);">
			立即购买
		</div>
	</div>
	<div style="width: 200px;height:300px;margin-top:-300px;margin-left:615px;background-color: #fff;">
		<div style="width:150px; color: #999;margin: 0 auto;padding-top:20px;text-align: center;">永久</div>
		<div style="width:150px; color: #999;margin: 0 auto;margin-top:15px;text-align: center;">￥<span style="color: #000;font-size: 30px;">7000</span></div>
		<div style="width: 100px;height: 40px;line-height: 40px;text-align:center;color:#f57c00;margin: 0 auto;margin-top:20px;border:#f57c00 solid 1px;border-radius:5px;cursor: pointer;" onclick="goBuy(7000);">
			立即购买
		</div>
	</div>
	<div style="width: 200px;height:300px;margin-top:-300px;margin-left:820px;background-color: #fff;">
		<div style="width:150px; color: #999;margin: 0 auto;padding-top:20px;text-align: center;">连续包月</div>
		<div style="width:150px; color: #999;margin: 0 auto;margin-top:15px;text-align: center;">￥<span style="color: #000;font-size: 30px;">50</span></div>
		<div style="width: 100px;height: 40px;line-height: 40px;text-align:center;color:#f57c00;margin: 0 auto;margin-top:20px;border:#f57c00 solid 1px;border-radius:5px;cursor: pointer;" onclick="goBuy(50);">
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