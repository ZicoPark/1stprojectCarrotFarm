package kr.co.cf.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cf.admin.dao.AdminTagDAO;
import kr.co.cf.admin.dto.AdminTagDTO;

@Service
public class AdminTagService {
	@Autowired AdminTagDAO adminTagdao;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public HashMap<String, Object> adminTagList(HashMap<String, String> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<AdminTagDTO> list = new ArrayList<AdminTagDTO>();
		String searchText = params.get("searchText");
		logger.info("태그 검색어 :"+searchText);
		String page = params.get("page");
		if(searchText.equals("default")) {
			int tagListCnt=adminTagdao.tagListCnt();
			map.put("totalList", tagListCnt);
			int offSet = (Integer.parseInt(page)-1)*10;
			list = adminTagdao.tagList(offSet);
			map.put("list", list);
		}else {
			int tagSearchListCnt = adminTagdao.tagSearchListCnt(searchText);
			map.put("totalList", tagSearchListCnt);
			int offSet = (Integer.parseInt(page)-1)*10;
			list = adminTagdao.tagSearchList(searchText,offSet);
			map.put("list", list);
		}
		return map;
	}

	public AdminTagDTO tagInfo(String tagIdx) {
		return adminTagdao.tagInfo(tagIdx);
	}

	public void tagUpdate(String tagContent, int tagIdx) {
		adminTagdao.tagUpdate(tagContent,tagIdx);
		
	}

	public HashMap<String, Object> tagContentChk(String tagContent) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info(tagContent);
		if(tagContent.equals("")) {
			logger.info("공백입니다");
			map.put("msg", "태그내용을 입력해주세요");
		}else {
			int tagChk = adminTagdao.tagContentChk(tagContent);
			map.put("tagChk", tagChk);
		}
			
		return map;
	}

	public HashMap<String, Object> tagIdChk(String tagId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info(tagId);
		if(tagId.equals("")) {
			logger.info("공백입니다");
			map.put("msg", "태그ID를 입력해주세요");
		}else {
			int tagIdChk = adminTagdao.tagIdChk(tagId);
			map.put("tagIdChk", tagIdChk);
		}
			
		return map;
	}

	public void tagRegist(HashMap<String, String> params) {
		adminTagdao.tagRegist(params);
		
	}
	

}
