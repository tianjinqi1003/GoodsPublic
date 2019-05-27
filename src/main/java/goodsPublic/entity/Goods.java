package goodsPublic.entity;

import java.io.Serializable;

//平台资讯显示
public class Goods implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int id;//主键

	private String title;//产品名称

    private String imgUrl;//产品缩略图地址
    
	private String qrCode;//二维码缩略图地址

	private String accountNumber; //商户编号

	private String goodsNumber; //产品编号

    private String htmlContent;//产品描述

    private String gmt_create;  //创建时间

	private String gmt_modified;//修改时间

	private int status;//备用状态码
    
    private Integer category_id;//类别id
	
    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
    
	public Integer getCategory_id() {
		return category_id;
	}

	public void setCategory_id(Integer category_id) {
		this.category_id = category_id;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
	
	public String getGoodsNumber() {
		return goodsNumber;
	}

	public void setGoodsNumber(String goodsNumber) {
		this.goodsNumber = goodsNumber;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

    public String getQrCode() {
		return qrCode;
	}

	public void setQrCode(String qrCode) {
		this.qrCode = qrCode;
	}

	public String getHtmlContent() {
		return htmlContent;
	}

	public void setHtmlContent(String htmlContent) {
		this.htmlContent = htmlContent;
	}
    
    public String getGmt_create() {
		return gmt_create;
	}

	public void setGmt_create(String gmt_create) {
		this.gmt_create = gmt_create;
	}

    public String getGmt_modified() {
		return gmt_modified;
	}

	public void setGmt_modified(String gmt_modified) {
		this.gmt_modified = gmt_modified;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Goods [title=" + title + ", imgUrl=" + imgUrl + ", goodsNumber=" + goodsNumber
				+ ", htmlContent=" + htmlContent + ", gmt_create=" + gmt_create + ", gmt_modified=" + gmt_modified + ", status="
				+ status + "]";
	}
}
