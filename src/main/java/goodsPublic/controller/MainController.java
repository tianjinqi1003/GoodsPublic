package goodsPublic.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.goodsPublic.util.FileUploadUtils;
import com.goodsPublic.util.JsonUtil;
import com.goodsPublic.util.PlanResult;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.Goods;
import goodsPublic.service.CategoryService;
import goodsPublic.service.PublicService;
import goodsPublic.service.UserService;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/merchant/main")
public class MainController {

	@Autowired
	private UserService userService;
	@Autowired
	private PublicService publicService;
	
	@Autowired
	private CategoryService categoryService;
	
//	/**
//	 * 跳转到主页
//	 * @return
//	 */
//	@RequestMapping("/index")
//	public String toIndex() {
//
//		/*
//		//填充首页店内分类模块的子模块名称
//		AccountMsg accountMsg = (AccountMsg)request.getSession().getAttribute("user");
//		List<CategoryInfo> catList = categoryService.getCategory(accountMsg.getId());
//		request.setAttribute("categoryList", catList);
//		*/
//		return "/merchant/index";
//	}
	
	/**
	 * 跳转至商品发布页面
	 * @return
	 */
	@RequestMapping("/operation")
	public String SayHellow() {
		
		/*
		HttpSession session=request.getSession();
		AccountMsg accountMsg=(AccountMsg) session.getAttribute("user");
		System.out.println(accountMsg);
		List<CategoryInfo> catList = categoryService.getCategory(accountMsg.getId());
		request.setAttribute("categoryList", catList);
		*/
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
			if(publicService.addGoodsPublic(goods)>0) {
				plan.setStatus(0);
				plan.setMsg("商品发布成功");
				plan.setUrl("/merchant/main/show");
				plan.setData(goods.getGoodsNumber());
			}
			json=JsonUtil.getJsonFromObject(plan);
			JSONObject js = JSONObject.fromObject(json);
			request.setAttribute("json", js);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "../../merchant/main/operation?";
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
			
			publicService.editAccountInfo(accountMsg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "../../merchant/main/goAccountInfo?accountId="+accountMsg.getId()+"&";
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
			
			int count=publicService.editGoods(goods);
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
	public String Show(String goodsNumber,HttpServletRequest request) {
		System.out.println(goodsNumber);
		PlanResult plan=publicService.getGoodsByGN(goodsNumber);
		request.setAttribute("plan", plan.getData());
		return "/merchant/show";
	}
	
	/**
	 * 跳转至分类页面
	 * @return
	 */
	@RequestMapping(value="/goCategoryList")
	public String goCategoryList() {
		
		/*
		HttpSession session=request.getSession();
		AccountMsg user=(AccountMsg) session.getAttribute("user");
		AccountMsg accountMsg=userService.getUserLogin(user);
		List<CategoryInfo> catList = categoryService.getCategory(accountMsg.getId());
		request.setAttribute("categoryList", catList);
		*/
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
		//List<Map<String, Object>> companyList = companyDao.queryCompanyList(input, startTime, endTime, page, rows, sort, order);
		
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
	
	/**
	 * 跳转到类别编辑页面
	 * */
	/*
	@RequestMapping(value="/goEditCategory")
	public String goEditCategory(HttpServletRequest request, String id) {
		CategoryInfo categoryInfo = categoryService.getById(id);
		request.setAttribute("categoryInfo", categoryInfo);
		return "/merchant/editCategory";
	}
	*/
	
	/**
	 * 跳转至编辑商品页面
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/goEditGoods")
	public String goEditGoods(HttpServletRequest request, String id) {
		
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
	public String goAccountInfo(HttpServletRequest request, String accountId) {
		AccountMsg accountMsg=publicService.getAccountById(accountId);
		request.setAttribute("accountMsg", accountMsg);
		return "/merchant/accountInfo";
	}
	
	/**
	//创建分类
	@RequestMapping(value="/addCategory",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addCategory(CategoryInfo categoryInfo) {
		categoryService.addCategory(categoryInfo);
		
		return null;
	}
	**/
}
