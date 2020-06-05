package goodsPublic.service.serviceImpl;

import java.awt.image.BufferedImage;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodsPublic.util.FreeMakerUtil;
import com.google.code.kaptcha.Producer;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import goodsPublic.entity.Goods;
import goodsPublic.service.UtilService;

@Service
public class UtilServiceImpl implements UtilService {
	@Autowired
    private Producer captchaProducer = null;

	@Override
	public void getKaptchaImageByMerchant(HttpSession session, String identity, HttpServletResponse response) {
		 response.setDateHeader("Expires", 0);  //设置http头，告诉客户端不要缓存此图像
	        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
	        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
	        response.setHeader("Pragma", "no-cache");
	        response.setContentType("image/jpeg");
	        String capText = captchaProducer.createText();  //创建图片中显示的随机文字
	            try {
	            	System.out.println("capText==="+capText);
	            	session.setAttribute("验证码", capText);
	                BufferedImage bi = captchaProducer.createImage(capText);
	                ServletOutputStream out = response.getOutputStream();
	                JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(response.getOutputStream());
	                encoder.encode(bi);
	                try {
	                    out.flush();
	                } finally {
	                    out.close();
	                }
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	}

	@Override
	public String doHTML(Goods articleInfo ,HttpServletRequest request) {
		Map<String, Object> root = new HashMap<String, Object>();
		//2.赋值
		root.put("user_name", "胖先生");
		String path=FreeMakerUtil.fprint("Model.flt", root,"第一个模版.html",request);
		return path;
	}

}
