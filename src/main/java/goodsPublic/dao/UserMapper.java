package goodsPublic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import goodsPublic.entity.AccountMsg;
import goodsPublic.entity.AccountPayRecord;


public interface UserMapper {
	//保存注册用户信息
	public int saveUser(AccountMsg msg);
	//通过用户信息查询用户
	public AccountMsg getUser(AccountMsg msg);
	//查询数据库中用户数量（有限定条件）
	public int getUserCount(AccountMsg msg);
	/**
	 * 查询商户数量
	 * @return
	 */
	public int queryAccountForInt();
	/**
	 * 查询商户信息
	 * @param page
	 * @param rows
	 * @param sort
	 * @param order
	 * @return
	 */
	public List<AccountMsg> queryAccountList(int start, int rows, String sort, String order);
	public int queryAprForInt(String accountId); 
	public List<AccountPayRecord> queryAprList(@Param("start") int start, @Param("rows") int rows, String sort, String order, @Param("accountId") String accountId);
	/**
	 * 更新商户状态
	 * @param id
	 * @param status
	 * @return
	 */
	public int updateAccountStatus(String id, String status);
}
