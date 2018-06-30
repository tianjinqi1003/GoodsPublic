<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<title>测试标题</title>
<style type="text/css">
body {
	zoom: 1;
	font-family: '微软雅黑';
	color: #666;
	background: #f5f5f5;
}

.mainContent {
	width: 100%;
	margin: 0 auto;
}

.contentBody {
	height: 60px;
	background: #15bc7e;
	font-size: 21px;
	text-align: center;
	line-height: 60px;
	color: #fff;
	position: relative;
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

.mainMsg {
	padding: 0 10px;
}

.imgContent {
	height: 100%;
}

.imgItme {
	text-align: center;
}

.imgUrl {
	width: 80%
}
</style>
<%@include file="js.jsp"%>
</head>
<body>
	<div id="context">
		<div class="mainContent">
			<div class="contentBody">${plan.title}</div>
			<div class="imgContent">
				<div class="imgItme">
					<img class="imgUrl" src="${plan.imgUrl }">
				</div>
			</div>
			<div class="changeBtm">
				<a href="javascript:;" class="active">1</a> <a href="javascript:;">2</a>
				<a href="javascript:;">3</a>
			</div>
			<div class="msgContent">
				<div class="mainMsg" style="display: block;">
					${plan.htmlContent}</div>
				<div class="mainMsg" style="display: none;">2</div>
				<div class="mainMsg" style="display: none;">3</div>
			</div>
			<script type="text/javascript">
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
											$('.changeBtm a').removeClass(
													'active');
											$('.msgContent div.mainMsg').hide();
										}
										$(this).attr('class', 'active');
										$(
												'.msgContent div.mainMsg:nth-child('
														+ index + ')').show();
									});
				})
			</script>
		</div>
	</div>
</body>
</html>