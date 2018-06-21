package goodsPublic.dao;

import java.util.List;

import goodsPublic.entity.CategoryInfo;

public interface CategoryInfoMapper {
	//查找分类
	public List<CategoryInfo> getCategoryList(String accountId);
	//修改分类
	public int updateCategoryInfo(CategoryInfo categoryInfo);
	//删除分类
	public int deletCategoryInfo(String id);
	//添加分类
	public int saveCategoryInfo(CategoryInfo categoryInfo);
	/**
	 * 根据id查询
	 * */
	public CategoryInfo getById(String id);
}
