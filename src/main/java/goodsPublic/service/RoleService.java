package goodsPublic.service;
/**
 * 获取用户在系统中的角色
 * @author Administrator
 *
 */

import java.util.Set;

import org.springframework.stereotype.Service;

/**这个是用来获取用户在系统中扮演的角色
 * @author Administrator
 *
 */
@Service
public interface RoleService {
	public Set<String> getRoleListByUserId(Long userId);
}
