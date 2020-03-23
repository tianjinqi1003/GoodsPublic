<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="../../js.jsp"%>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../../side.jsp"%>
	<div id="gkjfqd_div" style="height:230px;margin-top:20px;margin-left: 238px;padding-top:15px;padding-left:15px;background-color:#FAFDFE;">
		<div style="font-size: 20px;color: #373737;font-weight:700;">顾客积分清单</div>
		<div>
			<div class="item_div">
				<div style="color: #999;width: 100%;height:30px;line-height:30px;">3月13日</div>
				<div style="background-color: #fff;width: 100%;height:120px;">
					<span style="color: #000;margin-top: 10px;margin-left: 10px;position: absolute;">李天赐</span>
					<span style="color: #00f;margin-top: 10px;margin-right: 110px;float: right;cursor: pointer;">查看积分明细</span>
					<span style="color: #999;margin-top: 40px;margin-left: 10px;position: absolute;">奖品码   123</span>
					<span style="color: #999;margin-top: 40px;margin-left: 228px;position: absolute;">消费次数:12</span>
					<span style="color: #999;margin-top: 70px;margin-left: 10px;position: absolute;">剩余积分:20</span>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>