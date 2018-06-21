package goodsPublic.service;

import javax.servlet.http.HttpServletRequest;

import com.goodsPublic.util.PlanResult;

import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.ShopArticleInfo;

public interface PublicService {
	//保存商品到数据库
	public void publicGoods(ShopArticleInfo articleInfo,HttpServletRequest request);
	//获得所有跟当前用户有关的商品列表
	public int getGoodsByGoodsNumber(String goodsNumber);
	//查询当前用户的
	public PlanResult getGoodsByGN(String goodsNumber);
	/**
	 * 编辑类别
	 * @param categoryInfo
	 * @return
	 */
	public int editCategory(CategoryInfo categoryInfo);
	/**
	 * 生成show页面地址栏二维码
	 * @param url
	 * @param goodsNumber
	 */
	public void createShowUrlQrcode(String url, String goodsNumber);
}
