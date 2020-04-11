package goodsPublic.entity;

import java.io.Serializable;

public class ScoreQrcode implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String uuid;
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
	public Boolean getEnable() {
		return enable;
	}
	public void setEnable(Boolean enable) {
		this.enable = enable;
	}
	public Boolean getExample() {
		return example;
	}
	public void setExample(Boolean example) {
		this.example = example;
	}
	public Boolean getJfewmlbShow() {
		return jfewmlbShow;
	}
	public void setJfewmlbShow(Boolean jfewmlbShow) {
		this.jfewmlbShow = jfewmlbShow;
	}
	public String getExUuid() {
		return exUuid;
	}
	public void setExUuid(String exUuid) {
		this.exUuid = exUuid;
	}
	private String createTime;
	private String qrcode;
	private String shopLogo;
	private Integer score;
	private Integer accountNumber;
	private String openId;
	private Boolean enable;
	private Boolean example;
	private Boolean jfewmlbShow;
	private String exUuid;

}