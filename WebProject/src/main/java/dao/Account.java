package dao;

public class Account {
	private String userID;
	private String userPW;
	
	
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	public void setUserPW(String userPW) {
		this.userPW = userPW;
	}
	
	public String getUserID() {
		return userID;
	}
	
	public String getUserPW() {
		return userPW;
	}
}
