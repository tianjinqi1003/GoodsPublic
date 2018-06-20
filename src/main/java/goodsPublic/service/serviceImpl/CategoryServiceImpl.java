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
		categoryInfoMapper.getCategoryInfo(accountId);
		return null;
	}
	@Override
	public int addCategory(CategoryInfo categoryInfo) {
		categoryInfoMapper.saveCategoryInfo(categoryInfo);
		return 0;
	}

}
