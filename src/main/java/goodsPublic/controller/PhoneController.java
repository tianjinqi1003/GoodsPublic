package goodsPublic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodsPublic.util.MethodUtil;

import goodsPublic.entity.PrizeCode;
import goodsPublic.entity.ScoreQrcode;
import goodsPublic.entity.ScoreTakeRecord;
import goodsPublic.service.PublicService;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/merchant/phone")
public class PhoneController {

	@Autowired
	private PublicService publicService;

	@RequestMapping(value="/openJPDHJFRedBagByJC")
	@ResponseBody
	public Map<String, Object> openJPDHJFRedBagByJC(ScoreQrcode sq) {
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		boolean bool = publicService.openJPDHJFRedBagByJC(sq);
		
		if(bool) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "打开红包失败！");
		}
		
		return jsonMap;
	}

	@RequestMapping(value="/createPrizeCode")
	@ResponseBody
	public Map<String, Object> createPrizeCode(PrizeCode pz, Integer dhjpScore, String openId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		pz.setCodeNo(new Random().nextInt(10000)+"");
		
		int count=publicService.addPrizeCode(pz,dhjpScore,openId);
		
		if(count>0) {
			jsonMap.put("status", "ok");
			jsonMap.put("codeNo", pz.getCodeNo());
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "生成兑奖码失败！");
		}
		
		return jsonMap;
	}
	
	@RequestMapping(value="/addScoreTakeRecord")
	@ResponseBody
	public Map<String, Object> addScoreTakeRecord(ScoreTakeRecord str) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();

		int count=publicService.addScoreTakeRecord(str);
		
		if(count>0) {
			jsonMap.put("status", "ok");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "添加积分消费记录失败！");
		}
		
		return jsonMap;
	}
	
	@RequestMapping(value="/goAdminCreateQrcode")
	public String goAdminCreateQrcode() {
		
		return "/merchant/phoneAdmin/createQrcode";
	}
	
	@RequestMapping(value="/goAdminQrcodeList")
	public String goAdminQrcodeList() {
		
		return "/merchant/phoneAdmin/qrcodeList";
	}
	
	@RequestMapping(value="/goAdminMine")
	public String goAdminMine() {
		
		return "/merchant/phoneAdmin/mine";
	}
	
	@RequestMapping(value="/goBindWX")
	public String goBindWX() {
		
		return "/merchant/phoneAdmin/bindWX";
	}

	@RequestMapping(value="/bindWX")
	public String bindWX(HttpServletRequest request) {

		String url=null;
		String code = request.getParameter("code");
		String accountId = request.getParameter("accountId");
		if(StringUtils.isEmpty(code)) {
			url="redirect:https://open.weixin.qq.com/connect/oauth2/authorize?appid="+com.goodsPublic.util.StringUtils.APP_ID+"&redirect_uri=http://www.qrcodesy.com/getCode.asp?params=bindWX,"+accountId+"&response_type=code&scope=snsapi_base&state=1&connect_redirect=1#wechat_redirect";
		}
		else {
			JSONObject obj = JSONObject.fromObject(MethodUtil.httpRequest("https://api.weixin.qq.com/sns/oauth2/access_token?appid="+com.goodsPublic.util.StringUtils.APP_ID+"&secret="+com.goodsPublic.util.StringUtils.APP_SECRET+"&code="+code+"&grant_type=authorization_code"));
			String openId = obj.getString("openid");
			System.out.println("openId======"+openId);
			boolean bool=publicService.checkAccountOpenIdExist(openId);
			//boolean bool=false;
			if(bool) {
				request.setAttribute("status", "no");
				request.setAttribute("message", "你的微信号已绑定其他辰麒账号");
			}
			else {
				publicService.updateAccountOpenIdById(openId,accountId);
				
				request.setAttribute("status", "ok");
				request.setAttribute("message", "你已成功绑定辰麒账号");
			}
			url="/merchant/phoneAdmin/bindStatus";
		}
		return url;
	}

	@RequestMapping(value="/selectAdminQrcodeList")
	@ResponseBody
	public Map<String, Object> selectAdminQrcodeList(String searchTxt, String accountId) {

		Map<String, Object> jsonMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> qrcodeList=publicService.selectAdminQrcodeList(searchTxt,accountId);
		
		if(qrcodeList.size()>0) {
			jsonMap.put("status", "ok");
			jsonMap.put("list", qrcodeList);
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "暂无数据");
		}
		return jsonMap;
	}
}
