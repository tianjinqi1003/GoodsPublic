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
.list_div .item_div .createDate_div{
	color: #999;width: 100%;height:30px;line-height:30px;
}
.list_div .item_div .content_div{
	width: 100%;height:120px;background-color: #fff;
}
.list_div .item_div .nickName_span{
	color: #000;margin-top: 10px;margin-left: 10px;position: absolute;
}
.list_div .item_div .createTime_span{
	color: #000;margin-top: 10px;margin-left: 100px;position: absolute;
}
.list_div .item_div .showDetail_span{
	color: #00f;margin-top: 10px;margin-right: 110px;float: right;cursor: pointer;
}
.list_div .item_div .codeNo_div{
	width:200px;color: #999;margin-top: 40px;margin-left: 10px;position: absolute;
}
.list_div .item_div .codeEnable{
	color: #0f0;margin-top: 3px;margin-left: 10px;position: absolute;
}
.list_div .item_div .codeDisable{
	color: #f00;margin-top: 3px;margin-left: 10px;position: absolute;
}
.list_div .item_div .takeScore_span{
	color: #999;margin-top: 40px;margin-left: 228px;position: absolute;
}
.list_div .item_div .jfye_span{
	color: #999;margin-top: 40px;margin-left: 390px;position: absolute;
}
.list_div .item_div .takeCount_span{
	color: #999;margin-top: 70px;margin-left: 10px;position: absolute;
}
.list_div .item_div .takeScoreSum_span{
	color: #999;margin-top: 70px;margin-left: 228px;position: absolute;
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
					var htmlStr="<div class=\"createDate_div\">"+item.createDate+"</div>";
					htmlStr+="<div class=\"item_div\">";
					htmlStr+="<div class=\"content_div\">";
					htmlStr+="<span class=\"nickName_span\">"+item.nickName+"</span>";
					htmlStr+="<span class=\"createTime_span\">"+item.createTime+"</span>";
					htmlStr+="<span class=\"showDetail_span\">查看积分明细</span>";
					if(item.enable==null)
						htmlStr+="<div class=\"codeNo_div\">奖品码   暂无</div>";
					else
						htmlStr+="<div class=\"codeNo_div\">奖品码   <span class=\""+(item.enable?"codeEnable":"codeDisable")+"\">"+item.codeNo+"<span></div>";
					htmlStr+="<span class=\"takeScore_span\">消费积分:"+item.takeScore+"</span>";
					htmlStr+="<span class=\"jfye_span\">积分余额:"+item.jfye+"</span>";
					htmlStr+="<span class=\"takeCount_span\">消费次数:"+item.takeCount+"</span>";
					htmlStr+="<span class=\"takeScoreSum_span\">消费总积分:"+item.takeScoreSum+"</span>";
					htmlStr+="</div>";
					htmlStr+="</div>";
					listDiv.append(htmlStr);
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
			<div class="createTime_div">3月13日</div>
			<div class="item_div">
				<div class="content_div">
					<span class="nickName_span">李天赐</span>
					<span class="showDetail_span">查看积分明细</span>
					<div class="codeNo_div">奖品码   123</div>
					<span class="takeScore_span">消费积分:12</span>
					<span class="score_span">剩余积分:20</span>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../../foot.jsp"%>
</div>
</body>
</html>