package goodsPublic.entity;

import java.io.Serializable;

public class ScoreQrcodeHistory implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String uuid;
	private String createTime;
	private String qrcode;
	private String shopLogo;
	private Integer score;
	private Integer dhjpScore;
	private String jpmdhReg;
	private String endTime;
	private Integer accountNumber;
	private String openId;
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getQrcode() {
		return qrcode;
	}
	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}
	public String getShopLogo() {
		return shopLogo;
	}
	public void setShopLogo(String shopLogo) {
		this.shopLogo = shopLogo;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
	}
	public Integer getDhjpScore() {
		return dhjpScore;
	}
	public void setDhjpScore(Integer dhjpScore) {
		this.dhjpScore = dhjpScore;
	}
	public String getJpmdhReg() {
		return jpmdhReg;
	}
	public void setJpmdhReg(String jpmdhReg) {
		this.jpmdhReg = jpmdhReg;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public Integer getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(Integer accountNumber) {
		this.accountNumber = accountNumber;
	}
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}

}
