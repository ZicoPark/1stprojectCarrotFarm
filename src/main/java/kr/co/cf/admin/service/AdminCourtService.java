package kr.co.cf.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cf.admin.dao.AdminCourtDAO;
import kr.co.cf.admin.dto.AdminCourtDTO;


@Service
public class AdminCourtService {
	@Autowired AdminCourtDAO adminCourtdao;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	// 페이징 처리
	public ArrayList<AdminCourtDTO> courtListPage(HashMap<String, String> params) {
		String page = params.get("page");
		int offSet = (Integer.parseInt(page)-1)*10;
		logger.info("page :"+page);
		logger.info("offset :"+offSet);
		return adminCourtdao.courtListPage(offSet);
	}
	// 페이징 처리할 떄 전체 리스트 수 불러오기
	public int courtListCnt() {
		return adminCourtdao.courtListCnt();
	}

	public ArrayList<AdminCourtDTO> courtListSearchPage(HashMap<String, String> params) {
		String page = params.get("page");
		String courtSearch = params.get("courtSearch");
		int offSet = (Integer.parseInt(page)-1)*10;
		return adminCourtdao.courtListSearchPage(offSet,courtSearch);
	}
	public int courtListSearchCnt(HashMap<String, String> params) {
		return adminCourtdao.courtListSearchCnt(params);
	}
	public AdminCourtDTO courtInfo(String courtIdx) {
		return adminCourtdao.courtInfo(courtIdx);
	}
	public ArrayList<AdminCourtDTO> selectGu() {
		return adminCourtdao.selectGu();
	}
	public void courtUpdate(HashMap<String, String> params) {
		adminCourtdao.courtUpdate(params);
		
	}
	public void courtDelete(String courtIdx) {
		adminCourtdao.courtDelete(courtIdx);
		
	}
	public ArrayList<AdminCourtDTO> courtTipOffList(HashMap<String, String> params) {
		String page = params.get("page");
		int offSet = (Integer.parseInt(page)-1)*10;
		logger.info("page :"+page);
		logger.info("offset :"+offSet);
		return adminCourtdao.courtTipOffList(offSet);
	}
	public int courtTipOffCnt() {
		return adminCourtdao.courtTipOffCnt();
	}
	public AdminCourtDTO courtTipOffInfo(String courtTipOffIdx) {
		return adminCourtdao.courtTipOffInfo(courtTipOffIdx);
	}
	public int adminCourtRegist(HashMap<String, String> params) {
		
		return adminCourtdao.adminCourtRegist(params);
		
	}
	public void courtTipOffDelete(String courtTipOffIdx) {
		adminCourtdao.courtTipOffDelete(courtTipOffIdx);
		
	}
	public void courtReRegist(String courtIdx) {
		adminCourtdao.courtReRegist(courtIdx);
		
	}
	
	
		

	
	
}
