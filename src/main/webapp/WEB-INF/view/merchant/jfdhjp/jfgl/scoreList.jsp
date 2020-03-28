<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.gkjfqd_div{
	height:230px;margin-top:20px;margin-left: 238px;padding-top:15px;padding-left:15px;background-color:#FAFDFE;
}
.gkjfqd_div .title_div{
	font-size: 20px;color: #373737;font-weight:700;
}
.list_div .item_div .createTime_div{
	color: #999;width: 100%;height:30px;line-height:30px;
}
.list_div .item_div .content_div{
	width: 100%;height:120px;background-color: #fff;
}
.list_div .item_div .nickName_span{
	color: #000;margin-top: 10px;margin-left: 10px;position: absolute;
}
.list_div .item_div .showDetail_span{
	color: #00f;margin-top: 10px;margin-right: 110px;float: right;cursor: pointer;
}
.list_div .item_div .codeNo_span{
	color: #999;margin-top: 40px;margin-left: 10px;position: absolute;
}
.list_div .item_div .takeCount_span{
	color: #999;margin-top: 40px;margin-left: 228px;position: absolute;
}
.list_div .item_div .score_span{
	color: #999;margin-top: 70px;margin-left: 10px;position: absolute;
}
</style>
<script type="text/javascript">
$(function(){
	$.post("queryCustomerScoreList",
		{accountId:'${sessionScope.user.id}'},
		function(data){
			if(data.status=="ok"){
				var listDiv=$("#list_div");
				listDiv.empty();
				var list=data.list;
				for(var i=0;i<list.length;i++){
					var item=list[i];
					listDiv.append("<div class=\"item_div\">"
								+"<div class=\"createTime_div\">"+item.createTime+"</div>"
								+"<div class=\"content_div\">"
									+"<span class=\"nickName_span\">"+item.nickName+"</span>"
									+"<span class=\"showDetail_span\">查看积分明细</span>"
									+"<span class=\"codeNo_span\">奖品码   "+item.codeNo+"</span>"
									+"<span class=\"takeCount_span\">消费次数:"+item.takeCount+"</span>"
									+"<span class=\"score_span\">剩余积分:"+item.score+"</span>"
								+"</div>"
							+"</div>");
				}
			}
			else{
				
			}
		}
	,"json");
});
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../../side.jsp"%>
	<div class="gkjfqd_div" id="gkjfqd_div">
		<div class="title_div">顾客积分清单</div>
		<div class="list_div" id="list_div">
			<div class="item_div">
				<div class="createTime_div">3月13日</div>
				<div class="content_div">
					<span class="nickName_span">李天赐</span>
					<span class="showDetail_span">查看积分明细</span>
					<span class="codeNo_span">奖品码   123</span>
					<span class="takeCount_span">消费次数:12</span>
					<span class="score_span">剩余积分:20</span>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>