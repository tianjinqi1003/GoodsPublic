package goodsPublic.entity;

import java.io.Serializable;

public class ScoreTakeRecord implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String uuid;
	private String openId;
	private String nickName;
	private Integer takeCount;
	private Integer takeScore;
	private Integer jfye;
	private Integer takeScoreSum;
	private String createTime;
	private String sqUuid;
	private Integer accountNumber;
	private Boolean gkjfqdShow;
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
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
	public Integer getTakeCount() {
		return takeCount;
	}
	public void setTakeCount(Integer takeCount) {
		this.takeCount = takeCount;
	}
	public Integer getTakeScore() {
		return takeScore;
	}
	public void setTakeScore(Integer takeScore) {
		this.takeScore = takeScore;
	}
	public Integer getJfye() {
		return jfye;
	}
	public void setJfye(Integer jfye) {
		this.jfye = jfye;
	}
	public Integer getTakeScoreSum() {
		return takeScoreSum;
	}
	public void setTakeScoreSum(Integer takeScoreSum) {
		this.takeScoreSum = takeScoreSum;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getSqUuid() {
		return sqUuid;
	}
	public void setSqUuid(String sqUuid) {
		this.sqUuid = sqUuid;
	}
	public Integer getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(Integer accountNumber) {
		this.accountNumber = accountNumber;
	}
	public Boolean getGkjfqdShow() {
		return gkjfqdShow;
	}
	public void setGkjfqdShow(Boolean gkjfqdShow) {
		this.gkjfqdShow = gkjfqdShow;
	}

}
