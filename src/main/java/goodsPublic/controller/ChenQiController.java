package goodsPublic.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.goodsPublic.util.FileUploadUtils;
import com.goodsPublic.util.qrcode.Qrcode;

import goodsPublic.entity.HtmlGoodsGRMP;
import goodsPublic.entity.HtmlGoodsText;
import goodsPublic.service.PublicService;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/merchant/chenQi")
public class ChenQiController {
	
	@Autowired
	private PublicService publicService;

	@RequestMapping(value="/createQrcodeByCQSCQ")
	@ResponseBody
	public void createQrcodeByCQSCQ(HtmlGoodsText htmlGoodsText, HttpServletResponse response) {

		String accountNumber = htmlGoodsText.getAccountNumber();
		String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
		String avaPath="/GoodsPublic/upload/ChenQiQrcode/"+fileName;
		String path = "D:/resource/ChenQiQrcode/";
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		String url=null;
		switch (htmlGoodsText.getTextType()) {
		case HtmlGoodsText.TEXT:
			if(StringUtils.isEmpty(accountNumber))
				url="http://www.qrcodesy.com:8080/GoodsPublic/merchant/phone/goShowTextHtml?textType="+htmlGoodsText.getTextType()+"&uuid="+uuid;
			else
				url="http://www.qrcodesy.com:8080/GoodsPublic/merchant/main/goShowHtmlGoods?trade=text&textType="+htmlGoodsText.getTextType()+"&uuid="+uuid+"&accountId="+accountNumber;
			break;
		case HtmlGoodsText.URL:
			url=htmlGoodsText.getText();
			break;
		}
        Qrcode.createQrCode(url, path, fileName);
        
		htmlGoodsText.setUuid(uuid);
		htmlGoodsText.setQrcode(avaPath);
		int a=publicService.addHtmlGoodsText(htmlGoodsText);
		
        String jsonpCallback="jsonpCallback(\"{\\\"qrcode\\\":\\\""+avaPath+"\\\"}\")";
        try {
			response.getWriter().print(jsonpCallback);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/addHtmlGoodsGRMP",produces="plain/text; charset=UTF-8")
	public void addHtmlGoodsGRMP(HtmlGoodsGRMP htmlGoodsGRMP, @RequestParam(value="avatorImg",required=false) MultipartFile avatorImg, 
			HttpServletRequest request, HttpServletResponse response) {

        try {
			if(avatorImg.getSize()>0) {
				String jsonStr = FileUploadUtils.appUploadContentImg(request,avatorImg,"");
				JSONObject fileJson = JSONObject.fromObject(jsonStr);
				if("成功".equals(fileJson.get("msg"))) {
					JSONObject dataJO = (JSONObject)fileJson.get("data");
					htmlGoodsGRMP.setAvatorUrl(dataJO.get("src").toString());
				}
			}
			String userNumber = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			String url = "http://www.iot-mes.com:8081/";
			String fileName = userNumber + ".jpg";
			String avaPath="/GoodsPublic/upload/ChenQiQrcode/"+fileName;
			String path = "D:/resource/ChenQiQrcode/";
			Qrcode.createQrCode(url, path, fileName);

			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			htmlGoodsGRMP.setUuid(uuid);
			htmlGoodsGRMP.setQrcode(avaPath);
			int a=publicService.addHtmlGoodsGRMP(htmlGoodsGRMP);
			
	        //String jsonpCallback="jsonpCallback(\"{\\\"qrcode\\\":\\\"1111111111\\\"}\")";
			//response.getWriter().print(jsonpCallback);
			response.sendRedirect("http://www.qrcodesy.com/qrcodeCreate/vcard.html?type=1&uuid="+uuid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/editHtmlGoodsGRMP",produces="plain/text; charset=UTF-8")
	public void editHtmlGoodsGRMP(HtmlGoodsGRMP htmlGoodsGRMP, @RequestParam(value="avatorImg",required=false) MultipartFile avatorImg, 
			HttpServletRequest request, HttpServletResponse response) {
        try {
			if(avatorImg.getSize()>0) {
				String jsonStr = FileUploadUtils.appUploadContentImg(request,avatorImg,"");
				JSONObject fileJson = JSONObject.fromObject(jsonStr);
				if("成功".equals(fileJson.get("msg"))) {
					JSONObject dataJO = (JSONObject)fileJson.get("data");
					htmlGoodsGRMP.setAvatorUrl(dataJO.get("src").toString());
				}
			}
			int a=publicService.editHtmlGoodsGRMP(htmlGoodsGRMP);
			response.sendRedirect("http://www.qrcodesy.com/qrcodeCreate/vcard.html?type=1");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/getHtmlGoodsGRMP")
	@ResponseBody
	public void getHtmlGoodsGRMP(String uuid, HttpServletResponse response) {
		
		HtmlGoodsGRMP htmlGoodsGRMP = publicService.getHtmlGoodsGRMP(uuid);
		
		String grmpStr=JSONObject.fromObject(htmlGoodsGRMP).toString().replaceAll("\"", "\\\\\"");
		String jsonpCallback="jsonpCallback(\"{\\\"htmlGoodsGRMP\\\":"+grmpStr+"}\")";
        try {
			response.getWriter().print(jsonpCallback);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
