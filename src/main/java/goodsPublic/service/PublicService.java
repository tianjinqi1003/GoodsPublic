package goodsPublic.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.goodsPublic.util.PlanResult;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.Goods;

public interface PublicService {

	/**
	 * 保存商品到数据库
	 * @param goods
	 * @return
	 */
	public int addGoodsPublic(Goods goods);

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
	 * @return
	 */
	public int editGoods(Goods goods);
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
}
