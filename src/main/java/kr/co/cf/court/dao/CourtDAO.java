package kr.co.cf.court.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cf.court.dto.CourtDTO;

public interface CourtDAO {

	CourtDTO searchCourt(String courtLatitude, String courtLongitude);

	int addCourt(String courtName, String courtLatitude, String courtLongitude, String courtAddress);

	ArrayList<CourtDTO> list();

	ArrayList<CourtDTO> location();

	CourtDTO courtNameSearch(String searchCourt);

	CourtDTO courtDetail(String courtIdx);

	int courtReviewWrite(CourtDTO dto);

	ArrayList<CourtDTO> courtReviewList(String courtIdx);

	String reviewWriter(HashMap<String, String> params);

	void fileWrite(int courtReviewIdx, String photoName);

	ArrayList<CourtDTO> reviewPhotoList(String courtIdx);

	String findFile(String string);

	int courtReviewDelete(String string);

	void courtPhotoDelete(String string);

	ArrayList<CourtDTO> guList();

	ArrayList<CourtDTO> selectList(String gu);

	//ArrayList<CourtDTO> courtList(String gu);

	ArrayList<CourtDTO> courtSearch(String searchCourt,int offSet);

	ArrayList<CourtDTO> courtList(String gu, String inOut, int offSet);


	ArrayList<CourtDTO> paging(int limit, int offSet);

	int sortTotalList(String gu, String inOut);

	int searchTotalList(String searchCourt);

	CourtDTO userCourtReview(String courtReviewIdx);

	CourtDTO userCourtReviewPhoto(String courtReviewIdx);

	void reviewUpdate(HashMap<String, String> params);

	String findReviewPhoto(String courtReviewIdx);

	void fileChange(int courtReviewIdx, String photoName);

	void courtTipOff(HashMap<String, String> params);

	void courtReviewReport(HashMap<String, String> params);

	

}
