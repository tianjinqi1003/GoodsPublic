package goodsPublic.entity;

import java.io.Serializable;

//平台资讯显示
public class ShopArticleInfo implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    private String title;//产品名称

    private String imgUrl;//产品缩略图地址

    private String goodsNumber; //产品编号

    private String htmlContent;//产品描述

    private String createTime;  //创建时间
    
    private String modified;//修改时间

    private int status;//备用状态码
    
    private int categoryId;//类别id
    
	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getGoodsNumber() {
		return goodsNumber;
	}

	public void setGoodsNumber(String goodsNumber) {
		this.goodsNumber = goodsNumber;
	}

	public String getModified() {
		return modified;
	}

	public void setModified(String modified) {
		this.modified = modified;
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


	public String getHtmlContent() {
		return htmlContent;
	}

	public void setHtmlContent(String htmlContent) {
		this.htmlContent = htmlContent;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
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
		return "ShopArticleInfo [title=" + title + ", imgUrl=" + imgUrl + ", goodsNumber=" + goodsNumber
				+ ", htmlContent=" + htmlContent + ", createTime=" + createTime + ", modified=" + modified + ", status="
				+ status + "]";
	}
}
