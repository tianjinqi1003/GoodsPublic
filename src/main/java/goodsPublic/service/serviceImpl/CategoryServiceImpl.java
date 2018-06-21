package goodsPublic.service.serviceImpl;

import java.util.Arrays;
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
		return categoryInfoMapper.getById(id);
	}
	@Override
<<<<<<< HEAD
	public int deletCategoryInfo(String ids) {
		// TODO Auto-generated method stub
		List<String> idList = Arrays.asList(ids.split(","));
		return categoryInfoMapper.deletCategoryInfo(idList);
=======
	public int deletCategoryInfo(String id) {
		return categoryInfoMapper.deletCategoryInfo(id);
>>>>>>> 70adeb36274a454c5592f37a2adcb116ef83bd85
	}

}
