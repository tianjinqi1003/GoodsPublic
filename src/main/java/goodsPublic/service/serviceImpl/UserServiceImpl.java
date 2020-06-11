package goodsPublic.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.AccountPayRecord;
import goodsPublic.service.UserService;
import goodsPublic.dao.UserMapper;
/**
 * 用来处理客户信息的服务层
 * @author Administrator
 *
 */
@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;
	
	@Override
	public int saveUser(AccountMsg msg) {
		int a=userMapper.getUserCount(msg);
		if(a>0) {
			return 2;
		}
		a =userMapper.saveUser(msg);
		if(a!=0) {
			return a;
		}
		return a;
	}
	@Override
	public AccountMsg checkUser(AccountMsg user) {
		AccountMsg resultUser=userMapper.getUser(user);
		if(resultUser==null) {
			return resultUser;
		}
		return resultUser;
	}
	@Override
	public int queryAccountForInt() {
		// TODO Auto-generated method stub
		
		return userMapper.queryAccountForInt();
	}
	@Override
	public List<AccountMsg> queryAccountList(int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		
		return userMapper.queryAccountList((page-1)*rows, rows, sort, order);
	}
	@Override
	public int queryAprForInt(String accountId) {
		// TODO Auto-generated method stub
		return userMapper.queryAprForInt(accountId);
	}
	@Override
	public List<AccountPayRecord> queryAprList(int page, int rows, String sort, String order, String accountId) {
		// TODO Auto-generated method stub
		return userMapper.queryAprList((page-1)*rows, rows, sort, order, accountId);
	}
	@Override
	public int updateAccountStatus(String id, String status) {
		// TODO Auto-generated method stub
		
		return userMapper.updateAccountStatus(id,status);
	}
}
