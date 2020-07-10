package goodsPublic.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.AccountPayRecord;
import goodsPublic.entity.CreatePayCodeRecord;
import goodsPublic.entity.Goods;
import goodsPublic.entity.GoodsLabelSet;
import goodsPublic.entity.HtmlGoodsDMTTS;
import goodsPublic.entity.HtmlGoodsDMTZL;
import goodsPublic.entity.HtmlGoodsGRMP;
import goodsPublic.entity.HtmlGoodsHDQD;
import goodsPublic.entity.HtmlGoodsJZSG;
import goodsPublic.entity.HtmlGoodsSMYL;
import goodsPublic.entity.HtmlGoodsSPZS;
import goodsPublic.entity.HtmlGoodsText;
import goodsPublic.entity.JFDHJPActivity;
import goodsPublic.entity.JFDHJPCustomer;
import goodsPublic.entity.ModuleDMTTS;
import goodsPublic.entity.ModuleDMTZL;
import goodsPublic.entity.ModuleHDQD;
import goodsPublic.entity.ModuleJZSG;
import goodsPublic.entity.ModuleSMYL;
import goodsPublic.entity.ModuleSPZS;
import goodsPublic.entity.PrizeCode;
import goodsPublic.entity.ScoreQrcode;
import goodsPublic.entity.ScoreQrcodeHistory;
import goodsPublic.entity.ScoreTakeRecord;

public interface PublicMapper {
	//保存发布的产品信息
	public int addGoodsPublic(Goods articleInfo);
	
	/**
	 * 保存发布的产品模版内容信息
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
	 * 添加多媒体图书模版内容
	 * @param htmlGoodsDMTTS
	 * @return
	 */
	public int addHtmlGoodsDMTTS(HtmlGoodsDMTTS htmlGoodsDMTTS);
	
