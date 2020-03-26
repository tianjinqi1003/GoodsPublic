package goodsPublic.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import goodsPublic.entity.ScoreQrcode;
import goodsPublic.service.PublicService;

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
}
