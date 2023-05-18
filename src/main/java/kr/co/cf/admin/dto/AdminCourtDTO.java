package kr.co.cf.admin.dto;

public class AdminCourtDTO {
	private String courtName;
	private String courtAddress;
	private String courtInOut;
	private int courtIdx;
	private String courtState;
	private int listCnt;
	private String gu;
	private double courtLatitude;
	private double courtLongitude;
	private int locationIdx;
	private int courtDelete;
	private String userId;
	private int courtTipOffIdx;
	
	public int getCourtTipOffIdx() {
		return courtTipOffIdx;
	}
	public void setCourtTipOffIdx(int courtTipOffIdx) {
		this.courtTipOffIdx = courtTipOffIdx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getCourtDelete() {
		return courtDelete;
	}
	public void setCourtDelete(int courtDelete) {
		this.courtDelete = courtDelete;
	}
	public int getLocationIdx() {
		return locationIdx;
	}
	public void setLocationIdx(int locationIdx) {
		this.locationIdx = locationIdx;
	}
	public String getGu() {
		return gu;
	}
	public void setGu(String gu) {
		this.gu = gu;
	}
	public double getCourtLatitude() {
		return courtLatitude;
	}
	public void setCourtLatitude(double courtLatitude) {
		this.courtLatitude = courtLatitude;
	}
	public double getCourtLongitude() {
		return courtLongitude;
	}
	public void setCourtLongitude(double courtLongitude) {
		this.courtLongitude = courtLongitude;
	}
	public int getListCnt() {
		return listCnt;
	}
	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}
	public String getCourtState() {
		return courtState;
	}
	public void setCourtState(String courtState) {
		this.courtState = courtState;
	}
	public String getCourtName() {
		return courtName;
	}
	public void setCourtName(String courtName) {
		this.courtName = courtName;
	}
	public String getCourtAddress() {
		return courtAddress;
	}
	public void setCourtAddress(String courtAddress) {
		this.courtAddress = courtAddress;
	}
	public String getCourtInOut() {
		return courtInOut;
	}
	public void setCourtInOut(String courtInOut) {
		this.courtInOut = courtInOut;
	}
	public int getCourtIdx() {
		return courtIdx;
	}
	public void setCourtIdx(int courtIdx) {
		this.courtIdx = courtIdx;
	}
	
	
}
