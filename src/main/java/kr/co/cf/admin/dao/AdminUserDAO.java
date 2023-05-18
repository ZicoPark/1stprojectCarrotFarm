package kr.co.cf.admin.dao;

import java.util.ArrayList;

import kr.co.cf.admin.dto.AdminUserDTO;

public interface AdminUserDAO {
	

	void insert(String user_name, int age);

	ArrayList<AdminUserDTO> list();

	int userCnt();

	ArrayList<AdminUserDTO> userList(int offSet);

	int stateCategoryCnt(String stateCategory);

	ArrayList<AdminUserDTO> stateCategoryList(int offSet, String stateCategory);

	int searchTextCnt(String searchText);

	ArrayList<AdminUserDTO> searchText(String searchText, int offSet);

	int searchCategoryCnt(String searchText, String searchCategory);

	ArrayList<AdminUserDTO> searchCategory(String searchCategory, String searchText, int offSet);

	void nickNameChange(String newNickName, String userId);

	void profileChange(String photoName, String userId);

	String selectProfile(String userId);

	void profileRegist(String userId, String photoName);

	
}