	/**
	 * 添加建筑施工模版内容
	 * @param htmlGoods
	 * @return
	 */
	public int addHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoods);

	public int addHtmlGoodsHDQD(HtmlGoodsHDQD htmlGoodsHDQD);

	public int addHtmlGoodsSMYL(HtmlGoodsSMYL htmlGoodsSMYL);

	public int addScoreQrcode(ScoreQrcode scoreQrcode);

	public int addScoreQrcodeHistory(ScoreQrcodeHistory sqh);

	public int addHtmlGoodsGRMP(HtmlGoodsGRMP htmlGoodsGRMP);
	
	public int editHtmlGoodsGRMP(HtmlGoodsGRMP htmlGoodsGRMP);
	
	public int addHtmlGoodsText(HtmlGoodsText htmlGoodsText);
	
	public int editHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS);
	
	public int editHtmlGoodsDMTZL(HtmlGoodsDMTZL htmlGoodsDMTZL);

	public int editHtmlGoodsDMTTS(HtmlGoodsDMTTS htmlGoodsDMTTS);
	
	public int editHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoodsJZSG);
	
	public int editHtmlGoodsHDQD(HtmlGoodsHDQD htmlGoodsHDQD);
	//修改发布的产品信息
	public int updataGoodsPublic(Goods articleInfo);
	//查询所有的产品信息
	public Goods getAllGoodsMsg(@Param("goodsNumber")String goodsNumber, @Param("accountNumber")String accountNumber);
	
	/**
	 * 更新二维码链接
	 * @param avaPath
	 * @param goodsNumber
	 * @return
	 */
	public int updateQrcode(@Param("avaPath")String avaPath, @Param("goodsNumber")String goodsNumber, @Param("accountNumber")String accountNumber);
	
	/**
	 * 查询商品
	 * @param accountMsgId
	 * @param categoryId
	 * @return
	 */
	public List<Goods> queryGoodsList(String accountId, String categoryId, int start, int rows, String sort, String order);

	public List<ScoreQrcode> queryScoreQrcodeList(String accountId, int i, int rows, String sort, String order);
	
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
	 * @param i
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<HtmlGoodsDMTZL> queryHtmlGoodsDMTZLList(String accountId, int i, int rows, String sort,
			String order);

	/**
	 * 根据商户编号，查询多媒体图书模版内容
	 * @param accountId
	 * @param i
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<HtmlGoodsDMTTS> queryHtmlGoodsDMTTSList(String accountId, int i, int rows, String sort, 
			String order);
	
	/**
	 * 根据商户编号，查询建筑施工模版内容
	 * @param accountId
	 * @param i
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<HtmlGoodsJZSG> queryHtmlGoodsJZSGList(String accountId, int i, int rows, String sort,
			String order);

	public List<HtmlGoodsHDQD> queryHtmlGoodsHDQDList(String accountId, int i, int rows, String sort, String order);

	public List<HtmlGoodsHDQD> queryHtmlGoodsSMYLList(String accountId, int i, int rows, String sort, String order);
	
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

	public int queryScoreQrcodeForInt(String accountId);
	
	/**
	 * 查询模版商品数量
	 * @param accountId
	 * @param moduleType 
	 * @return
	 */
	public int queryHtmlGoodsSPZSForInt(String accountId, String moduleType);
	/**
	 * 查询模版多媒体资料数量
	 * @param accountId
	 * @return
	 */
	public int queryHtmlGoodsDMTZLForInt(String accountId);

	/**
	 * 查询模版多媒体图书数量
	 * @param accountId
	 * @return
	 */
	public int queryHtmlGoodsDMTTSForInt(String accountId);
	/**
	 * 查询建筑施工模版内容数量
	 * @param accountId
	 * @return
	 */
	public int queryHtmlGoodsJZSGForInt(String accountId);

	public int queryHtmlGoodsHDQDForInt(String accountId);

	public int queryHtmlGoodsSMYLForInt(String accountId);
	
	/**
	 * 编辑商户信息
	 * @param accountMsg
	 * @return
	 */
	public int editAccountInfo(AccountMsg accountMsg);

	public int editJFDHJPActivity(JFDHJPActivity jfdhjpActivity);
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

	public int addGoodsLabelSet(GoodsLabelSet goodsLabelSet);
	
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
	public void insertGoodsLabel(GoodsLabelSet goodsLabelSet);
	
	/**
	 * 根据类型，查询商品展示模版列表
	 * @param type 
	 * @return
	 */
	public List<ModuleSPZS> getModuleSPZSByType(String type, String moduleType);
	
	/**
	 * 根据类型，查询多媒体资料模版列表
	 * @param type
	 * @return
	 */
	public List<ModuleDMTZL> getModuleDMTZLByType(String type);

	/**
	 * 根据类型，查询多媒体图书模版列表
	 * @param type
	 * @return
	 */
	public List<ModuleDMTTS> getModuleDMTTSByType(String type);
	
	/**
	 * 根据类型，查询建筑施工模版列表
	 * @param type
	 * @return
	 */
	public List<ModuleJZSG> getModuleJZSGByType(String type);

	/**
	 * 根据类型，查询活动签到模版列表
	 * @param type
	 * @return
	 */
	public List<ModuleHDQD> getModuleHDQDByType(String type);

	/**
	 * 根据类型，查询树木园林模版列表
	 * @param type
	 * @return
	 */
	public List<ModuleSMYL> getModuleSMYLByType(String type);
	
	/**
	 * 获得商品展示模版内容
	 * @param goodsNumber
	 * @param accountId
	 * @return
	 */
	public HtmlGoodsSPZS getHtmlGoodsSPZS(String moduleType, String goodsNumber, String accountId);
	
	/**
	 * 获得多媒体资料模版内容
	 * @param goodsNumber
	 * @param accountId
	 * @return
	 */
	public HtmlGoodsDMTZL getHtmlGoodsDMTZL(String goodsNumber, String accountId);

	/**
	 * 获得多媒体图书模版内容
	 * @param goodsNumber
	 * @param accountId
	 * @return
	 */
	public HtmlGoodsDMTTS getHtmlGoodsDMTTS(String goodsNumber, String accountId);
	
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

	/**
	 * 获得树木园林模版内容
	 * @param goodsNumber
	 * @param accountNumber
	 * @return
	 */
	public HtmlGoodsSMYL getHtmlGoodsSMYL(String goodsNumber, String accountNumber);

	public HtmlGoodsText getHtmlGoodsText(@Param("textType") String textType, @Param("uuid") String uuid, @Param("accountNumber") String accountNumber);

	public ScoreQrcode getScoreQrcode(String uuid, String accountId);
	
	/**
	 * 根据备注类型，获得多媒体资料模版对应的值
	 * @param type
	 * @return
	 */
	public ModuleDMTZL getModuleDMTZLByMemo(String type);

	/**
	 * 根据备注类型，获得多媒体图书模版对应的值
	 * @param type
	 * @return
	 */
	public ModuleDMTTS getModuleDMTTSByMemo(String type);

	public int deleteScoreQrcodeByUuids(List<String> uuidList);

	/**
	 *现在不直接从数据库里删除积分二维码数据了，这个方法暂时不用了 
	public int deleteScoreQrcodeByExUuids(List<String> exUuidList);
	*/
	
	/**
	 * 根据id删除商品展示模版内容
	 * @param idList
	 * @return
	 */
	public int deleteHtmlGoodsSPZSByIds(List<String> idList);

	/**
	 * 根据id删除活动签到模版内容
	 * @param idList
	 * @return
	 */
	public int deleteHtmlGoodsHDQDByIds(List<String> idList);
	
	/**
	 * 根据id删除多媒体资料模版内容
	 * @param idList
	 * @return
	 */
	public int deleteHtmlGoodsDMTZLByIds(List<String> idList);

	/**
	 * 根据id删除多媒体图书模版内容
	 * @param idList
	 * @return
	 */
	public int deleteHtmlGoodsDMTTSByIds(List<String> idList);
	
	/**
	 * 根据id删除建筑施工模版内容
	 * @param idList
	 * @return
	 */
	public int deleteHtmlGoodsJZSGByIds(List<String> idList);

	/**
	 * 根据id删除商品
	 * @param idList
	 * @return
	 */
	public int deleteGoodsByIds(List<String> idList);

	/**
	 * 添加商户付费记录
	 * @param accountPayRecord
	 * @return
	 */
	public int addAccountPayRecord(AccountPayRecord accountPayRecord);

	public int addCreatePayCodeRecord(CreatePayCodeRecord cpcr);

	public int addJFDHJPCustomer(JFDHJPCustomer jc);

	public int addPrizeCode(PrizeCode pz);

	public int addJFDHJPActivity(JFDHJPActivity jfdhjpActivity);

	public CreatePayCodeRecord getCreatePayCodeRecordByOutTradeNo(@Param("outTradeNo") String outTradeNo);

	public AccountPayRecord getLastAccountPayRecordByNumber(@Param("accountNumber") String accountNumber);

	public String getAccountEndTimeByNumber(@Param("accountNumber") String accountNumber);

	public int deleteLabelByKeys(@Param("accountNumber") String accountNumber, @Param("keys") String keys);

	public List<String> getLabelKeyList(@Param("module") String module, @Param("accountNumber") String accountNumber);

	public HtmlGoodsGRMP getHtmlGoodsGRMP(@Param("uuid") String uuid);

	public String getAccountPwdByUserName(@Param("userName") String userName);

	public int updatePwdByAccountId(@Param("passWord") String passWord, @Param("id") String id);

	public int updateAccountQCById(@Param("qrcodeCount") int qrcodeCount, @Param("id") String id);

	public int updatePcExcById(@Param("id") String id);

	public int updatePcLimitByAccountId(@Param("jpmLimit") String jpmLimit, @Param("accountNumber") String accountNumber);

	public int getJCCountByOpenId(@Param("openId") String openId);

	public int getAccountCountByOpenId(@Param("openId") String openId);

	public AccountMsg getAccountByOpenId(@Param("openId") String openId);

	public JFDHJPActivity getJAByAccountId(@Param("accountNumber") String accountNumber);

	public JFDHJPCustomer getJCByOpenId(@Param("openId") String openId);

	public int updateSQEnableByUuid(@Param("openId") String openId,@Param("uuid") String uuid);

	public int addJCScoreByOpenId(@Param("score") Integer score, @Param("openId") String openId);

	public int addScoreTakeRecord(ScoreTakeRecord str);

	public int reduceJCScoreByOpenId(@Param("dhjpScore") Integer dhjpScore, @Param("openId") String openId);

	public List<String> getCSDateList(@Param("searchTxt") String searchTxt, @Param("accountNumber") String accountNumber);

	public List<String> getCSDDateList( @Param("startTime")String startTime, @Param("endTime") String endTime, @Param("accountNumber") String accountNumber, @Param("openId") String openId);

	public List<Map<String, Object>> queryCustomerScoreList(@Param("searchTxt") String searchTxt, @Param("accountNumber") String accountNumber);

	public List<Map<String, Object>> queryCSDetailList(@Param("startTime") String startTime, @Param("endTime") String endTime, @Param("accountNumber") String accountNumber,
			@Param("openId") String openId);

	public int updateAccountPayInfo(AccountPayRecord accountPayRecord);
	
	public int updateScoreByQrcodeUuid(@Param("score") Integer score, @Param("uuid") String uuid);

	public int updateJPMDHRegByAccountId(@Param("jpmdhReg") String jpmdhReg, @Param("accountNumber") Integer accountNumber);

	public int updateSTRGkjfqdShow(@Param("openId") String openId, @Param("accountNumber") Integer accountNumber);

	public List<Map<String, Object>> selectAdminQrcodeList(@Param("searchTxt") String searchTxt, @Param("accountNumber") String accountNumber);

	public int updateWXQrcodeByAccountId(@Param("wxFlag") int wxFlag, @Param("wxQrcode") String wxQrcode, @Param("accountNumber") String accountNumber);

	public int updateAccountOpenIdById(@Param("openId") String openId, @Param("id") String id);

	public int updateHGTAccoNumByUserId(@Param("accountNumber") String accountNumber, @Param("userId") String userId);

	public int deleteAccountByUserName(@Param("userName") String userName);

}
