package goodsPublic.service.serviceImpl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.swing.filechooser.FileSystemView;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodsPublic.util.JsonUtil;
import com.goodsPublic.util.PlanResult;
import com.goodsPublic.util.qrcode.Qrcode;

import goodsPublic.dao.CategoryInfoMapper;
import goodsPublic.dao.PublicMapper;
import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.Goods;
import goodsPublic.service.PublicService;
@Service
public class PublicServiceImpl implements PublicService {
	@Autowired
	private PublicMapper publicDao;
	@Autowired
	private CategoryInfoMapper categoryInfoDao;
	
	//发布商品接口，将商品保存在数据库中
	@Override
	public void publicGoods(Goods goods, HttpServletRequest request) {
		int a=publicDao.addGoodsPublic(goods);
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
	public int editCategory(CategoryInfo categoryInfo) {
		// TODO Auto-generated method stub
		
		int count=0;
		if(StringUtils.isEmpty(categoryInfo.getId()))
			count=categoryInfoDao.saveCategoryInfo(categoryInfo);
		else
			count=categoryInfoDao.updateCategoryInfo(categoryInfo);
		return count;
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
	public List<Goods> queryGoodsList(String accountMsgId, String categoryId) {
		// TODO Auto-generated method stub
		
		return publicDao.queryGoodsList(accountMsgId,categoryId);
	}

	@Override
	public Goods getGoodsById(String id) {
		// TODO Auto-generated method stub
		
		return publicDao.getGoodsById(id);
	}

	@Override
	public int editGoods(Goods goods) {
		// TODO Auto-generated method stub
		
		return publicDao.updateGoods(goods);
	}

	@Override
	public AccountMsg getAccountById(String accountId) {
		// TODO Auto-generated method stub
		return publicDao.getAccountById(accountId);
	}
	
}
