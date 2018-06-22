package goodsPublic.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.LoginUser;
import goodsPublic.service.UserService;
import goodsPublic.dao.UserMapper;
@Service
public class UserServiceImpl implements UserService {
	private final static String userRole="a"; 
	@Autowired
	private UserMapper userMapper;
	@Override
	public List<AccountMsg> getUserList() {
		AccountMsg user=new AccountMsg();
		List<AccountMsg> list=userMapper.getUserListByUser(user);
		return list;
	}
	@Override
	 public AccountMsg getUserLogin(AccountMsg user) {  
	        List<AccountMsg> list = userMapper.getUserListByUser(user);  
	        if(list.size() == 0){  
	            return null;  
	        }else{  
	        	for(AccountMsg info:list) {
	        		if(info.getPassWord().equals(user.getPassWord())) {
	        			 return info; 
	        		}else{  
		                return null;  
		            } 
	        	}
	        }
	        return null;
	    }
	@Override
	public int saveUser(AccountMsg msg) {
		AccountMsg msg1=userMapper.getUser(msg);
		if(msg1!=null) {
			return 2;
		}
		int a =userMapper.saveUser(msg);
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
}
