package kr.co.cf.main.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.cf.main.dto.JoinDTO;
import kr.co.cf.matching.dto.MatchingDTO;
import kr.co.cf.team.dto.TeamDTO;

public interface JoinDAO {

	int join(JoinDTO dto);
	
	int idChk(String userId);
	
	int nickChk(String nickName);

	int photoWrite(String photoName,String userId);

	int joinData(JoinDTO dto);

	int locationFind(String location);

	JoinDTO login(String id, String pw);

	ArrayList<JoinDTO> findId(String email);

	int findIdCheck(String eamil);

	int updatePw(HashMap<String, String> params);
	
	int userdelete(Object attribute);

	JoinDTO userInfo(Object attribute);

	int userInfoUpdate(HashMap<String, String> params);

	int userInfoUpdatedata(HashMap<String, String> params);

	int userInfoUpdateloc(int locationIdx, String userId);
	

	ArrayList<JoinDTO> reviewList(HashMap<String, Object> params);

	ArrayList<JoinDTO> GameDateList(HashMap<String, Object> params);

	ArrayList<JoinDTO> SearchGameList(HashMap<String, Object> params);

	ArrayList<JoinDTO> GameDateListDesc(HashMap<String, Object> params);

	ArrayList<JoinDTO> GameDateListAsc(HashMap<String, Object> params);
	
	ArrayList<JoinDTO> allGameList(HashMap<String, Object> params);

	ArrayList<JoinDTO> allGameDateList(HashMap<String, Object> params);

	ArrayList<JoinDTO> allSearchGameList(HashMap<String, Object> params);

	ArrayList<JoinDTO> allGameDateListDesc(HashMap<String, Object> params);

	ArrayList<JoinDTO> allGameDateListAsc(HashMap<String, Object> params);

	ArrayList<JoinDTO> profileGames(String userId);

	JoinDTO profileInfo(String userId);

	void mannerDefalut(String userId);

	void photoDefalut(String userId);

	void photoUpdate(String photoName, String userId);

	String selectPhoto(String userId);

	void userReport(HashMap<String, String> params);

	String findPhotoName(String id);

	



}
