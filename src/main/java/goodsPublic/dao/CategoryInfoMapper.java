package goodsPublic.dao;

import goodsPublic.entity.CategoryInfo;

public interface CategoryInfoMapper {
	//查找分类
	public CategoryInfo getCategoryInfo(String accountId);
	//修改分类
	public int updataCategoryInfo(CategoryInfo categoryInfo);
	//删除分类
	public int deletCategoryInfo();
	//添加分类
	public int saveCategoryInfo(CategoryInfo categoryInfo);
}
