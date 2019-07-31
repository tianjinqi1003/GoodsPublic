<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
    System.out.println("1111111111111111");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
var baseUrl="${pageContext.request.contextPath}";
$(function(){
	var date=new Date();
	var payTime=date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
	date.setMonth(date.getMonth()+7);
	var endTime=date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
	$.post(baseUrl+"/merchant/main/kaiTong",
		{accountNumber:"32",payTime:payTime,endTime:endTime,vipType:1,payType:2,money:"0.01",phone:"13608977126"},
		function(data){
			
		}
	,"json");
});
</script>
</head>
<body>

</body>
</html>