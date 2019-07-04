<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>边框导航栏</title>
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
.layui-nav .layui-nav-item .pointer-img{
	margin-top: 18px;
	margin-left: 18px;
	position: absolute;
}
.layui-nav .first-level{
    font-size: 15px;
	font-weight: bold;
	background-color: #E7F4FD;
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
			<img alt="" src="<%=basePath%>resource/images/qrcode.png"/>
			<a>二维码产品发布系统</a>
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
				style="margin-right: 10px;height: 800px;overflow-y:scroll;">
				<div style="width: 92%; margin: 0 auto; margin-top: 20px;border: #CAD9EA solid 1px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<a>
							系统管理
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="<%=basePath%>merchant/main/goAccountInfo?accountId=${sessionScope.user.id }">
							&nbsp;&nbsp;&nbsp;商家信息
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="<%=basePath%>merchant/main/goCategoryList">
							&nbsp;&nbsp;&nbsp;分类管理
						</a>
					</li>
				</div>
				<!-- 
				<li class="layui-nav-item">
					<a href="javascript:;" class="getCategory">店内分类</a>
					<dl class="layui-nav-child">
						 <c:choose>
						 <c:when test="${empty sessionScope.categoryList}">
							 <dd>
							 	<a href="<%=basePath%>merchant/main/goCategoryList">暂无分类</a>
							 </dd>
						 </c:when>
						 <c:otherwise>
							 <c:forEach items="${sessionScope.categoryList }" var="item">
							 <dd>
								<a href="<%=basePath%>merchant/main/queryGoodsList?categoryId=${item.categoryId}">${item.categoryName }</a>
								<a href="<%=basePath%>merchant/main/operation" style="margin-top: -40px;margin-left: 90px;">|&nbsp;添加</a>
							 </dd>
							 </c:forEach>
						 </c:otherwise>
						 </c:choose>
					</dl>
				</li>
				 -->
				<div style="width: 92%; margin: 0 auto; margin-top: 5px;border: #CAD9EA solid 1px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<a>
							商品管理
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
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
									<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
									<a href="<%=basePath%>merchant/main/goGoodsList?categoryId=${item.categoryId}">
										&nbsp;&nbsp;&nbsp;${item.categoryName }
									</a>
									<a href="<%=basePath%>merchant/main/operation?categoryId=${item.categoryId}&accountId=${sessionScope.user.id}" style="margin-top: -45px; margin-left: 90px;">
										|&nbsp;添加
									</a>
								</li>
								<c:if test="${status.index<sessionScope.categoryList.size()-1 }">
									<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<div style="width: 92%; margin: 0 auto; margin-top: 20px;border: #CAD9EA solid 1px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<a>
							标签管理
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="<%=basePath%>merchant/main/goGoodsLabelSetList?accountId=${sessionScope.user.id }">
							&nbsp;&nbsp;&nbsp;标签查询
						</a>
					</li>
				</div>
				<div style="width: 92%; margin: 0 auto; margin-top: 20px;border: #CAD9EA solid 1px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<a>
							模板快速生成
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=spzs&accountId=${sessionScope.user.id }">
							&nbsp;&nbsp;&nbsp;商品展示
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=dmtzl&accountId=${sessionScope.user.id }">
							&nbsp;&nbsp;&nbsp;多媒体资料
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="<%=basePath%>merchant/main/goHtmlGoodsList?trade=jzsg&accountId=${sessionScope.user.id }">
							&nbsp;&nbsp;&nbsp;建筑施工
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="">
							&nbsp;&nbsp;&nbsp;设备巡检
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="">
							&nbsp;&nbsp;&nbsp;物资标识
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="">
							&nbsp;&nbsp;&nbsp;无纸化记录
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="">
							&nbsp;&nbsp;&nbsp;其他应用
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="">
							&nbsp;&nbsp;&nbsp;自定义模板
						</a>
					</li>
				</div>
				<div style="width: 92%; margin: 0 auto; margin-top: 20px;border: #CAD9EA solid 1px;background-color: #F5FAFE;">
					<li class="layui-nav-item first-level">
						<a>
							vip付费管理
						</a>
					</li>
					<div style="width:100%;height: 1px;background-color: #CAD9EA;"></div>
					<li class="layui-nav-item">
						<img class="pointer-img" alt="" src="<%=basePath%>resource/images/ico_3.gif" />
						<a href="<%=basePath%>merchant/main/goFeePrice?accountId=${sessionScope.user.id }">
							&nbsp;&nbsp;&nbsp;付费
						</a>
					</li>
				</div>
			</ul>
			<shiro:hasRole  name="admin">
  			<!--  有权限   -->
			<ul class="layui-nav layui-nav-tree layui-inline" lay-filter="demo"
				style="margin-right: 10px;">
				<div style="border: #f3f3f4 solid 1px; width: 92%; margin: 0 auto; margin-top: 5px;">
					<li class="layui-nav-item">
						<a href="<%=basePath%>admin/goAccountList">商户查询</a>
					</li>
				</div>
			</ul>
			</shiro:hasRole>
		</div>
	</div>
</body>
</html>