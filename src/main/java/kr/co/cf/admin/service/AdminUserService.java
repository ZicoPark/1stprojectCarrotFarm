package kr.co.cf.admin.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cf.admin.dao.AdminCourtDAO;
import kr.co.cf.admin.dao.AdminUserDAO;
import kr.co.cf.admin.dto.AdminUserDTO;

@Service
public class AdminUserService {
	
	@Autowired AdminUserDAO adminUserdao;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	

	public HashMap<String, Object> adminUserList(HashMap<String, String> params) {
		String page = params.get("page");
		String stateCategory=params.get("stateCategory");
		String searchCategory = params.get("searchCategory");
		String searchText=params.get("searchText");
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<AdminUserDTO> list = new ArrayList<AdminUserDTO>();
		if(searchText.equals("default")) {
			if(stateCategory.equals("default")) {
				int userCnt = adminUserdao.userCnt();
				map.put("totalList", userCnt);
				int offSet = (Integer.parseInt(page)-1)*10;
				list=adminUserdao.userList(offSet);
				map.put("list", list);
			}else {
				int stateCategoryCnt = adminUserdao.stateCategoryCnt(stateCategory);
				map.put("totalList", stateCategoryCnt);
				int offSet = (Integer.parseInt(page)-1)*10;
				list = adminUserdao.stateCategoryList(offSet,stateCategory);
				map.put("list", list);
			}
		}else {
			if(searchCategory.equals("default")) {
				int searchTextCnt=adminUserdao.searchTextCnt(searchText);
				map.put("totalList", searchTextCnt);
				int offSet = (Integer.parseInt(page)-1)*10;
				list = adminUserdao.searchText(searchText,offSet);
				map.put("list", list);
			}else {
				logger.info(searchText+searchCategory);
				int searchCategoryCnt=adminUserdao.searchCategoryCnt(searchText,searchCategory);
				map.put("totalList", searchCategoryCnt);
				logger.info("searchCategoryCnt :"+searchCategoryCnt);
				int offSet = (Integer.parseInt(page)-1)*10;
				list = adminUserdao.searchCategory(searchCategory,searchText,offSet);
				logger.info("list :"+list);
				map.put("list", list);
			}
			
		}
		return map;
	}


	public void nickNameChange(String userIdx, String userId) {
		String newNickName="user_"+userId;
		logger.info(newNickName);
		adminUserdao.nickNameChange(newNickName,userId);
		
	}


	public void profileChange(String userIdx, String userId) {
		fileChange(userId);
	}


	private void fileChange(String userId) {
		String newPhotoName="default.jpg";
		String photoName = adminUserdao.selectProfile(userId);
		logger.info(photoName);
		if(photoName==null) {
			adminUserdao.profileRegist(userId,newPhotoName);
		}else {
			if(photoName.equals("default.jpg")) {
				adminUserdao.profileChange(newPhotoName,userId);
			}else {
				adminUserdao.profileChange(newPhotoName,userId);
				File file = new File("C:/img/upload/"+photoName);
				if(file.exists()) {// 2. 해당 파일이 존재 하는지?
					file.delete();// 3. 삭제
				}
			}
		}
		
	}


	public HashMap<String, Object> nickNamesChange(ArrayList<String> nickChangeList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		for(String userId :nickChangeList) {
			String newNickName="1user_"+userId;
			adminUserdao.nickNameChange(newNickName,userId);
		}
		return map;
	}


	public HashMap<String, Object> profilesChange(ArrayList<String> profileChangeList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		for(String userId :profileChangeList) {
			fileChange(userId);
		}
		return map;
	}

}
