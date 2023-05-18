package kr.co.cf.admin.dao;

import java.util.ArrayList;

import kr.co.cf.admin.dto.AdminTeamDTO;

public interface AdminTeamDAO {

	ArrayList<AdminTeamDTO> adminTeamList(int offSet);

	int adminTeamListCnt();

	int teamStateCategoryCnt(Boolean isDisbanded);

	ArrayList<AdminTeamDTO> teamStateCategoryList(Boolean isDisbanded, int offSet);

	int teamSearchTextCnt(String searchText);

	ArrayList<AdminTeamDTO> teamSearchTextList(String searchText, int offSet);

	void adminTeamNameChange(String newTeamName, String teamIdx);

	String selectTeamProfile(String teamIdx);

	void teamProfileRegist(String teamIdx, String newPhotoName);

	void teamProfileUpdate(String teamIdx, String newPhotoName);

}
