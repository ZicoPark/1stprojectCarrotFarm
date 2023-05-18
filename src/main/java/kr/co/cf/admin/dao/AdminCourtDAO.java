package kr.co.cf.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cf.admin.dto.AdminCourtDTO;

public interface AdminCourtDAO {
	
	// 어드민 페이징 처리
	ArrayList<AdminCourtDTO> courtListPage(int offSet);
	
	// 페이징 처리할 때 전체 페이지 수
	int courtListCnt();

	ArrayList<AdminCourtDTO> courtListSearchPage(int offSet, String courtSearch);

	int courtListSearchCnt(HashMap<String, String> params);

	AdminCourtDTO courtInfo(String courtIdx);

	ArrayList<AdminCourtDTO> selectGu();

	void courtUpdate(HashMap<String, String> params);

	void courtDelete(String courtIdx);

	ArrayList<AdminCourtDTO> courtTipOffList(int offSet);

	int courtTipOffCnt();

	AdminCourtDTO courtTipOffInfo(String courtTipOffIdx);

	int adminCourtRegist(HashMap<String, String> params);

	void courtTipOffDelete(String courtTipOffIdx);

	void courtReRegist(String courtIdx);
	

	

}
