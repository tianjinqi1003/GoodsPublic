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
	/*
	var ht=$("#htmlContent_div").html();
	$("#glsList_div #goodsLabelSet_div").each(function(){
		var label=$(this).attr("attr-label");
		var key=$(this).attr("attr-key");
		var value=$(this).attr("attr-value");
		
		var repKeyStr="{goodsLabelSet."+key+"}";
		ht=ht.replace(repKeyStr,label);
		
		var repValStr="{plan."+key+"}";
		ht=ht.replace(repValStr,value);
		//console.log(label+","+key+","+value);
	});
	$("#htmlContent_div").html(ht);
	*/
	
	$("#mainMsg1 #htmlContent_div").find("img").each(function(){
		var title=$(this).attr("title");
		if(title!=""&title!=null){
			$(this).click(function(){
				location.href=title;
			});
		}
	});
	
	$("#mainMsg1 #htmlContent_div #imgUrl_img").click(function(){
		previewImg($(this).attr("src"));
	});
})

//预览图片
function previewImg(src) {
	$("#previewDiv").css("display", "block");
	$("#previewDiv img").attr("src", src);
}

//关闭预览
function unPreviewImg(o) {
	$(o).css("display", "none");
	$(o).find("img").attr("src", "");
}
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

.avatarImg {
	width: 256px;
	height:256px;
}
</style>
<%@include file="js.jsp"%>
</head>
<body>
	<div id="previewDiv" style="width: 100%;height: 300px;margin-top:680px;position:absolute;text-align: center;display:none;z-index: 1;" onclick="unPreviewImg(this);">
		<img alt="" src="" style="width: 300px; height: 300px; margin: 0 auto;" />
	</div>
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
					<img class="avatarImg" src="${accountMsg.avatar_img }">
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
							<!-- 
							<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
								<span style="margin-left:10px;color: #686868;">${plan.title}</span>
							</div>
							 -->
							<!-- 
							<div id="htmlContent_div" style="width: 100%;background-color: #fff;">
								${plan.htmlContent}
							</div>
							<c:forEach items="${requestScope.glsList }" var="goodsLabelSet">
								<c:if test="${goodsLabelSet.isShow }">
									<c:choose>
										<c:when test="${goodsLabelSet.key eq 'imgUrl' }">
										</c:when>
										<c:when test="${goodsLabelSet.key eq 'htmlContent' }">
											<div id="htmlContent_div" style="width: 100%;background-color: #fff;">
												${goodsLabelSet.label }:${plan.htmlContent}
											</div>
										</c:when>
										<c:otherwise>
											<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;">
												<span style="margin-left:10px;color: #686868;">${goodsLabelSet.label }:${plan[goodsLabelSet.key]}</span>
											</div>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:forEach>
							 -->
							 <div id="glsList_div">
								<c:forEach items="${requestScope.glsList }" var="goodsLabelSet">
									<c:if test="${goodsLabelSet.isShow }">
										<c:choose>
											<c:when test="${goodsLabelSet.key eq 'imgUrl' }">
												<div style="width: 100%;height: 220px;line-height: 220px;background-color: #fff;text-align: center;">
													<img alt="" src="${plan[goodsLabelSet.key]}" style="width:200px;height:200px;margin-top: 10px;">
												</div>
											</c:when>
											<c:when test="${goodsLabelSet.key eq 'htmlContent' }">
												<div style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;text-align: center;">产品详情</div>
												<div style="width: 100%;padding-bottom:10px; background-color: #fff;">
													<span style="margin-left:20px;">${plan[goodsLabelSet.key]}</span>
												</div>
											</c:when>
											<c:otherwise>
												<div id="goodsLabelSet_div" style="width: 100%;height: 40px;line-height: 40px;background-color: #fff;" attr-label="${goodsLabelSet.label }" attr-key="${goodsLabelSet.key }" attr-value="${plan[goodsLabelSet.key]}">
													<span style="margin-left:20px;">${goodsLabelSet.label }:${plan[goodsLabelSet.key]}</span>
												</div>
											</c:otherwise>
										</c:choose>
									</c:if>
								</c:forEach>
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
								<span style="margin-left:20px;color: #686868;" onclick="goFlagGoods('${goods.goodsNumber }','${param.accountId}');">${goods.title }</span>
							</div>
							<div style="width: 100%;height: 260px;text-align: center;background-color: #fff;">
								<img alt="" src="${goods.imgUrl }" onclick="location.href='/GoodsPublic/merchant/main/show?goodsNumber=${goods.goodsNumber }&accountId=${param.accountId}';" style="width: 256px;height:256px;">
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
				
				function goFlagGoods(goodsNumber,accountId){
					var url=location.href.substring(0,location.href.indexOf("GoodsPublic")-1)+baseUrl+"/merchant/main/show?goodsNumber="+goodsNumber+"&accountId="+accountId;
					window.location.href=url;
				}
			</script>
		</div>
	</div>
</body>
</html>