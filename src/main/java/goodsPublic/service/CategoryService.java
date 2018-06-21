package goodsPublic.service;

import java.util.List;

import goodsPublic.entity.CategoryInfo;

public interface CategoryService {
	//根据商家id获取分类
	public List<CategoryInfo> getCategory(String accountId);
	//增加分类
	public int addCategory(CategoryInfo categoryInfo);
	/**
	 * 根据id查询
	 * */
	public CategoryInfo getById(String id);
	/**
	 * 删除类别
	 * @param id
	 * @return
	 */
	public int deletCategoryInfo(String id);
}
