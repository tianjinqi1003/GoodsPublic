package goodsPublic.entity;

import java.io.Serializable;

public class JFDHJPCustomer implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String openId;
	private String nickName;
	private String createTime;
	private Integer takeCount;//消费次数
	private Integer takeScoreSum;//消费总积分
	private Integer score;//剩余积分
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getTakeCount() {
		return takeCount;
	}
	public void setTakeCount(Integer takeCount) {
		this.takeCount = takeCount;
	}
	public Integer getTakeScoreSum() {
		return takeScoreSum;
	}
	public void setTakeScoreSum(Integer takeScoreSum) {
		this.takeScoreSum = takeScoreSum;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}

}
