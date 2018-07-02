package goodsPublic.entity;

public class AccountMsg {
	private String id;
	private String userName;
	private String passWord;
	private String nickName;
	private String passWord1;
	private String phone;
	private String email;
	private String createTime;
	private String createUser;
	private String avatar_img;
	private String companyName;
	private String companyAddress;
	private String postcode;
	private String quotient;
	private String fax;
	private String countCode;
	private String recordNumber;
	private String accountStatus;
	
	public String getAccountStatus() {
		return accountStatus;
	}
	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}
	public String getAvatar_img() {
		return avatar_img;
	}
	public void setAvatar_img(String avatar_img) {
		this.avatar_img = avatar_img;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCompanyAddress() {
		return companyAddress;
	}
	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getQuotient() {
		return quotient;
	}
	public void setQuotient(String quotient) {
		this.quotient = quotient;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getCountCode() {
		return countCode;
	}
	public void setCountCode(String countCode) {
		this.countCode = countCode;
	}
	public String getRecordNumber() {
		return recordNumber;
	}
	public void setRecordNumber(String recordNumber) {
		this.recordNumber = recordNumber;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getPassWord1() {
		return passWord1;
	}
	public void setPassWord1(String passWord1) {
		this.passWord1 = passWord1;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	@Override
	public String toString() {
		return "AccountMsg [userName=" + userName + ", passWord=" + passWord + ", nickName=" + nickName + ", passWord1="
				+ passWord1 + ", phone=" + phone + ", email=" + email + ", createTime=" + createTime + ", createUser="
				+ createUser + "]";
	}
	
	
}
