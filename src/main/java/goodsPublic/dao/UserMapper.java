package goodsPublic.dao;

import java.util.List;
import goodsPublic.entity.AccountMsg;


public interface UserMapper {
	//查询(忘记是查什么了……)
	public List<AccountMsg> getUserListByUser(AccountMsg user);
	//保存注册用户信息
	public int saveUser(AccountMsg msg);
	//通过用户信息查询用户
	public AccountMsg getUser(AccountMsg msg);
	//查询数据库中用户数量（有限定条件）
	public int getUserCount(AccountMsg msg);
}
