package kr.co.cf.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cf.admin.dto.AdminTagDTO;

public interface AdminTagDAO {

	int tagListCnt();

	ArrayList<AdminTagDTO> tagList(int offSet);

	int tagSearchListCnt(String searchText);

	ArrayList<AdminTagDTO> tagSearchList(String searchText, int offSet);

	AdminTagDTO tagInfo(String tagIdx);

	void tagUpdate(String tagContent, int tagIdx);

	int tagContentChk(String tagContent);

	int tagIdChk(String tagId);

	void tagRegist(HashMap<String, String> params);

}
