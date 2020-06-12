<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>价格方案</title>
<%@include file="../js.jsp"%>
<script type="text/javascript">
function goBuy(price){
	if(price==0){
		location.href="${pageContext.request.contextPath}/merchant/regist";
	}
	else{
	  $.ajax({
		 url:"${pageContext.request.contextPath}/merchant/checkIfLogin",
		 dataType:'jsonp',
		 processData: false, 
		 jsonp:'callback',
		 jsonpCallback:"jsonpCallback",
		 type:'get',
		 success:function(data){
		   var json=JSON.parse(data);
		   console.log(json);
		   if(json.status==0){
				location.href="${pageContext.request.contextPath}/merchant/main/goFeeBuy?price="+price;
		   }
		   else{
			  $("#login_bg_div").css("display","block");
			  $("#login_bg_div #price_hid").val(price);
		   }
		 },
		 error:function(XMLHttpRequest, textStatus, errorThrown) {
		   alert(XMLHttpRequest);
		   alert(XMLHttpRequest.status);
		   alert(XMLHttpRequest.readyState);
		   alert(textStatus);
		 }
	  });
	}
}
</script>
<style type="text/css">
body{
	font-size: 12px;
	font-family: Arial,"Microsoft Yahei";
}
.usePrice_div {
    width: 100%;
    height: 400px;
    text-align: center;
    background-color: #F9F9F9;
}
.usePrice_div .title1 {
    width: 100%;
    margin-top: 65px;
    font-size: 30px;
    text-align: center;
    position: absolute;
}
.usePrice_div .title2 {
    width: 100%;
    margin-top: 115px;
    font-size: 16px;
    text-align: center;
    position: absolute;
}
.usePrice_div .space_div {
    width: 100%;
    height: 175px;
}
.usePrice_div .list_div{
	width: 1032px;height:300px;margin: 0 auto;text-align: center;
}
.usePrice_div .list_div .item_div{
	width: 220px;height:380px;float: left;background-color: #fff;box-shadow: 0 2px 8px 0 rgba(0,0,0,.08);
}
.usePrice_div .list_div .jcb_div,.list_div .gjb_div,.list_div .hyb_div{
	margin-left: 50px;
}
.usePrice_div .list_div .item_div .p-t-md_div{
	font-size: 22px;
    font-weight: 500;
    margin-top: 30px;
    color: #363636;
}
.usePrice_div .list_div .item_div .p-b-md_div {
    color: #999;
    font-size: 14px;
    margin-top: 5px;
}
.usePrice_div .list_div .item_div .price_div {
    margin-top: 30px;
}
.usePrice_div .list_div .item_div .fuhao_span {
    color: #999;
}
.usePrice_div .list_div .item_div .jine_span {
    font-size: 18px;
    color: #363636;
}
.usePrice_div .list_div .item_div .text-intro_div {
    width: 100%;
    height: 60px;
}
.usePrice_div .list_div .item_div .text_div1 {
    text-align: center;
    color: #666;
    font-size: 12px;
    margin-top: 15px;
}
.usePrice_div .list_div .item_div .text_div2 {
    text-align: center;
    color: #666;
    font-size: 12px;
    margin-top: 5px;
}
.usePrice_div .list_div .item_div .buy_div {
    width: 112px;
    height: 38px;
    line-height: 38px;
    margin: 50px auto 0;
    font-size: 15px;
    color: #f57c00;
    border: #f57c00 solid 1px;
    border-radius: 5px;
    cursor: pointer;
}
.usePrice_div .list_div .item_div .buy_div:hover{
	color:#fff;
	background-color:#f57c00;
}

