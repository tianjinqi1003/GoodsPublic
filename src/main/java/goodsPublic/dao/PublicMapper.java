package goodsPublic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.Goods;
import goodsPublic.entity.GoodsLabelSet;
import goodsPublic.entity.HtmlGoodsJZSG;
import goodsPublic.entity.HtmlGoodsSPZS;
import goodsPublic.entity.ModuleJZSG;
import goodsPublic.entity.ModuleSPZS;

public interface PublicMapper {
	//保存发布的产品信息
	public int addGoodsPublic(Goods articleInfo);
	/**
	 * 保存发布的产品模板内容信息
	 * @param htmlGoods
	 * @return
	 */
	public int addHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoods);
	public int editHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS);
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
	 * 查询模板商品
	 * @param accountId
	 * @param i
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<HtmlGoodsSPZS> queryHtmlGoodsSPZSList(String accountId, int i, int rows, String sort,
			String order);
	
	/**
	 * 查询建筑施工模板内容
	 * @param accountId
	 * @param i
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<HtmlGoodsJZSG> queryHtmlGoodsJZSGList(String accountId, int i, int rows, String sort,
			String order);
	
	/**
	 * 根据类别id查询商品
	 * @param categoryID
	 * @param accountId 
	 * @return
	 */
	public List<Goods> queryGoodsListByCateId(int categoryID, String accountId);
	/**
	 * 根据id查询商品
	 * @param id
	 * @return
	 */
	public Goods getGoodsById(@Param("id")String id);
	/**
	 * 编辑单个商品
	 * @param singleGoods
	 * @return
	 */
	public int updateSingleGoods(Goods singleGoods);
	/**
	 * 编辑同一类别下的商品
	 * @param publicGoods
	 * @return
	 */
	public int updatePublicGoods(Goods publicGoods);
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
	 * 查询模板商品数量
	 * @param accountId
	 * @return
	 */
	public int queryHtmlGoodsSPZSForInt(String accountId);
	/**
	 * 查询建筑施工模板内容数量
	 * @param accountId
	 * @return
	 */
	public int queryHtmlGoodsJZSGForInt(String accountId);
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
	 * @param module
	 * @param accountId 
	 * @return
	 */
	public List<GoodsLabelSet> getGoodsLabelSetByModuleAccountId(@Param("module") String module, @Param("accountNumber") String accountId);
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
	public int editGoodsLabelSetById(GoodsLabelSet goodsLabelSet);
	/**
	 * 编辑其他对应商品标签
	 * @param goodsLabelSet
	 * @return
	 */
	public int editOtherGoodsLabelSetNameByKeyAccountNumber(GoodsLabelSet goodsLabelSet);
	/**
	 * 验证商品标签是否存在
	 * @param key
	 * @param module
	 * @param accountNumber
	 * @return
	 */
	public int checkGoodsLabelExist(@Param("key") String key, @Param("module") String module, @Param("accountNumber") String accountNumber);
	/**
	 * 添加商品标签
	 * @param key
	 * @param module
	 * @param accountNumber
	 */
	public void insertGoodsLabel(@Param("key") String key, @Param("module") String module, @Param("accountNumber") String accountNumber);
	/**
	 * 根据类型，查询商品展示模板列表
	 * @param type 
	 * @return
	 */
	public List<ModuleSPZS> getModuleSPZSBySPXQ(String type);
	public List<ModuleJZSG> getModuleJZSGByType(String type);
	public HtmlGoodsSPZS getHtmlGoodsSPZS(String goodsNumber, String accountId);
	/**
	 * @param type
	 * @return
	 */
	public ModuleSPZS getModuleSPZSByMemo(String type);
	public int deleteHtmlGoodsSPZSByIds(List<String> idList);
}
