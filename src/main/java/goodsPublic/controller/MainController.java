package goodsPublic.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.goodsPublic.util.FileUploadUtils;
import com.goodsPublic.util.FinalState;
import com.goodsPublic.util.JsonUtil;
import com.goodsPublic.util.MethodUtil;
import com.goodsPublic.util.PlanResult;
import com.goodsPublic.util.TenpayHttpClient;
import com.goodsPublic.util.alipay.AlipayConfig;
import com.goodsPublic.util.qrcode.Qrcode;
import com.jpay.ext.kit.HttpKit;
import com.jpay.ext.kit.PaymentKit;
import com.jpay.weixin.api.WxPayApiConfigKit;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.AccountPayRecord;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.CreatePayCodeRecord;
import goodsPublic.entity.Goods;
import goodsPublic.entity.GoodsLabelSet;
import goodsPublic.entity.HtmlGoodsDMTZL;
import goodsPublic.entity.HtmlGoodsHDQD;
import goodsPublic.entity.HtmlGoodsJZSG;
import goodsPublic.entity.HtmlGoodsSPZS;
import goodsPublic.entity.HtmlGoodsText;
import goodsPublic.entity.JFDHJPActivity;
import goodsPublic.entity.JFDHJPCustomer;
import goodsPublic.entity.ModuleDMTZL;
import goodsPublic.entity.ModuleHDQD;
import goodsPublic.entity.ModuleJZSG;
import goodsPublic.entity.ModuleSPZS;
import goodsPublic.entity.ScoreQrcode;
import goodsPublic.service.CategoryService;
import goodsPublic.service.PublicService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/merchant/main")
public class MainController {

	@Autowired
	private PublicService publicService;
	@Autowired
	private CategoryService categoryService;
	private SimpleDateFormat timeSDF=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private SimpleDateFormat orderIdSDF=new SimpleDateFormat("yyyyMMddHHmmss");
	
	/**
	 * 跳转至商品发布页面
	 * @return
	 */
	@RequestMapping("/operation")
	public String SayHellow(HttpServletRequest request, String accountId, String categoryId) {
		List<GoodsLabelSet> glsList = publicService.getGoodsLabelSetByModuleAccountId("operation",accountId);
		/*
		Field[] fieldArr = goodsAttrSet.getClass().getDeclaredFields();
		for(Field field : fieldArr) {
			String name = field.getName();
			System.out.println("Name==="+name);
			String type = field.getGenericType().toString();//获取属性类型
		    if (type.equals("class java.lang.String")) {
		        try {
		            Method m = goodsAttrSet.getClass().getMethod("get" + name.substring(0, 1).toUpperCase() + name.substring(1));
		            String value = (String) m.invoke(goodsAttrSet);
		            if (null != value) {
		    			System.out.println("value==="+value);
		    			htmlContent = htmlContent.replaceAll("goodsAttrSet."+name, value);
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }
		}
		htmlContent = htmlContent.replaceAll("sessionScope.user.id", accountId).replaceAll("param.categoryId", categoryId);
		//System.out.println("HtmlContent==="+htmlContent);
		*/
		request.setAttribute("glsList", glsList);
		//aaa
		return "/merchant/operation";
	}

	/**
	 * 图片上传接口
	 * @param file
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/upload",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String upload(@RequestParam  MultipartFile file,HttpServletRequest request) {
		PlanResult plan=new PlanResult();
		try {
			System.out.println("这是图片上传接口");
			String url=FileUploadUtils.appUploadContentImg(request,file,"");
			return url;
		} catch (Exception e) {
			plan.setStatus(1);
			plan.setMsg("图片上传失败");
			return JsonUtil.getJsonFromObject(plan);
		}
	}

	/**
	 * 添加商品
	 * @param goods
	 * @param request
	 * @param file
	 * @return
	 */
	@RequestMapping(value="/addGoodsPublic",produces="plain/text; charset=UTF-8")
	public String addGoodsPublic(Goods goods,HttpServletRequest request,@RequestParam(value="file",required=false)  MultipartFile file) {
		try {
			//TODO对商品发布增加权限检测
			  Subject subject = SecurityUtils.getSubject();
			  AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
				 if(subject.hasRole(FinalState.UserLevel1)){
					 System.out.println("初级会员");
					 int count=publicService.getGoodsListByMsg();
					 System.out.println(count);
					 if(file!=null) {
						 if(file.getSize()>0) {
							String jsonStr = FileUploadUtils.appUploadContentImg(request,file,"");
							JSONObject fileJson = JSONObject.fromObject(jsonStr);
							if("成功".equals(fileJson.get("msg"))) {
								JSONObject dataJO = (JSONObject)fileJson.get("data");
								goods.setImgUrl(dataJO.get("src").toString());
							}
						 }
					 }
					String json;
					PlanResult plan=new PlanResult();
					int result =publicService.getGoodsListByMsg();
					//TODO想办法获取条件权限
					int a=publicService.addGoodsPublic(goods);
					if(a>0) {
						plan.setStatus(0);
						plan.setMsg("商品发布成功");
						plan.setUrl("/merchant/main/show");
						plan.setData(goods.getGoodsNumber());
					}
					json=JsonUtil.getJsonFromObject(plan);
					JSONObject js = JSONObject.fromObject(json);
					request.setAttribute("json", js);
		         }
				 else if(subject.hasRole(FinalState.UserLevel2)){
		           // 无权限
		        	System.out.println("中级会员");
		         }
				 else if(subject.hasRole(FinalState.UserLevel2)) {
		        	System.out.println("高级会员");
		         }
				 else {
		        	System.out.println("临时用户");
		         }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "../../merchant/main/operation?";
	}
	
	@RequestMapping(value="/addBatchHtmlGoodsSPZS")
	@ResponseBody
	public Map<String, Object> addBatchHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS,
			String jaStr,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file1_4",required=false) MultipartFile file1_4,
			@RequestParam(value="file1_5",required=false) MultipartFile file1_5,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			@RequestParam(value="file2_2",required=false) MultipartFile file2_2,
			@RequestParam(value="file2_3",required=false) MultipartFile file2_3,
			@RequestParam(value="file2_4",required=false) MultipartFile file2_4,
			@RequestParam(value="file2_5",required=false) MultipartFile file2_5,
			@RequestParam(value="file3_1",required=false) MultipartFile file3_1,
			@RequestParam(value="file3_2",required=false) MultipartFile file3_2,
			@RequestParam(value="file3_3",required=false) MultipartFile file3_3,
			@RequestParam(value="file3_4",required=false) MultipartFile file3_4,
			@RequestParam(value="file3_5",required=false) MultipartFile file3_5,
			@RequestParam(value="file4_1",required=false) MultipartFile file4_1,
			@RequestParam(value="file4_2",required=false) MultipartFile file4_2,
			@RequestParam(value="file4_3",required=false) MultipartFile file4_3,
			@RequestParam(value="file4_4",required=false) MultipartFile file4_4,
			@RequestParam(value="file4_5",required=false) MultipartFile file4_5,
			HttpServletRequest request) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		//System.out.println("==="+jaStr);
		JSONArray ja = JSONArray.fromObject(jaStr);
		
		String moduleType = htmlGoodsSPZS.getModuleType();
		
