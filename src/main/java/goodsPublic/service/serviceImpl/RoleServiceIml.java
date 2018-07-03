package goodsPublic.service.serviceImpl;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import goodsPublic.dao.RoleMapper;
import goodsPublic.service.RoleService;
@Service
public class RoleServiceIml implements RoleService{
	@Autowired
	private RoleMapper roleMapper;

	@Override
	public Set<String> getRoleListByUserId(String userId) {
		return roleMapper.getRoleList(userId);
	}

	@Override
	public Set<String> getPermissionByUserId(String id) {
		// TODO Auto-generated method stub
		return roleMapper.getPermissions(id);
	}

}
