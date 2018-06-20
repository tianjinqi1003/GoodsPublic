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
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	@Override
	public String toString() {
		return "AccountMsg [userName=" + userName + ", passWord=" + passWord + ", nickName=" + nickName + ", passWord1="
				+ passWord1 + ", phone=" + phone + ", email=" + email + ", createTime=" + createTime + ", createUser="
				+ createUser + "]";
	}
	
	
}
