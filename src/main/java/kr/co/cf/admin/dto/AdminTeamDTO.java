package kr.co.cf.admin.dto;

public class AdminTeamDTO {
	private int teamIdx;
	private boolean teamDisband;
	private String teamName;
	private String teamOpenDate;
	private String photoName;
	public int getTeamIdx() {
		return teamIdx;
	}
	public void setTeamIdx(int teamIdx) {
		this.teamIdx = teamIdx;
	}
	public boolean isTeamDisband() {
		return teamDisband;
	}
	public void setTeamDisband(boolean teamDisband) {
		this.teamDisband = teamDisband;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getTeamOpenDate() {
		return teamOpenDate;
	}
	public void setTeamOpenDate(String teamOpenDate) {
		this.teamOpenDate = teamOpenDate;
	}
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	
	
}
