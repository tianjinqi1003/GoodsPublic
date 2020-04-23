<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>绑定辰麒账号</title>
</head>
<body>
<div style="font-size: 16px;text-align: center;">授权微信号</div>
<div style="font-size: 16px;text-align: center;">绑定你的辰麒账号</div>
<a style="text-decoration: none;" href="bindWX?accountId=${param.accountId}"><div style="width: 200px;height:30px;line-height:30px;margin:auto;color:#fff;text-align:center;background-color: #00A3FF;border-radius:4px;">立即授权绑定</div></a>
<div style="width: 200px;height:30px;line-height:30px;margin:auto;text-align:center;" onclick="WeixinJSBridge.call('closeWindow')">取消</div>
</body>
</html>