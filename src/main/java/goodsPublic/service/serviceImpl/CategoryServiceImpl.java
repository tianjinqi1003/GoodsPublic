package goodsPublic.service.serviceImpl;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import goodsPublic.dao.CategoryInfoMapper;
import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.service.CategoryService;
/**
 * 这个是主要负责分类操作的服务层
 * @author Administrator
 *
 */
@Service
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	private CategoryInfoMapper categoryInfoMapper;
	@Override
	public List<CategoryInfo> getCategory(String accountId) {
		List<CategoryInfo> list = categoryInfoMapper.getCategoryList(accountId);
		return list;
	}
	@Override
	public int addCategory(CategoryInfo categoryInfo) {
		categoryInfoMapper.saveCategoryInfo(categoryInfo);
		return 0;
	}
	/*
	@Override
	public CategoryInfo getById(String id) {
		return categoryInfoMapper.getById(id);
	}
	*/
	@Override
	public int deletCategoryInfo(String ids, HttpSession session) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=categoryInfoMapper.deletCategoryInfo(idList);
		//提取已经登录的用户信息
		AccountMsg resultUser=(AccountMsg) session.getAttribute("user");
		//通过用户信息查询对应店铺的分类信息
		List<CategoryInfo> cateList=categoryInfoMapper.getCategoryList(resultUser.getId());
		//将分类信息进行保存
		session.setAttribute("categoryList", cateList);
		return count;
	}
	@Override
	public int editCategory(CategoryInfo categoryInfo,HttpSession session) {
		// TODO 针对分类实时动态的调整（未测）
		int count=0;
		if(StringUtils.isEmpty(categoryInfo.getId())) {
			CategoryInfo resultCate=categoryInfoMapper.getByCategoryId(categoryInfo.getCategoryId());
			if(resultCate==null) {
				count=categoryInfoMapper.saveCategoryInfo(categoryInfo);
				List<CategoryInfo> catList = categoryInfoMapper.getCategoryList(categoryInfo.getAccountId());
				session.setAttribute("categoryList", catList);
				return count;
			}
			//当分类id重复时返回2表示分类已存在
			return 2;
		}else{
			count=categoryInfoMapper.updateCategoryInfo(categoryInfo);
			List<CategoryInfo> catList = categoryInfoMapper.getCategoryList(categoryInfo.getAccountId());
			session.setAttribute("categoryList", catList);
		}
		return count;
	}

}
