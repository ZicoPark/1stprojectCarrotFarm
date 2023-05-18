package kr.co.cf.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cf.admin.dto.AdminReportDTO;
import kr.co.cf.admin.dto.AdminUserDTO;

public interface AdminReportDAO {

	int reportCnt();

	ArrayList<AdminReportDTO> reportList(int offSet);

	int categoryCnt(String category);

	ArrayList<AdminReportDTO> categoryList(String category, int offSet);

	int reportStateCnt(String reportState);

	ArrayList<AdminReportDTO> reportStateList(String reportState, int offSet);

	int sortCnt(String reportState, String category);

	ArrayList<AdminReportDTO> sortList(String reportState, String category, int offSet);

	int reportSearchCnt(String searchText);

	ArrayList<AdminReportDTO> reportSearchList(String searchText, int offSet);

	int searchCategoryCnt(String searchCategory, String searchText);

	ArrayList<AdminReportDTO> searchCategoryList(String searchCategory, String searchText, int offSet);

	AdminReportDTO reportInfo(HashMap<String, String> params);

	String selectReview(HashMap<String, String> params);



	ArrayList<AdminReportDTO> recordList(HashMap<String, String> params);

	String selectReviewPhoto(HashMap<String, String> params);

	void reportReviewDel(HashMap<String, String> params);

	void reportReviewPhotoDel(HashMap<String, String> params);

	void adminReportPro(HashMap<String, String> params);

	void adminReportState(HashMap<String, String> params);

	String adminRecordState(HashMap<String, String> params);

	void adminReportUpdate(HashMap<String, String> params);

	void adminReportUpdateState(HashMap<String, String> params);

	String selectReportResult(HashMap<String, String> params);

	void userRestriction(HashMap<String, String> params);

	void userRestrictionCancel(HashMap<String, String> params);

	String selectCategory(HashMap<String, String> params);

	String SelectBoard(HashMap<String, String> params);

	void reportBoardBlind(HashMap<String, String> params);

	void boardBlindCancel(HashMap<String, String> params);

	void adminReportProCancel(HashMap<String, String> params);

	String warningCount(HashMap<String, String> params);

	String selectMatchingCategory(HashMap<String, String> params);

	String selectMatchingIdx(HashMap<String, String> params);

	void reportMatchingBlind(HashMap<String, String> params);

	void matchingBlindCancel(HashMap<String, String> params);

	String SelectComment(HashMap<String, String> params);

	String selectCommentContent(HashMap<String, String> params);

	void reportCommentBlind(HashMap<String, String> params);

	void commentBlindCancel(HashMap<String, String> params);

	void adminReportProcess(HashMap<String, String> params);

	void reportAlarm(HashMap<String, String> params);





}
