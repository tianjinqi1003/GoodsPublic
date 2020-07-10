package goodsPublic.service.serviceImpl;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodsPublic.util.PlanResult;
import com.goodsPublic.util.qrcode.Qrcode;

import goodsPublic.dao.PublicMapper;
import goodsPublic.dao.UserMapper;
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
import goodsPublic.entity.HtmlGoodsSPZS;
import goodsPublic.entity.HtmlGoodsText;
import goodsPublic.entity.JFDHJPActivity;
import goodsPublic.entity.JFDHJPCustomer;
import goodsPublic.entity.ModuleDMTTS;
import goodsPublic.entity.ModuleDMTZL;
import goodsPublic.entity.ModuleHDQD;
import goodsPublic.entity.ModuleJZSG;
import goodsPublic.entity.ModuleSMYL;
import goodsPublic.entity.PrizeCode;
import goodsPublic.entity.ScoreQrcode;
import goodsPublic.entity.ScoreQrcodeHistory;
import goodsPublic.entity.ScoreTakeRecord;
import goodsPublic.service.PublicService;
/**
 * 这是用来处理商品的对应接口
 * @author Administrator
 *
 */
@Service
public class PublicServiceImpl implements PublicService {
	@Autowired
	private PublicMapper publicDao;
	@Autowired
	private UserMapper userDao;
	private SimpleDateFormat timeSDF=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	//发布商品接口，将商品保存在数据库中
	@Override
	public int addGoodsPublic(Goods goods) {
		return publicDao.addGoodsPublic(goods);
	}

