package goodsPublic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.Goods;
import goodsPublic.entity.GoodsLabelSet;
import goodsPublic.entity.HtmlTemplate;

public interface PublicMapper {
	//保存发布的产品信息
	public int addGoodsPublic(Goods articleInfo);
	//修改发布的产品信息
	public int updataGoodsPublic(Goods articleInfo);
	//查询所有的产品信息
	public Goods getAllGoodsMsg(String goodsNumber);
	/**
	 * 更新二维码链接
	 * @param avaPath
	 * @param goodsNumber
	 * @return
	 */
	public int updateQrcode(@Param("avaPath")String avaPath, @Param("goodsNumber")String goodsNumber);
	/**
	 * 查询商品
	 * @param accountMsgId
	 * @param categoryId
	 * @return
	 */
	public List<Goods> queryGoodsList(String accountId, String categoryId, int start, int rows, String sort, String order);
	
	/**
	 * 根据类别id查询商品
	 * @param categoryID
	 * @return
	 */
	public List<Goods> queryGoodsListByCateId(int categoryID);
	/**
	 * 根据id查询商品
	 * @param id
	 * @return
	 */
	public Goods getGoodsById(@Param("id")String id);
	/**
	 * 编辑商品
	 * @param goods
	 * @return
	 */
	public int updateGoods(Goods goods);
	/**
	 * 根据id查询商家信息
	 * @param accountId
	 * @return
	 */
	public AccountMsg getAccountById(String accountId);
	/**
	 * 查询商品数量
	 * @param accountId
	 * @param categoryId
	 * @return
	 */
	public int queryGoodsForInt(String accountId, String categoryId);
	/**
	 * 编辑商户信息
	 * @param accountMsg
	 * @return
	 */
	public int editAccountInfo(AccountMsg accountMsg);
	/**
	 * 根据商户信息查询名下商品条目数量
	 */
	public int getGoodsListByMsg(AccountMsg accountMsg);
	/**
	 * 根据商家编号获得商品属性设置
	 * @param accountId
	 * @return
	 */
	public List<GoodsLabelSet> getGoodsLabelSetByAccountId(@Param("accountNumber") String accountId);
	/**
	 * 根据模板类型、商家编号获得页面模板
	 * @param type
	 * @param accountId
	 * @return
	 */
	public HtmlTemplate getHtmlTemplateByTypeAccountId(@Param("type") String type,@Param("accountNumber") String accountId);
	/**
	 * 查询标签数量
	 * @param accountNumber
	 * @return
	 */
	public int queryGoodsLabelSetForInt(String accountNumber);
	/**
	 * 根据商户号，查询标签信息
	 * @param accountNumber
	 * @param start
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<GoodsLabelSet> queryGoodsLabelSetList(String accountNumber, int start, int rows, String sort, String order);
	/**
	 * 根据id查询标签信息
	 * @param id
	 * @return
	 */
	public GoodsLabelSet getGoodsLabelSetById(String id);
	/**
	 * 编辑商品标签
	 * @param goodsLabelSet
	 * @return
	 */
	public int editGoodsLabelSet(GoodsLabelSet goodsLabelSet);
}
