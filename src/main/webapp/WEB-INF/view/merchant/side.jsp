<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>边框导航栏</title>
<script type="text/javascript">
/*这个验证方法与其他页面的验证恰好相反，其他页面都是未付费不让用，而这里是未付费就跳转到相应链接页面付费，付过费了就不能再继续付费了
因为其他页面包含了这个页，虽然调用了同一个接口，必须用checkIfPaidInSide这个方法，把方法名区分开
function checkIfPaidInSide(){
	var bool=false;
	$.ajaxSetup({async:false});
	$.post("checkIfPaid",
		{accountNumber:'${sessionScope.user.id}'},
		function(data){
			if(data.status=="ok"&&data.vipType!=0){
				alert(data.message);
				bool=false;
			}
			else{
				bool=true;
			}
		}
	,"json");
	return bool;
}
*/
</script>
<style type="text/css">
.side {
	position: fixed;
	top: 50px;
	bottom: 0;
	height: 100%;
	justify-content: center;
	display: flex;
}

.head {
	align-items: center;
	position: relative;
	height: 50px;
	background-color: #20A0FF !important;
}

.headTitle, .headTitle>h1 {
	padding-left: 15px;
	margin: 0px auto;
}
.layui-nav .layui-nav-item a{
	color:#000;
}
.layui-nav .layui-nav-item .first-level-img{
	width:13px;height:13px;margin-top: 16px;margin-left: 18px;
}
.layui-nav .layui-nav-item .first-level-a{
	margin-top: -29px;margin-left: 18px;
}
.layui-nav .layui-nav-item .second-level-a{
	margin-left:19px;
}
.layui-nav .layui-nav-item .third-level-a{
	margin-left:38px;
}
.layui-nav .layui-nav-item .add_a{
	margin-top: -45px; margin-left: 113px;
}
.layui-nav .first-level .pointer-img{
	margin-top: 18px;
	margin-left: 127px;
	position: absolute;
}
.layui-nav .first-level{
    font-size: 15px;
	font-weight: bold;
	background-color: #E7F4FD;
}
.layui-nav .second-level .pointer-img{
	margin-top: 18px;
	margin-left: 160px;
	position: absolute;
}
.layui-nav,.layui-side{
	background-color: #FAFDFE;
}
.layui-side{
	border-right:#86B9D6 solid 1px;
}
.layui-layout-admin .layui-header{
	background-color:  #E7F4FD;
}

