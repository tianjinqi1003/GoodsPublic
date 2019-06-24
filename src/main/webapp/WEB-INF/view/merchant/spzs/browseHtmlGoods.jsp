<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>预览</title>
</head>
<body>
<div>预览</div>
<div>
	${requestScope.htmlGoods.htmlContent }
</div>
<div>
	<img alt="" src="${requestScope.htmlGoods.qrCode }" />
</div>
</body>
</html>