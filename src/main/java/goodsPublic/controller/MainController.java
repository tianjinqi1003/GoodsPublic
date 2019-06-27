package goodsPublic.controller;


import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.goodsPublic.util.FileUploadUtils;
import com.goodsPublic.util.FinalState;
import com.goodsPublic.util.JsonUtil;
import com.goodsPublic.util.PlanResult;
import com.goodsPublic.util.qrcode.Qrcode;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.Goods;
import goodsPublic.entity.GoodsLabelSet;
import goodsPublic.entity.HtmlGoodsSPZS;
import goodsPublic.entity.HtmlTemplate;
import goodsPublic.entity.ModuleSPZS;
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
	public String addGoodsPublic(Goods goods,HttpServletRequest request,@RequestParam(value="file")  MultipartFile file) {
		try {
			//TODO对商品发布增加权限检测
			  Subject subject = SecurityUtils.getSubject();
			  AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
				 if(subject.hasRole(FinalState.UserLevel1)){
					 System.out.println("初级会员");
					 int count=publicService.getGoodsListByMsg();
					 System.out.println(count);
					 if(file.getSize()>0) {
							String jsonStr = FileUploadUtils.appUploadContentImg(request,file,"");
							JSONObject fileJson = JSONObject.fromObject(jsonStr);
							if("成功".equals(fileJson.get("msg"))) {
								JSONObject dataJO = (JSONObject)fileJson.get("data");
								goods.setImgUrl(dataJO.get("src").toString());
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
			        }else if(subject.hasRole(FinalState.UserLevel2)){
			           // 无权限
			        	System.out.println("中级会员");
			        }else if(subject.hasRole(FinalState.UserLevel2)) {
			        	System.out.println("高级会员");
			        }else {
			        	System.out.println("临时用户");
			        }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "../../merchant/main/operation?";
	}
	
	@RequestMapping(value="/addHtmlGoodsSPZS",produces="plain/text; charset=UTF-8")
	public String addHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS,
			@RequestParam(value="file2_1",required=false) MultipartFile file2_1,
			@RequestParam(value="file2_2",required=false) MultipartFile file2_2,
			@RequestParam(value="file2_3",required=false) MultipartFile file2_3,
			@RequestParam(value="file2_4",required=false) MultipartFile file2_4,
			@RequestParam(value="file2_5",required=false) MultipartFile file2_5,
			HttpServletRequest request) {
		
		System.out.println("111111111111111"+file2_1);
		System.out.println("111111111111111"+file2_2);
		System.out.println("111111111111111"+file2_3);
		System.out.println("111111111111111"+file2_4);
		System.out.println("111111111111111"+file2_5);
		try {
			MultipartFile[] file2Arr=new MultipartFile[5];
			file2Arr[0]=file2_1;
			file2Arr[1]=file2_2;
			file2Arr[2]=file2_3;
			file2Arr[3]=file2_4;
			file2Arr[4]=file2_5;
			for (int i = 0; i < file2Arr.length; i++) {
				String jsonStr = null;
				if(file2Arr[i]!=null&&file2Arr[i].getSize()>0) {
					jsonStr = FileUploadUtils.appUploadContentImg(request,file2Arr[i],"");
					JSONObject fileJson = JSONObject.fromObject(jsonStr);
					if("成功".equals(fileJson.get("msg"))) {
						JSONObject dataJO = (JSONObject)fileJson.get("data");
						switch (i) {
						case 0:
							htmlGoodsSPZS.setImage2_1(dataJO.get("src").toString());
							break;
						case 1:
							htmlGoodsSPZS.setImage2_2(dataJO.get("src").toString());
							break;
						case 2:
							htmlGoodsSPZS.setImage2_3(dataJO.get("src").toString());
							break;
						case 3:
							htmlGoodsSPZS.setImage2_4(dataJO.get("src").toString());
							break;
						case 4:
							htmlGoodsSPZS.setImage2_5(dataJO.get("src").toString());
							break;
						}
					}
				}
			}
		
			/*
			String goodsNumber = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			htmlGoodsSPZS.setGoodsNumber(goodsNumber);
			
			String addr = request.getLocalAddr();
			int port = request.getLocalPort();
			String contextPath = request.getContextPath();
			String url = "http://"+addr+":"+port+contextPath+"/merchant/main/goShowHtmlGoodsSPZS?goodsNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountId="+htmlGoodsSPZS.getAccountNumber();
			//String url = "http://www.bainuojiaoche.com:8080/GoodsPublic/merchant/main/goShowHtmlGoodsSPZS?goodsNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountId="+htmlGoodsSPZS.getAccountNumber();
			
			String fileName = goodsNumber + ".jpg";
			String avaPath="/GoodsPublic/upload/"+fileName;
			String path = "D:/resource";
	        Qrcode.createQrCode(url, path, fileName);
			
	        htmlGoodsSPZS.setQrCode(avaPath);
			int a=publicService.addHtmlGoodsSPZS(htmlGoodsSPZS);
			*/
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "../../merchant/main/goBrowseHtmlGoodsSPZS?goodsNumber="+htmlGoodsSPZS.getGoodsNumber()+"&accountNumber="+htmlGoodsSPZS.getAccountNumber();
	}
	
	/**
	 * 这个是显示商品的模板内容，用于后台商户浏览
	 * @param goodsNumber
	 * @param accountNumber
	 * @param request
	 * @return
	 */
	@RequestMapping("/goBrowseHtmlGoodsSPZS")
	public String goBrowseHtmlGoods(String goodsNumber, String accountNumber, HttpServletRequest request) {
		HtmlGoodsSPZS htmlGoodsSPZS = publicService.getHtmlGoods(goodsNumber,accountNumber);
		request.setAttribute("htmlGoodsSPZS", htmlGoodsSPZS);
		return "/merchant/spzs/browseHtmlGoods";
	}
	
	/**
	 * 验证商品编号
	 * @param goodsNumber
	 * @return
	 */
	@RequestMapping(value="/checkGoodsNumber",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String checkGoodsNumber(String goodsNumber) {
		int count=publicService.getGoodsByGoodsNumber(goodsNumber);
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
	public String createShowUrlQrcode(String url, String goodsNumber,HttpServletRequest request) {
		publicService.createShowUrlQrcode(url,goodsNumber);
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
	public String editAccountInfo(AccountMsg accountMsg,HttpServletRequest request,@RequestParam(value="file")  MultipartFile file) {
		try {
			if(file.getSize()>0) {
				String jsonStr = FileUploadUtils.appUploadContentImg(request,file,"");
				JSONObject fileJson = JSONObject.fromObject(jsonStr);
				if("成功".equals(fileJson.get("msg"))) {
					JSONObject dataJO = (JSONObject)fileJson.get("data");
					accountMsg.setAvatar_img(dataJO.get("src").toString());
				}
			}
			AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
			accountMsg.setId(msg.getId());
			int a=publicService.editAccountInfo(accountMsg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/merchant/accountInfo";
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

	/**
	 * 跳转至商品展示页
	 * @param goodsNumber
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/show",method=RequestMethod.GET)
	public String Show(String goodsNumber,String accountId,HttpServletRequest request) {
		System.out.println(goodsNumber);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss");
		request.setAttribute("searchTime", sdf.format(date));

		List<GoodsLabelSet> glsList=publicService.getGoodsLabelSetByModuleAccountId("editGoods",accountId);
		request.setAttribute("glsList", glsList);
		
		PlanResult plan=publicService.getGoodsByGN(goodsNumber);
		Goods goods = (Goods)plan.getData();
		request.setAttribute("plan", goods);
		
		List<Goods> goodsList = publicService.queryGoodsList(goods.getCategory_id(),accountId);
		request.setAttribute("flagGoodsList", goodsList);
		
		AccountMsg accountMsg = publicService.getAccountById(((Goods)plan.getData()).getAccountNumber());
		request.setAttribute("accountMsg", accountMsg);
		return "/merchant/show";
	}
	
	/**
	 * 这个是显示商品的模板内容，用于前端手机上显示
	 * @param goodsNumber
	 * @param accountId
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/goShowHtmlGoodsSPZS",method=RequestMethod.GET)
	public String goShowHtmlGoodsSPZS(String goodsNumber,String accountId,HttpServletRequest request) {
		
		HtmlGoodsSPZS htmlGoodsSPZS = publicService.getHtmlGoods(goodsNumber,accountId);
		request.setAttribute("htmlGoodsSPZS", htmlGoodsSPZS);
		return "/merchant/spzs/showHtmlGoods";
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
	
	@RequestMapping(value="/queryHtmlGoodsSPZSList")
	@ResponseBody
	public Map<String, Object> queryHtmlGoodsSPZSList(String accountId,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count = publicService.queryHtmlGoodsSPZSForInt(accountId);
		List<HtmlGoodsSPZS> htmlGoodsList = publicService.queryHtmlGoodsSPZSList(accountId, page, rows, sort, order);
		
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
	
	/**
	 * 跳转至商品展示模板快速生成页面
	 * @return
	 */
	@RequestMapping(value="/goHtmlGoodsSPZSList")
	public String goHtmlGoodsSPZSList() {
		
		return "/merchant/spzs/htmlGoodsList";
	}
	
	/**
	 * 跳转至模板编辑页面
	 * @param type
	 * @return
	 */
	@RequestMapping(value="/goEditModule")
	public String goEditModule(HttpServletRequest request, String trade) {
		
		String url=null;
		switch (trade) {
		case "spzs":
			List<ModuleSPZS> spxqList = (List<ModuleSPZS>)publicService.getModuleSPZSByType("spxq");
			request.setAttribute("spxqList", spxqList);
			
			String memo1 = (String)publicService.getModuleSPZSByType("memo1");
			request.setAttribute("memo1", memo1);
			
			String memo2 = (String)publicService.getModuleSPZSByType("memo2");
			request.setAttribute("memo2", memo2);
			
			String memo3 = (String)publicService.getModuleSPZSByType("memo3");
			request.setAttribute("memo3", memo3);
			
			List<ModuleSPZS> image1List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image1");
			request.setAttribute("image1List", image1List);
			
			List<ModuleSPZS> image2List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image2");
			request.setAttribute("image2List", image2List);
			
			List<ModuleSPZS> image3List = (List<ModuleSPZS>)publicService.getModuleSPZSByType("image3");
			request.setAttribute("image3List", image3List);
			
			url="/merchant/spzs/editModule";
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
	
}
