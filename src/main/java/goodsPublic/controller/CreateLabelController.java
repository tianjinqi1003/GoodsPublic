package goodsPublic.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import goodsPublic.service.CreateLabelService;

@Controller
@RequestMapping("/createLabel")
public class CreateLabelController {
	
	@Autowired
	private CreateLabelService createLabelService;
	
	@RequestMapping("/toCreateBatch")
	public String toCreateBatch() {
		
		return "/createLabel/createBatch";
	}

}
