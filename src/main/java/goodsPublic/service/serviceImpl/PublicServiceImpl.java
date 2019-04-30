package goodsPublic.service.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodsPublic.util.PlanResult;
import com.goodsPublic.util.qrcode.Qrcode;

import goodsPublic.dao.CategoryInfoMapper;
import goodsPublic.dao.PublicMapper;
import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.entity.Goods;
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
	public int editGoods(Goods goods) {
		// TODO Auto-generated method stub
		
		return publicDao.updateGoods(goods);
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
	public List<Goods> queryGoodsList(String accountId, String categoryId, int page, int rows, String sort,
			String order) {
		// TODO Auto-generated method stub
		return publicDao.queryGoodsList(accountId, categoryId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public List<Goods> queryGoodsList(int categoryID) {
		// TODO Auto-generated method stub
		return publicDao.queryGoodsListByCateId(categoryID);
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

}
