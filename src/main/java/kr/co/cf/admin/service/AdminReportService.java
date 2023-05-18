package kr.co.cf.admin.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cf.admin.dao.AdminReportDAO;
import kr.co.cf.admin.dto.AdminReportDTO;


@Service
public class AdminReportService {
	@Autowired AdminReportDAO adminReportdao;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public HashMap<String, Object> adminReportList(HashMap<String, String> params) {
		String page = params.get("page");
		String category=params.get("category");
		String searchText = params.get("searchText");
		String searchCategory=params.get("searchCategory");
		String reportState=params.get("reportState");
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<AdminReportDTO> list = new ArrayList<AdminReportDTO>();
		int offSet = (Integer.parseInt(page)-1)*10;
		
		if(searchText.equals("default")) {
			if(category.equals("default") && reportState.equals("default")) {
			// 전체 보여주기
				int reportCnt = adminReportdao.reportCnt();
				map.put("totalList", reportCnt);
				list=adminReportdao.reportList(offSet);
				map.put("list", list);
			}else if(!category.equals("default") && reportState.equals("default")) {
				// category에 따라 출력
				int categoryCnt = adminReportdao.categoryCnt(category);
				map.put("totalList", categoryCnt);
				list=adminReportdao.categoryList(category,offSet);
				map.put("list", list);
			}else if(category.equals("default") && !reportState.equals("default")) {
				// 처리상태에 따라 출력
				int reportStateCnt = adminReportdao.reportStateCnt(reportState);
				map.put("totalList", reportStateCnt);
				list=adminReportdao.reportStateList(reportState,offSet);
				map.put("list", list);
			}else {
				//처리 상태 + 카테고리에 따라 출력
				int sortCnt = adminReportdao.sortCnt(reportState,category);
				map.put("totalList", sortCnt);
				list=adminReportdao.sortList(reportState,category,offSet);
				map.put("list", list);
			}
		}else {
			if(searchCategory.equals("default")) {
				//검색 종류 없이 검색어에 따라 출력
				int reportSearchCnt = adminReportdao.reportSearchCnt(searchText);
				map.put("totalList", reportSearchCnt);
				list=adminReportdao.reportSearchList(searchText,offSet);
				map.put("list", list);
			}else {
				//검색어 종류가 있을 때
				int searchCategoryCnt = adminReportdao.searchCategoryCnt(searchCategory,searchText);
				map.put("totalList", searchCategoryCnt);
				list=adminReportdao.searchCategoryList(searchCategory,searchText,offSet);
				map.put("list", list);
			}
		}
		return map;
	}

	public AdminReportDTO reportInfo(HashMap<String, String> params) {
		AdminReportDTO dto = new AdminReportDTO();
		String categoryId=params.get("categoryId"); 
		dto= adminReportdao.reportInfo(params);
		dto.setCategoryId(categoryId);
		dto.setReportId(Integer.parseInt(params.get("reportId")));
		if(categoryId.equals("rr")) {
			String courtIdx = adminReportdao.selectReview(params);
			if(courtIdx==null){ 
				dto.setMsg("해당 리뷰가 삭제되었습니다.");
			}else {
				dto.setAddress("courtDetail.do?courtIdx="+Integer.parseInt(courtIdx)); 
			}
		}else if(categoryId.equals("rb")) {
			String oriCategory = adminReportdao.selectCategory(params);
			logger.info(oriCategory);
			params.put("oriCategory", oriCategory);
			String boardIdx = adminReportdao.SelectBoard(params);
			if(oriCategory==null) {
				dto.setMsg("해당 게시글이 삭제되었습니다.");
			}else if(oriCategory.equals("rb001")||oriCategory.equals("b001")) {
				if(boardIdx==null){ 
					dto.setMsg("해당 게시글이 삭제되었습니다.");
				}else {
					dto.setAddress("freeboardDetail.do?bidx="+Integer.parseInt(boardIdx));
				}
				
			}else if(oriCategory.equals("rb003")||oriCategory.equals("b003")) {
				if(boardIdx==null){ 
					dto.setMsg("해당 게시글이 삭제되었습니다.");
				}else {
					dto.setAddress("inquiryboardDetail.do?bidx="+Integer.parseInt(boardIdx));
				}
			}else if(oriCategory.equals("rb011")||oriCategory.equals("b011")) {
				if(boardIdx==null){ 
					dto.setMsg("해당 게시글이 삭제되었습니다.");
				}else {
					dto.setAddress("teampictureboardDetail.do?bidx="+Integer.parseInt(boardIdx));
				}
			}else if(oriCategory.equals("rb012")||oriCategory.equals("b012")) {
				if(boardIdx==null){ 
					dto.setMsg("해당 게시글이 삭제되었습니다.");
				}else {
					dto.setAddress("teamfreeboardDetail.do?bidx="+Integer.parseInt(boardIdx));
				}
			}else if(oriCategory.equals("rb013")||oriCategory.equals("b013")) {
				if(boardIdx==null){ 
					dto.setMsg("해당 게시글이 삭제되었습니다.");
				}else {
					dto.setAddress("teamnoticeboardDetail.do?bidx="+Integer.parseInt(boardIdx));
				}
			}
		}else if(categoryId.equals("rm")) {
			String oriCategory= adminReportdao.selectMatchingCategory(params);
			logger.info(oriCategory);
			params.put("oriCategory", oriCategory);
			String matchingIdx = adminReportdao.selectMatchingIdx(params);
			if(oriCategory==null) {
				dto.setMsg("해당 게시글이 삭제되었습니다.");
			}else if(oriCategory.equals("m01")||oriCategory.equals("rm01")) {
				if(matchingIdx==null){ 
					dto.setMsg("해당 게시글이 삭제되었습니다.");
				}else {
					dto.setAddress("matching/detail.go?matchingIdx="+Integer.parseInt(matchingIdx));
				}
				
			}else if(oriCategory.equals("m02")||oriCategory.equals("rm02")) {
				if(matchingIdx==null){ 
					dto.setMsg("해당 게시글이 삭제되었습니다.");
				}else {
					dto.setAddress("matching/teamDetail.go?matchingIdx="+Integer.parseInt(matchingIdx));
				}
				
			}
		}else if(categoryId.equals("rc")) {
			String commentIdx = adminReportdao.SelectComment(params);
			if(commentIdx==null) {
				dto.setMsg("해당 댓글이 삭제되었습니다.");
			}else {
				String commentContent = adminReportdao.selectCommentContent(params);
				dto.setCommentContent(commentContent);
			}
		}else if(categoryId.equals("ru")) {
			logger.info(params.get("reportUserId"));
			dto.setAddress("userprofile.go?userId="+params.get("reportUserId"));
		}
				
			
				
					
		return dto;
	}


