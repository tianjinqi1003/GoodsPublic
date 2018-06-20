package goodsPublic.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import goodsPublic.entity.ShopArticleInfo;
import goodsPublic.service.CategoryService;
import goodsPublic.service.PublicService;
import goodsPublic.service.UserService;

@Controller
@RequestMapping("/merchant/main")
public class MainController {

	@Autowired
	private UserService userService;
	@Autowired
	private PublicService publicService;
	
	@Autowired
	private CategoryService categoryService;
	
	//主页接口
	@RequestMapping("/index")
	public String toIndex(HttpServletRequest request) {
		return "/merchant/index";
	}
	//商品发布页面接口
	@RequestMapping("/operation")
	public String SayHellow(Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		AccountMsg user=(AccountMsg) session.getAttribute("user");
		System.out.println(user);
		System.out.println("=======操作页面======");
		return "/merchant/operation";
	}

	//图片图片上传接口
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

	//富文本框接口
	@RequestMapping(value="/addGoodsPublic",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addGoodsPublic(ShopArticleInfo articleInfo,HttpServletRequest request) {
		int a=publicService.getGoodsByGoodsNumber(articleInfo.getGoodsNumber());
		PlanResult plan=new PlanResult();
		String json;
		if(a==1) {
			plan.setStatus(1);
			plan.setMsg("商品编码重复");
			json=JsonUtil.getJsonFromObject(plan);
			return json;
		}
		publicService.publicGoods(articleInfo, request);
		//return  "{'code': 1,'msg': 'success'}";
		plan.setStatus(0);
		plan.setMsg("商品发布成功");
		plan.setUrl("/merchant/main/show");
		plan.setData(articleInfo.getGoodsNumber());
		json=JsonUtil.getJsonFromObject(plan);
		return json;
	}


	//主操作页面接口
	@RequestMapping(value="/show",method=RequestMethod.GET)
	public String Show(String goodsNumber,HttpServletRequest request) {
		System.out.println(goodsNumber);
		PlanResult plan=publicService.getGoodsByGN(goodsNumber);
		request.setAttribute("plan", plan.getData());
		//TODO
		//检查数据是否传过来
		return "/merchant/show";
	}
	//获得店铺名下的所有分类
	@RequestMapping(value="/getCategory",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String getCategory(HttpServletRequest request) {
		HttpSession session=request.getSession();
		AccountMsg user=(AccountMsg) session.getAttribute("user");
		AccountMsg SqlUser=userService.getUserLogin(user);
		System.out.println("这是用来查询分类的用户："+SqlUser);
		//TODO  制作分类反馈信息
		return "查出来了";
	}
	//创建分类
	@RequestMapping(value="/addCategory",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String addCategory(CategoryInfo categoryInfo) {
		//categoryService.addCategory(categoryInfo);
		
		return "merchant/creatCategory";
	}
}
