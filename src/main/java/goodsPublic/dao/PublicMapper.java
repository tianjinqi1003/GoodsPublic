package goodsPublic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.Goods;

public interface PublicMapper {
	//保存发布的产品信息
	public int addGoodsPublic(Goods articleInfo);
	//修改发布的产品信息
	public int updataGoodsPublic(Goods articleInfo);
	//查询所有的产品信息
	public Goods getAllGoodsMsg(String goodsNumber);
	/**
	 * 更新二维码链接
	 * @param url
	 * @param goodsNumber
	 * @return
	 */
	public int updateQrcode(@Param("url")String url, @Param("goodsNumber")String goodsNumber);
	/**
	 * 查询商品
	 * @param accountMsgId
	 * @param categoryId
	 * @return
	 */
	public List<Goods> queryGoodsList(@Param("accountMsgId")String accountMsgId, @Param("categoryId")String categoryId);
	/**
	 * 根据id查询商品
	 * @param id
	 * @return
	 */
	public Goods getGoodsById(@Param("id")String id);
	
}
