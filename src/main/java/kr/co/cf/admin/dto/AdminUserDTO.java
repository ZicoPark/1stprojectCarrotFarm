package kr.co.cf.admin.dto;

import java.sql.Date;

public class AdminUserDTO {
	private String userId;
	private String nickname;
	private String userName;
	private int userIdx;
	private String userJoinDate;
	private String teamName;
	private String email;
	private String photoName;

	private String userState;
	public String getUserState() {
		return userState;
	}
	public void setUserState(String userState) {
		this.userState = userState;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public String getUserId() {
		return userId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickName(String nickname) {
		this.nickname = nickname;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getUserJoinDate() {
		return userJoinDate;
	}
	public void setUserJoinDate(String userJoinDate) {
		this.userJoinDate = userJoinDate;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	
	
}