.version_div{
	width:1032px;
	/*
	height:292px;
	*/
	margin:0 auto;
	margin-top: 205px;
	margin-bottom: 50px;
}
.version_div .title_div{
	width:1032px;
	height:84px;
	border-bottom: 2px solid rgba(120,130,140,.25);
}
.version_div .title_div .col1_div{
	width:206px;
	float:left;
}
.version_div .title_div .bbdb_span{
	font-size:20px;
	font-weight: 600;
	margin-left:20px;
}
.version_div .title_div .col2_div,.version_div .title_div .col3_div,.version_div .title_div .col4_div,.version_div .title_div .col5_div{
	width:206px;
	float:left;
	text-align:center;
}
.version_div .title_div .long_div{
	font-size:16px;
	height:30px;
}
.version_div .title_div .fuhao_span{
	font-size:12px;
}
.version_div .title_div .price_span{
	font-size:16px;
	font-weight: 600;
}
.version_div .jcgn_div,.version_div .bbrl_div,.version_div .txjld_div,.version_div .qyzhxz_div,.version_div .qyppgn_div,.version_div .shfw_div{
	width:1032px;
	height:56px;
	line-height:56px;
	background:#F9F9F9;
}
.version_div .jcgn_span,.version_div .bbrl_span,.version_div .txjld_span,.version_div .qyzhxz_span,.version_div .qyppgn_span,.version_div .shfw_span{
	margin-left:20px;
	font-weight: 600;
}
.rightSign_span{
	color:#4caf50;
	font-size:18px;
}
.version_div .content_div{
	width:1032px;
	background:#F9F9F9;
}
.version_div .content_div .row_div{
	width:100%;
	height:40px;
}
.version_div .content_div .col1_div{
	width:206px;
	height:40px;
	line-height:40px;
	float:left;
}
.version_div .content_div .col1_span{
	color: #666;
	margin-left:20px;
}
.version_div .content_div .col2_div,.version_div .content_div .col3_div,.version_div .content_div .col4_div,.version_div .content_div .col5_div{
	width:206px;
	height:40px;
	line-height:40px;
	color: #666;
	text-align:center;
	float:left;
}
</style>
</head>
<body>
<div class="usePrice_div">
	<div class="title1">辰麒为你提供的不止是好用的产品，还有极具性价比的定价</div>
	<div class="title2">从内容展示到深度记录应用，满足不同规模不同需求，为企业创造价值</div>
	<div class="space_div"></div>
	<div class="list_div">
		<div class="item_div">
			<div class="p-t-md_div">免费版</div>
			<div class="p-b-md_div">免费试用</div>
			<div class="price_div">
				<span class="fuhao_span">￥</span>
				<span class="jine_span">0元/年</span>
			</div>
			<div class="text-intro_div">
				<div class="text_div1">二维码生成数量不限</div>
				<div class="text_div2">限时7天</div>
			</div>
			<div class="buy_div" onclick="goBuy(0);">
				立即购买
			</div>
		</div>
		<div class="item_div jcb_div">
			<div class="p-t-md_div">基础版</div>
			<div class="p-b-md_div">内容展示简单应用</div>
			<div class="price_div">
				<span class="fuhao_span">￥</span>
				<span class="jine_span">600元/年</span>
			</div>
			<div class="text-intro_div">
				<div class="text_div1">去除辰麒所有标识，开放所有模</div>
				<div class="text_div2">版和定制功能，客服一对一辅导</div>
			</div>
			<div class="buy_div" onclick="goBuy(600);">
				立即购买
			</div>
		</div>
		<div class="item_div gjb_div">
			<div class="p-t-md_div">高级版</div>
			<div class="p-b-md_div">内容展示多人协作</div>
			<div class="price_div">
				<span class="fuhao_span">￥</span>
				<span class="jine_span">1270元/年</span>
			</div>
			<div class="text-intro_div">
				<div class="text_div1">多管理员账号协作建码/数据管</div>
				<div class="text_div2">理，更大容量/少量个性化定制</div>
			</div>
			<div class="buy_div" onclick="goBuy(1270);">
				立即购买
			</div>
		</div>
		<div class="item_div hyb_div">
			<div class="p-t-md_div">行业版</div>
			<div class="p-b-md_div">行业专属二维码应用</div>
			<div class="price_div">
				<span class="fuhao_span">￥</span>
				<span class="jine_span">2670元/年</span>
			</div>
			<div class="text-intro_div">
				<div class="text_div1">多管理员账号协作建码/数据管</div>
				<div class="text_div2">理，根据客户需求定制功能开发</div>
			</div>
			<div class="buy_div" onclick="goBuy(2670);">
				立即购买
			</div>
		</div>
		<!-- 
		<div>
			<img alt="" src="http://192.168.230.1:8088/GoodsPublic/merchant/main/createQRCode?orderId=20150806125346">
		</div>
		 -->
	</div>
</div>

