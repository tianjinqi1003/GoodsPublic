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
	width: 98%;font-size: 20px;color: #373737;font-weight:700;
}
.dateList_div .takeDate_div{
	color: #999;width: 100%;height:30px;line-height:30px;
}
.scoreList_div .item_div{
	width: 98%;height:120px;background-color: #fff;
}
.scoreList_div .item_div .nickName_span{
	color: #000;margin-top: 10px;margin-left: 10px;position: absolute;
}
.scoreList_div .item_div .takeTime_span{
	color: #000;margin-top: 13px;margin-left: 100px;position: absolute;
}
.scoreList_div .item_div .showDetail_span{
	margin-top: 10px;margin-right: 110px;float: right;cursor: pointer;
}
.scoreList_div .item_div .showDetail_span a{
	color: #00f;
}
.scoreList_div .item_div .codeNo_div{
	width:200px;color: #999;margin-top: 40px;margin-left: 10px;position: absolute;
}
.scoreList_div .item_div .codeEnable{
	color: #0f0;margin-top: 3px;margin-left: 10px;position: absolute;
}
.scoreList_div .item_div .codeDisable{
	color: #f00;margin-top: 3px;margin-left: 10px;position: absolute;
}
.scoreList_div .item_div .takeCount_span{
	color: #999;margin-top: 40px;margin-left: 228px;position: absolute;
}
.scoreList_div .item_div .takeScore_span{
	color: #999;margin-top: 70px;margin-left: 10px;position: absolute;
}
.scoreList_div .item_div .jfye_span{
	color: #999;margin-top: 70px;margin-left: 228px;position: absolute;
}
.scoreList_div .item_div .takeScoreSum_span{
	color: #999;margin-top: 70px;margin-left: 390px;position: absolute;
}
</style>
<script type="text/javascript">
var jpmLimit='${requestScope.jpmLimit }';
$(function(){
	initListDiv();
});

function initListDiv(){
	var searchTxt=$("#searchTxt_inp").val();
	$.post("queryCustomerScoreList",
		{searchTxt:searchTxt,accountId:'${sessionScope.user.id}'},
		function(data){
			var dateListDiv=$("#dateList_div");
			dateListDiv.empty();
			if(data.status=="ok"){
				var dateList=data.dateList;
				var scoreList=data.scoreList;
				for(var i=0;i<dateList.length;i++){
					dateListDiv.append("<div class=\"takeDate_div\">"+dateList[i]+"</div>"
							+"<div class=\"scoreList_div\" id=\"scoreList_div"+dateList[i]+"\"></div>");
				}
				for(var i=0;i<scoreList.length;i++){
					var item=scoreList[i];
					var htmlStr="<div class=\"item_div\">";
					htmlStr+="<span class=\"nickName_span\">"+item.nickName+"</span>";
					htmlStr+="<span class=\"takeTime_span\">"+item.takeTime+"</span>";
					htmlStr+="<span class=\"showDetail_span\"><a href=\"goScoreQrcodeDetail?openId="+item.openId+"\">查看积分明细</a></span>";
					if(item.codeNo==null)
						htmlStr+="<div class=\"codeNo_div\">奖品码   暂无</div>";
					else
						htmlStr+="<div class=\"codeNo_div\">奖品码   <span class=\""+(checkIfLimit(item.createTime)?"codeDisable":"codeEnable")+"\">"+item.codeNo+"<span></div>";
					htmlStr+="<span class=\"takeCount_span\">消费次数:"+item.takeCount+"</span>";
					htmlStr+="<span class=\"takeScore_span\">消费积分:"+item.takeScore+"</span>";
					htmlStr+="<span class=\"jfye_span\">积分余额:"+item.jfye+"</span>";
					htmlStr+="<span class=\"takeScoreSum_span\">消费总积分:"+item.takeScoreSum+"</span>";
					htmlStr+="</div>";
					var takeDate=item.takeDate;
					$("#scoreList_div"+takeDate).append(htmlStr);
				}
				/*
				for(var i=0;i<list.length;i++){
					var item=list[i];
					var htmlStr="<div class=\"takeDate_div\">"+item.createDate+"</div>";
					htmlStr+="<div class=\"scoreList_div\" id=\"scoreList_div"+item.createDate+"\">";
					htmlStr+="<div class=\"item_div\">";
					htmlStr+="<span class=\"nickName_span\">"+item.nickName+"</span>";
					htmlStr+="<span class=\"takeTime_span\">"+item.createTime+"</span>";
					htmlStr+="<span class=\"showDetail_span\">查看积分明细</span>";
					if(item.enable==null)
						htmlStr+="<div class=\"codeNo_div\">奖品码   暂无</div>";
					else
						htmlStr+="<div class=\"codeNo_div\">奖品码   <span class=\""+(item.enable?"codeEnable":"codeDisable")+"\">"+item.codeNo+"<span></div>";
					htmlStr+="<span class=\"takeCount_span\">消费次数:"+item.takeCount+"</span>";
					htmlStr+="<span class=\"takeScore_span\">消费积分:"+item.takeScore+"</span>";
					htmlStr+="<span class=\"jfye_span\">积分余额:"+item.jfye+"</span>";
					htmlStr+="<span class=\"takeScoreSum_span\">消费总积分:"+item.takeScoreSum+"</span>";
					htmlStr+="</div>";
					htmlStr+="</div>";
					listDiv.append(htmlStr);
				}
				*/
			}
			else{
				dateListDiv.append("<div style=\"text-align:center;\">"+data.message+"</div>");
			}
		}
	,"json");
}

function checkIfLimit(ctTime){
	var ctDate=new Date(ctTime);
	var overTime=ctDate.setDate(ctDate.getDate() + jpmLimit);
	return overTime>new Date().getTime();
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../../side.jsp"%>
	<div class="gkjfqd_div" id="gkjfqd_div">
		<div class="title_div"">
			顾客积分清单
			<div style="width: 200px;height:30px;margin-top:-8px;float: right;border: #999 solid 1px;">
				<input type="text" id="searchTxt_inp" placeholder="输入昵称或奖品码" style="width:150px;height:30px;line-height:30px;color:#999;font-size:15px;border: 0;"/>
				<img alt="" src="<%=basePath %>resource/images/jfdhjp/005.png" onclick="initListDiv();" style="width: 30px;height:30px;float: right;cursor: pointer;">
			</div>
		</div>
		<div class="dateList_div" id="dateList_div">
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