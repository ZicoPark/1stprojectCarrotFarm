package kr.co.cf.admin.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cf.admin.dao.AdminTeamDAO;
import kr.co.cf.admin.dto.AdminTeamDTO;

@Service
public class AdminTeamService {
	@Autowired AdminTeamDAO adminTeamdao;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public HashMap<String, Object> adminTeamList(HashMap<String, String> params) {
		String page = params.get("page");
		String stateCategory=params.get("stateCategory");
		String searchText=params.get("searchText");
		Boolean isDisbanded = true;
		if(stateCategory.equals("false")) {
			isDisbanded=false;
		}
		HashMap<String, Object> map = new HashMap<String,Object>();
		ArrayList<AdminTeamDTO> list = new ArrayList<AdminTeamDTO>();
		if(searchText.equals("default")) {
			if(stateCategory.equals("default")) {
				int offSet = (Integer.parseInt(page)-1)*10;
				list = adminTeamdao.adminTeamList(offSet);
				map.put("list", list);
				int teamCnt = adminTeamdao.adminTeamListCnt();
				map.put("totalList", teamCnt);
			}else {
				int teamStateCategoryCnt=adminTeamdao.teamStateCategoryCnt(isDisbanded);
				map.put("totalList",teamStateCategoryCnt);
				int offSet = (Integer.parseInt(page)-1)*10;
				list = adminTeamdao.teamStateCategoryList(isDisbanded,offSet);
				map.put("list", list);
			}
		}else {
			int teamSearchTextCnt = adminTeamdao.teamSearchTextCnt(searchText);
			map.put("totalList", teamSearchTextCnt);
			int offSet = (Integer.parseInt(page)-1)*10;
			list = adminTeamdao.teamSearchTextList(searchText,offSet);
			map.put("list", list);
		}
		return map;
	}

	public void adminTeamNameChange(String teamIdx) {
		String newTeamName = "team-"+teamIdx;
		adminTeamdao.adminTeamNameChange(newTeamName,teamIdx);
		
	}

	public void adminTeamProfileChange(String teamIdx) {
		teamProfileChange(teamIdx);
		
	}

	private void teamProfileChange(String teamIdx) {
		String newPhotoName="teamDefault.png";
		String photoName = adminTeamdao.selectTeamProfile(teamIdx);
		logger.info(photoName);
		if(photoName==null) {
			adminTeamdao.teamProfileRegist(teamIdx,newPhotoName);
		}else {
			if(photoName.equals("teamDefault.png")) {
				adminTeamdao.teamProfileUpdate(teamIdx,newPhotoName);
			}else {
				adminTeamdao.teamProfileUpdate(teamIdx,newPhotoName);
				File file = new File("C:/img/upload/"+photoName);
				if(file.exists()) {// 2. 해당 파일이 존재 하는지?
					file.delete();// 3. 삭제
				}
			}
		}
		
	}

	public HashMap<String, Object> adminTeamNamesChange(ArrayList<String> teamNameChangeList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		for(String teamIdx :teamNameChangeList) {
			String newTeamName = "team-"+teamIdx;
			adminTeamdao.adminTeamNameChange(newTeamName,teamIdx);
		}
		return map;
	}

	public HashMap<String, Object> adminTeamProfilesChange(ArrayList<String> teamProfileChangeList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		for(String teamIdx :teamProfileChangeList) {
			teamProfileChange(teamIdx);
		}
		return map;
	}
	

}