<div class="version_div">
	<div class="title_div">
		<div class="col1_div"><span class="bbdb_span">版本对比<span></span></span></div>
		<div class="col2_div">
			<div class="long_div">免费版</div>
			<span class="fuhao_span">￥</span>
			<span class="price_span">0元/年</span>
		</div>
		<div class="col3_div">
			<div class="long_div">基础版</div>
			<span class="fuhao_span">￥</span>
			<span class="price_span">600元/年</span>
		</div>
		<div class="col4_div">
			<div class="long_div">高级版</div>
			<span class="fuhao_span">￥</span>
			<span class="price_span">1270元/年</span>
		</div>
		<div class="col5_div">
			<div class="long_div">行业版</div>
			<span class="fuhao_span">￥</span>
			<span class="price_span">2670元/年</span>
		</div>
	</div>
	<div class="jcgn_div">
		<span class="jcgn_span">基础功能</span>
	</div>
	<div class="content_div">
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">二维码长期有效</span>
			</div>
			<div class="col2_div">
				<span class="rightSign_span"></span>
			</div>
			<div class="col3_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col4_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col5_div">
				<span class="rightSign_span">√</span>
			</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">二维码生成数量/扫描次数</span>
			</div>
			<div class="col2_div">不限</div>
			<div class="col3_div">不限</div>
			<div class="col4_div">不限</div>
			<div class="col5_div">不限</div>
		</div>
	</div>
	<div class="bbrl_div">
		<span class="bbrl_span">扫码展示图片、文件、音视频等内容</span>
	</div>
	<div class="content_div">
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">图片/文件上传总容量限额</span>
			</div>
			<div class="col2_div">50M</div>
			<div class="col3_div">1G</div>
			<div class="col4_div">3G</div>
			<div class="col5_div">30G</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">音视频上传总容量限额</span>
			</div>
			<div class="col2_div">500M</div>
			<div class="col3_div">不限</div>
			<div class="col4_div">不限</div>
			<div class="col5_div">不限</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">音视频播放人数</span>
			</div>
			<div class="col2_div">限5人播放体验</div>
			<div class="col3_div">不限</div>
			<div class="col4_div">不限</div>
			<div class="col5_div">不限</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">音视频高清播放流量</span>
			</div>
			<div class="col2_div">12G</div>
			<div class="col3_div">240G</div>
			<div class="col4_div">600G</div>
			<div class="col5_div">6000G</div>
		</div>
	</div>
	<div class="txjld_div">
		<span class="txjld_span">扫码填写记录单，收集多种信息</span>
	</div>
	<div class="content_div">
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">记录填写与查看</span>
			</div>
			<div class="col2_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col3_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col4_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col5_div">
				<span class="rightSign_span">√</span>
			</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">图片水印防作假</span>
			</div>
			<div class="col2_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col3_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col4_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col5_div">
				<span class="rightSign_span">√</span>
			</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">记录图片高清查看限额</span>
			</div>
			<div class="col2_div">100M</div>
			<div class="col3_div">100M</div>
			<div class="col4_div">100M</div>
			<div class="col5_div">不限</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">高级权限设置</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div">-</div>
			<div class="col4_div">-</div>
			<div class="col5_div">
				<span class="rightSign_span">√</span>
			</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">记录协作人数</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div">-</div>
			<div class="col4_div">-</div>
			<div class="col5_div">15名协作人</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">消息提醒人数（每个记录单）</span>
			</div>
			<div class="col2_div">3人</div>
			<div class="col3_div">3人</div>
			<div class="col4_div">3人</div>
			<div class="col5_div">不限</div>
		</div>
	</div>
	<div class="qyzhxz_div">
		<span class="qyzhxz_span">企业账号协作</span>
	</div>
	<div class="content_div">
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">协作管理权限</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div">-</div>
			<div class="col4_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col5_div">
				<span class="rightSign_span">√</span>
			</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">子管理员人数</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div">-</div>
			<div class="col4_div">2个</div>
			<div class="col5_div">5个</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">账号操作日志</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div">-</div>
			<div class="col4_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col5_div">
				<span class="rightSign_span">√</span>
			</div>
		</div>
	</div>
	<div class="qyppgn_div">
		<span class="qyppgn_span">企业品牌功能</span>
	</div>
	<div class="content_div">
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">去除页面底部辰麒标识</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div"><span class="rightSign_span">√</span></div>
			<div class="col4_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col5_div">
				<span class="rightSign_span">√</span>
			</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">去除网址活码中间页</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div"><span class="rightSign_span">√</span></div>
			<div class="col4_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col5_div">
				<span class="rightSign_span">√</span>
			</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">企业自定义登录域名</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div">-</div>
			<div class="col4_div">-</div>
			<div class="col5_div">-</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">企业独立管理后台</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div">-</div>
			<div class="col4_div">-</div>
			<div class="col5_div">-</div>
		</div>
	</div>
	<div class="shfw_div">
		<span class="shfw_span">售后服务</span>
	</div>
	<div class="content_div">
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">在线客服</span>
			</div>
			<div class="col2_div">5*8小时工单支持</div>
			<div class="col3_div">1v1专属售后</div>
			<div class="col4_div">1v1专属售后</div>
			<div class="col5_div">1v1专属售后</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">发票和合同</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div"><span class="rightSign_span">√</span></div>
			<div class="col4_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col5_div">
				<span class="rightSign_span">√</span>
			</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">技术支持</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div"><span class="rightSign_span">√</span></div>
			<div class="col4_div">
				<span class="rightSign_span">√</span>
			</div>
			<div class="col5_div">
				<span class="rightSign_span">√</span>
			</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">远程培训服务</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div">-</div>
			<div class="col4_div">-</div>
			<div class="col5_div">-</div>
		</div>
		<div class="row_div">
			<div class="col1_div">
				<span class="col1_span">落地应用支持</span>
			</div>
			<div class="col2_div">-</div>
			<div class="col3_div">-</div>
			<div class="col4_div">-</div>
			<div class="col5_div">-</div>
		</div>
	</div>
</div>
</body>
</html>