	public ArrayList<AdminReportDTO> recordList(HashMap<String, String> params) {
		return adminReportdao.recordList(params);
	}

	public void adminReportPro(HashMap<String, String> params) {
		String categoryId=params.get("categoryId");
		String reportResult = params.get("reportResult");
		if(categoryId.equals("rr")) {
			adminReportdao.reportReviewDel(params);
			String photoName = adminReportdao.selectReviewPhoto(params);
			if(photoName != null) {
				File file = new File("C:/img/upload/"+photoName);
				if(file.exists()) {// 2. 해당 파일이 존재 하는지?
					file.delete();// 3. 삭제
				}
				adminReportdao.reportReviewPhotoDel(params);
			}
			
		}else if(categoryId.equals("rb")) {
			String oriCategory=adminReportdao.selectCategory(params);
			String newCategory;
			if(oriCategory!=null &&(oriCategory.equals("b001")||oriCategory.equals("rb001"))) {
				newCategory="rb001";
				params.put("newCategory",newCategory);
			}else if(oriCategory!=null &&(oriCategory.equals("b003")||oriCategory.equals("rb003"))) {
				newCategory="rb003";
				params.put("newCategory",newCategory);
			}else if(oriCategory!=null &&(oriCategory.equals("b011")||oriCategory.equals("rb011"))) {
				newCategory="rb011";
				params.put("newCategory",newCategory);
			}else if(oriCategory!=null &&(oriCategory.equals("b012")||oriCategory.equals("rb012"))) {
				newCategory="rb012";
				params.put("newCategory",newCategory);
			}else if(oriCategory!=null &&(oriCategory.equals("b013")||oriCategory.equals("rb013"))) {
				newCategory="rb013";
				params.put("newCategory",newCategory);
			}
			adminReportdao.reportBoardBlind(params);
		
		}else if(categoryId.equals("rm")){
			String oriCategory=adminReportdao.selectMatchingCategory(params);
			String newCategory;
			if(oriCategory!=null &&(oriCategory.equals("m01")||oriCategory.equals("rm01"))) {
				newCategory="rm01";
				params.put("newCategory",newCategory);
			}else if(oriCategory!=null &&(oriCategory.equals("m02")||oriCategory.equals("rm02"))) {
				newCategory="rm02";
				params.put("newCategory",newCategory);
			}
			adminReportdao.reportMatchingBlind(params);
			
		}else if(categoryId.equals("rc")) {
			adminReportdao.reportCommentBlind(params);
		}else if(categoryId.equals("ru")) {
			
		}
		
		
		if(reportResult.equals("블라인드")) {
			params.put("reportCheck","0");
		}else if(reportResult.equals("경고")) {
			params.put("reportCheck","1");
			adminReportdao.reportAlarm(params);
			logger.info("경고 시 들어오는 :"+params);
		}else {
			params.put("reportCheck","0");
			adminReportdao.userRestriction(params);
				
		}
		
		adminReportdao.adminReportPro(params);
		adminReportdao.adminReportState(params);
		
	}

	public String adminRecordState(HashMap<String, String> params) {
		return adminReportdao.adminRecordState(params);
	}


