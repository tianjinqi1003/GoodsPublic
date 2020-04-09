<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>积分明细</title>
<%@include file="../../js.jsp"%>
<style type="text/css">
.gkjfmx_div{
	height:230px;margin-top:20px;margin-left: 238px;padding-top:15px;padding-left:15px;background-color:#FAFDFE;
}
.gkjfmx_div .title_div{
	width: 98%;font-size: 20px;color: #373737;font-weight:700;
}
.dateList_div .createDate_div{
	color: #999;width: 100%;height:30px;line-height:30px;
}
.scoreList_div .item_div{
	width: 98%;height:120px;background-color: #fff;
}
.scoreList_div .item_div .createTime_span{
	color: #000;margin-top: 13px;margin-left: 10px;position: absolute;
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
$(function(){
	startTimeDTB=$("#startTime_dtb").datetimebox({
		width:157,
		editable:false
	});
	endTimeDTB=$("#endTime_dtb").datetimebox({
		width:157,
		editable:false
	});
	$("#search_but").linkbutton({
		iconCls:"icon-search",
		onClick:function(){
			initListDiv();
		}
	});
	initListDiv();
});

function initListDiv(){
	var startTime=startTimeDTB.datetimebox("getValue");
	var endTime=endTimeDTB.datetimebox("getValue");
	$.post("queryCSDetailList",
		{startTime:startTime,endTime:endTime,accountId:'${sessionScope.user.id}',openId:'${param.openId}'},
		function(data){
			var dateListDiv=$("#dateList_div");
			dateListDiv.empty();
			if(data.status=="ok"){
				var dateList=data.dateList;
				var scoreList=data.scoreList;
				for(var i=0;i<dateList.length;i++){
					dateListDiv.append("<div class=\"createDate_div\">"+dateList[i]+"</div>"
							+"<div class=\"scoreList_div\" id=\"scoreList_div"+dateList[i]+"\"></div>");
				}
				for(var i=0;i<scoreList.length;i++){
					var item=scoreList[i];
					var htmlStr="<div class=\"item_div\">";
					htmlStr+="<span class=\"createTime_span\">"+item.takeTime+"</span>";
					if(item.codeNo==null)
						htmlStr+="<div class=\"codeNo_div\">奖品码   暂无</div>";
					else
						htmlStr+="<div class=\"codeNo_div\">奖品码   <span class=\""+(item.enable?"codeEnable":"codeDisable")+"\">"+item.codeNo+"<span></div>";
					htmlStr+="<span class=\"takeCount_span\">消费次数:"+item.takeCount+"</span>";
					htmlStr+="<span class=\"takeScore_span\">消费积分:"+item.takeScore+"</span>";
					htmlStr+="<span class=\"jfye_span\">积分余额:"+item.jfye+"</span>";
					htmlStr+="<span class=\"takeScoreSum_span\">消费总积分:"+item.takeScoreSum+"</span>";
					htmlStr+="</div>";
					var takeDate=item.takeDate;
					$("#scoreList_div"+takeDate).append(htmlStr);
				}
			}
			else{
				dateListDiv.append("<div style=\"text-align:center;\">"+data.message+"</div>");
			}
		}
	,"json");
}
</script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
	<%@include file="../../side.jsp"%>
	<div class="gkjfmx_div" id="gkjfmx_div">
		<div class="title_div"">
			顾客积分明细
			<div style="width: 400px;height:25px;float: right;">
				<input id="startTime_dtb" name="startTime" type="text" maxlength="20"/>
				<input id="endTime_dtb" name="endTime" type="text" maxlength="20"/>
				<a id="search_but">搜索</a>
			</div>
		</div>
		<div class="dateList_div" id="dateList_div">
			<div class="createTime_div">3月13日</div>
			<div class="item_div">
				<div class="content_div">
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