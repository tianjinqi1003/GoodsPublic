package goodsPublic.service;

import javax.servlet.http.HttpServletRequest;

import com.goodsPublic.util.PlanResult;

import goodsPublic.entity.ShopArticleInfo;

public interface PublicService {
	//保存商品到数据库
	public void publicGoods(ShopArticleInfo articleInfo,HttpServletRequest request);
	//获得所有跟当前用户有关的商品列表
	public int getGoodsByGoodsNumber(String goodsNumber);
	//查询当前用户的
	public PlanResult getGoodsByGN(String goodsNumber);
}
