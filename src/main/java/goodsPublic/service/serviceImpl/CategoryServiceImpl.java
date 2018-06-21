package goodsPublic.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import goodsPublic.dao.CategoryInfoMapper;
import goodsPublic.entity.CategoryInfo;
import goodsPublic.service.CategoryService;
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
	@Override
	public CategoryInfo getById(String id) {
		// TODO Auto-generated method stub
		return categoryInfoMapper.getById(id);
	}
	@Override
	public int deletCategoryInfo(String id) {
		// TODO Auto-generated method stub
		return categoryInfoMapper.deletCategoryInfo(id);
	}

}