		try {
			MultipartFile[] fileArr=new MultipartFile[20];
			fileArr[0]=file1_1;
			fileArr[1]=file1_2;
			fileArr[2]=file1_3;
			fileArr[3]=file1_4;
			fileArr[4]=file1_5;
			fileArr[5]=file2_1;
			fileArr[6]=file2_2;
			fileArr[7]=file2_3;
			fileArr[8]=file2_4;
			fileArr[9]=file2_5;
			fileArr[10]=file3_1;
			fileArr[11]=file3_2;
			fileArr[12]=file3_3;
			fileArr[13]=file3_4;
			fileArr[14]=file3_5;
			fileArr[15]=file4_1;
			fileArr[16]=file4_2;
			fileArr[17]=file4_3;
			fileArr[18]=file4_4;
			fileArr[19]=file4_5;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],"");
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1(dataJO.get("src").toString());
								break;
							case 1:
								htmlGoodsSPZS.setImage1_2(dataJO.get("src").toString());
								break;
							case 2:
								htmlGoodsSPZS.setImage1_3(dataJO.get("src").toString());
								break;
							case 3:
								htmlGoodsSPZS.setImage1_4(dataJO.get("src").toString());
								break;
							case 4:
								htmlGoodsSPZS.setImage1_5(dataJO.get("src").toString());
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1(dataJO.get("src").toString());
								break;
							case 6:
								htmlGoodsSPZS.setImage2_2(dataJO.get("src").toString());
								break;
							case 7:
								htmlGoodsSPZS.setImage2_3(dataJO.get("src").toString());
								break;
							case 8:
								htmlGoodsSPZS.setImage2_4(dataJO.get("src").toString());
								break;
							case 9:
								htmlGoodsSPZS.setImage2_5(dataJO.get("src").toString());
								break;
							case 10:
								if("productExplain".equals(moduleType))
									htmlGoodsSPZS.setEmbed1_1(dataJO.get("src").toString());
								else
									htmlGoodsSPZS.setImage3_1(dataJO.get("src").toString());
								break;
							case 11:
								htmlGoodsSPZS.setImage3_2(dataJO.get("src").toString());
								break;
							case 12:
								htmlGoodsSPZS.setImage3_3(dataJO.get("src").toString());
								break;
							case 13:
								htmlGoodsSPZS.setImage3_4(dataJO.get("src").toString());
								break;
							case 14:
								htmlGoodsSPZS.setImage3_5(dataJO.get("src").toString());
								break;
							case 15:
								htmlGoodsSPZS.setImage4_1(dataJO.get("src").toString());
								break;
							case 16:
								htmlGoodsSPZS.setImage4_2(dataJO.get("src").toString());
								break;
							case 17:
								htmlGoodsSPZS.setImage4_3(dataJO.get("src").toString());
								break;
							case 18:
								htmlGoodsSPZS.setImage4_4(dataJO.get("src").toString());
								break;
							case 19:
								htmlGoodsSPZS.setImage4_5(dataJO.get("src").toString());
								break;
							}
						}
					}
					else {
						if("redWine".equals(moduleType)) {
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1("/GoodsPublic/resource/images/spzs/22ad5cebe49933335608eeb6356e6ab9.png");
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1("/GoodsPublic/resource/images/spzs/41116eb627d54a623813c01bcadd05ce.png");
								break;
							case 10:
								htmlGoodsSPZS.setImage3_1("/GoodsPublic/resource/images/spzs/573ab1fc91d98528915519d96dc2e6ec.png");
								break;
							}
						}
						else if("whiteWine".equals(moduleType)) {
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1("/GoodsPublic/resource/images/spzs/258bb5b4e0d98344406a5f71e32ad767.png");
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1("/GoodsPublic/resource/images/spzs/25787fd7408641e333869e762e514fdd.png");
								break;
							}
						}
						else if("homeTextiles".equals(moduleType)) {
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1("/GoodsPublic/resource/images/spzs/8878b699bd21eeaeeaec254b5d4e6f79.png");
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1("/GoodsPublic/resource/images/spzs/e3f0c2aa261ac2b652fbdca9eaba04f3.png");
								break;
							case 10:
								htmlGoodsSPZS.setImage3_1("/GoodsPublic/resource/images/spzs/bc40c19357bcf636e9ad6e71581686c4.png");
								break;
							case 15:
								htmlGoodsSPZS.setImage4_1("/GoodsPublic/resource/images/spzs/f078f4614735e89cd7608110115c6ad6.png");
								break;
							}
						}
						else if("artwork".equals(moduleType)) {
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1("/GoodsPublic/resource/images/spzs/f21c462d8e78cbe6f31d4b8c67a0560e.png");
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1("/GoodsPublic/resource/images/spzs/a61777ec9042bb003308d961f185a4e1.png");
								break;
							}
						}
						else if("productExplain".equals(moduleType)) {
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1("/GoodsPublic/resource/images/spzs/81a5d69b81bda7b772771e31b57e4fae.png");
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1("/GoodsPublic/resource/images/spzs/59a9157e809d046c12699bc4f431266c.png");
								break;
							case 6:
								htmlGoodsSPZS.setImage2_2("/GoodsPublic/resource/images/spzs/594c03f1f5e93d78248d9d268f8070b6.png");
								break;
							case 10:
								htmlGoodsSPZS.setEmbed1_1("/GoodsPublic/resource/embed/spzs/4c4a6999823cc4088a4996896ae136c2.mp4");
								break;
							}
						}
					}
				}
			}
		
			JSONObject jo = ja.getJSONObject(0);
			Iterator<String> it = jo.keys();
			while (it.hasNext()) {
				String key = it.next();
				String value = jo.getString(key);
				Integer colIndex = Integer.valueOf(key.substring(5));
				switch (colIndex) {
				case 1:
					htmlGoodsSPZS.setSpxqName1(value);
					break;
				case 2:
					htmlGoodsSPZS.setSpxqName2(value);
					break;
				case 3:
					htmlGoodsSPZS.setSpxqName3(value);
					break;
				case 4:
					htmlGoodsSPZS.setSpxqName4(value);
					break;
				case 5:
					htmlGoodsSPZS.setSpxqName5(value);
					break;
				case 6:
					htmlGoodsSPZS.setSpxqName6(value);
					break;
				case 7:
					htmlGoodsSPZS.setSpxqName7(value);
					break;
				case 8:
					htmlGoodsSPZS.setSpxqName8(value);
					break;
				case 9:
					htmlGoodsSPZS.setSpxqName9(value);
					break;
				case 10:
					htmlGoodsSPZS.setSpxqName10(value);
					break;
				}
			}
			
			for(int i=1;i<ja.size();i++) {
				String goodsNumber = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+i;
				htmlGoodsSPZS.setGoodsNumber(goodsNumber);
				jo = ja.getJSONObject(i);
				it = jo.keys();
				while (it.hasNext()) {
					String key = it.next();
					String value = jo.getString(key);
					Integer colIndex = Integer.valueOf(key.substring(5));
					//System.out.println("key==="+key);
					switch (colIndex) {
					case 1:
						htmlGoodsSPZS.setSpxqValue1(value);
						break;
					case 2:
						htmlGoodsSPZS.setSpxqValue2(value);
						break;
					case 3:
						htmlGoodsSPZS.setSpxqValue3(value);
						break;
					case 4:
						htmlGoodsSPZS.setSpxqValue4(value);
						break;
					case 5:
						htmlGoodsSPZS.setSpxqValue5(value);
						break;
					case 6:
						htmlGoodsSPZS.setSpxqValue6(value);
						break;
					case 7:
						htmlGoodsSPZS.setSpxqValue7(value);
						break;
					case 8:
						htmlGoodsSPZS.setSpxqValue8(value);
						break;
					case 9:
						htmlGoodsSPZS.setSpxqValue9(value);
						break;
					case 10:
						htmlGoodsSPZS.setSpxqValue10(value);
						break;
					}
				}
				
				String addr = request.getLocalAddr();
				int port = request.getLocalPort();
				String contextPath = request.getContextPath();
				//String url = "http://"+addr+":"+port+contextPath+"/merchant/main/goShowHtmlGoods?trade=spzs&moduleType="+moduleType+"&goodsNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountId="+htmlGoodsSPZS.getAccountNumber();
				String url = com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/main/goShowHtmlGoods?trade=spzs&moduleType="+moduleType+"&goodsNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountId="+htmlGoodsSPZS.getAccountNumber();
				
				String fileName = goodsNumber + ".jpg";
				String avaPath="/GoodsPublic/upload/"+fileName;
				String path = "D:/resource";
		        Qrcode.createQrCode(url, path, fileName);
				
		        htmlGoodsSPZS.setQrCode(avaPath);
				int a=publicService.addHtmlGoodsSPZS(htmlGoodsSPZS);
				//System.out.println("a==="+a);
				
				jsonMap.put("message", "ok");
				jsonMap.put("info", "批量导入成功！");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonMap.put("message", "no");
			jsonMap.put("info", "批量导入失败！");
		}
		finally {
			return jsonMap;
		}
	}
	
	/**
	 * 添加商品展示模板内容
	 * @param htmlGoodsSPZS
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file1_4
	 * @param file1_5
	 * @param file2_1
	 * @param file2_2
	 * @param file2_3
	 * @param file2_4
	 * @param file2_5
	 * @param file3_1
	 * @param file3_2
	 * @param file3_3
	 * @param file3_4
	 * @param file3_5
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/addHtmlGoodsSPZS",produces="plain/text; charset=UTF-8")
	public String addHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file1_4",required=false) MultipartFile file1_4,
			@RequestParam(value="file1_5",required=false) MultipartFile file1_5,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			@RequestParam(value="file2_2",required=false) MultipartFile file2_2,
			@RequestParam(value="file2_3",required=false) MultipartFile file2_3,
			@RequestParam(value="file2_4",required=false) MultipartFile file2_4,
			@RequestParam(value="file2_5",required=false) MultipartFile file2_5,
			@RequestParam(value="file3_1",required=false) MultipartFile file3_1,
			@RequestParam(value="file3_2",required=false) MultipartFile file3_2,
			@RequestParam(value="file3_3",required=false) MultipartFile file3_3,
			@RequestParam(value="file3_4",required=false) MultipartFile file3_4,
			@RequestParam(value="file3_5",required=false) MultipartFile file3_5,
			@RequestParam(value="file4_1",required=false) MultipartFile file4_1,
			@RequestParam(value="file4_2",required=false) MultipartFile file4_2,
			@RequestParam(value="file4_3",required=false) MultipartFile file4_3,
			@RequestParam(value="file4_4",required=false) MultipartFile file4_4,
			@RequestParam(value="file4_5",required=false) MultipartFile file4_5,
			HttpServletRequest request) {
		
		System.out.println("111111111111111"+file2_1);
		System.out.println("111111111111111"+file2_2);
		System.out.println("111111111111111"+file2_3);
		System.out.println("111111111111111"+file2_4);
		System.out.println("111111111111111"+file2_5);
		String moduleType = htmlGoodsSPZS.getModuleType();
        String accountNumberCq = null;
		String from=htmlGoodsSPZS.getFrom();

    	System.out.println("from==="+from);
        if("cq".equals(from)) {
        	accountNumberCq=getCQAccountNumber(request);
        	htmlGoodsSPZS.setAccountNumber(accountNumberCq);
        }
		try {
			MultipartFile[] fileArr=new MultipartFile[20];
			fileArr[0]=file1_1;
			fileArr[1]=file1_2;
			fileArr[2]=file1_3;
			fileArr[3]=file1_4;
			fileArr[4]=file1_5;
			fileArr[5]=file2_1;
			fileArr[6]=file2_2;
			fileArr[7]=file2_3;
			fileArr[8]=file2_4;
			fileArr[9]=file2_5;
			fileArr[10]=file3_1;
			fileArr[11]=file3_2;
			fileArr[12]=file3_3;
			fileArr[13]=file3_4;
			fileArr[14]=file3_5;
			fileArr[15]=file4_1;
			fileArr[16]=file4_2;
			fileArr[17]=file4_3;
			fileArr[18]=file4_4;
			fileArr[19]=file4_5;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],"");
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1(dataJO.get("src").toString());
								break;
							case 1:
								htmlGoodsSPZS.setImage1_2(dataJO.get("src").toString());
								break;
							case 2:
								htmlGoodsSPZS.setImage1_3(dataJO.get("src").toString());
								break;
							case 3:
								htmlGoodsSPZS.setImage1_4(dataJO.get("src").toString());
								break;
							case 4:
								htmlGoodsSPZS.setImage1_5(dataJO.get("src").toString());
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1(dataJO.get("src").toString());
								break;
							case 6:
								htmlGoodsSPZS.setImage2_2(dataJO.get("src").toString());
								break;
							case 7:
								htmlGoodsSPZS.setImage2_3(dataJO.get("src").toString());
								break;
							case 8:
								htmlGoodsSPZS.setImage2_4(dataJO.get("src").toString());
								break;
							case 9:
								htmlGoodsSPZS.setImage2_5(dataJO.get("src").toString());
								break;
							case 10:
								if("productExplain".equals(moduleType))
									htmlGoodsSPZS.setEmbed1_1(dataJO.get("src").toString());
								else
									htmlGoodsSPZS.setImage3_1(dataJO.get("src").toString());
								break;
							case 11:
								htmlGoodsSPZS.setImage3_2(dataJO.get("src").toString());
								break;
							case 12:
								htmlGoodsSPZS.setImage3_3(dataJO.get("src").toString());
								break;
							case 13:
								htmlGoodsSPZS.setImage3_4(dataJO.get("src").toString());
								break;
							case 14:
								htmlGoodsSPZS.setImage3_5(dataJO.get("src").toString());
								break;
							case 15:
								htmlGoodsSPZS.setImage4_1(dataJO.get("src").toString());
								break;
							case 16:
								htmlGoodsSPZS.setImage4_2(dataJO.get("src").toString());
								break;
							case 17:
								htmlGoodsSPZS.setImage4_3(dataJO.get("src").toString());
								break;
							case 18:
								htmlGoodsSPZS.setImage4_4(dataJO.get("src").toString());
								break;
							case 19:
								htmlGoodsSPZS.setImage4_5(dataJO.get("src").toString());
								break;
							}
						}
					}
					else {
						if("redWine".equals(moduleType)) {
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1("/GoodsPublic/resource/images/spzs/22ad5cebe49933335608eeb6356e6ab9.png");
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1("/GoodsPublic/resource/images/spzs/41116eb627d54a623813c01bcadd05ce.png");
								break;
							case 10:
								htmlGoodsSPZS.setImage3_1("/GoodsPublic/resource/images/spzs/573ab1fc91d98528915519d96dc2e6ec.png");
								break;
							}
						}
						else if("whiteWine".equals(moduleType)) {
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1("/GoodsPublic/resource/images/spzs/258bb5b4e0d98344406a5f71e32ad767.png");
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1("/GoodsPublic/resource/images/spzs/25787fd7408641e333869e762e514fdd.png");
								break;
							}
						}
						else if("homeTextiles".equals(moduleType)) {
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1("/GoodsPublic/resource/images/spzs/8878b699bd21eeaeeaec254b5d4e6f79.png");
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1("/GoodsPublic/resource/images/spzs/e3f0c2aa261ac2b652fbdca9eaba04f3.png");
								break;
							case 10:
								htmlGoodsSPZS.setImage3_1("/GoodsPublic/resource/images/spzs/bc40c19357bcf636e9ad6e71581686c4.png");
								break;
							case 15:
								htmlGoodsSPZS.setImage4_1("/GoodsPublic/resource/images/spzs/f078f4614735e89cd7608110115c6ad6.png");
								break;
							}
						}
						else if("artwork".equals(moduleType)) {
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1("/GoodsPublic/resource/images/spzs/f21c462d8e78cbe6f31d4b8c67a0560e.png");
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1("/GoodsPublic/resource/images/spzs/a61777ec9042bb003308d961f185a4e1.png");
								break;
							}
						}
						else if("productExplain".equals(moduleType)) {
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1("/GoodsPublic/resource/images/spzs/81a5d69b81bda7b772771e31b57e4fae.png");
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1("/GoodsPublic/resource/images/spzs/59a9157e809d046c12699bc4f431266c.png");
								break;
							case 6:
								htmlGoodsSPZS.setImage2_2("/GoodsPublic/resource/images/spzs/594c03f1f5e93d78248d9d268f8070b6.png");
								break;
							case 10:
								htmlGoodsSPZS.setEmbed1_1("/GoodsPublic/resource/embed/spzs/4c4a6999823cc4088a4996896ae136c2.mp4");
								break;
							}
						}
					}
				}
			}
		
			String goodsNumber = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			htmlGoodsSPZS.setGoodsNumber(goodsNumber);
			
			String addr = request.getLocalAddr();
			int port = request.getLocalPort();
			String contextPath = request.getContextPath();
			//String url = "http://"+addr+":"+port+contextPath+"/merchant/main/goShowHtmlGoods?trade=spzs&moduleType="+moduleType+"&goodsNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountId="+htmlGoodsSPZS.getAccountNumber();
			String url = com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/main/goShowHtmlGoods?trade=spzs&moduleType="+moduleType+"&goodsNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountId="+htmlGoodsSPZS.getAccountNumber();
			
			String fileName = goodsNumber + ".jpg";
			String avaPath="/GoodsPublic/upload/"+fileName;
			String path = "D:/resource";
	        Qrcode.createQrCode(url, path, fileName);
			
	        htmlGoodsSPZS.setQrCode(avaPath);
			int a=publicService.addHtmlGoodsSPZS(htmlGoodsSPZS);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if("cq".equals(from))
			return "../../merchant/main/goEditModule?trade=spzs&moduleType="+moduleType+"&goodsNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountNumber="+accountNumberCq+"&from="+from;
		else
			return "../../merchant/main/goBrowseHtmlGoodsSPZS?moduleType="+moduleType+"&goodsNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountNumber="+htmlGoodsSPZS.getAccountNumber();
	}
	
	public String getCQAccountNumber(HttpServletRequest request) {
    	AccountMsg user=(AccountMsg)request.getSession().getAttribute("user");
    	String accountNumber=user.getId();
    	return accountNumber;
	}
	
	/**
	 * 添加多媒体资料模板内容
	 * @param htmlGoodsDMTZL
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file1_4
	 * @param file1_5
	 * @param file2_1
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/addHtmlGoodsDMTZL",produces="plain/text; charset=UTF-8")
	public String addHtmlGoodsDMTZL(HtmlGoodsDMTZL htmlGoodsDMTZL,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file1_4",required=false) MultipartFile file1_4,
			@RequestParam(value="file1_5",required=false) MultipartFile file1_5,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			HttpServletRequest request) {
		
		System.out.println("111111111111111"+file2_1);

        String accountNumberCq = null;
		String from=htmlGoodsDMTZL.getFrom();
        if("cq".equals(from)) {
        	accountNumberCq=getCQAccountNumber(request);
        	htmlGoodsDMTZL.setAccountNumber(accountNumberCq);
        }
		try {
			MultipartFile[] fileArr=new MultipartFile[6];
			fileArr[0]=file1_1;
			fileArr[1]=file1_2;
			fileArr[2]=file1_3;
			fileArr[3]=file1_4;
			fileArr[4]=file1_5;
			fileArr[5]=file2_1;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],"");
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								htmlGoodsDMTZL.setImage1_1(dataJO.get("src").toString());
								break;
							case 1:
								htmlGoodsDMTZL.setImage1_2(dataJO.get("src").toString());
								break;
							case 2:
								htmlGoodsDMTZL.setImage1_3(dataJO.get("src").toString());
								break;
							case 3:
								htmlGoodsDMTZL.setImage1_4(dataJO.get("src").toString());
								break;
							case 4:
								htmlGoodsDMTZL.setImage1_5(dataJO.get("src").toString());
								break;
							case 5:
								htmlGoodsDMTZL.setEmbed1_1(dataJO.get("src").toString());
								break;
							}
						}
					}
					else {
						switch (i) {
						case 0:
							htmlGoodsDMTZL.setImage1_1("/GoodsPublic/resource/images/dmtzl/c769d75fc7033f7218ca8bcb0c08624e.jpg");
							break;
						case 5:
							htmlGoodsDMTZL.setEmbed1_1("/GoodsPublic/resource/embed/dmtzl/d707ea145302bad9422553804f43d669_conv.H_57_5.mp4");
							break;
						}
					}
				}
			}
			
			String goodsNumber = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			htmlGoodsDMTZL.setGoodsNumber(goodsNumber);
			
			String addr = request.getLocalAddr();
			int port = request.getLocalPort();
			String contextPath = request.getContextPath();
			//String url = "http://"+addr+":"+port+contextPath+"/merchant/main/goShowHtmlGoods?trade=dmtzl&goodsNumber="+htmlGoodsDMTZL.getGoodsNumber()+"&accountId="+htmlGoodsDMTZL.getAccountNumber();
			String url = com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/main/goShowHtmlGoods?trade=dmtzl&goodsNumber="+htmlGoodsDMTZL.getGoodsNumber()+"&accountId="+htmlGoodsDMTZL.getAccountNumber();
			
			String fileName = goodsNumber + ".jpg";
			String avaPath="/GoodsPublic/upload/"+fileName;
			String path = "D:/resource";
			Qrcode.createQrCode(url, path, fileName);
			
			htmlGoodsDMTZL.setQrCode(avaPath);

			int a=publicService.addHtmlGoodsDMTZL(htmlGoodsDMTZL);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if("cq".equals(from))
			return "../../merchant/main/goEditModule?trade=dmtzl&goodsNumber="+htmlGoodsDMTZL.getGoodsNumber()+"&accountNumber="+accountNumberCq+"&from="+from;
		else
			return "../../merchant/main/goBrowseHtmlGoodsDMTZL?goodsNumber="+htmlGoodsDMTZL.getGoodsNumber()+"&accountNumber="+htmlGoodsDMTZL.getAccountNumber();
	}
	

	@RequestMapping(value="/addBatchHtmlGoodsJZSG")
	@ResponseBody
	public Map<String, Object> addBatchHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoodsJZSG,
			String jaStr,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			@RequestParam(value="file2_2",required=false) MultipartFile file2_2,
			@RequestParam(value="file2_3",required=false) MultipartFile file2_3,
			HttpServletRequest request) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		//System.out.println("==="+jaStr);
		JSONArray ja = JSONArray.fromObject(jaStr);
		try {
			MultipartFile[] fileArr=new MultipartFile[6];
			fileArr[0]=file1_1;
			fileArr[1]=file1_2;
			fileArr[2]=file1_3;
			fileArr[3]=file2_1;
			fileArr[4]=file2_2;
			fileArr[5]=file2_3;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],"");
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								htmlGoodsJZSG.setImage1_1(dataJO.get("src").toString());
								break;
							case 1:
								htmlGoodsJZSG.setImage1_2(dataJO.get("src").toString());
								break;
							case 2:
								htmlGoodsJZSG.setImage1_3(dataJO.get("src").toString());
								break;
							case 3:
								htmlGoodsJZSG.setImage2_1(dataJO.get("src").toString());
								break;
							case 4:
								htmlGoodsJZSG.setImage2_2(dataJO.get("src").toString());
								break;
							case 5:
								htmlGoodsJZSG.setImage2_3(dataJO.get("src").toString());
								break;
							}
						}
					}
					else {
						switch (i) {
						case 0:
							htmlGoodsJZSG.setImage1_1("/GoodsPublic/resource/images/jzsg/bf0b334d871019cf3b2359e22b405d1c.png");
							break;
						case 3:
							htmlGoodsJZSG.setImage2_1("/GoodsPublic/resource/images/jzsg/43a339cd90f1a6b00c0c256d49d6a119.png");
							break;
						}
					}
				}
			}
			
			JSONObject jo = ja.getJSONObject(0);
			Iterator<String> it = jo.keys();
			while (it.hasNext()) {
				String key = it.next();
				String value = jo.getString(key);
				Integer colIndex = Integer.valueOf(key.substring(5));
				switch (colIndex) {
				case 1:
					htmlGoodsJZSG.setRyxxName1(value);
					break;
				case 2:
					htmlGoodsJZSG.setRyxxName2(value);
					break;
				case 3:
					htmlGoodsJZSG.setRyxxName3(value);
					break;
				case 4:
					htmlGoodsJZSG.setRyxxName4(value);
					break;
				case 5:
					htmlGoodsJZSG.setRyxxName5(value);
					break;
				case 6:
					htmlGoodsJZSG.setRyxxName6(value);
					break;
				case 7:
					htmlGoodsJZSG.setRyxxName7(value);
					break;
				case 8:
					htmlGoodsJZSG.setRyxxName8(value);
					break;
				case 9:
					htmlGoodsJZSG.setRyxxName9(value);
					break;
				case 10:
					htmlGoodsJZSG.setRyxxName10(value);
					break;
				}
			}
			
			for(int i=1;i<ja.size();i++) {
				String userNumber = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+i;
				htmlGoodsJZSG.setUserNumber(userNumber);
				jo = ja.getJSONObject(i);
				it = jo.keys();
				while (it.hasNext()) {
					String key = it.next();
					String value = jo.getString(key);
					Integer colIndex = Integer.valueOf(key.substring(5));
					//System.out.println("key==="+key);
					switch (colIndex) {
					case 1:
						htmlGoodsJZSG.setRyxxValue1(value);
						break;
					case 2:
						htmlGoodsJZSG.setRyxxValue2(value);
						break;
					case 3:
						htmlGoodsJZSG.setRyxxValue3(value);
						break;
					case 4:
						htmlGoodsJZSG.setRyxxValue4(value);
						break;
					case 5:
						htmlGoodsJZSG.setRyxxValue5(value);
						break;
					case 6:
						htmlGoodsJZSG.setRyxxValue6(value);
						break;
					case 7:
						htmlGoodsJZSG.setRyxxValue7(value);
						break;
					case 8:
						htmlGoodsJZSG.setRyxxValue8(value);
						break;
					case 9:
						htmlGoodsJZSG.setRyxxValue9(value);
						break;
					case 10:
						htmlGoodsJZSG.setRyxxValue10(value);
						break;
					}
				}
			
				String addr = request.getLocalAddr();
				int port = request.getLocalPort();
				String contextPath = request.getContextPath();
				//String url = "http://"+addr+":"+port+contextPath+"/merchant/main/goShowHtmlGoods?trade=jzsg&userNumber="+htmlGoodsJZSG.getUserNumber()+"&accountId="+htmlGoodsJZSG.getAccountNumber();
				String url = com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/main/goShowHtmlGoods?trade=jzsg&userNumber="+htmlGoodsJZSG.getUserNumber()+"&accountId="+htmlGoodsJZSG.getAccountNumber();
				
				String fileName = userNumber + ".jpg";
				String avaPath="/GoodsPublic/upload/"+fileName;
				String path = "D:/resource";
				Qrcode.createQrCode(url, path, fileName);
				
				htmlGoodsJZSG.setQrCode(avaPath);
	
				int a=publicService.addHtmlGoodsJZSG(htmlGoodsJZSG);
			}

			jsonMap.put("message", "ok");
			jsonMap.put("info", "批量导入成功！");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			jsonMap.put("message", "no");
			jsonMap.put("info", "批量导入失败！");
		}
		finally {
			return jsonMap;
		}
	}
	
	/**
	 * 添加建筑施工模板内容
	 * @param htmlGoodsJZSG
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file2_1
	 * @param file2_2
	 * @param file2_3
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/addHtmlGoodsJZSG",produces="plain/text; charset=UTF-8")
	public String addHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoodsJZSG,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			@RequestParam(value="file2_2",required=false) MultipartFile file2_2,
			@RequestParam(value="file2_3",required=false) MultipartFile file2_3,
			HttpServletRequest request) {
		
		System.out.println("111111111111111"+file2_1);
		System.out.println("111111111111111"+file2_2);
		System.out.println("111111111111111"+file2_3);
        String accountNumberCq = null;
		String from=htmlGoodsJZSG.getFrom();
        if("cq".equals(from)) {
        	accountNumberCq=getCQAccountNumber(request);
        	htmlGoodsJZSG.setAccountNumber(accountNumberCq);
        }
		try {
			MultipartFile[] fileArr=new MultipartFile[6];
			fileArr[0]=file1_1;
			fileArr[1]=file1_2;
			fileArr[2]=file1_3;
			fileArr[3]=file2_1;
			fileArr[4]=file2_2;
			fileArr[5]=file2_3;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],"");
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								htmlGoodsJZSG.setImage1_1(dataJO.get("src").toString());
								break;
							case 1:
								htmlGoodsJZSG.setImage1_2(dataJO.get("src").toString());
								break;
							case 2:
								htmlGoodsJZSG.setImage1_3(dataJO.get("src").toString());
								break;
							case 3:
								htmlGoodsJZSG.setImage2_1(dataJO.get("src").toString());
								break;
							case 4:
								htmlGoodsJZSG.setImage2_2(dataJO.get("src").toString());
								break;
							case 5:
								htmlGoodsJZSG.setImage2_3(dataJO.get("src").toString());
								break;
							}
						}
					}
					else {
						switch (i) {
						case 0:
							htmlGoodsJZSG.setImage1_1("/GoodsPublic/resource/images/jzsg/bf0b334d871019cf3b2359e22b405d1c.png");
							break;
						case 3:
							htmlGoodsJZSG.setImage2_1("/GoodsPublic/resource/images/jzsg/43a339cd90f1a6b00c0c256d49d6a119.png");
							break;
						}
					}
				}
			}
			
			String userNumber = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			htmlGoodsJZSG.setUserNumber(userNumber);
			
			String addr = request.getLocalAddr();
			int port = request.getLocalPort();
			String contextPath = request.getContextPath();
			//String url = "http://"+addr+":"+port+contextPath+"/merchant/main/goShowHtmlGoods?trade=jzsg&userNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountId="+htmlGoodsSPZS.getAccountNumber();
			String url = com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/main/goShowHtmlGoods?trade=jzsg&userNumber="+htmlGoodsJZSG.getUserNumber()+"&accountId="+htmlGoodsJZSG.getAccountNumber();
			
			String fileName = userNumber + ".jpg";
			String avaPath="/GoodsPublic/upload/"+fileName;
			String path = "D:/resource";
			Qrcode.createQrCode(url, path, fileName);
			
			htmlGoodsJZSG.setQrCode(avaPath);

			int a=publicService.addHtmlGoodsJZSG(htmlGoodsJZSG);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if("cq".equals(from))
			return "../../merchant/main/goEditModule?trade=jzsg&userNumber="+htmlGoodsJZSG.getUserNumber()+"&accountNumber="+accountNumberCq+"&from="+from;
		else
			return "../../merchant/main/goBrowseHtmlGoodsJZSG?userNumber="+htmlGoodsJZSG.getUserNumber()+"&accountNumber="+htmlGoodsJZSG.getAccountNumber();
	}
	
	@RequestMapping(value="/addBatchScoreQrcode")
	@ResponseBody
	public Map<String, Object> addBatchScoreQrcode(ScoreQrcode scoreQrcode,String qrcodeUuidsStr,String qrcodeUrlsStr) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		String[] qrcodeUuidArr = qrcodeUuidsStr.split(",");
		String[] qrcodeUrlArr = qrcodeUrlsStr.split(",");
		
		int count = 0;
		for (int i = 0; i < qrcodeUuidArr.length; i++) {
			scoreQrcode.setUuid(qrcodeUuidArr[i]);
			scoreQrcode.setQrcode(qrcodeUrlArr[i]);
			count += publicService.addScoreQrcode(scoreQrcode);
		}
		
		if(count==qrcodeUuidArr.length) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "生成成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "生成失败！");
		}
		
		return jsonMap;
	}
	
	@RequestMapping(value="/addScoreQrcode",produces="plain/text; charset=UTF-8")
	public String addScoreQrcode(ScoreQrcode scoreQrcode,
			@RequestParam(value="file",required=false) MultipartFile file,
			HttpServletRequest request) {
		
		try {
			if(file.getSize()>0) {
				String jsonStr = FileUploadUtils.appUploadContentImg(request,file,"");
				JSONObject fileJson = JSONObject.fromObject(jsonStr);
				if("成功".equals(fileJson.get("msg"))) {
					JSONObject dataJO = (JSONObject)fileJson.get("data");
					scoreQrcode.setShopLogo(dataJO.get("src").toString());
				}
			}

			String uuid = UUID.randomUUID().toString().replaceAll("-", "");
			scoreQrcode.setUuid(uuid);
			//String jsonParams="{\"accountId\":\""+scoreQrcode.getAccountNumber()+"\",\"uuid\":\""+uuid+"\"}";
			//String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+APP_ID+"&redirect_uri=http://www.qrcodesy.com/getCode.asp?params="+scoreQrcode.getAccountNumber()+","+uuid+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
			String url="http://www.qrcodesy.com:8080/GoodsPublic/merchant/main/goShowHtmlGoods?trade=jfdhjp&accountId="+scoreQrcode.getAccountNumber()+"&uuid="+uuid;
			
			String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
			String avaPath="/GoodsPublic/upload/jfdhjp/"+fileName;
			String path = "D:/resource/jfdhjp";
			Qrcode.createQrCode(url, path, fileName);
			
			scoreQrcode.setQrcode(avaPath);
			scoreQrcode.setExample(true);
			scoreQrcode.setJfewmlbShow(true);
			
			int a=publicService.addScoreQrcode(scoreQrcode);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "../../merchant/main/goHtmlGoodsList?trade=jfdhjp&nav=ewmsc&accountId="+scoreQrcode.getAccountNumber();
	}
	
	@RequestMapping(value="/editScoreQrcode")
	@ResponseBody
	public Map<String, Object> editScoreQrcode(ScoreQrcode sq, String jpmdhReg) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=publicService.editScoreQrcode(sq,jpmdhReg);
		if(count>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "编辑成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "编辑失败！");
		}
		return jsonMap;
	}

	/**
	 * 生成积分兑换奖品二维码
	 * @param url
	 * @param qpbh
	 * @return
	 */
	@RequestMapping(value="/createJFDHJPQrcode")
	@ResponseBody
	public Map<String, Object> createJFDHJPQrcode(String accountNumber, Integer qrcodeIndex) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		//String jsonParams="{\"accountId\":\""+accountNumber+"\",\"uuid\":\""+uuid+"\"}";
		//String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf600e162d89732da&redirect_uri=http://www.qrcodesy.com/getCode.asp?jsonParams="+jsonParams+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
		//String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxf600e162d89732da&redirect_uri=http://www.qrcodesy.com/getCode.asp?params="+accountNumber+","+uuid+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
		String url="http://www.qrcodesy.com:8080/GoodsPublic/merchant/main/goShowHtmlGoods?trade=jfdhjp&accountId="+accountNumber+"&uuid="+uuid;
		String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) +qrcodeIndex+ ".jpg";
		String avaPath="/GoodsPublic/upload/jfdhjp/"+fileName;
		String path = "D:/resource/jfdhjp";
        Qrcode.createQrCode(url, path, fileName);
        
        jsonMap.put("uuid", uuid);
        jsonMap.put("qrcodeUrl", avaPath);
		
		return jsonMap;
	}
	
	/**
	 * 完成编辑商品展示模板内容
	 * @param htmlGoodsSPZS
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file1_4
	 * @param file1_5
	 * @param file2_1
	 * @param file2_2
	 * @param file2_3
	 * @param file2_4
	 * @param file2_5
	 * @param file3_1
	 * @param file3_2
	 * @param file3_3
	 * @param file3_4
	 * @param file3_5
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/finishEditHtmlGoodsSPZS",produces="plain/text; charset=UTF-8")
	public String finishEditHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file1_4",required=false) MultipartFile file1_4,
			@RequestParam(value="file1_5",required=false) MultipartFile file1_5,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			@RequestParam(value="file2_2",required=false) MultipartFile file2_2,
			@RequestParam(value="file2_3",required=false) MultipartFile file2_3,
			@RequestParam(value="file2_4",required=false) MultipartFile file2_4,
			@RequestParam(value="file2_5",required=false) MultipartFile file2_5,
			@RequestParam(value="file3_1",required=false) MultipartFile file3_1,
			@RequestParam(value="file3_2",required=false) MultipartFile file3_2,
			@RequestParam(value="file3_3",required=false) MultipartFile file3_3,
			@RequestParam(value="file3_4",required=false) MultipartFile file3_4,
			@RequestParam(value="file3_5",required=false) MultipartFile file3_5,
			@RequestParam(value="file4_1",required=false) MultipartFile file4_1,
			@RequestParam(value="file4_2",required=false) MultipartFile file4_2,
			@RequestParam(value="file4_3",required=false) MultipartFile file4_3,
			@RequestParam(value="file4_4",required=false) MultipartFile file4_4,
			@RequestParam(value="file4_5",required=false) MultipartFile file4_5,
			HttpServletRequest request) {
		
		editHtmlGoodsSPZS(htmlGoodsSPZS,file1_1,file1_2,file1_3,file1_4,file1_5,file2_1,file2_2,file2_3,file2_4,file2_5,file3_1,file3_2,file3_3,file3_4,file3_5,file4_1,file4_2,file4_3,file4_4,file4_5,request);
		
		return "../../merchant/main/goBrowseHtmlGoodsSPZS?moduleType="+htmlGoodsSPZS.getModuleType()+"&goodsNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountNumber="+htmlGoodsSPZS.getAccountNumber();
	}
	
	/**
	 * 完成编辑多媒体资料模板内容
	 * @param htmlGoodsDMTZL
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file1_4
	 * @param file1_5
	 * @param file2_1
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/finishEditHtmlGoodsDMTZL",produces="plain/text; charset=UTF-8")
	public String finishEditHtmlGoodsDMTZL(HtmlGoodsDMTZL htmlGoodsDMTZL,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file1_4",required=false) MultipartFile file1_4,
			@RequestParam(value="file1_5",required=false) MultipartFile file1_5,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			HttpServletRequest request) {
		
		editHtmlGoodsDMTZL(htmlGoodsDMTZL,file1_1,file1_2,file1_3,file1_4,file1_5,file2_1,request);
		
		return "../../merchant/main/goBrowseHtmlGoodsDMTZL?goodsNumber="+htmlGoodsDMTZL.getGoodsNumber()+"&accountNumber="+htmlGoodsDMTZL.getAccountNumber();
	}
	
	/**
	 * 完成编辑建筑施工模板内容
	 * @param htmlGoodsJZSG
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file2_1
	 * @param file2_2
	 * @param file2_3
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/finishEditHtmlGoodsJZSG",produces="plain/text; charset=UTF-8")
	public String finishEditHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoodsJZSG,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			@RequestParam(value="file2_2",required=false) MultipartFile file2_2,
			@RequestParam(value="file2_3",required=false) MultipartFile file2_3,
			HttpServletRequest request) {
		
		editHtmlGoodsJZSG(htmlGoodsJZSG,file1_1,file1_2,file1_3,file2_1,file2_2,file2_3,request);
		
		return "../../merchant/main/goBrowseHtmlGoodsJZSG?userNumber="+htmlGoodsJZSG.getUserNumber()+"&accountNumber="+htmlGoodsJZSG.getAccountNumber();
	}
	
	/**
	 * 保存编辑商品展示模板内容
	 * @param htmlGoodsSPZS
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file1_4
	 * @param file1_5
	 * @param file2_1
	 * @param file2_2
	 * @param file2_3
	 * @param file2_4
	 * @param file2_5
	 * @param file3_1
	 * @param file3_2
	 * @param file3_3
	 * @param file3_4
	 * @param file3_5
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/saveEditHtmlGoodsSPZS",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String saveEditHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file1_4",required=false) MultipartFile file1_4,
			@RequestParam(value="file1_5",required=false) MultipartFile file1_5,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			@RequestParam(value="file2_2",required=false) MultipartFile file2_2,
			@RequestParam(value="file2_3",required=false) MultipartFile file2_3,
			@RequestParam(value="file2_4",required=false) MultipartFile file2_4,
			@RequestParam(value="file2_5",required=false) MultipartFile file2_5,
			@RequestParam(value="file3_1",required=false) MultipartFile file3_1,
			@RequestParam(value="file3_2",required=false) MultipartFile file3_2,
			@RequestParam(value="file3_3",required=false) MultipartFile file3_3,
			@RequestParam(value="file3_4",required=false) MultipartFile file3_4,
			@RequestParam(value="file3_5",required=false) MultipartFile file3_5,
			@RequestParam(value="file4_1",required=false) MultipartFile file4_1,
			@RequestParam(value="file4_2",required=false) MultipartFile file4_2,
			@RequestParam(value="file4_3",required=false) MultipartFile file4_3,
			@RequestParam(value="file4_4",required=false) MultipartFile file4_4,
			@RequestParam(value="file4_5",required=false) MultipartFile file4_5,
			HttpServletRequest request) {
		
		PlanResult plan=new PlanResult();
		String json;
		int count = editHtmlGoodsSPZS(htmlGoodsSPZS,file1_1,file1_2,file1_3,file1_4,file1_5,file2_1,file2_2,file2_3,file2_4,file2_5,file3_1,file3_2,file3_3,file3_4,file3_5,file4_1,file4_2,file4_3,file4_4,file4_5,request);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("内容保存失败！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("内容保存成功！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 保存编辑多媒体资料模板内容
	 * @param htmlGoodsDMTZL
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file1_4
	 * @param file1_5
	 * @param file2_1
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/saveEditHtmlGoodsDMTZL",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String saveEditHtmlGoodsDMTZL(HtmlGoodsDMTZL htmlGoodsDMTZL,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file1_4",required=false) MultipartFile file1_4,
			@RequestParam(value="file1_5",required=false) MultipartFile file1_5,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			HttpServletRequest request) {
		
		PlanResult plan=new PlanResult();
		String json;
		int count = editHtmlGoodsDMTZL(htmlGoodsDMTZL,file1_1,file1_2,file1_3,file1_4,file1_5,file2_1,request);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("内容保存失败！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("内容保存成功！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 保存编辑建筑施工模板内容
	 * @param htmlGoodsJZSG
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file2_1
	 * @param file2_2
	 * @param file2_3
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/saveEditHtmlGoodsJZSG",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String saveEditHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoodsJZSG,
			@RequestParam(value="file1_1",required=false) MultipartFile file1_1,
			@RequestParam(value="file1_2",required=false) MultipartFile file1_2,
			@RequestParam(value="file1_3",required=false) MultipartFile file1_3,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			@RequestParam(value="file2_2",required=false) MultipartFile file2_2,
			@RequestParam(value="file2_3",required=false) MultipartFile file2_3,
			HttpServletRequest request) {
		
		PlanResult plan=new PlanResult();
		String json;
		int count = editHtmlGoodsJZSG(htmlGoodsJZSG,file1_1,file1_2,file1_3,file2_1,file2_2,file2_3,request);
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("内容保存失败！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("内容保存成功！");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 提交编辑好的商品展示的模板内容
	 * @param htmlGoodsSPZS
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file1_4
	 * @param file1_5
	 * @param file2_1
	 * @param file2_2
	 * @param file2_3
	 * @param file2_4
	 * @param file2_5
	 * @param file3_1
	 * @param file3_2
	 * @param file3_3
	 * @param file3_4
	 * @param file3_5
	 * @param request
	 * @return
	 */
	public int editHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS, MultipartFile file1_1, MultipartFile file1_2, MultipartFile file1_3, MultipartFile file1_4, MultipartFile file1_5, MultipartFile file2_1, MultipartFile file2_2, MultipartFile file2_3, MultipartFile file2_4, MultipartFile file2_5, MultipartFile file3_1, MultipartFile file3_2, MultipartFile file3_3, MultipartFile file3_4, MultipartFile file3_5, MultipartFile file4_1, MultipartFile file4_2, MultipartFile file4_3, MultipartFile file4_4, MultipartFile file4_5, HttpServletRequest request) {
		int count = 0;
		try {
			String moduleType = htmlGoodsSPZS.getModuleType();
			MultipartFile[] fileArr=new MultipartFile[20];
			fileArr[0]=file1_1;
			fileArr[1]=file1_2;
			fileArr[2]=file1_3;
			fileArr[3]=file1_4;
			fileArr[4]=file1_5;
			fileArr[5]=file2_1;
			fileArr[6]=file2_2;
			fileArr[7]=file2_3;
			fileArr[8]=file2_4;
			fileArr[9]=file2_5;
			fileArr[10]=file3_1;
			fileArr[11]=file3_2;
			fileArr[12]=file3_3;
			fileArr[13]=file3_4;
			fileArr[14]=file3_5;
			fileArr[15]=file4_1;
			fileArr[16]=file4_2;
			fileArr[17]=file4_3;
			fileArr[18]=file4_4;
			fileArr[19]=file4_5;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],"");
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								htmlGoodsSPZS.setImage1_1(dataJO.get("src").toString());
								break;
							case 1:
								htmlGoodsSPZS.setImage1_2(dataJO.get("src").toString());
								break;
							case 2:
								htmlGoodsSPZS.setImage1_3(dataJO.get("src").toString());
								break;
							case 3:
								htmlGoodsSPZS.setImage1_4(dataJO.get("src").toString());
								break;
							case 4:
								htmlGoodsSPZS.setImage1_5(dataJO.get("src").toString());
								break;
							case 5:
								htmlGoodsSPZS.setImage2_1(dataJO.get("src").toString());
								break;
							case 6:
								htmlGoodsSPZS.setImage2_2(dataJO.get("src").toString());
								break;
							case 7:
								htmlGoodsSPZS.setImage2_3(dataJO.get("src").toString());
								break;
							case 8:
								htmlGoodsSPZS.setImage2_4(dataJO.get("src").toString());
								break;
							case 9:
								htmlGoodsSPZS.setImage2_5(dataJO.get("src").toString());
								break;
							case 10:
								if("productExplain".equals(moduleType))
									htmlGoodsSPZS.setImage3_1(dataJO.get("src").toString());
								else
									htmlGoodsSPZS.setEmbed1_1(dataJO.get("src").toString());
								break;
							case 11:
								htmlGoodsSPZS.setImage3_2(dataJO.get("src").toString());
								break;
							case 12:
								htmlGoodsSPZS.setImage3_3(dataJO.get("src").toString());
								break;
							case 13:
								htmlGoodsSPZS.setImage3_4(dataJO.get("src").toString());
								break;
							case 14:
								htmlGoodsSPZS.setImage3_5(dataJO.get("src").toString());
								break;
							case 15:
								htmlGoodsSPZS.setImage4_1(dataJO.get("src").toString());
								break;
							case 16:
								htmlGoodsSPZS.setImage4_2(dataJO.get("src").toString());
								break;
							case 17:
								htmlGoodsSPZS.setImage4_3(dataJO.get("src").toString());
								break;
							case 18:
								htmlGoodsSPZS.setImage4_4(dataJO.get("src").toString());
								break;
							case 19:
								htmlGoodsSPZS.setImage4_5(dataJO.get("src").toString());
								break;
							}
						}
					}
				}
			}
			count=publicService.editHtmlGoodsSPZS(htmlGoodsSPZS);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			return count;
		}
	}
	
	/**
	 * 编辑多媒体资料模板内容
	 * @param htmlGoodsDMTZL
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file1_4
	 * @param file1_5
	 * @param file2_1
	 * @param request
	 * @return
	 */
	public int editHtmlGoodsDMTZL(HtmlGoodsDMTZL htmlGoodsDMTZL, MultipartFile file1_1, MultipartFile file1_2, MultipartFile file1_3, MultipartFile file1_4, MultipartFile file1_5, MultipartFile file2_1, HttpServletRequest request) {
		int count = 0;
		try {
			MultipartFile[] fileArr=new MultipartFile[6];
			fileArr[0]=file1_1;
			fileArr[1]=file1_2;
			fileArr[2]=file1_3;
			fileArr[3]=file1_4;
			fileArr[4]=file1_5;
			fileArr[5]=file2_1;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],"");
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								htmlGoodsDMTZL.setImage1_1(dataJO.get("src").toString());
								break;
							case 1:
								htmlGoodsDMTZL.setImage1_2(dataJO.get("src").toString());
								break;
							case 2:
								htmlGoodsDMTZL.setImage1_3(dataJO.get("src").toString());
								break;
							case 3:
								htmlGoodsDMTZL.setImage1_4(dataJO.get("src").toString());
								break;
							case 4:
								htmlGoodsDMTZL.setImage1_5(dataJO.get("src").toString());
								break;
							case 5:
								htmlGoodsDMTZL.setEmbed1_1(dataJO.get("src").toString());
								break;
							}
						}
					}
				}
			}
			count=publicService.editHtmlGoodsDMTZL(htmlGoodsDMTZL);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			return count;
		}
	}
	
	/**
	 * 编辑建筑施工模板内容
	 * @param htmlGoodsJZSG
	 * @param file1_1
	 * @param file1_2
	 * @param file1_3
	 * @param file2_1
	 * @param file2_2
	 * @param file2_3
	 * @param request
	 * @return
	 */
	public int editHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoodsJZSG, MultipartFile file1_1, MultipartFile file1_2, MultipartFile file1_3, MultipartFile file2_1, MultipartFile file2_2, MultipartFile file2_3, HttpServletRequest request) {
		int count = 0;
		try {
			MultipartFile[] fileArr=new MultipartFile[6];
			fileArr[0]=file1_1;
			fileArr[1]=file1_2;
			fileArr[2]=file1_3;
			fileArr[3]=file2_1;
			fileArr[4]=file2_2;
			fileArr[5]=file2_3;
			for (int i = 0; i < fileArr.length; i++) {
				String jsonStr = null;
				if(fileArr[i]!=null) {
					if(fileArr[i].getSize()>0) {
						jsonStr = FileUploadUtils.appUploadContentImg(request,fileArr[i],"");
						JSONObject fileJson = JSONObject.fromObject(jsonStr);
						if("成功".equals(fileJson.get("msg"))) {
							JSONObject dataJO = (JSONObject)fileJson.get("data");
							switch (i) {
							case 0:
								htmlGoodsJZSG.setImage1_1(dataJO.get("src").toString());
								break;
							case 1:
								htmlGoodsJZSG.setImage1_2(dataJO.get("src").toString());
								break;
							case 2:
								htmlGoodsJZSG.setImage1_3(dataJO.get("src").toString());
								break;
							case 3:
								htmlGoodsJZSG.setImage2_1(dataJO.get("src").toString());
								break;
							case 4:
								htmlGoodsJZSG.setImage2_2(dataJO.get("src").toString());
								break;
							case 5:
								htmlGoodsJZSG.setImage2_3(dataJO.get("src").toString());
								break;
							}
						}
					}
				}
			}
			count=publicService.editHtmlGoodsJZSG(htmlGoodsJZSG);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			return count;
		}
	}
	
	/**
	 * 这个是显示商品的模板内容，用于后台商户浏览
	 * @param goodsNumber
	 * @param accountNumber
	 * @param request
	 * @return
	 */
	@RequestMapping("/goBrowseHtmlGoodsSPZS")
	public String goBrowseHtmlGoodsSPZS(String moduleType, String goodsNumber, String accountNumber, HttpServletRequest request) {
		HtmlGoodsSPZS htmlGoodsSPZS = publicService.getHtmlGoodsSPZS(moduleType,goodsNumber,accountNumber);
		request.setAttribute("htmlGoodsSPZS", htmlGoodsSPZS);
		String url="";
		if(ModuleSPZS.RED_WINE.equals(moduleType))
			url="/merchant/spzs/redWine/browseHtmlGoods";
		else if(ModuleSPZS.WHITE_WINE.equals(moduleType))
			url="/merchant/spzs/whiteWine/browseHtmlGoods";
		else if(ModuleSPZS.HOME_TEXTILES.equals(moduleType))
			url="/merchant/spzs/homeTextiles/browseHtmlGoods";
		else if(ModuleSPZS.ARTWORK.equals(moduleType))
			url="/merchant/spzs/artwork/browseHtmlGoods";
		else if(ModuleSPZS.PRODUCT_EXPLAIN.equals(moduleType))
			url="/merchant/spzs/productExplain/browseHtmlGoods";
		return url;
	}
	
	@RequestMapping("/goBrowseHtmlGoodsDMTZL")
	public String goBrowseHtmlGoodsDMTZL(String goodsNumber, String accountNumber, HttpServletRequest request) {
		HtmlGoodsDMTZL htmlGoodsDMTZL = publicService.getHtmlGoodsDMTZL(goodsNumber,accountNumber);
		request.setAttribute("htmlGoodsDMTZL", htmlGoodsDMTZL);
		return "/merchant/dmtzl/browseHtmlGoods";
	}
	
	/**
	 * 这个是显示建筑施工的模板内容，用于后台商户浏览
	 * @param userNumber
	 * @param accountNumber
	 * @param request
	 * @return
	 */
	@RequestMapping("/goBrowseHtmlGoodsJZSG")
	public String goBrowseHtmlGoodsJZSG(String userNumber, String accountNumber, HttpServletRequest request) {
		HtmlGoodsJZSG htmlGoodsJZSG = publicService.getHtmlGoodsJZSG(userNumber,accountNumber);
		request.setAttribute("htmlGoodsJZSG", htmlGoodsJZSG);
		return "/merchant/jzsg/browseHtmlGoods";
	}
	
	/**
	 * 验证商品编号
	 * @param goodsNumber
	 * @return
	 */
	@RequestMapping(value="/checkGoodsNumber",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String checkGoodsNumber(String goodsNumber, String accountNumber) {
		int count=publicService.getGoodsByGoodsNumber(goodsNumber,accountNumber);
		PlanResult plan=new PlanResult();
		String json;
		if(count==1) {
			plan.setStatus(1);
			plan.setMsg("商品编码重复");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(0);
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 生成show页面地址栏二维码
	 * @param url
	 * @param goodsNumber
	 */
	@RequestMapping(value="/createShowUrlQrcode",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String createShowUrlQrcode(String url, String goodsNumber, String accountNumber) {
		publicService.createShowUrlQrcode(url,goodsNumber,accountNumber);
		PlanResult plan=new PlanResult();
		String json;
		plan.setStatus(0);
		plan.setUrl(url);
		json=JsonUtil.getJsonFromObject(plan);
		return json;
	}
	
	/**
	 * 添加/编辑类别信息
	 * */
	@RequestMapping(value="/editCategory",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String editCategory(CategoryInfo categoryInfo,HttpSession session) {
		int count=categoryService.editCategory(categoryInfo,session);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(1);
			plan.setMsg("分类编辑失败");
			json=JsonUtil.getJsonFromObject(plan);
		}else if(count==1){
			plan.setStatus(0);
			plan.setMsg("分类编辑成功");
			plan.setUrl("/merchant/main/queryCategoryList");
			json=JsonUtil.getJsonFromObject(plan);
		}else {
			plan.setStatus(1);
			plan.setMsg("分类已存在");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 编辑商户信息
	 * @param accountMsg
	 * @param request
	 * @param file
	 * @return
	 */
	@RequestMapping(value="/editAccountInfo")
	@ResponseBody
	public String editAccountInfo(AccountMsg accountMsg,HttpServletRequest request) {
		String json="";
		try {
			AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
			accountMsg.setId(msg.getId());
			int a=publicService.editAccountInfo(accountMsg);

			PlanResult plan=new PlanResult();
			if(a==0) {
				plan.setStatus(0);
				//plan.setMsg("商家编辑失败");
			}
			else {
				plan.setStatus(1);
				//plan.setMsg("商家编辑成功，重新登录生效！");
			}
			json=JsonUtil.getJsonFromObject(plan);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//return "/merchant/accountInfo";
		return json;
	}
	
	@RequestMapping(value="/editJFDHJPActivity",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String editJFDHJPActivity(JFDHJPActivity jfdhjpActivity) {
		String json="";
		int a=0;
		if(jfdhjpActivity.getId()==null) {
			a=publicService.addJFDHJPActivity(jfdhjpActivity);
		}
		else
			a=publicService.editJFDHJPActivity(jfdhjpActivity);

		PlanResult plan=new PlanResult();
		if(a==0) {
			plan.setStatus(0);
			plan.setMsg("活动设置编辑失败");
		}
		else {
			plan.setStatus(1);
			plan.setMsg("活动设置编辑成功");
		}
		json=JsonUtil.getJsonFromObject(plan);
		return json;
	}
	
	@RequestMapping(value="/updatePwdByAccountId")
	@ResponseBody
	public String updatePwdByAccountId(String passWord) {
		AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
		String accountId = msg.getId();
		int a = publicService.updatePwdByAccountId(passWord,accountId);
		
		PlanResult plan=new PlanResult();
		if(a==0) {
			plan.setStatus(0);
		}
		else {
			plan.setStatus(1);
		}
		return JsonUtil.getJsonFromObject(plan);
	}
	
	/**
	 * 编辑商品信息
	 * */
	@RequestMapping(value="/editGoods",produces="plain/text; charset=UTF-8")
	public String editGoods(Goods goods,HttpServletRequest request,@RequestParam(value="file")  MultipartFile file) {
		String json="";
		try {
			if(file.getSize()>0) {
				String jsonStr = FileUploadUtils.appUploadContentImg(request,file,"");
				JSONObject fileJson = JSONObject.fromObject(jsonStr);
				if("成功".equals(fileJson.get("msg"))) {
					JSONObject dataJO = (JSONObject)fileJson.get("data");
					goods.setImgUrl(dataJO.get("src").toString());
				}
			}
			
			List<GoodsLabelSet> glsList = publicService.getGoodsLabelSetByModuleAccountId("editGoods", goods.getAccountNumber());
			int count=publicService.editGoods(goods,glsList);
			PlanResult plan=new PlanResult();
			if(count==0) {
				plan.setStatus(1);
				plan.setMsg("商品编辑失败");
				json=JsonUtil.getJsonFromObject(plan);
			}
			else {
				plan.setStatus(0);
				plan.setMsg("商品编辑成功");
			}
			json=JsonUtil.getJsonFromObject(plan);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "../../merchant/main/goGoodsList?categoryId="+goods.getCategory_id()+"&json="+json;
	}
	
	/**
	 * 删除类别信息
	 * @return
	 */
	@RequestMapping(value="/deleteCategory",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteCategory(String ids, HttpSession session) {
		//TODO 针对分类的动态进行实时调整更新
		int count=categoryService.deletCategoryInfo(ids,session);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(1);
			plan.setMsg("类别删除失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(0);
			plan.setMsg("类别删除成功");
			plan.setUrl("/merchant/main/queryCategoryList");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	@RequestMapping(value="/deleteScoreQrcodeByUuids",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteScoreQrcodeByUuids(String uuids) {

		int count=publicService.deleteScoreQrcodeByUuids(uuids);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除积分兑换奖品信息失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除积分兑换奖品信息成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	@RequestMapping(value="/updatePcExcById",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String updatePcExcById(String id) {
		
		int count=publicService.updatePcExcById(id);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("更新状态失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("更新状态成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 根据id删除商品展示模板内容
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="/deleteHtmlGoodsSPZSByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteHtmlGoodsSPZSByIds(String ids) {
		
		int count=publicService.deleteHtmlGoodsSPZSByIds(ids);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除商品展示信息失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除商品展示信息成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 根据id删除多媒体资料模板内容
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="/deleteHtmlGoodsDMTZLByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteHtmlGoodsDMTZLByIds(String ids) {
		
		int count=publicService.deleteHtmlGoodsDMTZLByIds(ids);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除多媒体资料信息失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除多媒体资料信息成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 根据id删除建筑施工模板内容
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="/deleteHtmlGoodsJZSGByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteHtmlGoodsJZSGByIds(String ids) {
		
		int count=publicService.deleteHtmlGoodsJZSGByIds(ids);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除建筑施工信息失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除建筑施工信息成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 根据id删除商品
	 * @param ids
	 * @return
	 */
	@RequestMapping(value="/deleteGoodsByIds",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteGoodsByIds(String ids) {
		
		int count=publicService.deleteGoodsByIds(ids);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(0);
			plan.setMsg("删除商品信息失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(1);
			plan.setMsg("删除商品信息成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	/**
	 * 根据商户号、类别编号验证是否有商品
	 * @param accountNumber
	 * @param categoryIds
	 * @return
	 */
	@RequestMapping(value="/checkGoodsCount",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String checkGoodsCount(String accountNumber, String categoryIds, String ids) {
		String categoryIds1="";//用来记录有商品的分类编号
		String ids1="";//用来记录无商品的分类id
		String[] idArr = ids.split(",");
		String[] catArr = categoryIds.split(",");
		for (int i = 0; i < catArr.length; i++) {
			int count = publicService.queryGoodsForInt(accountNumber, catArr[i]);
			if(count>0)
				categoryIds1+=","+catArr[i];
			else
				ids1+=","+idArr[i];
		}
		
		PlanResult plan=new PlanResult();
		String json;
		if(!StringUtils.isEmpty(categoryIds1)) {
			categoryIds1=categoryIds1.substring(1);
			plan.setStatus(1);
			plan.setMsg("分类"+categoryIds1+"下存在商品，是否先删除其他分类？");
		}
		else {
			plan.setStatus(0);
		}
		ids1=ids1.substring(1);
		plan.setData(ids1);
		json=JsonUtil.getJsonFromObject(plan);
		return json;
	}
	
	@RequestMapping(value="/deleteLabelByKeys",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String deleteLabelByKeys(String accountNumber, String keys) {
		
		int count = publicService.deleteLabelByKeys(accountNumber, keys);
		
		PlanResult plan=new PlanResult();
		if(count>0) {
			plan.setStatus(1);
			plan.setMsg("删除标签成功！");
		}
		else {
			plan.setStatus(0);
			plan.setMsg("删除标签失败！");
		}
		String json=JsonUtil.getJsonFromObject(plan);
		return json;
	}

	/**
	 * 跳转至商品展示页
	 * @param goodsNumber
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/show",method=RequestMethod.GET)
	public String Show(String goodsNumber,String accountId,HttpServletRequest request) {
		System.out.println(goodsNumber);
		
		Map<String, Object> jsonMap = checkIfPaid(accountId,request);
		String status = jsonMap.get("status").toString();
		if("ok".equals(status)) {
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss");
			request.setAttribute("searchTime", sdf.format(date));
	
			List<GoodsLabelSet> glsList=publicService.getGoodsLabelSetByModuleAccountId("editGoods",accountId);
			request.setAttribute("glsList", glsList);
			
			PlanResult plan=publicService.getGoodsByGN(goodsNumber,accountId);
			Goods goods = (Goods)plan.getData();
			request.setAttribute("plan", goods);
			
			List<Goods> goodsList = publicService.queryGoodsList(goods.getCategory_id(),accountId);
			request.setAttribute("flagGoodsList", goodsList);
			
			AccountMsg accountMsg = publicService.getAccountById(((Goods)plan.getData()).getAccountNumber());
			request.setAttribute("accountMsg", accountMsg);
			
			return "/merchant/show";
		}
		else {
			
			String message = jsonMap.get("message").toString();
			request.setAttribute("message", message);
			
			return "/merchant/unPaid";
		}
	}
	

	@RequestMapping(value="/getPreviewHtmlGoods")
	@ResponseBody
	public Map<String, Object> getPreviewHtmlGoods(String trade,String moduleType,String goodsNumber,String accountId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		switch (trade) {
		case "spzs":
			HtmlGoodsSPZS htmlGoodsSPZS = publicService.getHtmlGoodsSPZS(moduleType,goodsNumber,accountId);
			jsonMap.put("previewSPZS", htmlGoodsSPZS);
			break;
		}
		return jsonMap;
	}
	
	/**
	 * 这个是显示各行业的模板内容，用于前端手机上显示
	 * @param goodsNumber
	 * @param accountId
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/goShowHtmlGoods",method=RequestMethod.GET)
	public String goShowHtmlGoods(String trade,String moduleType,String goodsNumber,String accountId,HttpServletRequest request) {
		
		String url=null;
		String uuid=null;
		Map<String, Object> jsonMap = checkIfPaid(accountId,request);
		String status = jsonMap.get("status").toString();
		if("ok".equals(status)) {
			switch (trade) {
			case "spzs":
				HtmlGoodsSPZS htmlGoodsSPZS = publicService.getHtmlGoodsSPZS(moduleType,goodsNumber,accountId);
				request.setAttribute("htmlGoodsSPZS", htmlGoodsSPZS);
				if(ModuleSPZS.RED_WINE.equals(moduleType))
					url = "/merchant/spzs/redWine/showHtmlGoods";
				else if(ModuleSPZS.WHITE_WINE.equals(moduleType))
					url = "/merchant/spzs/whiteWine/showHtmlGoods";
				else if(ModuleSPZS.HOME_TEXTILES.equals(moduleType))
					url = "/merchant/spzs/homeTextiles/showHtmlGoods";
				else if(ModuleSPZS.ARTWORK.equals(moduleType))
					url = "/merchant/spzs/artwork/showHtmlGoods";
				else if(ModuleSPZS.PRODUCT_EXPLAIN.equals(moduleType))
					url = "/merchant/spzs/productExplain/showHtmlGoods";
				break;
			case "dmtzl":
				HtmlGoodsDMTZL htmlGoodsDMTZL = publicService.getHtmlGoodsDMTZL(goodsNumber,accountId);
				request.setAttribute("htmlGoodsDMTZL", htmlGoodsDMTZL);
				url = "/merchant/dmtzl/showHtmlGoods";
				break;
			case "jzsg":
				HtmlGoodsJZSG htmlGoodsJZSG = publicService.getHtmlGoodsJZSG(request.getParameter("userNumber"),accountId);
				request.setAttribute("htmlGoodsJZSG", htmlGoodsJZSG);
				url = "/merchant/jzsg/showHtmlGoods";
				break;
			case "text":
				uuid = request.getParameter("uuid");
				String textType = request.getParameter("textType");
				HtmlGoodsText htmlGoodsText=publicService.getHtmlGoodsText(textType,uuid,accountId);
				request.setAttribute("htmlGoodsText", htmlGoodsText);
				if((HtmlGoodsText.TEXT+"").equals(textType))
					url = "/merchant/text/showTextHtml";
				break;
			case "jfdhjp":
				//http://localhost:8088/GoodsPublic/merchant/main/goShowHtmlGoods?trade=jfdhjp&uuid=134654686&accountId=34
				String code = request.getParameter("code");
				System.out.println("code======"+code);
				HttpSession session = request.getSession();
				Object openIdObj = session.getAttribute("openId");
				//Object openIdObj = "oNFEuwzkbP4OTTjBucFgBTWE5Bqg";
				String openId = null;
				if(openIdObj==null&&StringUtils.isEmpty(code)) {
					uuid = request.getParameter("uuid").toString();
					url="redirect:https://open.weixin.qq.com/connect/oauth2/authorize?appid="+com.goodsPublic.util.StringUtils.APP_ID+"&redirect_uri=http://www.qrcodesy.com/getCode.asp?params=showGoods,"+accountId+","+uuid+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
				}
				else if(openIdObj!=null&&StringUtils.isEmpty(code)) {
					openId = openIdObj.toString();
					System.out.println("openId======"+openId);
					url=initJFDHJPObj(openId,accountId,request);
				}
				else
				{
					JSONObject obj = JSONObject.fromObject(MethodUtil.httpRequest("https://api.weixin.qq.com/sns/oauth2/access_token?appid="+com.goodsPublic.util.StringUtils.APP_ID+"&secret="+com.goodsPublic.util.StringUtils.APP_SECRET+"&code="+code+"&grant_type=authorization_code"));
					openId = obj.getString("openid");
					session.setAttribute("openId", openId);
					System.out.println("openId======"+openId);
					url=initJFDHJPObj(openId,accountId,request);
				}
				
				break;
			}
		}
		else {
			String message = jsonMap.get("message").toString();
			request.setAttribute("message", message);
			url = "/merchant/unPaid";
		}
		return url;
	}
	
	public String initJFDHJPObj(String openId, String accountId, HttpServletRequest request) {

		boolean bool=publicService.checkJCOpenIdExist(openId);
		if(!bool) {
			Map<String, String> userMap = queryUserFromApi(openId,com.goodsPublic.util.StringUtils.APP_ID,com.goodsPublic.util.StringUtils.APP_SECRET);
			
			JFDHJPCustomer jc=new JFDHJPCustomer();
			jc.setOpenId(openId);
			jc.setNickName(userMap.get("nickname"));
			//jc.setHeadImgUrl(userMap.get("headimgurl"));
			
			publicService.addJFDHJPCustomer(jc);
		}
		JFDHJPCustomer jc = publicService.getJCByOpenId(openId);
		request.setAttribute("jc", jc);
		
		String uuid = request.getParameter("uuid");
		ScoreQrcode scoreQrcode = publicService.getScoreQrcode(uuid,accountId);
		request.setAttribute("scoreQrcode", scoreQrcode);
		
		JFDHJPActivity jfdhjpActivity = publicService.getJAByAccountId(accountId);
		request.setAttribute("jfdhjpActivity", jfdhjpActivity);
		
		AccountMsg accountMsg = publicService.getAccountById(accountId);
		request.setAttribute("accountMsg", accountMsg);
		return "/merchant/jfdhjp/showHtmlGoods.jsp?openId="+openId+"&sqUuid="+uuid+"&";
	}

	@RequestMapping(value="/addCreatePayCodeRecord")
	@ResponseBody
	public String addCreatePayCodeRecord(CreatePayCodeRecord cpcr) {
		
		/*
		cpcr.setOutTradeNo(outTradeNo);
		AccountMsg user = (AccountMsg)request.getSession().getAttribute("user");
		cpcr.setAccountNumber(user.getUserName());
		cpcr.setPhone(user.getPhone());
		//cpcr.setVipType(Integer.valueOf(request.getParameter("vipType")));
		cpcr.setPayType(2);
		cpcr.setMoney(Float.valueOf(total_fee));
		cpcr.setCodeUrl(codeUrl);
		*/
		int count=publicService.addCreatePayCodeRecord(cpcr);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(1);
			plan.setMsg("添加失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(0);
			plan.setMsg("添加成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
	
	@RequestMapping(value="/kaiTongByWX")
	public void kaiTongByWX(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			// 支付结果通用通知文档:https://pay.weixin.qq.com/wiki/doc/api/native.php?chapter=9_7&index=8
			String xmlMsg = HttpKit.readData(request);
			System.out.println("收到微信支付回调通知===" + xmlMsg);
			Map<String, String> params = PaymentKit.xmlToMap(xmlMsg);
			 String appid = params.get("appid");
			 //商户号
			 String mch_id = params.get("mch_id");
			String result_code = params.get("result_code");
			 String openId = params.get("openid");
			 //交易类型
			 String trade_type = params.get("trade_type");
			 //付款银行
			 String bank_type = params.get("bank_type");
			 // 总金额
			String money = params.get("total_fee");
			 //现金支付金额
			 String cash_fee = params.get("cash_fee");
			 // 微信支付订单号
			String transactionId = params.get("transaction_id");
			// // 商户订单号
			String outTradeNo = params.get("out_trade_no");
			// // 支付完成时间，格式为yyyyMMddHHmmss
			// String time_end = params.get("time_end");
			///////////////////////////// 以下是附加参数///////////////////////////////////
			String type = params.get("attach");
			 String fee_type = params.get("fee_type");
			 String is_subscribe = params.get("is_subscribe");
			 String err_code = params.get("err_code");
			 String err_code_des = params.get("err_code_des");
			if (PaymentKit.verifyNotify(params, WxPayApiConfigKit.getWxPayApiConfig().getPaternerKey())) {
				System.out.println("result_code==="+result_code);
				if (("SUCCESS").equals(result_code)) {
					//自行实现
					System.out.println("SUCCESS...自行实现......");
					
					CreatePayCodeRecord cpcr=publicService.getCreatePayCodeRecordByOutTradeNo(outTradeNo);
					AccountPayRecord apr = new AccountPayRecord();
					apr.setOutTradeNo(outTradeNo);
					apr.setAccountNumber(cpcr.getAccountNumber());
					Date date = new Date();
					apr.setPayTime(timeSDF.format(date));
					Calendar calendar=Calendar.getInstance();
					calendar.setTime(date);
					int vipType = cpcr.getVipType();
					switch (vipType) {
						case CreatePayCodeRecord.ONE_MONTH:
						case CreatePayCodeRecord.CONTINUE_MONTH:
							calendar.add(Calendar.MONTH, 1);
							break;
						case CreatePayCodeRecord.THREE_MONTHS:
							calendar.add(Calendar.MONTH, 3);
							break;
						case CreatePayCodeRecord.ONE_YEAR:
							calendar.add(Calendar.YEAR, 1);
							break;
					}
					apr.setEndTime(timeSDF.format(calendar.getTime()));
					apr.setVipType(vipType);
					apr.setPayType(cpcr.getPayType());
					apr.setMoney(cpcr.getMoney());
					apr.setPhone(cpcr.getPhone());
					
					int count=publicService.addAccountPayRecord(apr);
					System.out.println("改变的条数==="+count);
					if(count>0) {
						response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>");
					}
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/kaiTongByAlipay")
	public void kaiTongByAlipay(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			
			//获取支付宝POST过来反馈信息
			Map<String,String> params = new HashMap<String,String>();
			Map<String,String[]> requestParams = request.getParameterMap();
			for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
				String name = (String) iter.next();
				String[] values = (String[]) requestParams.get(name);
				String valueStr = "";
				for (int i = 0; i < values.length; i++) {
					valueStr = (i == values.length - 1) ? valueStr + values[i]
							: valueStr + values[i] + ",";
				}
				//乱码解决，这段代码在出现乱码时使用
				valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
				params.put(name, valueStr);
			}
			
			boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type); //调用SDK验证签名

			//——请在这里编写您的程序（以下代码仅作参考）——
			
			/* 实际验证过程建议商户务必添加以下校验：
			1、需要验证该通知数据中的out_trade_no是否为商户系统中创建的订单号，
			2、判断total_amount是否确实为该订单的实际金额（即商户订单创建时的金额），
			3、校验通知中的seller_id（或者seller_email) 是否为out_trade_no这笔单据的对应的操作方（有的时候，一个商户可能有多个seller_id/seller_email）
			4、验证app_id是否为该商户本身。
			*/
			if(signVerified) {//验证成功
				//商户订单号
				String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
			
				//支付宝交易号
				String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
			
				//交易状态
				String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
				
				if(trade_status.equals("TRADE_FINISHED")){
					//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//如果有做过处理，不执行商户的业务程序
						
					//注意：
					//退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
				}else if (trade_status.equals("TRADE_SUCCESS")){
					//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//如果有做过处理，不执行商户的业务程序
					
					//注意：
					//付款完成后，支付宝系统发送该交易状态通知
				}
				
				System.out.println("success");
				

				CreatePayCodeRecord cpcr=publicService.getCreatePayCodeRecordByOutTradeNo(out_trade_no);
				AccountPayRecord apr = new AccountPayRecord();
				apr.setOutTradeNo(out_trade_no);
				apr.setAccountNumber(cpcr.getAccountNumber());
				Date date = new Date();
				apr.setPayTime(timeSDF.format(date));
				Calendar calendar=Calendar.getInstance();
				calendar.setTime(date);
				int vipType = cpcr.getVipType();
				switch (vipType) {
					case CreatePayCodeRecord.ONE_MONTH:
					case CreatePayCodeRecord.CONTINUE_MONTH:
						calendar.add(Calendar.MONTH, 1);
						break;
					case CreatePayCodeRecord.THREE_MONTHS:
						calendar.add(Calendar.MONTH, 3);
						break;
					case CreatePayCodeRecord.ONE_YEAR:
						calendar.add(Calendar.YEAR, 1);
						break;
				}
				apr.setEndTime(timeSDF.format(calendar.getTime()));
				apr.setVipType(vipType);
				apr.setPayType(cpcr.getPayType());
				apr.setMoney(cpcr.getMoney());
				apr.setPhone(cpcr.getPhone());
				
				int count=publicService.addAccountPayRecord(apr);
				System.out.println("改变的条数==="+count);
				response.getWriter().write("success");
				
			}else {//验证失败
				System.out.println("fail");
			
				//调试用，写文本函数记录程序运行情况是否正常
				String sWord = AlipaySignature.getSignCheckContentV1(params);
				System.out.println("sWord===="+sWord);
				AlipayConfig.logResult(sWord);
				response.getWriter().write("fail");
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (AlipayApiException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 验证是否已付费
	 * @param accountNumber
	 * @return
	 */
	@RequestMapping(value="/checkIfPaid")
	@ResponseBody
	public Map<String, Object> checkIfPaid(String accountNumber, HttpServletRequest request) {

		Map<String, Object> jsonMap=null;
		try {
			if(StringUtils.isEmpty(accountNumber)) {
				AccountMsg accountMsg=(AccountMsg)request.getSession().getAttribute("user");
				accountNumber=accountMsg.getId();
			}
			jsonMap = publicService.checkIfPaid(accountNumber);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			return jsonMap;
		}
	}
	
	@RequestMapping(value="/checkPassWord")
	@ResponseBody
	public Map<String, Object> checkPassWord(String passWord, String userName) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		boolean bool=publicService.checkPassWord(passWord,userName);
		
		if(bool) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "原密码错误！");
		}
		return jsonMap;
	}
	
	/**
	 * 验证是否已登录
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/checkIfLogined")
	@ResponseBody
	public Map<String, Object> checkIfLogined(HttpSession session) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		Object userObj = session.getAttribute("user");
		
		if(userObj!=null) {
			jsonMap.put("status", "ok");
			jsonMap.put("message", "已登录");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "未登录");
		}
		return jsonMap;
	}
	
	/**
	 * 跳转至分类页面
	 * @return
	 */
	@RequestMapping(value="/goCategoryList")
	public String goCategoryList() {
		
		return "/merchant/categoryList";
	}
	
	/**
	 * 跳转至分类查询页
	 * @param session
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/queryCategoryList")
	@ResponseBody
	public Map<String, Object> queryCategoryList(HttpSession session,int page,int rows,String sort,String order) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<CategoryInfo> catList = (List<CategoryInfo>)session.getAttribute("categoryList");
		List<CategoryInfo> catList1 = new ArrayList<CategoryInfo>();
		for (int i = (page-1)*rows; i < page*rows-1; i++) {
			if(i>=catList.size())
				break;
			catList1.add(catList.get(i));
		}
		jsonMap.put("total", catList1.size());
		jsonMap.put("rows", catList1);
		return jsonMap;
	}
	
	@RequestMapping(value="/queryCustomerScoreList")
	@ResponseBody
	public Map<String, Object> queryCustomerScoreList(String searchTxt, String accountId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();

		JFDHJPActivity ja = publicService.getJAByAccountId(accountId);
		int c=publicService.updatePcLimitByAccountId(ja.getJpmLimit(),accountId);//更新已过期的奖品码
		
		//select s.uuid,date_format(max(s.createtime),'%m月%d日') createDate,date_format(s.createTime,'%H:%i:%s') createTime,j.nickName,p.codeNo,j.takeCount,j.takeScoreSum,j.score jfye,s.score takeScore,s.openId from score_qrcode s LEFT JOIN jfdhjp_customer j on s.openid=j.openid LEFT JOIN prize_code p on s.openid=p.openid where s.enable=1 and s.accountNumber=#{accountNumber} GROUP BY date_format(s.createtime,'%m月%d日'),s.openid ORDER BY s.createtime desc
		List<String> dateList=publicService.getCSDateList(searchTxt,accountId);
		List<Map<String, Object>> scoreList=publicService.queryCustomerScoreList(searchTxt,accountId);
		if(dateList.size()>0) {
			jsonMap.put("status", "ok");
			jsonMap.put("dateList", dateList);
			jsonMap.put("scoreList", scoreList);
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "暂无数据");
		}
		
		return jsonMap;
	}

	@RequestMapping(value="/queryCSDetailList")
	@ResponseBody
	public Map<String, Object> queryCSDetailList(String startTime, String endTime, String accountId, String openId) {
		
		//select s.uuid,date_format(s.createtime,'%m月%d日') createDate,date_format(s.createTime,'%H:%i:%s') createTime,j.nickName,p.codeNo,j.takeCount,j.takeScoreSum,j.score jfye,s.score takeScore from score_qrcode s LEFT JOIN jfdhjp_customer j on s.openid=j.openid LEFT JOIN prize_code p on s.openid=p.openid where s.enable=1
	    //and s.createtime>DATE_SUB(s.createtime,INTERVAL 1 MONTH) and s.accountNumber=34 and s.openId='oNFEuwzkbP4OTTjBucFgBTWE5Bqg' ORDER BY s.createtime desc
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		List<String> dateList=publicService.getCSDDateList(startTime,endTime,accountId,openId);
		List<Map<String, Object>> scoreList=publicService.queryCSDetailList(startTime,endTime,accountId,openId);
		if(dateList.size()>0) {
			jsonMap.put("status", "ok");
			jsonMap.put("dateList", dateList);
			jsonMap.put("scoreList", scoreList);
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "暂无数据");
		}
		
		return jsonMap;
	}

	/**
	 * 跳转至商品查询页面
	 * @return
	 */
	@RequestMapping(value="/goGoodsList")
	public String goGoodsList() {
		
		return "/merchant/goodsList";
	}
	
	@RequestMapping(value="/getGoodsListColumns")
	@ResponseBody
	public Map<String, Object> getGoodsListColumns(HttpServletRequest request, String accountId){

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		List<GoodsLabelSet> glsList=publicService.getGoodsLabelSetByModuleAccountId("goodsList",accountId);
		jsonMap.put("glsList", glsList);
		return jsonMap;
	}
	
	/**
	 * 查询商品信息
	 * @param accountId
	 * @param categoryId
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/queryGoodsList")
	@ResponseBody
	public Map<String, Object> queryGoodsList(String accountId,String categoryId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count = publicService.queryGoodsForInt(accountId, categoryId);
		List<Goods> goodsList = publicService.queryGoodsList(accountId, categoryId, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", goodsList);
		return jsonMap;
	}
	
	@RequestMapping(value="/queryScoreQrcodeList")
	@ResponseBody
	public Map<String, Object> queryScoreQrcodeList(String accountId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count = publicService.queryScoreQrcodeForInt(accountId);
		sort="createTime";
		order="desc";
		List<ScoreQrcode> scList = publicService.queryScoreQrcodeList(accountId, page, rows, sort, order);
		JFDHJPActivity ja = publicService.getJAByAccountId(accountId);
		jsonMap.put("jpmdhReg", ja.getJpmdhReg());
		jsonMap.put("total", count);
		jsonMap.put("rows", scList);
		return jsonMap;
	}
	
	/**
	 * 根据商户编号，查询商品展示模板内容
	 * @param accountId
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/queryHtmlGoodsSPZSList")
	@ResponseBody
	public Map<String, Object> queryHtmlGoodsSPZSList(String accountId,String moduleType,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count = publicService.queryHtmlGoodsSPZSForInt(accountId,moduleType);
		List<HtmlGoodsSPZS> htmlGoodsList = publicService.queryHtmlGoodsSPZSList(accountId,moduleType, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", htmlGoodsList);
		return jsonMap;
	}
	
	/**
	 * 根据商户编号，查询多媒体资料模板内容
	 * @param accountId
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/queryHtmlGoodsDMTZLList")
	@ResponseBody
	public Map<String, Object> queryHtmlGoodsDMTZLList(String accountId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count = publicService.queryHtmlGoodsDMTZLForInt(accountId);
		List<HtmlGoodsDMTZL> htmlGoodsList = publicService.queryHtmlGoodsDMTZLList(accountId, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", htmlGoodsList);
		return jsonMap;
	}
	
	/**
	 * 根据商户编号，查询建筑施工模板内容信息
	 * @param accountId
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/queryHtmlGoodsJZSGList")
	@ResponseBody
	public Map<String, Object> queryHtmlGoodsJZSGList(String accountId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count = publicService.queryHtmlGoodsJZSGForInt(accountId);
		List<HtmlGoodsJZSG> htmlGoodsList = publicService.queryHtmlGoodsJZSGList(accountId, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", htmlGoodsList);
		return jsonMap;
	}
	
	@RequestMapping(value="/queryHtmlGoodsHDQDList")
	@ResponseBody
	public Map<String, Object> queryHtmlGoodsHDQDList(String accountId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count = publicService.queryHtmlGoodsHDQDForInt(accountId);
		List<HtmlGoodsHDQD> htmlGoodsList = publicService.queryHtmlGoodsHDQDList(accountId, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", htmlGoodsList);
		return jsonMap;
	}
	
	/**
	 * 跳转至编辑商品页面
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/goEditGoods")
	public String goEditGoods(HttpServletRequest request, String id , String categoryId, String accountId) {
		List<GoodsLabelSet> glsList=publicService.getGoodsLabelSetByModuleAccountId("editGoods",accountId);
		/*
		Field[] goodsAttrField = goodsLabelSet.get(0).getClass().getDeclaredFields();
		for(Field field : goodsAttrField) {
			String name = field.getName();
			System.out.println("Name==="+name);
			String type = field.getGenericType().toString();//获取属性类型
		    if (type.equals("class java.lang.String")) {
		        try {
		            Method m = goodsLabelSet.get(0).getClass().getMethod("get" + name.substring(0, 1).toUpperCase() + name.substring(1));
		            String value = (String) m.invoke(goodsLabelSet.get(0));
		            if (null != value) {
		    			System.out.println("value==="+value);
		    			htmlContent = htmlContent.replaceAll("goodsAttrSet."+name, value);
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }
		}
		
		Goods goods=publicService.getGoodsById(id);
		Field[] goodsField = goods.getClass().getDeclaredFields();
		for(Field field : goodsField) {
			String name = field.getName();
			String type = field.getGenericType().toString();
			if (type.equals("class java.lang.String")) {
				try {
					Method m = goods.getClass().getMethod("get" + name.substring(0, 1).toUpperCase() + name.substring(1));
		            String value = (String) m.invoke(goods);
		            if (null != value) {
		            	if("htmlContent".equals(name))
		            		value=htmlspecialchars(value);
		    			htmlContent = htmlContent.replaceAll("goods."+name, value);
		            }
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (type.equals("int")) {
				try {
					Method m = goods.getClass().getMethod("get" + name.substring(0, 1).toUpperCase() + name.substring(1));
					Integer value = (Integer)m.invoke(goods);
					if (null != value) {
						htmlContent = htmlContent.replaceAll("goods."+name, String.valueOf(value));
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		htmlContent = htmlContent.replaceAll("sessionScope.user.id", accountId).replaceAll("param.categoryId", categoryId);
		System.out.println("htmlContent==="+htmlContent);
		*/
		request.setAttribute("glsList", glsList);
		Goods goods=publicService.getGoodsById(id);
		request.setAttribute("goods", goods);
		return "/merchant/editGoods";
	}
	
	/**
	 * 跳转至商户信息页面
	 * @param request
	 * @param accountId
	 * @return
	 */
	@RequestMapping(value="/goAccountInfo")
	public String goAccountInfo(HttpServletRequest request) {
		AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();

		String accountId = msg.getId();
		String path = "D:/resource";
		if(StringUtils.isEmpty(msg.getBwxQrcode())) {//初始化微信绑定码
			String url = com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/phone/goBindWX?accountId="+accountId;
			String fileName = "bwx"+accountId + ".jpg";
			String avaPath="/GoodsPublic/upload/"+fileName;
	        Qrcode.createQrCode(url, path, fileName);
	        msg.setBwxQrcode(avaPath);
	        publicService.updateWXQrcodeByAccountId(AccountMsg.BWX,avaPath,msg.getId());
		}
		if(StringUtils.isEmpty(msg.getRbwxQrcode())) {//初始化微信解绑码
			String url = com.goodsPublic.util.StringUtils.REALM_NAME+"GoodsPublic/merchant/phone/goRemoveBind?accountId="+accountId;
			String fileName = "rbwx"+accountId + ".jpg";
			String avaPath="/GoodsPublic/upload/"+fileName;
	        Qrcode.createQrCode(url, path, fileName);
	        msg.setRbwxQrcode(avaPath);
	        publicService.updateWXQrcodeByAccountId(AccountMsg.RBWX,avaPath,msg.getId());
		}
		request.setAttribute("accountMsg", msg);
		return "/merchant/accountInfo";
	}
	
	/**
	 * 跳转至标签查询页面
	 * @return
	 */
	@RequestMapping(value="/goGoodsLabelSetList")
	public String goGoodsLabelSetList() {

		return "/merchant/goodsLabelSetList";
	}
	
	@RequestMapping(value="/goFeePrice")
	public String goFeePrice() {
		
		return "/merchant/fee/price";
	}
	
	@RequestMapping(value="/goFeeBuy")
	public String goFeeBuy() {
		
		return "/merchant/fee/buy";
	}
	
	@RequestMapping(value="/goFeeTenpay")
	public String goFeeTenpay() {
		
		return "/merchant/fee/tenpay";
	}
	
	/**
	 * 跳转至行业模板快速生成页面
	 * @return
	 */
	@RequestMapping(value="/goHtmlGoodsList")
	public String goHtmlGoodsList(String trade,HttpServletRequest request) {
		
		String url = null;
		switch (trade) {
		case "spzs":
			url="/merchant/spzs/htmlGoodsList";
			break;
		case "dmtzl":
			url="/merchant/dmtzl/htmlGoodsList";
			break;
		case "jzsg":
			url="/merchant/jzsg/htmlGoodsList";
			break;
		case "hdqd":
			url="/merchant/hdqd/htmlGoodsList";
			break;
		case "jfdhjp":
			String nav = request.getParameter("nav");
			if("hdsz".equals(nav)) {
				AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
				request.setAttribute("accountMsg", msg);
				
				JFDHJPActivity ja = publicService.getJAByAccountId(msg.getId());
				request.setAttribute("jfdhjpActivity", ja);
				url="/merchant/jfdhjp/hdsz/activity";
			}
			else if("ewmsc".equals(nav))
				url="/merchant/jfdhjp/ewmsc/htmlGoodsList";
			else if("jfgl".equals(nav)) {
				AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
				request.setAttribute("accountMsg", msg);
				
				JFDHJPActivity ja = publicService.getJAByAccountId(msg.getId());
				request.setAttribute("jpmLimit", ja.getJpmLimit());
				url="/merchant/jfdhjp/jfgl/scoreList";
			}
			break;
		}
		return url;
	}
	
	@RequestMapping(value="/goScoreQrcodeDetail")
	public String goScoreQrcodeDetail() {
		
		return "/merchant/jfdhjp/jfgl/scoreDetail";
	}
	
	@RequestMapping(value="/goBatchAddModule")
	public String goBatchAddModule(HttpServletRequest request) {

		String trade = request.getParameter("trade");
		String moduleType = request.getParameter("moduleType");
		String url=null;
		switch (trade) {
		case "spzs":
			if(ModuleSPZS.RED_WINE.equals(moduleType)) {
				List<ModuleSPZS> spxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq",moduleType);
				request.setAttribute("spxqList", spxqList);
				
				request.setAttribute("memo1", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo1",moduleType)).get(0).getValue());
				
				request.setAttribute("memo2", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo2",moduleType)).get(0).getValue());
				
				request.setAttribute("memo3", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo3",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> image1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1",moduleType);
				request.setAttribute("image1List", image1List);
				
				List<ModuleSPZS> image2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2",moduleType);
				request.setAttribute("image2List", image2List);
				
				List<ModuleSPZS> image3List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image3",moduleType);
				request.setAttribute("image3List", image3List);
				
				url="/merchant/spzs/redWine/batchAddModule";
			}
			else if(ModuleSPZS.WHITE_WINE.equals(moduleType)) {
				request.setAttribute("productName", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("productName",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> wwSpxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq",moduleType);
				request.setAttribute("spxqList", wwSpxqList);
				
				request.setAttribute("memo1", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo1",moduleType)).get(0).getValue());
				
				request.setAttribute("memo2", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo2",moduleType)).get(0).getValue());

				List<ModuleSPZS> wwImage1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1",moduleType);
				request.setAttribute("image1List", wwImage1List);
				
				List<ModuleSPZS> wwImage2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2",moduleType);
				request.setAttribute("image2List", wwImage2List);
				
				url="/merchant/spzs/whiteWine/batchAddModule";
			}
			else if(ModuleSPZS.HOME_TEXTILES.equals(moduleType)) {
				request.setAttribute("productName", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("productName",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> wwSpxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq",moduleType);
				request.setAttribute("spxqList", wwSpxqList);
				
				List<ModuleSPZS> wwImage1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1",moduleType);
				request.setAttribute("image1List", wwImage1List);
				
				List<ModuleSPZS> wwImage2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2",moduleType);
				request.setAttribute("image2List", wwImage2List);
				
				List<ModuleSPZS> wwImage3List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image3",moduleType);
				request.setAttribute("image3List", wwImage3List);
				
				List<ModuleSPZS> wwImage4List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image4",moduleType);
				request.setAttribute("image4List", wwImage4List);
				
				url="/merchant/spzs/homeTextiles/batchAddModule";
			}
			else if(ModuleSPZS.ARTWORK.equals(moduleType)) {
				request.setAttribute("productName", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("productName",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> wwSpxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq",moduleType);
				request.setAttribute("spxqList", wwSpxqList);

				request.setAttribute("memo1", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo1",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> wwImage1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1",moduleType);
				request.setAttribute("image1List", wwImage1List);
				
				List<ModuleSPZS> wwImage2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2",moduleType);
				request.setAttribute("image2List", wwImage2List);
				
				url="/merchant/spzs/artwork/batchAddModule";
			}
			else if(ModuleSPZS.PRODUCT_EXPLAIN.equals(moduleType)) {
				List<ModuleSPZS> wwSpxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq",moduleType);
				request.setAttribute("spxqList", wwSpxqList);
				
				request.setAttribute("memo1", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo1",moduleType)).get(0).getValue());
				
				request.setAttribute("memo2", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo2",moduleType)).get(0).getValue());
				
				request.setAttribute("memo3", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo3",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> wwImage1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1",moduleType);
				request.setAttribute("image1List", wwImage1List);
				
				List<ModuleSPZS> wwImage2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2",moduleType);
				request.setAttribute("image2List", wwImage2List);

				List<ModuleSPZS> spzsEmbed1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("embed1",moduleType);
				request.setAttribute("embed1List", spzsEmbed1List);
				
				url="/merchant/spzs/productExplain/batchAddModule";
			}
			break;
		case "jzsg":
			List<ModuleJZSG> ryxxList = (List<ModuleJZSG>)publicService.getModuleJZSGByType("ryxx");
			request.setAttribute("ryxxList", ryxxList);
			
			List<ModuleJZSG> jzsgImage1List = (List<ModuleJZSG>)publicService.getModuleJZSGByType("image1");
			request.setAttribute("image1List", jzsgImage1List);
			
			List<ModuleJZSG> jzsgImage2List = (List<ModuleJZSG>)publicService.getModuleJZSGByType("image2");
			request.setAttribute("image2List", jzsgImage2List);
			
			url="/merchant/jzsg/batchAddModule";
			break;
		}
		return url;
	}
	
	/**
	 * 跳转至模板添加页面
	 * @param type
	 * @return
	 */
	@RequestMapping(value="/goAddModule")
	public String goAddModule(HttpServletRequest request) {
		
		String trade = request.getParameter("trade");
		String moduleType = request.getParameter("moduleType");
		String url=null;
		switch (trade) {
		case "spzs":
			if(ModuleSPZS.RED_WINE.equals(moduleType)) {
				List<ModuleSPZS> spxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq",moduleType);
				request.setAttribute("spxqList", spxqList);
				
				request.setAttribute("memo1", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo1",moduleType)).get(0).getValue());
				
				request.setAttribute("memo2", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo2",moduleType)).get(0).getValue());
				
				request.setAttribute("memo3", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo3",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> image1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1",moduleType);
				request.setAttribute("image1List", image1List);
				
				List<ModuleSPZS> image2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2",moduleType);
				request.setAttribute("image2List", image2List);
				
				List<ModuleSPZS> image3List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image3",moduleType);
				request.setAttribute("image3List", image3List);
				
				url="/merchant/spzs/redWine/addModule";
			}
			else if(ModuleSPZS.WHITE_WINE.equals(moduleType)) {
				request.setAttribute("productName", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("productName",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> wwSpxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq",moduleType);
				request.setAttribute("spxqList", wwSpxqList);
				
				request.setAttribute("memo1", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo1",moduleType)).get(0).getValue());
				
				request.setAttribute("memo2", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo2",moduleType)).get(0).getValue());

				List<ModuleSPZS> wwImage1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1",moduleType);
				request.setAttribute("image1List", wwImage1List);
				
				List<ModuleSPZS> wwImage2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2",moduleType);
				request.setAttribute("image2List", wwImage2List);
				
				url="/merchant/spzs/whiteWine/addModule";
			}
			else if(ModuleSPZS.HOME_TEXTILES.equals(moduleType)) {
				request.setAttribute("productName", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("productName",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> wwSpxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq",moduleType);
				request.setAttribute("spxqList", wwSpxqList);
				
				List<ModuleSPZS> wwImage1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1",moduleType);
				request.setAttribute("image1List", wwImage1List);
				
				List<ModuleSPZS> wwImage2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2",moduleType);
				request.setAttribute("image2List", wwImage2List);
				
				List<ModuleSPZS> wwImage3List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image3",moduleType);
				request.setAttribute("image3List", wwImage3List);
				
				List<ModuleSPZS> wwImage4List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image4",moduleType);
				request.setAttribute("image4List", wwImage4List);
				
				url="/merchant/spzs/homeTextiles/addModule";
			}
			else if(ModuleSPZS.ARTWORK.equals(moduleType)) {
				request.setAttribute("productName", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("productName",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> wwSpxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq",moduleType);
				request.setAttribute("spxqList", wwSpxqList);

				request.setAttribute("memo1", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo1",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> wwImage1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1",moduleType);
				request.setAttribute("image1List", wwImage1List);
				
				List<ModuleSPZS> wwImage2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2",moduleType);
				request.setAttribute("image2List", wwImage2List);
				
				url="/merchant/spzs/artwork/addModule";
			}
			else if(ModuleSPZS.PRODUCT_EXPLAIN.equals(moduleType)) {
				List<ModuleSPZS> wwSpxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq",moduleType);
				request.setAttribute("spxqList", wwSpxqList);
				
				request.setAttribute("memo1", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo1",moduleType)).get(0).getValue());
				
				request.setAttribute("memo2", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo2",moduleType)).get(0).getValue());
				
				request.setAttribute("memo3", ((List<ModuleSPZS>)publicService.getModuleSPZSByType("memo3",moduleType)).get(0).getValue());
				
				List<ModuleSPZS> wwImage1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1",moduleType);
				request.setAttribute("image1List", wwImage1List);
				
				List<ModuleSPZS> wwImage2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2",moduleType);
				request.setAttribute("image2List", wwImage2List);

				List<ModuleSPZS> spzsEmbed1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("embed1",moduleType);
				request.setAttribute("embed1List", spzsEmbed1List);
				
				url="/merchant/spzs/productExplain/addModule";
			}
			break;
		case "dmtzl":

			List<ModuleDMTZL> dmtzlEmbed1List = (List<ModuleDMTZL>)publicService.getModuleDMTZLByType("embed1");
			request.setAttribute("embed1List", dmtzlEmbed1List);
			
			List<ModuleDMTZL> dmtzlImage1List = (List<ModuleDMTZL>)publicService.getModuleDMTZLByType("image1");
			request.setAttribute("image1List", dmtzlImage1List);
			
			String dmtzlMemo1 = (String)publicService.getModuleDMTZLByType("memo1");
			request.setAttribute("memo1", dmtzlMemo1);
			
			String dmtzlMemo2 = (String)publicService.getModuleDMTZLByType("memo2");
			request.setAttribute("memo2", dmtzlMemo2);
			
			url="/merchant/dmtzl/addModule";
			break;
		case "jzsg":
			List<ModuleJZSG> ryxxList = (List<ModuleJZSG>)publicService.getModuleJZSGByType("ryxx");
			request.setAttribute("ryxxList", ryxxList);
			
			List<ModuleJZSG> jzsgImage1List = (List<ModuleJZSG>)publicService.getModuleJZSGByType("image1");
			request.setAttribute("image1List", jzsgImage1List);
			
			List<ModuleJZSG> jzsgImage2List = (List<ModuleJZSG>)publicService.getModuleJZSGByType("image2");
			request.setAttribute("image2List", jzsgImage2List);
			
			url="/merchant/jzsg/addModule";
			break;
		case "hdqd":
			List<ModuleHDQD> hdapList = (List<ModuleHDQD>)publicService.getModuleHDQDByType("hdap");
			request.setAttribute("hdapList", hdapList);

			List<ModuleHDQD> hdqdImage1List = (List<ModuleHDQD>)publicService.getModuleHDQDByType("image1");
			request.setAttribute("image1List", hdqdImage1List);
			
			//String dmtzlMemo1 = (String)publicService.getModuleDMTZLByType("memo1");
			//request.setAttribute("memo1", dmtzlMemo1);
			
			url="/merchant/hdqd/addModule";
			break;
		case "jfdhjp":
			
			url="/merchant/jfdhjp/ewmsc/addModule";
			break;
		}
		return url;
	}
	
	/**
	 * 跳转至模板编辑页面
	 * @param request
	 * @param trade
	 * @param goodsNumber
	 * @return
	 */
	@RequestMapping(value="/goEditModule")
	public String goEditModule(HttpServletRequest request, String trade, String moduleType, String goodsNumber, String accountNumber, String from) {
		
        if("cq".equals(from)) {
        	accountNumber=getCQAccountNumber(request);
        }
		String url=null;
		switch (trade) {
		case "spzs":
			HtmlGoodsSPZS htmlGoodsSPZS = publicService.getHtmlGoodsSPZS(moduleType,goodsNumber,accountNumber);
			request.setAttribute("htmlGoodsSPZS", htmlGoodsSPZS);
			if(ModuleSPZS.RED_WINE.equals(moduleType))
				url="/merchant/spzs/redWine/editModule";
			else if(ModuleSPZS.WHITE_WINE.equals(moduleType))
				url="/merchant/spzs/whiteWine/editModule";
			else if(ModuleSPZS.HOME_TEXTILES.equals(moduleType))
				url="/merchant/spzs/homeTextiles/editModule";
			else if(ModuleSPZS.ARTWORK.equals(moduleType))
				url="/merchant/spzs/artwork/editModule";
			else if(ModuleSPZS.PRODUCT_EXPLAIN.equals(moduleType))
				url="/merchant/spzs/productExplain/editModule";
			break;
		case "dmtzl":
			HtmlGoodsDMTZL htmlGoodsDMTZL = publicService.getHtmlGoodsDMTZL(goodsNumber,accountNumber);
			request.setAttribute("htmlGoodsDMTZL", htmlGoodsDMTZL);
			url="/merchant/dmtzl/editModule";
			break;
		case "jzsg":
			HtmlGoodsJZSG htmlGoodsJZSG = publicService.getHtmlGoodsJZSG(request.getParameter("userNumber"),accountNumber);
			request.setAttribute("htmlGoodsJZSG", htmlGoodsJZSG);
			url="/merchant/jzsg/editModule";
			break;
		}
		return url;
	}
	
	/**
	 * 查询标签信息
	 * @param accountNumber
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/queryGoodsLabelSetList")
	@ResponseBody
	public Map<String, Object> queryGoodsLabelSetList(String accountNumber,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count = publicService.queryGoodsLabelSetForInt(accountNumber);
		List<GoodsLabelSet> glsList = publicService.queryGoodsLabelSetList(accountNumber, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", glsList);
		return jsonMap;
	}
	
	@RequestMapping(value="/goAddGoodsLabelSet")
	public String goAddGoodsLabelSet() {
		
		return "/merchant/addGoodsLabelSet";
	}
	
	/**
	 * 跳转至编辑标签页面
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/goEditGoodsLabelSet")
	public String goEditGoodsLabelSet(HttpServletRequest request, String id) {
		
		GoodsLabelSet goodsLabelSet=publicService.getGoodsLabelSetById(id);
		request.setAttribute("goodsLabelSet", goodsLabelSet);
		return "/merchant/editGoodsLabelSet";
	}
	
	/**
	 * 添加商品标签
	 * @param goodsLabelSet
	 * @return
	 */
	@RequestMapping(value="/addGoodsLabelSet")
	@ResponseBody
	public Map<String, Object> addGoodsLabelSet(GoodsLabelSet goodsLabelSet) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=publicService.addGoodsLabelSet(goodsLabelSet);
		if(count>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "添加标签成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "添加标签失败！");
		}
		return jsonMap;
	}
	
	/**
	 * 编辑商品标签
	 * @param goodsLabelSet
	 * @return
	 */
	@RequestMapping(value="/editGoodsLabelSet")
	@ResponseBody
	public Map<String, Object> editGoodsLabelSet(GoodsLabelSet goodsLabelSet) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		int count=publicService.editGoodsLabelSet(goodsLabelSet);
		if(count>0) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "编辑标签成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "编辑标签失败！");
		}
		return jsonMap;
	}
	
	@RequestMapping(value="/alipay")
	public void alipay(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			//获得初始化的AlipayClient
			AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
			
			//设置请求参数
			AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
			alipayRequest.setReturnUrl(AlipayConfig.return_url);
			alipayRequest.setNotifyUrl(AlipayConfig.notify_url);
			
			//商户订单号，商户网站订单系统中唯一订单号，必填
			String out_trade_no = orderIdSDF.format(new Date());
			//付款金额，必填
			//String total_amount = "0.01";
			String total_amount = request.getParameter("totalAmount");
			//订单名称，必填
			String subject = "aaa";
			//商品描述，可空
			String body = "";
			
			alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
					+ "\"total_amount\":\""+ total_amount +"\"," 
					+ "\"subject\":\""+ subject +"\"," 
					+ "\"body\":\""+ body +"\"," 
					+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
			
			//若想给BizContent增加其他可选请求参数，以增加自定义超时时间参数timeout_express来举例说明
			//alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
			//		+ "\"total_amount\":\""+ total_amount +"\"," 
			//		+ "\"subject\":\""+ subject +"\"," 
			//		+ "\"body\":\""+ body +"\"," 
			//		+ "\"timeout_express\":\"10m\"," 
			//		+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
			//请求参数可查阅【电脑网站支付的API文档-alipay.trade.page.pay-请求参数】章节
			

			CreatePayCodeRecord cpcr= new CreatePayCodeRecord();
			cpcr.setOutTradeNo(out_trade_no);
			cpcr.setAccountNumber(request.getParameter("accountNumber"));
			cpcr.setPhone(request.getParameter("phone"));
			cpcr.setVipType(Integer.valueOf(request.getParameter("vipType")));
			cpcr.setPayType(1);
			cpcr.setMoney(Float.valueOf(total_amount));
			
			String jsonString = addCreatePayCodeRecord(cpcr);
			PlanResult plan = JsonUtil.getObjectFromJson(jsonString,PlanResult.class);
			if(plan.getStatus()==0) {
				//请求
				String result = alipayClient.pageExecute(alipayRequest).getBody();
				//输出
				response.getWriter().println(result);
			}
		} catch (AlipayApiException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取微信用户信息
	 * @param appID 
	 * @param appSecret 
	 * @return 
	 */
	public static Map<String, String> queryUserFromApi(String openid, String appID, String appSecret){
		
		/*
		ApplicationContext ac = new ClassPathXmlApplicationContext("spring-mvc.xml");
		MPWeixinDaoImp mpWeixinDao = (MPWeixinDaoImp) ac.getBean("MPWeixinDao");
		*/
		
		/**
		 * 获取access_token值
		 */
		String access_token = "";
		System.out.println("openID==========="+openid);
		System.out.println("appID==========="+appID);
		System.out.println("appSecret==========="+appSecret);
		String tokenUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appID + "&secret=" + appSecret;
		TenpayHttpClient httpClientToken = new TenpayHttpClient();																
		httpClientToken.setMethod("GET");
		httpClientToken.setReqContent(tokenUrl);
		if (httpClientToken.call()) {
		    System.out.println("获取token成功");
			String resContent = httpClientToken.getResContent();
			System.out.println("resContent：" + resContent);
			//access_token = JsonUtil.getJsonValue(resContent, "access_token");
			access_token = new org.json.JSONObject(resContent).getString("access_token");
			System.out.println("token：" + access_token);
		}
		System.out.println("获取的token值为:" + access_token);
		
		
		/**
		 * 获取用户信息
		 */
		String nickname = "";
		String headimgurl = "";
		String userInfoUrl = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=" + access_token + "&openid=" + openid + "&lang=zh_CN";
		TenpayHttpClient httpClientUser = new TenpayHttpClient();																
		httpClientUser.setMethod("GET");
		httpClientUser.setReqContent(userInfoUrl);
        if (httpClientUser.call()) {
            System.out.println("获取用户信息成功");
            String resContent = httpClientUser.getResContent();
            System.out.println("resContent：" + resContent);
            /*
            nickname = JsonUtil.getJsonValue(resContent, "nickname");
            headimgurl = JsonUtil.getJsonValue(resContent, "headimgurl");
            */
            org.json.JSONObject rsJO = new org.json.JSONObject(resContent);
            nickname = rsJO.getString("nickname");
            headimgurl = rsJO.getString("headimgurl");
        }
        Map<String, String> jsonMap = new HashMap<String, String>();
        jsonMap.put("openid", openid);
        jsonMap.put("nickname", nickname);
        jsonMap.put("headimgurl", headimgurl);
        return jsonMap;
	}
}
