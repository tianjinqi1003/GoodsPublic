package goodsPublic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodsPublic.util.JsonUtil;
import com.goodsPublic.util.PlanResult;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.Goods;
import goodsPublic.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private UserService userService;
	
	/**
	 * 跳转至商品查询页面
	 * @return
	 */
	@RequestMapping(value="/goAccountList")
	public String goAccountList() {

		return "/admin/accountList";
	}
	
	/**
	 * 查询商户信息
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	@RequestMapping(value="/queryAccountList")
	@ResponseBody
	public Map<String, Object> queryAccountList(int page,int rows,String sort,String order) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		int count = userService.queryAccountForInt();
		List<AccountMsg> accList = userService.queryAccountList(page, rows, sort, order);
		
		jsonMap.put("total", count);
		jsonMap.put("rows", accList);
		return jsonMap;
	}
	
	/**
	 * 更新商户状态
	 * @param id
	 * @param status
	 * @return
	 */
	@RequestMapping(value="/updateAccountStatus",produces="plain/text; charset=UTF-8")
	@ResponseBody
	public String updateAccountStatus(String id, String status) {
		
		int count=userService.updateAccountStatus(id,status);
		PlanResult plan=new PlanResult();
		String json;
		if(count==0) {
			plan.setStatus(1);
			plan.setMsg("更新状态失败");
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(0);
			plan.setMsg("更新状态成功");
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}
}
