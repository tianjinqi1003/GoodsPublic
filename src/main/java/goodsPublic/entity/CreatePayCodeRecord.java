package goodsPublic.entity;

import java.io.Serializable;

public class CreatePayCodeRecord implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final int ONE_MONTH=1;
	public static final int THREE_MONTHS=2;
	public static final int ONE_YEAR=3;
	public static final int FOREVER=4;
	public static final int CONTINUE_MONTH=5;
	private Integer id;
	private String outTradeNo;
	private String accountNumber;
	private String phone;
	private Integer vipType;//会员类型 1.一个月 2.三个月 3.一年 4.永久 5.连续包月
	private Integer payType;
	private Float money;
	private String codeUrl;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getOutTradeNo() {
		return outTradeNo;
	}
	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Integer getVipType() {
		return vipType;
	}
	public void setVipType(Integer vipType) {
		this.vipType = vipType;
	}
	public Integer getPayType() {
		return payType;
	}
	public void setPayType(Integer payType) {
		this.payType = payType;
	}
	public Float getMoney() {
		return money;
	}
	public void setMoney(Float money) {
		this.money = money;
	}
	public String getCodeUrl() {
		return codeUrl;
	}
	public void setCodeUrl(String codeUrl) {
		this.codeUrl = codeUrl;
	}

}
