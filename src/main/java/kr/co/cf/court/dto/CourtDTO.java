package kr.co.cf.court.dto;

import java.sql.Date;

public class CourtDTO {
	private int courtIdx;
	private int locationId;
	private String courtName;
	private String courtTel;
	private String courtInOut;
	private String courtState;
	private double courtLatitude;
	private double courtLongitude;
	private String gu;
	private String courtAddress;
	private int courtReviewIdx;
	private String userId;
	private Date courtReviewDate;
	private String courtOneLineReview;
	private double courtStar;
	private String photoName;
	private int courtDelete;
	 
	public int getCourtDelete() {
		return courtDelete;
	}
	public void setCourtDelete(int courtDelete) {
		this.courtDelete = courtDelete;
	}
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public int getCourtReviewIdx() {
		return courtReviewIdx;
	}
	public void setCourtReviewIdx(int courtReviewIdx) {
		this.courtReviewIdx = courtReviewIdx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getCourtReviewDate() {
		return courtReviewDate;
	}
	public void setCourtReviewDate(Date courtReviewDate) {
		this.courtReviewDate = courtReviewDate;
	}
	public String getCourtOneLineReview() {
		return courtOneLineReview;
	}
	public void setCourtOneLineReview(String courtOneLineReview) {
		this.courtOneLineReview = courtOneLineReview;
	}
	public double getCourtStar() {
		return courtStar;
	}
	public void setCourtStar(double courtStar) {
		this.courtStar = courtStar;
	}
	public String getCourtAddress() {
		return courtAddress;
	}
	public void setCourtAddress(String courtAddress) {
		this.courtAddress = courtAddress;
	}
	public String getGu() {
		return gu;
	}
	public void setGu(String gu) {
		this.gu = gu;
	}
	public int getCourtIdx() {
		return courtIdx;
	}
	public void setCourtIdx(int courtIdx) {
		this.courtIdx = courtIdx;
	}
	public int getLocationId() {
		return locationId;
	}
	public void setLocationId(int locationId) {
		this.locationId = locationId;
	}
	public String getCourtName() {
		return courtName;
	}
	public void setCourtName(String courtName) {
		this.courtName = courtName;
	}
	public String getCourtTel() {
		return courtTel;
	}
	public void setCourtTel(String courtTel) {
		this.courtTel = courtTel;
	}
	public String getCourtInOut() {
		return courtInOut;
	}
	public void setCourtInOut(String courtInOut) {
		this.courtInOut = courtInOut;
	}
	public String getCourtState() {
		return courtState;
	}
	public void setCourtState(String courtState) {
		this.courtState = courtState;
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
	
	
}
