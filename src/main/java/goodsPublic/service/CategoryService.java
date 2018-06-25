package goodsPublic.service;

import java.util.List;

import javax.servlet.http.HttpSession;

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
	 * @param ids
	 * @return
	 */
	public int deletCategoryInfo(String ids);
	/**
	 * 编辑类别
	 * @param categoryInfo
	 * @return
	 */
	int editCategory(CategoryInfo categoryInfo, HttpSession session);
}
