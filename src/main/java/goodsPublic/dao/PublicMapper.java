package goodsPublic.dao;

import java.util.List;

import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.ShopArticleInfo;

public interface PublicMapper {
	//保存发布的产品信息
	public int addGoodsPublic(ShopArticleInfo articleInfo);
	//修改发布的产品信息
	public int updataGoodsPublic(ShopArticleInfo articleInfo);
	//查询所有的产品信息
	public ShopArticleInfo getAllGoodsMsg(String goodsNumber);
	
}
