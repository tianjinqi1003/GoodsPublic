package goodsPublic.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.goodsPublic.util.PlanResult;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.Goods;
import goodsPublic.entity.GoodsLabelSet;
import goodsPublic.entity.HtmlGoodsSPZS;
import goodsPublic.entity.HtmlTemplate;

public interface PublicService {

	/**
	 * 保存商品到数据库
	 * @param goods
	 * @return
	 */
	public int addGoodsPublic(Goods goods);

	/**
	 * 保存商品模板内容到数据库
	 * @param htmlGoods
	 * @return
	 */
	public int addHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoods);

	/**
	 * 获得所有跟当前用户有关的商品列表
	 * @param goodsNumber
	 * @return
	 */
	public int getGoodsByGoodsNumber(String goodsNumber);

	/**
	 * 查询当前用户的
	 * @param goodsNumber
	 * @return
	 */
	public PlanResult getGoodsByGN(String goodsNumber);

	/**
	 * 生成show页面地址栏二维码
	 * @param url
	 * @param goodsNumber
	 */
	public void createShowUrlQrcode(String url, String goodsNumber);
	/**
	 * 根据id查询商品
	 * @param id
	 * @return
	 */
	public Goods getGoodsById(String id);
	/**
	 * 编辑商品
	 * @param goods
	 * @param glsList 
	 * @return
	 */
	public int editGoods(Goods goods, List<GoodsLabelSet> glsList);
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
	 * 查询商品信息
	 * @param accountId
	 * @param categoryId
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<Goods> queryGoodsList(String accountId, String categoryId, int page, int rows, String sort,
			String order);

	/**
	 * 根据类别编号，查询商品信息
	 * @param categoryID
	 * @param accountId 
	 * @return
	 */
	public List<Goods> queryGoodsList(int categoryID, String accountId);

	/**
	 * 根据模板类型、商户编号，查询商品信息
	 * @param accountId
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<HtmlGoodsSPZS> queryHtmlGoodsSPZSList(String accountId, int page, int rows, String sort,
			String order);

	/**
	 * 编辑商户信息
	 * @param accountMsg
	 * @return
	 */
	public int editAccountInfo(AccountMsg accountMsg);
	/**
	 * 根据用户信息查询用户名下有多少条商品
	 */
	public int getGoodsListByMsg();

	/**
	 * 根据商家编号获得商品属性设置
	 * @param module
	 * @param accountId 
	 * @return
	 */
	public List<GoodsLabelSet> getGoodsLabelSetByModuleAccountId(String module, String accountId);

	/**
	 * 查询标签数量
	 * @param accountNumber
	 * @return
	 */
	public int queryGoodsLabelSetForInt(String accountNumber);
	
	/**
	 * 根据商户号，查询标签信息
	 * @param accountNumber
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<GoodsLabelSet> queryGoodsLabelSetList(String accountNumber, int page, int rows, String sort, String order);

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

	/**
	 * 根据商户号初始化商品标签
	 * @param accountNumber
	 */
	public void initGoodsLabelSet(String accountNumber);

	/**
	 * 根据类型查询商品展示模板
	 * @param type
	 * @return
	 */
	public Object getModuleSPZSByType(String type);

	public HtmlGoodsSPZS getHtmlGoodsSPZS(String goodsNumber, String accountId);

	public int editHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS);


}
