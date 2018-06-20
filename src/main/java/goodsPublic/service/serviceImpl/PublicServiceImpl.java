package goodsPublic.service.serviceImpl;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodsPublic.util.PlanResult;

import goodsPublic.dao.PublicMapper;
import goodsPublic.entity.ShopArticleInfo;
import goodsPublic.service.PublicService;
@Service
public class PublicServiceImpl implements PublicService {
	@Autowired
	private PublicMapper publicDao;
	
	//发布商品接口，将商品保存在数据库中
	@Override
	public void publicGoods(ShopArticleInfo articleInfo, HttpServletRequest request) {
		int a=publicDao.addGoodsPublic(articleInfo);
	}
	//展示商品接口，将商品从数据库中读取出来展示到对应的页面当中
	
	//获得所有跟当前用户有关的商品列表(1代表已存在，0代表不存在)
	@Override
	public int getGoodsByGoodsNumber(String goodsNumber) {
		//查询商品列表
		ShopArticleInfo shopInfo = publicDao.getAllGoodsMsg(goodsNumber);
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
		ShopArticleInfo shopInfo = publicDao.getAllGoodsMsg(goodsNumber);
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
	
}