</style>
</head>
<body>
	<div class="layui-header ">
		<div class="layui-logo">
			<img alt="" src="<%=basePath%>resource/images/qrcode.png" style="width:36px;height:36px;margin-left: 5px;"/>
			<a style="font-size: 17px;margin-left:9px;">辰麒二维码管理平台</a>
		</div>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item"><a href="javascript:;"> <img
					src="http://t.cn/RCzsdCq" class="layui-nav-img">
					${requestScope.accountMsg.nickName }
			</a></li>
			<li class="layui-nav-item"><a href="<%=basePath%>merchant/exit">退出</a>
			</li>
		</ul>
	</div>

	<div class="layui-side ">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree layui-inline" lay-filter="demo"
				style="margin-right: 10px;height: 800px;">
				<div style="width: 100%; margin: 0 auto; margin-top: 20px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<img class="first-level-img" alt="" src="<%=basePath%>resource/images/008.png" />
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_5.jpg" />
						<a class="first-level-a">
							系统管理
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goAccountInfo?accountId=${sessionScope.user.id }">
							商家信息
						</a>
					</li>
		  			<!--  有权限   -->
					<shiro:hasRole  name="admin">
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>admin/goAccountList">
							成员管理
						</a>
					</li>
					</shiro:hasRole>
				</div>
				<div style="width: 100%; margin: 0 auto; margin-top: 5px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<img class="first-level-img" alt="" src="<%=basePath%>resource/images/008.png" />
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_5.jpg" />
						<a class="first-level-a">
							标签管理
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goGoodsLabelSetList?accountId=${sessionScope.user.id }">
							标签定义
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goCategoryList">
							分类管理
						</a>
					</li>
						
					<li class="layui-nav-item first-level">
						<img class="first-level-img" alt="" src="<%=basePath%>resource/images/008.png" />
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_5.jpg" />
						<a class="first-level-a">
							商品管理
						</a>
					</li>
					<c:choose>
						<c:when test="${empty sessionScope.categoryList}">
							<li class="layui-nav-item">
								<a href="<%=basePath%>merchant/main/goCategoryList">
									暂无分类
								</a>
							</li>
						</c:when>
						<c:otherwise>
							<c:forEach items="${sessionScope.categoryList }" var="item" varStatus="status">
								<li class="layui-nav-item">
									<a class="second-level-a" href="<%=basePath%>merchant/main/goGoodsList?categoryId=${item.categoryId}">
										${item.categoryName }
									</a>
									<a class="add_a" href="<%=basePath%>merchant/main/operation?categoryId=${item.categoryId}&accountId=${sessionScope.user.id}">
										|&nbsp;添加
									</a>
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<div style="width: 100%; margin: 0 auto; margin-top: 20px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<img class="first-level-img" alt="" src="<%=basePath%>resource/images/008.png" />
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_5.jpg" />
						<a class="first-level-a">
							行业模版
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=spzs&moduleType=redWine&accountId=${sessionScope.user.id }">
							红酒
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=spzs&moduleType=whiteWine&accountId=${sessionScope.user.id }">
							白酒
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=spzs&moduleType=homeTextiles&accountId=${sessionScope.user.id }">
							家纺
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=spzs&moduleType=artwork&accountId=${sessionScope.user.id }">
							艺术品
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=spzs&moduleType=productExplain&accountId=${sessionScope.user.id }">
							说明书
						</a>
					</li>
					<li class="layui-nav-item" style="display: none;">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=spzs&accountId=${sessionScope.user.id }">
							展示样品
						</a>
					</li>
					<li class="layui-nav-item second-level">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_5.jpg" />
						<a class="second-level-a">
							积分兑换奖品
						</a>
					</li>
						<li class="layui-nav-item">
							<a class="third-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=jfdhjp&nav=hdsz&accountId=${sessionScope.user.id }">
								活动设置
							</a>
						</li>
						<li class="layui-nav-item">
							<a class="third-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=jfdhjp&nav=ewmsc&accountId=${sessionScope.user.id }">
								二维码生成
							</a>
						</li>
						<li class="layui-nav-item">
							<a class="third-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=jfdhjp&nav=jfgl&accountId=${sessionScope.user.id }">
								用户积分管理
							</a>
						</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=dmtzl&accountId=${sessionScope.user.id }">
							多媒体资料
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=jzsg&accountId=${sessionScope.user.id }">
							建筑施工
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=hdqd&accountId=${sessionScope.user.id }">
							活动签到
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=dmtts&accountId=${sessionScope.user.id }">
							多媒体图书
						</a>
					</li>
					<li class="layui-nav-item" style="display: none;">
						<a class="second-level-a">
							名片
						</a>
					</li>
					<li class="layui-nav-item" style="display: none;">
						<a class="second-level-a">
							设备管理
						</a>
					</li>
				</div>
				<div style="width: 100%; margin: 0 auto; margin-top: 20px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<img class="first-level-img" alt="" src="<%=basePath%>resource/images/008.png" />
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_5.jpg" />
						<a class="first-level-a">
							vip付费管理
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>merchant/main/goFeePrice?accountId=${sessionScope.user.id }">
							付费
						</a>
					</li>
				</div>
				<!-- 
				<div style="width: 100%; margin: 0 auto; margin-top: 20px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<img class="first-level-img" alt="" src="<%=basePath%>resource/images/008.png" />
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_5.jpg" />
						<a class="first-level-a">
							商户管理
						</a>
					</li>
					<li class="layui-nav-item">
						<a class="second-level-a" href="<%=basePath%>admin/goAccountList">商户查询</a>
					</li>
				</div>
				 -->
			</ul>
		</div>
	</div>
</body>
</html>