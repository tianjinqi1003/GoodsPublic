package goodsPublic.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import com.goodsPublic.util.PlanResult;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.AccountPayRecord;
import goodsPublic.entity.CreatePayCodeRecord;
import goodsPublic.entity.Goods;
import goodsPublic.entity.GoodsLabelSet;
import goodsPublic.entity.HtmlGoodsDMTZL;
import goodsPublic.entity.HtmlGoodsGRMP;
import goodsPublic.entity.HtmlGoodsHDQD;
import goodsPublic.entity.HtmlGoodsJZSG;
import goodsPublic.entity.HtmlGoodsSPZS;
import goodsPublic.entity.HtmlGoodsText;
import goodsPublic.entity.JFDHJPActivity;
import goodsPublic.entity.JFDHJPCustomer;
import goodsPublic.entity.ModuleHDQD;
import goodsPublic.entity.PrizeCode;
import goodsPublic.entity.ScoreQrcode;
import goodsPublic.entity.ScoreTakeRecord;

public interface PublicService {

	/**
	 * 保存商品到数据库
	 * @param goods
	 * @return
	 */
	public int addGoodsPublic(Goods goods);

	/**
	 * 保存商品模版内容到数据库
	 * @param htmlGoods
	 * @return
	 */
	public int addHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoods);
	
	/**
	 * 添加多媒体资料模版内容
	 * @param htmlGoods
	 * @return
	 */
	public int addHtmlGoodsDMTZL(HtmlGoodsDMTZL htmlGoods);
	
	/**
	 * 保存建筑施工模版内容到数据库
	 * @param htmlGoods
	 * @return
	 */
	public int addHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoods);

	public int addHtmlGoodsHDQD(HtmlGoodsHDQD htmlGoodsHDQD);

	public int addScoreQrcode(ScoreQrcode scoreQrcode);

	public int addHtmlGoodsGRMP(HtmlGoodsGRMP htmlGoodsGRMP);

	public int editHtmlGoodsGRMP(HtmlGoodsGRMP htmlGoodsGRMP);

	public int addHtmlGoodsText(HtmlGoodsText htmlGoodsText);

	/**
	 * 获得所有跟当前用户有关的商品列表
	 * @param goodsNumber
	 * @return
	 */
	public int getGoodsByGoodsNumber(String goodsNumber, String accountNumber);

	/**
	 * 查询当前用户的
	 * @param goodsNumber
	 * @return
	 */
	public PlanResult getGoodsByGN(String goodsNumber, String accountNumber);

	/**
	 * 生成show页面地址栏二维码
	 * @param url
	 * @param goodsNumber
	 */
	public void createShowUrlQrcode(String url, String goodsNumber, String accountNumber);
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

	public int queryScoreQrcodeForInt(String accountId);

	/**
	 * 查询商品模版内容数量
	 * @param accountId
	 * @param moduleType 
	 * @return
	 */
	public int queryHtmlGoodsSPZSForInt(String accountId, String moduleType);
	
	/**
	 * 查询多媒体资料模版内容数量
	 * @param accountId
	 * @return
	 */
	public int queryHtmlGoodsDMTZLForInt(String accountId);
	
	/**
	 * 查询建筑施工模版内容数量
	 * @param accountId
	 * @return
	 */
	public int queryHtmlGoodsJZSGForInt(String accountId);

	public int queryHtmlGoodsHDQDForInt(String accountId);
	
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

	public List<ScoreQrcode> queryScoreQrcodeList(String accountId, int page, int rows, String sort, String order);

	/**
	 * 根据商户编号，查询商品展示模版内容
	 * @param accountId
	 * @param moduleType 
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<HtmlGoodsSPZS> queryHtmlGoodsSPZSList(String accountId, String moduleType, int page, int rows, String sort,
			String order);
	
	/**
	 * 根据商户编号，查询多媒体资料模版内容
	 * @param accountId
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<HtmlGoodsDMTZL> queryHtmlGoodsDMTZLList(String accountId, int page, int rows, String sort,
			String order);
	
	/**
	 * 根据商户编号，查询建筑施工模版内容信息
	 * @param accountId
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<HtmlGoodsJZSG> queryHtmlGoodsJZSGList(String accountId, int page, int rows, String sort,
			String order);

	public List<HtmlGoodsHDQD> queryHtmlGoodsHDQDList(String accountId, int page, int rows, String sort, String order);

	/**
	 * 编辑商户信息
	 * @param accountMsg
	 * @return
	 */
	public int editAccountInfo(AccountMsg accountMsg);

	public int editJFDHJPActivity(JFDHJPActivity jfdhjpActivity);
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

	public int addGoodsLabelSet(GoodsLabelSet goodsLabelSet);

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
	 * 根据类型查询商品展示模版
	 * @param type
	 * @param moduleType 
	 * @return
	 */
	public Object getModuleSPZSByType(String type, String moduleType);
	
	/**
	 * 根据类型查询多媒体资料模版
	 * @param type
	 * @return
	 */
	public Object getModuleDMTZLByType(String type);
	
	/**
	 * 根据类型查询建筑施工模版
	 * @param type
	 * @return
	 */
	public Object getModuleJZSGByType(String type);

	/**
	 * 根据类型查询活动签到模版
	 * @param type
	 * @return
	 */
	public Object getModuleHDQDByType(String type);

	/**
	 * 获得商品展示模版内容
	 * @param goodsNumber
	 * @param accountId
	 * @return
	 */
	public HtmlGoodsSPZS getHtmlGoodsSPZS(String moduleType,String goodsNumber, String accountId);
	
	/**
	 * 获得多媒体资料模版内容
	 * @param goodsNumber
	 * @param accountId
	 * @return
	 */
	public HtmlGoodsDMTZL getHtmlGoodsDMTZL(String goodsNumber, String accountId);
	
	/**
	 * 获得建筑施工模版内容
	 * @param userNumber
	 * @param accountId
	 * @return
	 */
	public HtmlGoodsJZSG getHtmlGoodsJZSG(String userNumber, String accountId);

	/**
	 * 获得活动签到模版内容
	 * @param goodsNumber
	 * @param accountNumber
	 * @return
	 */
	public HtmlGoodsHDQD getHtmlGoodsHDQD(String goodsNumber, String accountNumber);

	public HtmlGoodsText getHtmlGoodsText(String textType, String uuid, String accountNumber);

	public ScoreQrcode getScoreQrcode(String uuid, String accountId);

	/**
	 * 编辑商品展示模版内容
	 * @param htmlGoodsSPZS
	 * @return
	 */
	public int editHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS);
	
	/**
	 * 编辑多媒体资料模版内容
	 * @param htmlGoodsDMTZL
	 * @return
	 */
	public int editHtmlGoodsDMTZL(HtmlGoodsDMTZL htmlGoodsDMTZL);
	
	/**
	 * 编辑建筑施工模版内容
	 * @param htmlGoodsJZSG
	 * @return
	 */
	public int editHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoodsJZSG);

	/**
	 * 编辑活动签到模版内容
	 * @param htmlGoodsHDQD
	 * @return
	 */
	public int editHtmlGoodsHDQD(HtmlGoodsHDQD htmlGoodsHDQD);

	public int deleteScoreQrcodeByUuids(String uuids);

	/**
	 * 根据id删除商品展示模版内容
	 * @param ids
	 * @return
	 */
	public int deleteHtmlGoodsSPZSByIds(String ids);
	
	/**
	 * 根据id删除多媒体资料模版内容
	 * @param ids
	 * @return
	 */
	public int deleteHtmlGoodsDMTZLByIds(String ids);
	
	/**
	 * 根据id删除建筑施工模版内容
	 * @param ids
	 * @return
	 */
	public int deleteHtmlGoodsJZSGByIds(String ids);

	/**
	 * 根据id删除商品
	 * @param ids
	 * @return
	 */
	public int deleteGoodsByIds(String ids);

	/**
	 * 添加商户付费记录
	 * @param accountPayRecord
	 * @return
	 */
	public int addAccountPayRecord(AccountPayRecord accountPayRecord);

	public int addCreatePayCodeRecord(CreatePayCodeRecord cpcr);

	public int addJFDHJPCustomer(JFDHJPCustomer jc);

	public int addPrizeCode(PrizeCode pz, Integer dhjpScore, String openId);

	public int addJFDHJPActivity(JFDHJPActivity jfdhjpActivity);

	public CreatePayCodeRecord getCreatePayCodeRecordByOutTradeNo(String outTradeNo);

	public Map<String, Object> checkIfPaid(String accountNumber) throws ParseException;

	public int deleteLabelByKeys(String accountNumber, String keys);

	public HtmlGoodsGRMP getHtmlGoodsGRMP(String uuid);

	public boolean checkPassWord(String passWord, String userName);

	public int updatePwdByAccountId(String passWord, String id);

	public int updatePcExcById(String id);

	public int updatePcLimitByAccountId(String jpmLimit, String accountId);

	public boolean checkJCOpenIdExist(String openId);

	public JFDHJPCustomer getJCByOpenId(String openId);

	public boolean openJPDHJFRedBagByJC(ScoreQrcode sq);

	public int addScoreTakeRecord(ScoreTakeRecord str);

	public List<String> getCSDateList(String searchTxt, String accountNumber);
	
	public List<String> getCSDDateList(String startTime, String endTime, String accountNumber, String openId);

	public List<Map<String, Object>> queryCustomerScoreList(String searchTxt, String accountNumber);

	public List<Map<String, Object>> queryCSDetailList(String startTime, String endTime, String accountNumber,
			String openId);

	public JFDHJPActivity getJAByAccountId(String accountNumber);

	public int editScoreQrcode(ScoreQrcode sq, String jpmdhReg);

	public List<Map<String, Object>> selectAdminQrcodeList(String searchTxt, String accountNumber);

	public int updateWXQrcodeByAccountId(int wxFlag, String avaPath, String id);

	public int updateAccountOpenIdById(String openId, String accountId);

	public int checkAccountOpenIdExist(String openId);

	public AccountMsg getAccountByOpenId(String openId);

	public int syncUserNameOpenIdById(String openId, String accountId);

	public int updateAccountQCById(int qrcodeCount, String id);


}
