package goodsPublic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodsPublic.util.JsonUtil;
import com.goodsPublic.util.PlanResult;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.AirBottle;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.Goods;
import goodsPublic.entity.PreviewCRSPDF;
import goodsPublic.entity.PreviewCRSPDFSet;
import goodsPublic.service.CreateLabelService;
import goodsPublic.service.UserService;

@Controller
@RequestMapping("/createLabel")
public class CreateLabelController {
	
	@Autowired
	private CreateLabelService createLabelService;
	@Autowired
	private UserService userService;
	
	/**
	 * 跳转至登录页面
	 * @return
	 */
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public String login() {
		return "/createLabel/login";
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String login(String userName,String password,String loginVCode,HttpServletRequest request) {
		System.out.println("===登录接口===");
		//返回值的json
		PlanResult plan=new PlanResult();
		HttpSession session=request.getSession();
		String verifyCode = (String) session.getAttribute("验证码");
		System.out.println("verifyCode==="+verifyCode);
		System.out.println("loginVCode==="+loginVCode);
		if(verifyCode.equals(loginVCode)) {
			//TODO在这附近添加登录储存信息步骤，将用户的账号以及密码储存到shiro框架的管理配置当中方便后续查询
			try {
				System.out.println("验证码一致");
				UsernamePasswordToken token = new UsernamePasswordToken(userName,password);  
				Subject currentUser = SecurityUtils.getSubject();  
				if (!currentUser.isAuthenticated()){
					//使用shiro来验证  
					token.setRememberMe(true);  
					currentUser.login(token);//验证角色和权限  
				}
			}catch (Exception e) {
				e.printStackTrace();
				plan.setStatus(1);
				plan.setMsg("登陆失败");
				return JsonUtil.getJsonFromObject(plan);
			}
			AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
			session.setAttribute("user", msg);
			
			plan.setStatus(0);
			plan.setMsg("验证通过");
			plan.setUrl("/createLabel/toAirBottleList");
			return JsonUtil.getJsonFromObject(plan);
		}
		plan.setStatus(1);
		plan.setMsg("验证码错误");
		return JsonUtil.getJsonFromObject(plan);
	}

	//注册页面
	@RequestMapping(value = "/regist" , method = RequestMethod.GET)
	public String regist() {
		System.out.println("===注册页面===");
		return "/createLabel/regist";
	}
	
	//注册信息处理接口
	@RequestMapping(value = "/regist" , method = RequestMethod.POST,produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String subRegist(AccountMsg msg, HttpServletRequest request) {
		
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
		plan.setUrl("/createLabel/toAirBottleList");
		
		AccountMsg resultUser=userService.checkUser(msg);
		List<PreviewCRSPDF> pCrsPdflist=createLabelService.selectPreviewCRSPDF();
		PreviewCRSPDFSet pCrsPdfSet=null;
		for (PreviewCRSPDF pCrsPdf : pCrsPdflist) {
			pCrsPdfSet=new PreviewCRSPDFSet();
			pCrsPdfSet.setCpxh_left(pCrsPdf.getCpxh_left());
			pCrsPdfSet.setCpxh_top(pCrsPdf.getCpxh_top());
			pCrsPdfSet.setQpbh_left(pCrsPdf.getQpbh_left());
			pCrsPdfSet.setQpbh_top(pCrsPdf.getQpbh_top());
			pCrsPdfSet.setGcrj_left(pCrsPdf.getGcrj_left());
			pCrsPdfSet.setGcrj_top(pCrsPdf.getGcrj_top());
			pCrsPdfSet.setNdbh_left(pCrsPdf.getNdbh_left());
			pCrsPdfSet.setNdbh_top(pCrsPdf.getNdbh_top());
			pCrsPdfSet.setZzrq_left(pCrsPdf.getZzrq_left());
			pCrsPdfSet.setZzrq_top(pCrsPdf.getZzrq_top());
			pCrsPdfSet.setQrcode_left(pCrsPdf.getQrcode_left());
			pCrsPdfSet.setQrcode_top(pCrsPdf.getQrcode_top());
			pCrsPdfSet.setLabel_type(pCrsPdf.getLabel_type());
			pCrsPdfSet.setAccountNumber(resultUser.getId());
			
			int count=createLabelService.insertPreviewCRSPDFSet(pCrsPdfSet);
		}
		
		return JsonUtil.getJsonFromObject(plan);
	}
	
	@RequestMapping("/toAirBottleList")
	public String toAirBottleList() {
		
		return "/createLabel/airBottleList";
	}
	
	@RequestMapping("/toCreateBatch")
	public String toCreateBatch() {
		
		return "/createLabel/createBatch";
	}
	
	@RequestMapping(value="/selectCRSPdfSet")
	@ResponseBody
	public Map<String, Object> selectCRSPdfSet(Integer labelType, String accountNumber) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		PreviewCRSPDFSet crsPdfSet=createLabelService.selectCRSPdfSet(labelType,accountNumber);
		
		jsonMap.put("crsPdfSet", crsPdfSet);
		
		return jsonMap;
	}

	@RequestMapping(value="/insertAirBottleRecord")
	@ResponseBody
	public Map<String, Object> insertAirBottleRecord(AirBottle airBottle, String qpbhsStr) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		String[] qpbhArr = qpbhsStr.split(",");
		
		int count = 0;
		for (int i = 0; i < qpbhArr.length; i++) {
			airBottle.setQpbh(qpbhArr[i]);
			count += createLabelService.insertAirBottleRecord(airBottle);
		}
		
		if(count==qpbhArr.length) {
			jsonMap.put("message", "ok");
			jsonMap.put("info", "生成历史记录成功！");
		}
		else {
			jsonMap.put("message", "no");
			jsonMap.put("info", "生成历史记录失败！");
		}
		
		return jsonMap;
	}
	
	@RequestMapping(value="/queryAirBottleList")
	@ResponseBody
	public Map<String, Object> queryAirBottleList(String qpbh,int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count = createLabelService.queryAirBottleForInt(qpbh);
		List<AirBottle> abList = createLabelService.queryAirBottleList(qpbh, page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", abList);
		return jsonMap;
	}

}
