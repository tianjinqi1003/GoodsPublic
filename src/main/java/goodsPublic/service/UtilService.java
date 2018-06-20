package goodsPublic.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import goodsPublic.entity.ShopArticleInfo;

public interface UtilService {
	public void getKaptchaImageByMerchant(HttpSession session, String identity, HttpServletResponse response);
	public String doHTML(ShopArticleInfo articleInfo,HttpServletRequest request );
}
