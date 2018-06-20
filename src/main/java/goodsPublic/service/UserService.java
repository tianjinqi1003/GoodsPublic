package goodsPublic.service;

import java.util.List;

import goodsPublic.entity.AccountMsg;

public interface UserService {
	//获取所有用户信息
	public List<AccountMsg> getUserList();
	//通过信息查找对应的账户
	public AccountMsg getUserLogin(AccountMsg user);
	//检查账户信息
	public int checkUser(AccountMsg user);
	//用户注册保存
	public int saveUser(AccountMsg msg);
	//用户之间的传递操作
}
