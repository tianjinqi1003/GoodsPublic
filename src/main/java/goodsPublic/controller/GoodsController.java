package goodsPublic.controller;



import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodsPublic.util.JsonUtil;
import com.goodsPublic.util.PlanResult;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.service.CategoryService;
import goodsPublic.service.UserService;
import goodsPublic.service.UtilService;

@Controller
@RequestMapping("/merchant")
public class GoodsController {
	@Autowired
	private UtilService utilService;
	@Autowired
	private UserService userService;
	@Autowired
	private CategoryService categoryService;

	//登录接口
		@RequestMapping(value="/login",method=RequestMethod.GET)
		public String login() {
			return "/merchant/login";
		}
		
	//登录接口
	@RequestMapping(value="/login",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String login(Model model,String userName,String password,
			String rememberMe,String role,String loginVCode,HttpServletRequest request) {
		System.out.println("===登录接口===");
		//返回值的json
		PlanResult plan=new PlanResult();
		//用来储存用户的用户信息
		AccountMsg user=new AccountMsg();
		user.setUserName(userName);
		user.setPassWord(password);
		//获得session
		HttpSession session = request.getSession();
		//获得session当中已经储存好的验证码
		String verifyCode = (String) session.getAttribute("验证码");
		//检查用户信息是否正确
		AccountMsg resultUser =userService.checkUser(user);
		if(resultUser!=null) {
			//检测输入的验证码以及储存的验证码
			if(verifyCode.equals(loginVCode)) {
				System.out.println("账号通过");
				model.addAttribute("user",resultUser);
				session.setAttribute("user",resultUser);
				
				plan.setStatus(0);
				plan.setMsg("验证通过");
				plan.setUrl("/merchant/main/index");
				return JsonUtil.getJsonFromObject(plan);
			}
			plan.setStatus(1);
			plan.setMsg("验证码错误");
			return JsonUtil.getJsonFromObject(plan);
		}
		plan.setStatus(0);
		plan.setMsg("用户不存在");
		return JsonUtil.getJsonFromObject(plan);
	}
	
	//为登录页面获取验证码
	@RequestMapping("/login/captcha")
	public void getKaptchaImageByMerchant(HttpSession session, String identity, HttpServletResponse response) {
		utilService.getKaptchaImageByMerchant(session, identity, response);
	}

	//注册页面
	@RequestMapping(value = "/regist" , method = RequestMethod.GET)
	public String regist() {
		System.out.println("===注册页面===");
		return "/merchant/regist";
	}

	//注册信息处理接口
	@RequestMapping(value = "/regist" , method = RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String subRegist(AccountMsg msg) {
		System.out.println("===注册信息处理接口===");
		System.out.println(msg);
		PlanResult plan=new PlanResult();
		int status=userService.saveUser(msg);
		if(status==2) {
			plan.setStatus(status);
			plan.setMsg("注册失败，用户已存在");
			return JsonUtil.getJsonFromObject(plan);
		}else if(status==0) {
			plan.setStatus(status);
			plan.setMsg("系统错误，请联系维护人员");
			return JsonUtil.getJsonFromObject(plan);
		}
		plan.setStatus(0);
		plan.setMsg("注册成功");
		plan.setData(msg);
		plan.setUrl("/merchant/login");
		return JsonUtil.getJsonFromObject(plan);
	}
}