	public void adminReportCancel(HashMap<String, String> params) {
		logger.info("신고 취소시 서비스로 넘어오는 값들 :"+params);
		String reportResult = adminReportdao.selectReportResult(params);
		logger.info(reportResult);
		if(reportResult.equals("블라인드")) {
			if(params.get("categoryId").equals("rr")) {
				String reportCheck="0";
				params.put("reportCheck",reportCheck);
				adminReportdao.adminReportProCancel(params);
			}else if(params.get("categoryId").equals("rb")) {
				String oriCategory=adminReportdao.selectCategory(params);
				logger.info(oriCategory);
				if(oriCategory.equals("rb001")) {
					String newCategoryId="b001";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb003")) {
					String newCategoryId="b003";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb011")) {
					String newCategoryId="b011";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb012")) {
					String newCategoryId="b012";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb013")) {
					String newCategoryId="b013";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}
					
			}else if(params.get("categoryId").equals("rm")) {
				String oriCategory=adminReportdao.selectMatchingCategory(params);
				logger.info(oriCategory);
				if(oriCategory.equals("rm01")) {
					String newCategoryId="m01";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.matchingBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rm02")) {
					String newCategoryId="m02";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.matchingBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}
			}else if(params.get("categoryId").equals("rc")) {
				adminReportdao.commentBlindCancel(params);
				String reportCheck="0";
				params.put("reportCheck",reportCheck);
				adminReportdao.adminReportProCancel(params);
			}
			
			
		}else if(reportResult.equals("경고")) {
			if(params.get("categoryId").equals("rr")) {
				String reportCheck="-1";
				params.put("reportCheck",reportCheck);
				adminReportdao.adminReportProCancel(params);
			}else if(params.get("categoryId").equals("rb")) {
				String oriCategory=adminReportdao.selectCategory(params);
				logger.info(oriCategory);
				if(oriCategory.equals("rb001")) {
					String newCategoryId="b001";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="-1";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb003")) {
					String newCategoryId="b003";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="-1";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb011")) {
					String newCategoryId="b003";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="-1";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb012")) {
					String newCategoryId="b012";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="-1";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb013")) {
					String newCategoryId="b013";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="-1";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}
				
				
			}else if(params.get("categoryId").equals("rm")) {
				String oriCategory=adminReportdao.selectMatchingCategory(params);
				logger.info(oriCategory);
				if(oriCategory.equals("rm01")) {
					String newCategoryId="m01";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.matchingBlindCancel(params);
					String reportCheck="-1";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rm02")) {
					String newCategoryId="m02";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.matchingBlindCancel(params);
					String reportCheck="-1";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}
			}else if(params.get("categoryId").equals("rc")) {
				adminReportdao.commentBlindCancel(params);
				String reportCheck="-1";
				params.put("reportCheck",reportCheck);
				adminReportdao.adminReportProCancel(params);
			}else if(params.get("categoryId").equals("ru")) {
				String reportCheck="-1";
				params.put("reportCheck",reportCheck);
				adminReportdao.adminReportProCancel(params);
			}
			
			
		}else if(reportResult.equals("영구제한")){
			
			if(params.get("categoryId").equals("rr")) {
				adminReportdao.userRestrictionCancel(params);
				String reportCheck="0";
				params.put("reportCheck",reportCheck);
				adminReportdao.adminReportProCancel(params);
			}else if(params.get("categoryId").equals("rb")) {
				adminReportdao.userRestrictionCancel(params);
				String oriCategory=adminReportdao.selectCategory(params);
				logger.info(oriCategory);
				if(oriCategory.equals("rb001")) {
					String newCategoryId="b001";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb003")) {
					String newCategoryId="b001";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb011")) {
					String newCategoryId="b011";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb012")) {
					String newCategoryId="b012";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rb013")) {
					String newCategoryId="b013";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.boardBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}
				
			}else if(params.get("categoryId").equals("rm")) {
				String oriCategory=adminReportdao.selectMatchingCategory(params);
				adminReportdao.userRestrictionCancel(params);
				logger.info(oriCategory);
				if(oriCategory.equals("rm01")) {
					String newCategoryId="m01";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.matchingBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}else if(oriCategory.equals("rm02")) {
					String newCategoryId="m01";
					params.put("newCategoryId", newCategoryId);
					adminReportdao.matchingBlindCancel(params);
					String reportCheck="0";
					params.put("reportCheck",reportCheck);
					adminReportdao.adminReportProCancel(params);
				}
			}else if(params.get("categoryId").equals("rc")) {
				adminReportdao.userRestrictionCancel(params);
				adminReportdao.commentBlindCancel(params);
				String reportCheck="0";
				params.put("reportCheck",reportCheck);
				adminReportdao.adminReportProCancel(params);
			}else if(params.get("categoryId").equals("ru")) {
				adminReportdao.userRestrictionCancel(params);
				String reportCheck="0";
				params.put("reportCheck",reportCheck);
				adminReportdao.adminReportProCancel(params);
			}
		}
		
		
	}

	public String warningCount(HashMap<String, String> params) {
		return adminReportdao.warningCount(params);
	}

	public void adminReportProcess(HashMap<String, String> params) {
		logger.info("처리 완료 버튼 눌렀을 떄 서비스로 넘어 오는 값: "+params);
		adminReportdao.adminReportProcess(params);
		logger.info("처리완료");
		
	}

}
		
	

