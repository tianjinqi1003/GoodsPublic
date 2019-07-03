package goodsPublic.service.serviceImpl;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodsPublic.util.PlanResult;
import com.goodsPublic.util.qrcode.Qrcode;

import goodsPublic.dao.PublicMapper;
import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.Goods;
import goodsPublic.entity.GoodsLabelSet;
import goodsPublic.entity.HtmlGoodsDMTZL;
import goodsPublic.entity.HtmlGoodsJZSG;
import goodsPublic.entity.HtmlGoodsSPZS;
import goodsPublic.entity.ModuleDMTZL;
import goodsPublic.entity.ModuleJZSG;
import goodsPublic.entity.ModuleSPZS;
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
	public int addHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoods) {
		// TODO Auto-generated method stub
		return publicDao.addHtmlGoodsJZSG(htmlGoods);
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
	public int editHtmlGoodsJZSG(HtmlGoodsJZSG htmlGoodsJZSG) {
		// TODO Auto-generated method stub
		return publicDao.editHtmlGoodsJZSG(htmlGoodsJZSG);
	}
	
	//展示商品接口，将商品从数据库中读取出来展示到对应的页面当中
	
	//获得所有跟当前用户有关的商品列表(1代表已存在，0代表不存在)
	@Override
	public int getGoodsByGoodsNumber(String goodsNumber) {
		//查询商品列表
		Goods shopInfo = publicDao.getAllGoodsMsg(goodsNumber);
		if(shopInfo!=null) {
			if(goodsNumber.equals(shopInfo.getGoodsNumber())) {
				return 1;
			}
			return 0;
		}
		return 0;
	}

	@Override
	public PlanResult getGoodsByGN(String goodsNumber) {
		PlanResult plan=new PlanResult();
		Goods shopInfo = publicDao.getAllGoodsMsg(goodsNumber);
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
	public void createShowUrlQrcode(String url, String goodsNumber) {
		// TODO Auto-generated method stub

        String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ".jpg";
		String avaPath="/GoodsPublic/upload/"+fileName;
		if(publicDao.updateQrcode(avaPath,goodsNumber)>0) {
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
	public int queryHtmlGoodsSPZSForInt(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsSPZSForInt(accountId);
	}
	
	@Override
	public int queryHtmlGoodsDMTZLForInt(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsDMTZLForInt(accountId);
	}
	
	@Override
	public int queryHtmlGoodsJZSGForInt(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsJZSGForInt(accountId);
	}

	@Override
	public List<Goods> queryGoodsList(String accountId, String categoryId, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return publicDao.queryGoodsList(accountId, categoryId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<HtmlGoodsSPZS> queryHtmlGoodsSPZSList(String accountId, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsSPZSList(accountId, (page-1)*rows, rows, sort, order);
	}
	
	@Override
	public List<HtmlGoodsDMTZL> queryHtmlGoodsDMTZLList(String accountId, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsDMTZLList(accountId, (page-1)*rows, rows, sort, order);
	}
	
	@Override
	public List<HtmlGoodsJZSG> queryHtmlGoodsJZSGList(String accountId, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return publicDao.queryHtmlGoodsJZSGList(accountId, (page-1)*rows, rows, sort, order);
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
		int maxSize=51;
		String[] keyArr=null;
		for (String module : moduleArr) {
			switch (module) {
			case "operation":
				keyArr=new String[maxSize];
				keyArr[0]="category_id";
				keyArr[1]="goodsNumber";
				keyArr[2]="title";
				keyArr[3]="imgUrl";
				keyArr[4]="htmlContent";
				for(int i = 5;i < maxSize;i++) {
					keyArr[i]="key"+(i-4);
				}
				
				for (String key : keyArr) {
					if(publicDao.checkGoodsLabelExist(key,module,accountNumber)==0)
						publicDao.insertGoodsLabel(key,module,accountNumber);
				}
				keyArr=null;
				break;
			case "editGoods":
				keyArr=new String[maxSize];
				keyArr[0]="category_id";
				keyArr[1]="goodsNumber";
				keyArr[2]="title";
				keyArr[3]="imgUrl";
				keyArr[4]="htmlContent";
				for(int i = 5;i < maxSize;i++) {
					keyArr[i]="key"+(i-4);
				}
				
				for (String key : keyArr) {
					if(publicDao.checkGoodsLabelExist(key,module,accountNumber)==0)
						publicDao.insertGoodsLabel(key,module,accountNumber);
				}
				keyArr=null;
				break;
			case "goodsList":
				keyArr=new String[maxSize];
				keyArr[0]="category_id";
				keyArr[1]="goodsNumber";
				keyArr[2]="title";
				keyArr[3]="imgUrl";
				keyArr[4]="qrCode";
				keyArr[5]="id";
				for(int i = 6;i < maxSize;i++) {
					keyArr[i]="key"+(i-5);
				}
				
				for (String key : keyArr) {
					if(publicDao.checkGoodsLabelExist(key,module,accountNumber)==0)
						publicDao.insertGoodsLabel(key,module,accountNumber);
				}
				keyArr=null;
				break;
			}
		}
	}

	@Override
	public Object getModuleSPZSByType(String type) {
		// TODO Auto-generated method stub
		
		Object obj=null;
		switch (type) {
		case "spxq":
		case "image1":
		case "image2":
		case "image3":
			List<ModuleSPZS> spxqList = publicDao.getModuleSPZSBySPXQ(type);
			obj=spxqList;
			break;
		case "memo1":
		case "memo2":
		case "memo3":
			ModuleSPZS moduleSPZS = publicDao.getModuleSPZSByMemo(type);
			obj=moduleSPZS.getValue();
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
	public HtmlGoodsSPZS getHtmlGoodsSPZS(String goodsNumber, String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getHtmlGoodsSPZS(goodsNumber,accountId);
	}
	
	@Override
	public HtmlGoodsDMTZL getHtmlGoodsDMTZL(String goodsNumber, String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getHtmlGoodsDMTZL(goodsNumber,accountId);
	}
	
	@Override
	public HtmlGoodsJZSG getHtmlGoodsJZSG(String userNumber, String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getHtmlGoodsJZSG(userNumber,accountId);
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
	public int deleteHtmlGoodsDMTZLByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=publicDao.deleteHtmlGoodsDMTZLByIds(idList);
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

}
