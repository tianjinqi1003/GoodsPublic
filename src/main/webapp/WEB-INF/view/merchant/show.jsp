<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>测试标题</title>
<script type="text/javascript"
	src="../../resource/js/jquery-3.3.1.js"></script>
<script type="text/javascript">
$(function(){
	$("#mainMsg1 #htmlContent_div").find("img").each(function(){
		var title=$(this).attr("title");
		if(title!=""&title!=null){
			$(this).click(function(){
				location.href=title;
			});
		}
	});
})
</script>
<style type="text/css">
body {
	zoom: 1;
	font-family: '微软雅黑';
	color: #666;
	background-color: #F5F5F5;
}

.mainContent {
	width: 100%;
	margin: 0 auto;
}
.msgContent{
	word-break: break-all;
	word-wrap: break-word;
	margin-top: 60px;
	position: absolute;
}
.contentBody {
	height: 60px;
	background: #15bc7e;
	font-size: 21px;
	text-align: center;
	line-height: 60px;
	color: #fff;
}

.changeBtm {
	margin: 15px 0;
}

.changeBtm a {
	width: calc(33.333% - 13px);
	float: left;
	height: 45px;
	line-height: 45px;
	text-align: center;
	font-size: 16px;
	color: #757575;
	background: #e5e5e5;
	margin-left: 10px;
}

.changeBtm .active {
    outline: 0;
    color:#fff;
	background-color: #15BC7E;
}

.mainMsg {
	width:350px;
	padding: 0 10px;
}

.imgContent {
	width: 100%;
	height:265px;
	margin-top: 15px;
	background-color: #fff;
}

.imgItme {
	text-align: center;
}

.imgUrl {
	width: 256px;
	height:256px;
}
</style>
<%@include file="js.jsp"%>
</head>
<body>
	<div id="context">
		<div class="mainContent">
			<div class="contentBody">
				<!-- 
				${plan.title}
				 -->
				产品追溯详情
			</div>
			<div class="imgContent">
				<div class="imgItme">
					<img class="imgUrl" src="${plan.imgUrl }">
				</div>
			</div>
			<div style="background-color: #F5F5F5;width: 350px;height: 320px;margin: 0 auto;">
				<div class="changeBtm">
					<a href="javascript:;" class="active">商品介绍</a> 
					<a href="javascript:;">旗下产品</a>
					<a href="javascript:;">公司简介</a>
				</div>
				<div class="msgContent">
					<div class="mainMsg" id="mainMsg1" style="display: block;">
						<div style="width: 100%;height: 50px;line-height: 50px;background-color: #E5E5E5;">
							<span style="margin-left:20px;">查询信息</span>
							<img alt="" src="<%=basePath%>resource/images/001.png" style="float:right;margin-top:8px;margin-right:10px;font-size: 25px;"/>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">查询时间：${searchTime }</span>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">查询次数：1</span>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">商品编码：</span>
						</div>
						<div style="width: 100%;height: 50px;line-height: 50px;margin-top:15px;background-color: #E5E5E5;">
							<span style="margin-left:20px;">产品信息</span>
							<img alt="" src="<%=basePath%>resource/images/001.png" style="float:right;margin-top:8px;margin-right:10px;font-size: 25px;"/>
						</div>
						<div>
							<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
								<span style="margin-left:10px;color: #686868;">${plan.title}</span>
							</div>
							<div id="htmlContent_div" style="width: 100%;background-color: #fff;">
								${plan.htmlContent}
							</div>
						</div>
						<div style="width: 100%;height: 50px;line-height: 50px;margin-top:15px;background-color: #E5E5E5;">
							<span style="margin-left:20px;">企业信息</span>
							<img alt="" src="<%=basePath%>resource/images/001.png" style="float:right;margin-top:8px;margin-right:10px;font-size: 25px;"/>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">公司名称：${accountMsg.companyName}</span>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">联系电话：${accountMsg.phone}</span>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">公司传真：${accountMsg.fax}</span>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">公司地址：${accountMsg.companyAddress}</span>
						</div>
					</div>
					<div class="mainMsg" style="display: none;">
						<div style="width: 100%;height: 50px;line-height: 50px;background-color: #E5E5E5;">
							<span style="margin-left:20px;">旗下产品</span>
							<img alt="" src="<%=basePath%>resource/images/001.png" style="float:right;margin-top:8px;margin-right:10px;font-size: 25px;"/>
						</div>
						<c:forEach items="${flagGoodsList }" var="goods">
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;" onclick="goFlagGoods('${goods.goodsNumber }');">${goods.title }</span>
						</div>
						<div style="width: 100%;height: 260px;background-color: #fff;">
							<img alt="" src="${goods.imgUrl }" onclick="location.href='/GoodsPublic/merchant/main/show?goodsNumber=${goods.goodsNumber }';" style="width: 256px;height:256px;">
						</div>
						</c:forEach>
					</div>
					<div class="mainMsg" style="display: none;">
						<div style="width: 100%;height: 50px;line-height: 50px;background-color: #E5E5E5;">
							<span style="margin-left:20px;">公司简介</span>
							<img alt="" src="<%=basePath%>resource/images/001.png" style="float:right;margin-top:8px;margin-right:10px;font-size: 25px;"/>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">公司名称：${accountMsg.companyName}</span>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">联系电话：${accountMsg.phone}</span>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">公司传真：${accountMsg.fax}</span>
						</div>
						<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
							<span style="margin-left:20px;color: #686868;">公司地址：${accountMsg.companyAddress}</span>
						</div>
					</div>
				</div>
			</div>
			<script type="text/javascript">
				var baseUrl = "${pageContext.request.contextPath}";
				function GetRequest() {
					var url = location.search; //获取url中"?"符后的字串  
					var theRequest = new Object();
					if (url.indexOf("?") != -1) {
						var str = url.substr(1);
						strs = str.split("&");
						for (var i = 0; i < strs.length; i++) {
							theRequest[strs[i].split("=")[0]] = unescape(strs[i]
									.split("=")[1]);
						}
					}
					return theRequest;
				}
				$(function() {
					var theRequest = GetRequest()
					console.log(theRequest)
				})

				$(function() {
					var url = "/merchant/main/getGoods"
					var result = GetRequest()
					$('.changeBtm a')
							.click(
									function() {
										var index = $(this).index() + 1;
										for (var i = 0; i < $('.changeBtm a')
												.get().length; i++) {
											$('.changeBtm a').removeClass('active');
											$('.msgContent div.mainMsg').hide();
										}
										$(this).attr('class', 'active');
										$(
												'.msgContent div.mainMsg:nth-child('
														+ index + ')').show();
									});
				})
				
				function goFlagGoods(goodsNumber){
					var url=location.href.substring(0,location.href.indexOf("GoodsPublic")-1)+baseUrl+"/merchant/main/show?goodsNumber="+goodsNumber;
					window.location.href=url;
				}
			</script>
		</div>
	</div>
</body>
</html>