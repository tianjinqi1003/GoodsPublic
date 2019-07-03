<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>预览</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
function editContent(goodsNumber,accountNumber){
	location.href="${pageContext.request.contextPath}/merchant/main/goEditModule?trade=dmtzl&goodsNumber="+goodsNumber+"&accountNumber="+accountNumber;
}
</script>
</head>
<body style="background-color: #fbfbfb;">
<div id="main_div" style="width: 800px;margin: 0 auto;background-color: #fbfbfb;">
	<div style="width: 100%;height: 60px;border:1px solid #a7e1c4;background-color: #ebf8f2;">
		<img alt="" src="/GoodsPublic/resource/images/006.png" style="width: 30px;height: 30px;margin-top: 15px;margin-left: 30px;">
		<span style="margin-top: 18px;margin-left: 30px;font-size: 15px;position: absolute;">生码成功！</span>
		<a href="${pageContext.request.contextPath}/merchant/main/goAddModule?trade=dmtzl" style="float: right;margin-top: 18px;margin-right: 50px;color: #357bb3;">新建二维码</a>
		<a href="${pageContext.request.contextPath}/merchant/main/goHtmlGoodsList?trade=dmtzl" style="float: right;margin-top: 18px;margin-right: 40px;color: #357bb3;">返回列表页</a>
	</div>
	<div id="left_div" style="width: 350px;margin-top: 20px;background-color: #fff;float: left;">
		<div style="width: 95%;height: 40px;line-height: 40px;text-align: center;font-size: 20px;font-weight: bold;">
			${requestScope.htmlGoodsDMTZL.title }
		</div>
		<div style="width:95%;margin-top: 20px;">
			${requestScope.htmlGoodsDMTZL.memo1 }
		</div>
		<div id="embed1_div" style="width: 95%;text-align: center;margin-top: 20px;">
			<c:if test="${requestScope.htmlGoodsDMTZL.embed1_1 ne null }">
				<embed alt="" src="${requestScope.htmlGoodsDMTZL.embed1_1 }" style="width: 95%;height: 300px;margin-top: 25px;">
			</c:if>
		</div>
		<div style="width:95%;margin-top: 20px;">
			${requestScope.htmlGoodsDMTZL.memo2 }
		</div>
		<div id="image1_div" style="width: 95%;text-align: center;">
			<c:if test="${requestScope.htmlGoodsDMTZL.image1_1 ne null }">
				<img alt="" src="${requestScope.htmlGoodsDMTZL.image1_1 }" style="width: 95%;height: 300px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsDMTZL.image1_2 ne null }">
				<img alt="" src="${requestScope.htmlGoodsDMTZL.image1_2 }" style="width: 95%;height: 300px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsDMTZL.image1_3 ne null }">
				<img alt="" src="${requestScope.htmlGoodsDMTZL.image1_3 }" style="width: 95%;height: 300px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsDMTZL.image1_4 ne null }">
				<img alt="" src="${requestScope.htmlGoodsDMTZL.image1_4 }" style="width: 95%;height: 300px;margin-top: 25px;">
			</c:if>
			<c:if test="${requestScope.htmlGoodsDMTZL.image1_5 ne null }">
				<img alt="" src="${requestScope.htmlGoodsDMTZL.image1_5 }" style="width: 95%;height: 300px;margin-top: 25px;">
			</c:if>
		</div>
	</div>
	<div style="width:400px;height: 280px;margin-top:20px;margin-left:50px;background-color: #fff;float: left;">
		<div style="width: 100%;height: 200px;">
			<div style="float: left;width:120px;height: 120px;margin-top:15px;margin-left: 15px;">
				<img alt="" src="${requestScope.htmlGoodsDMTZL.qrCode }" style="width: 120px;height: 120px;" />
				<div style="width: 100px;height: 30px;line-height: 30px;text-align:center;margin:0 auto;border:1px solid #eee;border-radius:3px;">下载二维码</div>
			</div>
			<div style="float: left;width:250px;margin-top:20px;margin-left: 10px;">
				<div style="width: 100%;height: 25px;">
					<a style="color: #357bb3;">排版打印</a>
				</div>
				<div style="width: 100%;height: 25px;">
					<a style="color: #357bb3;">下载其他格式</a>
				</div>
				<div style="width: 100%;height: 25px;">
					<a style="color: #357bb3;">二维码美化</a>
				</div>
				<div style="width: 100%;height: 25px;">
					<a style="color: #357bb3;">换个美化模板</a>
				</div>
			</div>
		</div>
		<div style="width: 350px;height: 1px;margin-left:20px; background-color: #eee;"></div>
		<div style="width: 100%;height: 50px;margin-top:15px;">
			<div style="float: left;width: 100px;height: 30px;line-height: 30px;text-align:center;margin-left:25px;color:#fff;background-color: #4caf50;border-radius:3px;" onclick="editContent(${requestScope.htmlGoodsDMTZL.goodsNumber },${requestScope.htmlGoodsDMTZL.accountNumber });">编辑内容</div>
			<div style="float: left;width:250px;margin-top: 5px;margin-left: 10px;">
				<a style="color: #357bb3;">创建副本</a>
				<a style="color: #357bb3;">删除</a>
			</div>
		</div>
		<div style="width: 350px;height: 1px;margin-left:20px; background-color: #eee;"></div>
	</div>
</div>
</body>
</html>