package kr.co.cf.main.dto;

import java.sql.Date;

public class JoinDTO {
	
	private String userId;
	private String nickName;
	private String userName;
	private String email;
	private Date birthday;
	private int locationIdx;
	private String favTime;

	private String position;
	private String userPw;
	private String height;

	private String si;
	private String gu;
	private String photoName;
	private String subject;
	private String gameDate;
	private String gamePlay;
	private int userIdx;
	private String matchingIdx;
	private String categoryId;
	
	
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public int getLocationIdx() {
		return locationIdx;
	}
	public void setLocationIdx(int locationIdx) {
		this.locationIdx = locationIdx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFavTime() {
		return favTime;
	}
	public void setFavTime(String favTime) {
		this.favTime = favTime;
	}
	public String getSi() {
		return si;
	}
	public void setSi(String si) {
		this.si = si;
	}
	public String getGu() {
		return gu;
	}
	public void setGu(String gu) {
		this.gu = gu;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getGameDate() {
		return gameDate;
	}
	public void setGameDate(String gameDate) {
		this.gameDate = gameDate;
	}
	public String getGamePlay() {
		return gamePlay;
	}
	public void setGamePlay(String gamePlay) {
		this.gamePlay = gamePlay;
	}
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getMatchingIdx() {
		return matchingIdx;
	}
	public void setMatchingIdx(String matchingIdx) {
		this.matchingIdx = matchingIdx;
	}
	
	
	

}
