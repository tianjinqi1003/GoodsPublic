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
    
    private String key1;//待选属性
    
    private String key2;//待选属性
    
    private String key3;//待选属性
    
    private String key4;//待选属性
    
    private String key5;//待选属性
    
    private String key6;//待选属性
    
    private String key7;//待选属性
    
    private String key8;//待选属性
    
    private String key9;//待选属性
    
    private String key10;//待选属性
    
    private String key11;//待选属性
    
    private String key12;//待选属性
    
    private String key13;//待选属性
    
    private String key14;//待选属性
    
    private String key15;//待选属性
    
    private String key16;//待选属性
    
    private String key17;//待选属性
    
    private String key18;//待选属性
    
    private String key19;//待选属性
    
    private String key20;//待选属性
    
    private String key21;//待选属性
    
    private String key22;//待选属性
    
    private String key23;//待选属性
    
    private String key24;//待选属性
    
    private String key25;//待选属性
    
    private String key26;//待选属性
    
    private String key27;//待选属性
    
    private String key28;//待选属性
    
    private String key29;//待选属性
    
    private String key30;//待选属性
    
    private String key31;//待选属性
    
    private String key32;//待选属性
    
    private String key33;//待选属性
    
    private String key34;//待选属性
    
    private String key35;//待选属性
    
    private String key36;//待选属性
    
    private String key37;//待选属性
    
    private String key38;//待选属性
    
    private String key39;//待选属性
    
    private String key40;//待选属性
    
    private String key41;//待选属性
    
    private String key42;//待选属性
    
    private String key43;//待选属性
    
    private String key44;//待选属性
    
    private String key45;//待选属性
    
    private String key46;//待选属性

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

    public String getKey1() {
		return key1;
	}

	public void setKey1(String key1) {
		this.key1 = key1;
	}

	public String getKey2() {
		return key2;
	}

	public void setKey2(String key2) {
		this.key2 = key2;
	}

	public String getKey3() {
		return key3;
	}

	public void setKey3(String key3) {
		this.key3 = key3;
	}

	public String getKey4() {
		return key4;
	}

	public void setKey4(String key4) {
		this.key4 = key4;
	}

	public String getKey5() {
		return key5;
	}

	public void setKey5(String key5) {
		this.key5 = key5;
	}

	public String getKey6() {
		return key6;
	}

	public void setKey6(String key6) {
		this.key6 = key6;
	}

	public String getKey7() {
		return key7;
	}

	public void setKey7(String key7) {
		this.key7 = key7;
	}

	public String getKey8() {
		return key8;
	}

	public void setKey8(String key8) {
		this.key8 = key8;
	}

	public String getKey9() {
		return key9;
	}

	public void setKey9(String key9) {
		this.key9 = key9;
	}

	public String getKey10() {
		return key10;
	}

	public void setKey10(String key10) {
		this.key10 = key10;
	}

	public String getKey11() {
		return key11;
	}

	public void setKey11(String key11) {
		this.key11 = key11;
	}

	public String getKey12() {
		return key12;
	}

	public void setKey12(String key12) {
		this.key12 = key12;
	}

	public String getKey13() {
		return key13;
	}

	public void setKey13(String key13) {
		this.key13 = key13;
	}

	public String getKey14() {
		return key14;
	}

	public void setKey14(String key14) {
		this.key14 = key14;
	}

	public String getKey15() {
		return key15;
	}

	public void setKey15(String key15) {
		this.key15 = key15;
	}

	public String getKey16() {
		return key16;
	}

	public void setKey16(String key16) {
		this.key16 = key16;
	}

	public String getKey17() {
		return key17;
	}

	public void setKey17(String key17) {
		this.key17 = key17;
	}

	public String getKey18() {
		return key18;
	}

	public void setKey18(String key18) {
		this.key18 = key18;
	}

	public String getKey19() {
		return key19;
	}

	public void setKey19(String key19) {
		this.key19 = key19;
	}

	public String getKey20() {
		return key20;
	}

	public void setKey20(String key20) {
		this.key20 = key20;
	}

	public String getKey21() {
		return key21;
	}

	public void setKey21(String key21) {
		this.key21 = key21;
	}

	public String getKey22() {
		return key22;
	}

	public void setKey22(String key22) {
		this.key22 = key22;
	}

	public String getKey23() {
		return key23;
	}

	public void setKey23(String key23) {
		this.key23 = key23;
	}

	public String getKey24() {
		return key24;
	}

	public void setKey24(String key24) {
		this.key24 = key24;
	}

	public String getKey25() {
		return key25;
	}

	public void setKey25(String key25) {
		this.key25 = key25;
	}

	public String getKey26() {
		return key26;
	}

	public void setKey26(String key26) {
		this.key26 = key26;
	}

	public String getKey27() {
		return key27;
	}

	public void setKey27(String key27) {
		this.key27 = key27;
	}

	public String getKey28() {
		return key28;
	}

	public void setKey28(String key28) {
		this.key28 = key28;
	}

	public String getKey29() {
		return key29;
	}

	public void setKey29(String key29) {
		this.key29 = key29;
	}

	public String getKey30() {
		return key30;
	}

	public void setKey30(String key30) {
		this.key30 = key30;
	}

	public String getKey31() {
		return key31;
	}

	public void setKey31(String key31) {
		this.key31 = key31;
	}

	public String getKey32() {
		return key32;
	}

	public void setKey32(String key32) {
		this.key32 = key32;
	}

	public String getKey33() {
		return key33;
	}

	public void setKey33(String key33) {
		this.key33 = key33;
	}

	public String getKey34() {
		return key34;
	}

	public void setKey34(String key34) {
		this.key34 = key34;
	}

	public String getKey35() {
		return key35;
	}

	public void setKey35(String key35) {
		this.key35 = key35;
	}

	public String getKey36() {
		return key36;
	}

	public void setKey36(String key36) {
		this.key36 = key36;
	}

	public String getKey37() {
		return key37;
	}

	public void setKey37(String key37) {
		this.key37 = key37;
	}

	public String getKey38() {
		return key38;
	}

	public void setKey38(String key38) {
		this.key38 = key38;
	}

	public String getKey39() {
		return key39;
	}

	public void setKey39(String key39) {
		this.key39 = key39;
	}

	public String getKey40() {
		return key40;
	}

	public void setKey40(String key40) {
		this.key40 = key40;
	}

	public String getKey41() {
		return key41;
	}

	public void setKey41(String key41) {
		this.key41 = key41;
	}

	public String getKey42() {
		return key42;
	}

	public void setKey42(String key42) {
		this.key42 = key42;
	}

	public String getKey43() {
		return key43;
	}

	public void setKey43(String key43) {
		this.key43 = key43;
	}

	public String getKey44() {
		return key44;
	}

	public void setKey44(String key44) {
		this.key44 = key44;
	}

	public String getKey45() {
		return key45;
	}

	public void setKey45(String key45) {
		this.key45 = key45;
	}

	public String getKey46() {
		return key46;
	}

	public void setKey46(String key46) {
		this.key46 = key46;
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
