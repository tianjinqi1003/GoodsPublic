package goodsPublic.entity;

import java.io.Serializable;

public class JFDHJPActivity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private Integer dhjpScore;
	private String jpmLimit;
	private String jpmdhReg;
	private String endTime;
	private Integer accountNumber;
	private Boolean enable;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getDhjpScore() {
		return dhjpScore;
	}
	public void setDhjpScore(Integer dhjpScore) {
		this.dhjpScore = dhjpScore;
	}
	public String getJpmLimit() {
		return jpmLimit;
	}
	public void setJpmLimit(String jpmLimit) {
		this.jpmLimit = jpmLimit;
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
	public Boolean getEnable() {
		return enable;
	}
	public void setEnable(Boolean enable) {
		this.enable = enable;
	}

}