	@Override
	public int addHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoods) {
		// TODO Auto-generated method stub
		return publicDao.addHtmlGoodsSPZS(htmlGoods);
	}
	
	@Override
	public int addHtmlGoodsDMTZL(HtmlGoodsDMTZL htmlGoods) {
		// TODO Auto-generated method stub
		return publicDao.addHtmlGoodsDMTZL(htmlGoods);
	}

	@Override
	public int addHtmlGoodsDMTTS(HtmlGoodsDMTTS htmlGoodsDMTTS) {
		// TODO Auto-generated method stub
		return publicDao.addHtmlGoodsDMTTS(htmlGoodsDMTTS);
	}
	
	@Override
	public int addHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoods) {
		// TODO Auto-generated method stub
		return publicDao.addHtmlGoodsJZSG(htmlGoods);
	}

	@Override
	public int addHtmlGoodsHDQD(HtmlGoodsHDQD htmlGoodsHDQD) {
		// TODO Auto-generated method stub
		return publicDao.addHtmlGoodsHDQD(htmlGoodsHDQD);
	}

	@Override
	public int addScoreQrcode(ScoreQrcode scoreQrcode) {
		// TODO Auto-generated method stub
		return publicDao.addScoreQrcode(scoreQrcode);
	}

	@Override
	public int addHtmlGoodsGRMP(HtmlGoodsGRMP htmlGoodsGRMP) {
		// TODO Auto-generated method stub
		return publicDao.addHtmlGoodsGRMP(htmlGoodsGRMP);
	}

	@Override
	public int editHtmlGoodsGRMP(HtmlGoodsGRMP htmlGoodsGRMP) {
		// TODO Auto-generated method stub
		return publicDao.editHtmlGoodsGRMP(htmlGoodsGRMP);
	}

	@Override
	public int addHtmlGoodsText(HtmlGoodsText htmlGoodsText) {
		// TODO Auto-generated method stub
		return publicDao.addHtmlGoodsText(htmlGoodsText);
	}
	
	@Override
	public int editHtmlGoodsSPZS(HtmlGoodsSPZS htmlGoodsSPZS) {
		// TODO Auto-generated method stub
		return publicDao.editHtmlGoodsSPZS(htmlGoodsSPZS);
	}
	
	@Override
	public int editHtmlGoodsDMTZL(HtmlGoodsDMTZL htmlGoodsDMTZL) {
		// TODO Auto-generated method stub
		return publicDao.editHtmlGoodsDMTZL(htmlGoodsDMTZL);
	}

	@Override
	public int editHtmlGoodsDMTTS(HtmlGoodsDMTTS htmlGoodsDMTTS) {
		// TODO Auto-generated method stub
		return publicDao.editHtmlGoodsDMTTS(htmlGoodsDMTTS);
	}
	
	@Override
	public int editHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoodsJZSG) {
		// TODO Auto-generated method stub
		return publicDao.editHtmlGoodsJZSG(htmlGoodsJZSG);
	}

	@Override
	public int editHtmlGoodsHDQD(HtmlGoodsHDQD htmlGoodsHDQD) {
		// TODO Auto-generated method stub
		return publicDao.editHtmlGoodsHDQD(htmlGoodsHDQD);
	}
	
	//展示商品接口，将商品从数据库中读取出来展示到对应的页面当中
	
	//获得所有跟当前用户有关的商品列表(1代表已存在，0代表不存在)
	@Override
	public int getGoodsByGoodsNumber(String goodsNumber, String accountNumber) {
		//查询商品列表
		Goods shopInfo = publicDao.getAllGoodsMsg(goodsNumber,accountNumber);
		if(shopInfo!=null) {
			if(goodsNumber.equals(shopInfo.getGoodsNumber())) {
				return 1;
			}
			return 0;
		}
		return 0;
	}

	@Override
	public PlanResult getGoodsByGN(String goodsNumber, String accountNumber) {
		PlanResult plan=new PlanResult();
		Goods shopInfo = publicDao.getAllGoodsMsg(goodsNumber,accountNumber);
		if(shopInfo==null) {
			plan.setStatus(0);
			plan.setMsg("查询失败，产品不存在");
			plan.setData(null);
			return plan;
		}
		plan.setStatus(1);
		plan.setMsg("查询成功");
		plan.setData(shopInfo);
		return plan;
	}

	@Override
	public void createShowUrlQrcode(String url, String goodsNumber, String accountNumber) {
		// TODO Auto-generated method stub

        String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
		String avaPath="/GoodsPublic/upload/"+fileName;
		if(publicDao.updateQrcode(avaPath,goodsNumber,accountNumber)>0) {
			//String path = FileSystemView.getFileSystemView().getHomeDirectory() + File.separator + "testQrcode";
			String path = "D:/resource";
	        Qrcode.createQrCode(url, path, fileName);
		}
	}

	@Override
	public Goods getGoodsById(String id) {
		// TODO Auto-generated method stub
		
		return publicDao.getGoodsById(id);
	}

	@Override
	public int editGoods(Goods goods, List<GoodsLabelSet> glsList) {
		// TODO Auto-generated method stub

		Goods singleGoods=null;
		Goods publicGoods=null;
		try {
			Class<?> singleClass = Class.forName("goodsPublic.entity.Goods");
			Class<?> publicClass = Class.forName("goodsPublic.entity.Goods");
			for (GoodsLabelSet goodsLabelSet : glsList) {
				String keyName = goodsLabelSet.getKey();
				String methodName = "set" + keyName.substring(0, 1).toUpperCase() + keyName.substring(1);
				//String methodName1 = "get" + keyName.substring(0, 1).toUpperCase() + keyName.substring(1);
				Boolean isPublic = goodsLabelSet.getIsPublic();
				if(isPublic) {
					if(publicGoods==null)
						publicGoods=(Goods)publicClass.newInstance();
					Object valueObj=getGoodsValueByKeyName(keyName,goods);
					if(valueObj==null)
						continue;
					Method method = null;
					if(valueObj instanceof Integer) {
						method = publicClass.getMethod(methodName, Integer.class);
					}
					else if(valueObj instanceof String)
						method = publicClass.getMethod(methodName, String.class);
					method.invoke(publicGoods, new Object[] {valueObj});
				}
				else {
					if(singleGoods==null)
						singleGoods=(Goods)singleClass.newInstance();
					Object valueObj=getGoodsValueByKeyName(keyName,goods);
					if(valueObj==null)
						continue;
					Method method = null;
					if(valueObj instanceof Integer) {
						method = singleClass.getMethod(methodName, Integer.class);
					}
					else if(valueObj instanceof String)
						method = singleClass.getMethod(methodName, String.class);
					method.invoke(singleGoods, new Object[] {valueObj});
				}
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int count=0;
		if(singleGoods!=null)
			singleGoods.setId(goods.getId());
			count+=publicDao.updateSingleGoods(singleGoods);
		if(publicGoods!=null) {
			publicGoods.setCategory_id(goods.getCategory_id());
			publicGoods.setAccountNumber(goods.getAccountNumber());
			count+=publicDao.updatePublicGoods(publicGoods);
		}
		return count;
	}

	private Object getGoodsValueByKeyName(String keyName, Goods goods) throws Exception {
		// TODO Auto-generated method stub
		Field[] fieldArr = goods.getClass().getDeclaredFields();
		for(Field field : fieldArr) {
			String name = field.getName();
			if(keyName.equals(name)) {
	            //System.out.println("name==="+name);
				//String type = field.getGenericType().toString();//获取属性类型
				Method m = goods.getClass().getMethod("get" + name.substring(0, 1).toUpperCase() + name.substring(1));
	            Object value = m.invoke(goods);
	            //System.out.println("value==="+value);
	            return value;
			}
		}
		return null;
	}

	@Override
	public AccountMsg getAccountById(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getAccountById(accountId);
	}

	@Override
	public int queryGoodsForInt(String accountId, String categoryId) {
		// TODO Auto-generated method stub
		return publicDao.queryGoodsForInt(accountId,categoryId);
	}

	@Override
	public int queryScoreQrcodeForInt(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.queryScoreQrcodeForInt(accountId);
	}

	@Override
	public int queryHtmlGoodsSPZSForInt(String accountId, String moduleType) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsSPZSForInt(accountId,moduleType);
	}
	
	@Override
	public int queryHtmlGoodsDMTZLForInt(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsDMTZLForInt(accountId);
	}

	@Override
	public int queryHtmlGoodsDMTTSForInt(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsDMTTSForInt(accountId);
	}
	
	@Override
	public int queryHtmlGoodsJZSGForInt(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsJZSGForInt(accountId);
	}

	@Override
	public int queryHtmlGoodsHDQDForInt(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsHDQDForInt(accountId);
	}

	@Override
	public int queryHtmlGoodsSMYLForInt(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsSMYLForInt(accountId);
	}

	@Override
	public List<Goods> queryGoodsList(String accountId, String categoryId, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return publicDao.queryGoodsList(accountId, categoryId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<ScoreQrcode> queryScoreQrcodeList(String accountId, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return publicDao.queryScoreQrcodeList(accountId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<HtmlGoodsSPZS> queryHtmlGoodsSPZSList(String accountId, String moduleType, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsSPZSList(accountId, moduleType, (page-1)*rows, rows, sort, order);
	}
	
	@Override
	public List<HtmlGoodsDMTZL> queryHtmlGoodsDMTZLList(String accountId, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsDMTZLList(accountId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<HtmlGoodsDMTTS> queryHtmlGoodsDMTTSList(String accountId, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsDMTTSList(accountId, (page-1)*rows, rows, sort, order);
	}
	
	@Override
	public List<HtmlGoodsJZSG> queryHtmlGoodsJZSGList(String accountId, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsJZSGList(accountId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<HtmlGoodsHDQD> queryHtmlGoodsHDQDList(String accountId, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsHDQDList(accountId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<HtmlGoodsHDQD> queryHtmlGoodsSMYLList(String accountId, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsSMYLList(accountId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<Goods> queryGoodsList(int categoryID, String accountId) {
		// TODO Auto-generated method stub
		return publicDao.queryGoodsListByCateId(categoryID,accountId);
	}

	@Override
	public int editAccountInfo(AccountMsg accountMsg) {
		// TODO Auto-generated method stub
		return publicDao.editAccountInfo(accountMsg);
	}

	@Override
	public int editJFDHJPActivity(JFDHJPActivity jfdhjpActivity) {
		// TODO Auto-generated method stub
		return publicDao.editJFDHJPActivity(jfdhjpActivity);
	}

	@Override
	public int getGoodsListByMsg() {
		AccountMsg msg=(AccountMsg)SecurityUtils.getSubject().getPrincipal();
		int a=publicDao.getGoodsListByMsg(msg);
		//TODO
		return a;
	}

	@Override
	public List<GoodsLabelSet> getGoodsLabelSetByModuleAccountId(String module, String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getGoodsLabelSetByModuleAccountId(module,accountId);
	}

	@Override
	public int queryGoodsLabelSetForInt(String accountNumber) {
		// TODO Auto-generated method stub
		return publicDao.queryGoodsLabelSetForInt(accountNumber);
	}

	@Override
	public List<GoodsLabelSet> queryGoodsLabelSetList(String accountNumber, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return publicDao.queryGoodsLabelSetList(accountNumber, (page-1)*rows, rows, sort, order);
	}

	@Override
	public GoodsLabelSet getGoodsLabelSetById(String id) {
		// TODO Auto-generated method stub
		return publicDao.getGoodsLabelSetById(id);
	}

	@Override
	public int addGoodsLabelSet(GoodsLabelSet goodsLabelSet) {
		// TODO Auto-generated method stub
		int count=0;
		String[] moduleArr= {"operation","editGoods","goodsList"};
		for (String module : moduleArr) {
			goodsLabelSet.setKey(makeLabelKey(module,goodsLabelSet.getAccountNumber()));
			goodsLabelSet.setModule(module);
			count+=publicDao.addGoodsLabelSet(goodsLabelSet);
		}
		return count;
	}
	
	public String makeLabelKey(String module, String accountNumber) {
		
		List<String> keyList=publicDao.getLabelKeyList(module,accountNumber);
		int index=1;
		String key=null;
		for (String key1 : keyList) {
			key="key"+index;
			if(key.equals(key1))
				index++;
			else
				return key;
		}
		key="key"+index;
		return key;
	}

	@Override
	public int editGoodsLabelSet(GoodsLabelSet goodsLabelSet) {
		// TODO Auto-generated method stub
		int count=0;
		count+=publicDao.editGoodsLabelSetById(goodsLabelSet);
		count+=publicDao.editOtherGoodsLabelSetNameByKeyAccountNumber(goodsLabelSet);
		return count;
	}

	@Override
	public void initGoodsLabelSet(String accountNumber) {
		// TODO Auto-generated method stub
		String[] moduleArr= {"operation","editGoods","goodsList"};
		String[] keyArr=null;
		for (String module : moduleArr) {
			switch (module) {
			case "operation":
				int addMaxSize=9;
				keyArr=new String[addMaxSize];
				keyArr[0]="goodsNumber";
				keyArr[1]="title";
				keyArr[2]="imgUrl";
				keyArr[3]="htmlContent";
				for(int i = 4;i < addMaxSize;i++) {
					keyArr[i]="key"+(i-3);
				}
				
				for (String key : keyArr) {
					if(publicDao.checkGoodsLabelExist(key,module,accountNumber)==0) {
						GoodsLabelSet gls=new GoodsLabelSet();
						gls.setKey(key);
						gls.setModule(module);
						String label=null;
						boolean isShow=false;
						int sort=0;
						if("goodsNumber".equals(key)) {
							label="商品编号";
							isShow=true;
						}
						else if("title".equals(key)) {
							label="名称";
							isShow=true;
							sort=1;
						}
						else if("imgUrl".equals(key)) {
							label="图片";
							isShow=true;
							sort=2;
						}
						else if("htmlContent".equals(key)) {
							label="文本编辑器";
							isShow=true;
							sort=3;
						}
						gls.setLabel(label);
						gls.setIsShow(isShow);
						gls.setAccountNumber(accountNumber);
						gls.setSort(sort);
						publicDao.insertGoodsLabel(gls);
					}
				}
				keyArr=null;
				break;
			case "editGoods":
				int editMaxSize=9;
				keyArr=new String[editMaxSize];
				keyArr[0]="goodsNumber";
				keyArr[1]="title";
				keyArr[2]="imgUrl";
				keyArr[3]="htmlContent";
				for(int i = 4;i < editMaxSize;i++) {
					keyArr[i]="key"+(i-3);
				}
				
				for (String key : keyArr) {
					if(publicDao.checkGoodsLabelExist(key,module,accountNumber)==0) {
						GoodsLabelSet gls=new GoodsLabelSet();
						gls.setKey(key);
						gls.setModule(module);
						String label=null;
						boolean isShow=false;
						int sort=0;
						if("goodsNumber".equals(key)) {
							label="商品编号";
							isShow=true;
						}
						else if("title".equals(key)) {
							label="名称";
							isShow=true;
							sort=1;
						}
						else if("imgUrl".equals(key)) {
							label="图片";
							isShow=true;
							sort=2;
						}
						else if("htmlContent".equals(key)) {
							label="文本编辑器";
							isShow=true;
							sort=3;
						}
						gls.setLabel(label);
						gls.setIsShow(isShow);
						gls.setAccountNumber(accountNumber);
						gls.setSort(sort);
						publicDao.insertGoodsLabel(gls);
					}
				}
				keyArr=null;
				break;
			case "goodsList":
				int listMaxSize=10;
				keyArr=new String[listMaxSize];
				keyArr[0]="goodsNumber";
				keyArr[1]="title";
				keyArr[2]="imgUrl";
				keyArr[3]="qrCode";
				keyArr[4]="id";
				for(int i = 5;i < listMaxSize;i++) {
					keyArr[i]="key"+(i-4);
				}
				
				for (String key : keyArr) {
					if(publicDao.checkGoodsLabelExist(key,module,accountNumber)==0) {
						GoodsLabelSet gls=new GoodsLabelSet();
						gls.setKey(key);
						gls.setModule(module);
						String label=null;
						boolean isShow=false;
						int sort=0;
						if("goodsNumber".equals(key)) {
							label="商品编号";
							isShow=true;
						}
						else if("title".equals(key)) {
							label="名称";
							isShow=true;
							sort=1;
						}
						else if("imgUrl".equals(key)) {
							label="图片";
							isShow=true;
							sort=2;
						}
						else if("qrCode".equals(key)) {
							label="二维码";
							isShow=true;
							sort=3;
						}
						if("id".equals(key)) {
							label="操作";
							isShow=true;
							sort=4;
						}
						gls.setLabel(label);
						gls.setIsShow(isShow);
						gls.setAccountNumber(accountNumber);
						gls.setSort(sort);
						publicDao.insertGoodsLabel(gls);//17863923662    2150902517@qq.com    http://192.168.230.1:8088/GoodsPublic/merchant/main/show?goodsNumber=00008&accountId=40
					}
				}
				keyArr=null;
				break;
			}
		}
	}

	@Override
	public Object getModuleSPZSByType(String type, String moduleType) {
		// TODO Auto-generated method stub
		
		Object obj=null;
		switch (type) {
		case "productName":
		case "spxq":
		case "image1":
		case "image2":
		case "image3":
		case "image4":
		case "embed1":
		case "memo1":
		case "memo2":
		case "memo3":
			obj = publicDao.getModuleSPZSByType(type,moduleType);
			break;
		}
		return obj;
	}
	
	@Override
	public Object getModuleDMTZLByType(String type) {
		// TODO Auto-generated method stub
		
		Object obj=null;
		switch (type) {
		case "embed1":
		case "image1":
			List<ModuleDMTZL> spxqList = publicDao.getModuleDMTZLByType(type);
			obj=spxqList;
			break;
		case "memo1":
		case "memo2":
			ModuleDMTZL moduleDMTZL = publicDao.getModuleDMTZLByMemo(type);
			obj=moduleDMTZL.getText();
			break;
		}
		return obj;
	}

	@Override
	public Object getModuleDMTTSByType(String type) {
		// TODO Auto-generated method stub

		Object obj=null;
		switch (type) {
		case "title1":
		case "title2":
		case "memo1":
			ModuleDMTTS moduleDMTTS = publicDao.getModuleDMTTSByMemo(type);
			obj=moduleDMTTS.getText();
			break;
		case "embed1":
		case "embed2":
			List<ModuleDMTTS> spxqList = publicDao.getModuleDMTTSByType(type);
			obj=spxqList;
			break;
		}
		return obj;
	}
	
	@Override
	public Object getModuleJZSGByType(String type) {
		// TODO Auto-generated method stub
		
		Object obj=null;
		switch (type) {
		case "ryxx":
		case "image1":
		case "image2":
			List<ModuleJZSG> spxqList = publicDao.getModuleJZSGByType(type);
			obj=spxqList;
			break;
		}
		return obj;
	}

	@Override
	public Object getModuleHDQDByType(String type) {
		// TODO Auto-generated method stub
		
		Object obj=null;
		switch (type) {
		case "hdap":
		case "image1":
		case "memo1":
			List<ModuleHDQD> hdqdList = publicDao.getModuleHDQDByType(type);
			obj=hdqdList;
			break;
		}
		return obj;
	}

	@Override
	public Object getModuleSMYLByType(String type) {
		// TODO Auto-generated method stub

		Object obj=null;
		switch (type) {
		case "productName":
		case "spxq":
		case "yhxx":
		case "image1":
		case "memo1":
		case "memo2":
			List<ModuleSMYL> smylList = publicDao.getModuleSMYLByType(type);
			obj=smylList;
			break;
		}
		return obj;
	}

	@Override
	public HtmlGoodsSPZS getHtmlGoodsSPZS(String moduleType, String goodsNumber, String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getHtmlGoodsSPZS(moduleType,goodsNumber,accountId);
	}
	
	@Override
	public HtmlGoodsDMTZL getHtmlGoodsDMTZL(String goodsNumber, String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getHtmlGoodsDMTZL(goodsNumber,accountId);
	}

	@Override
	public HtmlGoodsDMTTS getHtmlGoodsDMTTS(String goodsNumber, String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getHtmlGoodsDMTTS(goodsNumber,accountId);
	}
	
	@Override
	public HtmlGoodsJZSG getHtmlGoodsJZSG(String userNumber, String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getHtmlGoodsJZSG(userNumber,accountId);
	}

	@Override
	public HtmlGoodsHDQD getHtmlGoodsHDQD(String goodsNumber, String accountNumber) {
		// TODO Auto-generated method stub
		return publicDao.getHtmlGoodsHDQD(goodsNumber,accountNumber);
	}

	@Override
	public HtmlGoodsText getHtmlGoodsText(String textType, String uuid, String accountNumber) {
		// TODO Auto-generated method stub
		return publicDao.getHtmlGoodsText(textType, uuid, accountNumber);
	}

	@Override
	public ScoreQrcode getScoreQrcode(String uuid, String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getScoreQrcode(uuid,accountId);
	}

	@Override
	public int deleteScoreQrcodeByUuids(String uuids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> uuidList = Arrays.asList(uuids.split(","));
		count=publicDao.deleteScoreQrcodeByUuids(uuidList);
		/*
		if(count>0) {
			count=publicDao.deleteScoreQrcodeByExUuids(uuidList);
		}
		*/
		return count;
	}

	@Override
	public int deleteHtmlGoodsSPZSByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=publicDao.deleteHtmlGoodsSPZSByIds(idList);
		return count;
	}

	@Override
	public int deleteHtmlGoodsHDQDByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=publicDao.deleteHtmlGoodsHDQDByIds(idList);
		return count;
	}
	
	@Override
	public int deleteHtmlGoodsDMTZLByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=publicDao.deleteHtmlGoodsDMTZLByIds(idList);
		return count;
	}

	@Override
	public int deleteHtmlGoodsDMTTSByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=publicDao.deleteHtmlGoodsDMTTSByIds(idList);
		return count;
	}
	
	@Override
	public int deleteHtmlGoodsJZSGByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=publicDao.deleteHtmlGoodsJZSGByIds(idList);
		return count;
	}

	@Override
	public int deleteGoodsByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=publicDao.deleteGoodsByIds(idList);
		return count;
	}

	@Override
	public int addAccountPayRecord(AccountPayRecord accountPayRecord) {
		// TODO Auto-generated method stub
		int count=publicDao.addAccountPayRecord(accountPayRecord);
		publicDao.updateAccountPayInfo(accountPayRecord);
		return count;
	}

	@Override
	public int addCreatePayCodeRecord(CreatePayCodeRecord cpcr) {
		return publicDao.addCreatePayCodeRecord(cpcr);
	}

	@Override
	public int addJFDHJPCustomer(JFDHJPCustomer jc) {
		// TODO Auto-generated method stub
		return publicDao.addJFDHJPCustomer(jc);
	}

	@Override
	public int addPrizeCode(PrizeCode pz, Integer dhjpScore, String openId) {
		// TODO Auto-generated method stub
		int count=publicDao.addPrizeCode(pz);
		if(count>0) {
			count=publicDao.reduceJCScoreByOpenId(dhjpScore, openId);
		}
		return count;
	}

	@Override
	public int addJFDHJPActivity(JFDHJPActivity jfdhjpActivity) {
		// TODO Auto-generated method stub
		return publicDao.addJFDHJPActivity(jfdhjpActivity);
	}

	@Override
	public CreatePayCodeRecord getCreatePayCodeRecordByOutTradeNo(String outTradeNo) {
		// TODO Auto-generated method stub
		return publicDao.getCreatePayCodeRecordByOutTradeNo(outTradeNo);
	}

	@Override
	public Map<String, Object> checkIfPaid(String accountNumber) throws ParseException {
		// TODO Auto-generated method stub
		
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		boolean ifPaid=false;
		AccountPayRecord apr = publicDao.getLastAccountPayRecordByNumber(accountNumber);
		
		Date endTime=null;
		int vipType = apr.getVipType();
		switch (vipType) {
			case AccountPayRecord.FREE_TRIAL:
			case AccountPayRecord.JI_CHU:
			case AccountPayRecord.GAO_JI:
			case AccountPayRecord.HANG_YE:
				endTime = timeSDF.parse(apr.getEndTime());
				if(new Date().before(endTime)) {
					ifPaid=true;
				}
				break;
		}
		
		if(ifPaid) {
			jsonMap.put("status", "ok");
			if(vipType==AccountPayRecord.FREE_TRIAL) {
				jsonMap.put("vipType", AccountPayRecord.FREE_TRIAL);
				jsonMap.put("message", "免费试用");
			}
			else
				jsonMap.put("message", "已付过费了");
		}
		else {
			jsonMap.put("status", "no");
			jsonMap.put("message", "未付费，不能使用！");
		}
		return jsonMap;
	}

	@Override
	public int deleteLabelByKeys(String accountNumber, String keys) {
		// TODO Auto-generated method stub
		return publicDao.deleteLabelByKeys(accountNumber, keys);
	}

	@Override
	public HtmlGoodsGRMP getHtmlGoodsGRMP(String uuid) {
		// TODO Auto-generated method stub
		return publicDao.getHtmlGoodsGRMP(uuid);
	}

	@Override
	public boolean checkPassWord(String passWord, String userName) {
		// TODO Auto-generated method stub
		
		String pwd = publicDao.getAccountPwdByUserName(userName);
		if(pwd.equals(passWord)) {
			return true;
		}
		else
			return false;
	}

	@Override
	public int updatePwdByAccountId(String passWord, String id) {
		// TODO Auto-generated method stub
		return publicDao.updatePwdByAccountId(passWord,id);
	}

	@Override
	public int updatePcExcById(String id) {
		// TODO Auto-generated method stub
		return publicDao.updatePcExcById(id);
	}

	@Override
	public int updatePcLimitByAccountId(String jpmLimit, String accountNumber) {
		// TODO Auto-generated method stub
		return publicDao.updatePcLimitByAccountId(jpmLimit,accountNumber);
	}

	@Override
	public boolean checkJCOpenIdExist(String openId) {
		// TODO Auto-generated method stub
		int count=publicDao.getJCCountByOpenId(openId);
		if(count==0)
			return false;
		else
			return true;
	}

	@Override
	public JFDHJPCustomer getJCByOpenId(String openId) {
		// TODO Auto-generated method stub
		return publicDao.getJCByOpenId(openId);
	}

	@Override
	public boolean openJPDHJFRedBagByJC(ScoreQrcode sq) {
		// TODO Auto-generated method stub
		int count1=publicDao.updateSQEnableByUuid(sq.getOpenId(),sq.getUuid());
		if(count1>0) {
			ScoreQrcodeHistory sqh=new ScoreQrcodeHistory();
			sqh.setUuid(sq.getUuid());
			sqh.setCreateTime(sq.getCreateTime());
			sqh.setQrcode(sq.getQrcode());
			sqh.setShopLogo(sq.getShopLogo());
			sqh.setScore(sq.getScore());
			sqh.setAccountNumber(sq.getAccountNumber());
			sqh.setOpenId(sq.getOpenId());
			count1=publicDao.addScoreQrcodeHistory(sqh);
		}
		int count2=publicDao.addJCScoreByOpenId(sq.getScore(),sq.getOpenId());
		
		if(count1>0&&count2>0)
			return true;
		else
			return false;
	}

	@Override
	public int addScoreTakeRecord(ScoreTakeRecord str) {
		// TODO Auto-generated method stub

		int count=publicDao.updateSTRGkjfqdShow(str.getOpenId(),str.getAccountNumber());
		JFDHJPCustomer jc = publicDao.getJCByOpenId(str.getOpenId());
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		str.setUuid(uuid);
		//str.setOpenId(sq.getOpenId());
		str.setNickName(jc.getNickName());
		str.setTakeCount(jc.getTakeCount());
		//str.setTakeScore(sq.getScore());
		str.setJfye(jc.getScore());
		str.setTakeScoreSum(jc.getTakeScoreSum());
		//str.setSqUuid(sq.getUuid());
		//str.setAccountNumber(sq.getAccountNumber());
		count=publicDao.addScoreTakeRecord(str);
		return count;
	}

	@Override
	public List<String> getCSDateList(String searchTxt, String accountNumber) {
		// TODO Auto-generated method stub
		return publicDao.getCSDateList(searchTxt, accountNumber);
	}

	@Override
	public List<String> getCSDDateList(String startTime, String endTime, String accountNumber, String openId) {
		// TODO Auto-generated method stub
		return publicDao.getCSDDateList(startTime, endTime, accountNumber, openId);
	}

	@Override
	public List<Map<String, Object>> queryCustomerScoreList(String searchTxt, String accountNumber) {
		// TODO Auto-generated method stub
		return publicDao.queryCustomerScoreList(searchTxt,accountNumber);
	}

	@Override
	public List<Map<String, Object>> queryCSDetailList(String startTime, String endTime, String accountNumber,
			String openId) {
		// TODO Auto-generated method stub
		return publicDao.queryCSDetailList(startTime, endTime, accountNumber, openId);
	}

	@Override
	public JFDHJPActivity getJAByAccountId(String accountNumber) {
		// TODO Auto-generated method stub
		return publicDao.getJAByAccountId(accountNumber);
	}

	@Override
	public int editScoreQrcode(ScoreQrcode sq, Integer jaId, String jpmdhReg) {
		// TODO Auto-generated method stub
		int count=publicDao.updateScoreByQrcodeUuid(sq.getScore(),sq.getUuid());
		if(count>0) {
			if(jaId==null) {
				JFDHJPActivity jfdhjpActivity=new JFDHJPActivity();
				jfdhjpActivity.setJpmdhReg(jpmdhReg);
				jfdhjpActivity.setAccountNumber(sq.getAccountNumber());
				count=publicDao.addJFDHJPActivity(jfdhjpActivity);
			}
			else
				count=publicDao.updateJPMDHRegByAccountId(jpmdhReg,sq.getAccountNumber());
		}
		return count;
	}

	@Override
	public List<Map<String, Object>> selectAdminQrcodeList(String searchTxt, String accountNumber) {
		// TODO Auto-generated method stub
		return publicDao.selectAdminQrcodeList(searchTxt,accountNumber);
	}

	@Override
	public int updateWXQrcodeByAccountId(int wxFlag, String wxQrcode, String accountNumber) {
		// TODO Auto-generated method stub
		return publicDao.updateWXQrcodeByAccountId(wxFlag, wxQrcode, accountNumber);
	}

	@Override
	public int updateAccountOpenIdById(String openId, String id) {
		// TODO Auto-generated method stub
		return publicDao.updateAccountOpenIdById(openId,id);
	}

	@Override
	public int checkAccountOpenIdExist(String openId) {
		// TODO Auto-generated method stub
		
		int flag=0;
		int count=publicDao.getAccountCountByOpenId(openId);
		if(count>0) {
			flag=1;
		}
		else {
			AccountMsg msg=new AccountMsg();
			msg.setUserName(openId);
			AccountMsg user=userDao.getUser(msg);
			if(user==null) {
				flag=0;
			}
			else
				flag=2;
		}
		return flag;
	}

	@Override
	public AccountMsg getAccountByOpenId(String openId) {
		// TODO Auto-generated method stub
		return publicDao.getAccountByOpenId(openId);
	}

	@Override
	public int syncUserNameOpenIdById(String openId, String accountId) {
		// TODO Auto-generated method stub
		int count  =publicDao.updateAccountOpenIdById(openId,accountId);
		if(count>0) {
			AccountMsg msg=new AccountMsg();
			msg.setUserName(openId);
			AccountMsg user=userDao.getUser(msg);
			String userId = user.getId();
			publicDao.updateHGTAccoNumByUserId(accountId,userId);
			count = publicDao.deleteAccountByUserName(openId);
		}
		return count;
	}

	@Override
	public int updateAccountQCById(int qrcodeCount, String id) {
		// TODO Auto-generated method stub
		return publicDao.updateAccountQCById(qrcodeCount,id);
	}

	@Override
	public String getAccountEndTimeByNumber(String accountNumber) {
		// TODO Auto-generated method stub
		return publicDao.getAccountEndTimeByNumber(accountNumber);
	}

}
