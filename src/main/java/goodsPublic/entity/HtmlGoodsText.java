package goodsPublic.entity;

import java.io.Serializable;

public class HtmlGoodsText implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final int TEXT = 1;
	public static final int URL = 2;
	private String uuid;
	private String text;
	private String gmtCreate;
	private String qrcode;
	private Integer textType;
	private String accountNumber;
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getGmtCreate() {
		return gmtCreate;
	}
	public void setGmtCreate(String gmtCreate) {
		this.gmtCreate = gmtCreate;
	}
	public String getQrcode() {
		return qrcode;
	}
	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}
	public Integer getTextType() {
		return textType;
	}
	public void setTextType(Integer textType) {
		this.textType = textType;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

}
