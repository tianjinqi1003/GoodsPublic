package goodsPublic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.ShopArticleInfo;

public interface PublicMapper {
	//保存发布的产品信息
	public int addGoodsPublic(ShopArticleInfo articleInfo);
	//修改发布的产品信息
	public int updataGoodsPublic(ShopArticleInfo articleInfo);
	//查询所有的产品信息
	public ShopArticleInfo getAllGoodsMsg(String goodsNumber);
	/**
	 * 更新二维码链接
	 * @param url
	 * @param goodsNumber
	 * @return
	 */
	public int updateQrcode(@Param("url")String url, @Param("goodsNumber")String goodsNumber);
	
}
