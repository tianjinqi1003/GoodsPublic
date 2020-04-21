<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<style type="text/css">
body{
	margin: 0;
}
</style>
<title>我的</title>
</head>
<body>
<div style="height:140px;padding-top:20px;padding-left:30px;background-color:#f9f9f9;">
	<div style="font-size: 20px;color: #373737;font-weight:700;">账户信息</div>
	<div style="margin-top:20px;">
		<span style="font-size: 14px;color: #373737;font-weight: 700;">昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</span>
		<span>${requestScope.accountMsg.nickName }</span>
	</div>
	<div style="margin-top:20px;">
		<span style="font-size: 14px;color: #373737;font-weight: 700;">用户账号：</span>
		<span>${requestScope.accountMsg.userName }</span>
	</div>
</div>
<div id="gsxx_div" style="height:210px;margin-top:20px;padding-top:20px;padding-left:30px;background-color:#f9f9f9;">
	<div style="font-size: 20px;color: #373737;font-weight:700;">公司信息</div>
	<div style="margin-top:20px;">
		<span style="font-size: 14px;color: #373737;font-weight: 700;">公&nbsp;&nbsp;司&nbsp;&nbsp;&nbsp;名&nbsp;&nbsp;称：</span>
		<span>${requestScope.accountMsg.companyName }</span>
	</div>
	<div style="margin-top:20px;">
		<span style="font-size: 14px;color: #373737;font-weight: 700;">公&nbsp;&nbsp;司&nbsp;&nbsp;&nbsp;地&nbsp;&nbsp;址：</span>
		<span>${requestScope.accountMsg.companyAddress }</span>
	</div>
	<div style="margin-top:20px;">
		<span style="font-size: 14px;color: #373737;font-weight: 700;">联&nbsp;&nbsp;系&nbsp;&nbsp;&nbsp;电&nbsp;&nbsp;话：</span>
		<span>${requestScope.accountMsg.phone }</span>
	</div>
	<div style="margin-top:20px;">
		<span style="font-size: 14px;color: #373737;font-weight: 700;">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</span>
		<span>${requestScope.accountMsg.email }</span>
	</div>
</div>
<%@include file="nav.jsp"%>
</body>
</html>