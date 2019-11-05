<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>创建批次界面</title>
<%@include file="../merchant/js.jsp"%>
<script src="https://cdn.bootcss.com/jspdf/1.5.3/jspdf.debug.js"></script>
<script src="https://cdn.bootcss.com/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#add_div").dialog({
		title:"创建批次",
		width:setFitWidthInParent("body"),
		height:600,
		top:60,
		left:200,
		buttons:[
           {text:"中文标签",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   previewPDF();
           }},
           {text:"ISO标签",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   previewPDF();
           }},
           {text:"ECE标签",id:"ok_but",iconCls:"icon-ok",handler:function(){
        	   previewPDF();
           }}
        ]
	});
	
	$("#add_div table").css("width","1000px");
	$("#add_div table").css("magin","-100px");
	$("#add_div table td").css("padding-left","50px");
	$("#add_div table td").css("padding-right","20px");
	$("#add_div table td").css("font-size","15px");
	$("#add_div table tr").css("height","45px");
	
	var downPdf = document.getElementById("exportToPdf");
    downPdf.onclick = function () {
        html2canvas(
                document.getElementById("export_content"),
                {
                    dpi: 172,//导出pdf清晰度
                    onrendered: function (canvas) {
                        var contentWidth = canvas.width;
                        var contentHeight = canvas.height;
 
                        //一页pdf显示html页面生成的canvas高度;
                        var pageHeight = contentWidth / 592.28 * 841.89;
                        //未生成pdf的html页面高度
                        var leftHeight = contentHeight;
                        //pdf页面偏移
                        var position = 0;
                        //html页面生成的canvas在pdf中图片的宽高（a4纸的尺寸[595.28,841.89]）
                        var imgWidth = 595.28;
                        var imgHeight = 592.28 / contentWidth * contentHeight;
 
                        var pageData = canvas.toDataURL('image/jpeg', 1.0);
                        var pdf = new jsPDF('', 'pt', 'a4');
 
                        //有两个高度需要区分，一个是html页面的实际高度，和生成pdf的页面高度(841.89)
                        //当内容未超过pdf一页显示的范围，无需分页
                        if (leftHeight < pageHeight) {
                            pdf.addImage(pageData, 'JPEG', 0, 0, imgWidth, imgHeight);
                        } else {
                            while (leftHeight > 0) {
                                pdf.addImage(pageData, 'JPEG', 0, position, imgWidth, imgHeight)
                                leftHeight -= pageHeight;
                                position -= 841.89;
                                //避免添加空白页
                                if (leftHeight > 0) {
                                    pdf.addPage();
                                }
                            }
                        }
                        pdf.save('content.pdf');
                    },
                    //背景设为白色（默认为黑色）
                    background: "#fff"  
                })
    }
});

function setFitWidthInParent(o){
	var width=$(o).css("width");
	return width.substring(0,width.length-2)-200;
}

function setFitHeightInParent(o){
	var height=$(o).css("height");
	return height.substring(0,height.length-2)-98;
}
</script>
</head>
<body>
<div id="add_div">
	<form id="form1" name="form1" method="post" action="editGoods" enctype="multipart/form-data">
		<table>
			<tr>
				<td>产品型号：</td>
				<td>
					<input id="" name="" type="text" maxlength="20" onfocus="focus" onblur="check"/>
				</td>
			</tr>
			<tr>
				<td>气瓶起始编号：</td>
				<td>
					<input id="" name="" type="text" maxlength="20" onfocus="focus" onblur="check"/>
				</td>
			</tr>
			<tr>
				<td>气瓶结束编号：</td>
				<td>
					<input id="" name="" type="text" maxlength="20" onfocus="focus" onblur="check"/>
				</td>
			</tr>
			<tr>
				<td>公称容积：</td>
				<td>
					<input id="" name="" type="text" maxlength="20" onfocus="focus" onblur="check"/>
				</td>
			</tr>
			<tr>
				<td>内胆壁厚：</td>
				<td>
					<input id="" name="" type="text" maxlength="20" onfocus="focus" onblur="check"/>
				</td>
			</tr>
			<tr>
				<td>制造日期：</td>
				<td>
					<input id="" name="" type="text" maxlength="20" onfocus="focus" onblur="check"/>
				</td>
			</tr>
		</table>
	</form>
	<div id="export_content" style="width:400px;height: 300px;margin-top:-200px; margin-left:1200px;border:#000 solid 1px;">
		 <img alt="" src="<%=basePath %>/resource/images/qrcode.png" style="width: 80px;height: 80px;margin-top: 160px;margin-left: 300px;position: absolute;">
	     <span style="margin-top: 180px;margin-left: 150px;position: absolute;">356-70</span>
	     <span style="margin-top: 200px;margin-left: 90px;position: absolute;">CB190</span>
	     <span style="margin-top: 250px;margin-left: 210px;position: absolute;">70L</span>
	     <span style="margin-top: 300px;margin-left: 120px;position: absolute;">5.0</span>
	     <span style="margin-top: 350px;margin-left: 210px;position: absolute;">2019&nbsp;&nbsp;&nbsp;&nbsp;1</span>
	</div>
	<div style="margin-left: 1200px;">
		产品型号   
		<input type="button" value="上移"/> 
		<input type="button" value="下移"/> 
		<input type="button" value="左移"/> 
		<input type="button" value="右移"/> 
	</div>
	<div style="margin-left: 1200px;">
		气瓶编号   
		<input type="button" value="上移"/> 
		<input type="button" value="下移"/> 
		<input type="button" value="左移"/> 
		<input type="button" value="右移"/> 
	</div>
	<div>
		<button id="exportToPdf" style="margin-left: 1200px;">导出为PDF</button>
	</div>
</div>
</body>
</html>