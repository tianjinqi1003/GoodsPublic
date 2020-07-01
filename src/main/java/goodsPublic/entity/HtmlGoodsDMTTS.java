package goodsPublic.entity;

import java.io.Serializable;

public class HtmlGoodsDMTTS implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String title1;
	private String title2;
	private String memo1;
	private String embed1_1;
	private String embed2_1;
	private String qrCode;
	private String gmtCreate;
	private String gmtModified;
	private String goodsNumber;
	private String accountNumber;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle1() {
		return title1;
	}
	public void setTitle1(String title1) {
		this.title1 = title1;
	}
	public String getTitle2() {
		return title2;
	}
	public void setTitle2(String title2) {
		this.title2 = title2;
	}
	public String getMemo1() {
		return memo1;
	}
	public void setMemo1(String memo1) {
		this.memo1 = memo1;
	}
	public String getEmbed1_1() {
		return embed1_1;
	}
	public void setEmbed1_1(String embed1_1) {
		this.embed1_1 = embed1_1;
	}
	public String getEmbed2_1() {
		return embed2_1;
	}
	public void setEmbed2_1(String embed2_1) {
		this.embed2_1 = embed2_1;
	}
	public String getQrCode() {
		return qrCode;
	}
	public void setQrCode(String qrCode) {
		this.qrCode = qrCode;
	}
	public String getGmtCreate() {
		return gmtCreate;
	}
	public void setGmtCreate(String gmtCreate) {
		this.gmtCreate = gmtCreate;
	}
	public String getGmtModified() {
		return gmtModified;
	}
	public void setGmtModified(String gmtModified) {
		this.gmtModified = gmtModified;
	}
	public String getGoodsNumber() {
		return goodsNumber;
	}
	public void setGoodsNumber(String goodsNumber) {
		this.goodsNumber = goodsNumber;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

}
