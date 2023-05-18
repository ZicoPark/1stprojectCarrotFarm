package kr.co.cf.team.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import kr.co.cf.team.dto.TeamDTO;


public interface TeamDAO {

	int teamUserCount(String loginId);
	
	int overlay(String teamName);

	int teamRegist(TeamDTO teamDTO);

	int locationFind(String location);

	void addTeamLeader(int teamIdx, String loginId);
	
	void photoWrite(String photoName, int teamIdx);
	
	
	TeamDTO teamInfo(int teamIdx);

	ArrayList<TeamDTO> tagReview(int parseInt);


	ArrayList<TeamDTO> locationList();
	
	ArrayList<TeamDTO> teamList(HashMap<String, Object> params);
	
	ArrayList<TeamDTO> MatchStateList(HashMap<String, Object> params);

	ArrayList<TeamDTO> SearchList(HashMap<String, Object> params);

	int totalCount();

	int totalCountMatchState(HashMap<String, Object> params);

	int totalCountSearch(HashMap<String, Object> params);
	
	//팀정보 수정
	TeamDTO updateForm(String teamIdx);
	
	int teamPageUpdate(TeamDTO teamDTO);

	int teamProfilePhotoUpdate(String newPhotoName, int teamIdx);
	
	//팀 해체
	int disband(int teamIdx);

	int disbandCancle(int teamIdx);

	ArrayList<String> getTeamUser(int teamIdx);

	void disbandAlarm(int teamIdx, String userId);
	
	void disbandCancleAlarm(int teamIdx, String userId);
	
	//참가한 경기기록 보기
	ArrayList<TeamDTO> gameList(HashMap<String, Object> params);

	ArrayList<TeamDTO> SearchGameList(HashMap<String, Object> params);

	ArrayList<TeamDTO> GameDateListDesc(HashMap<String, Object> params);

	ArrayList<TeamDTO> GameDateListAsc(HashMap<String, Object> params);
	
	//신청한 경기 모집글 확인
	ArrayList<TeamDTO> getTeamLeaders(int teamIdx);

	ArrayList<TeamDTO> matchingRequestList(String leaderId);

	ArrayList<TeamDTO> matchingRequestListDesc(String leaderId);

	ArrayList<TeamDTO> matchingRequestListAsc(String leaderId);
	
	//신청한 경기 모집글 변경사항 알림
	ArrayList<TeamDTO> appGameUpdateAlarm(String teamIdx);

	//경기 초대 알림
	ArrayList<TeamDTO> matchingInviteAlarm(String userId);

	//경기 참가신청 알림
	ArrayList<TeamDTO> gameMatchingAppAlarm(String userId);

	int teamLeadersConf(int teamIdx, String loginId);
	
	//모집중인 경기 리스트 보기
	String getTeamLeader(int teamIdx);

	ArrayList<TeamDTO> writeMatchingList(String userId);
	
	//팀 가입 신청 및 취소
	int teamJoinChk(String loginId);

	int removeChk(int teamIdx, String loginId);

	int teamJoinApp(int teamIdx, String loginId);

	int joinAppChk(int teamIdx, String loginId);

	void joinAppCancel(int teamIdx, String loginId);
	
	//팀 가입 수락 및 거절
	ArrayList<TeamDTO> teamJoinAppList(int teamIdx);

	int teamJoinAccept(int teamIdx, String userId);

	int teamAppDel(String userId);

	int teamJoinReject(int teamIdx, String userId);
	
	//팀 탈퇴
	int teamUserChk(int teamIdx, String userId);

	int teamGradeUpdate(int teamIdx, String userId);

	int leaveTeam(int teamIdx, String userId);

	//팀원 리스트
	ArrayList<TeamDTO> teamUserListMy(HashMap<String, Object> params);

	ArrayList<TeamDTO> teamLeaderList(HashMap<String, Object> params);

	ArrayList<TeamDTO> teamUserList(HashMap<String, Object> params);

	ArrayList<TeamDTO> teamUserListDesc(HashMap<String, Object> params);

	ArrayList<TeamDTO> teamUserListAsc(HashMap<String, Object> params);

	ArrayList<TeamDTO> teamUserListSearch(HashMap<String, Object> params);

	//팀원 직급 변경
	int changeTeamGrade(HashMap<String, Object> params);

	//팀원 경고 및 취소
	ArrayList<TeamDTO> warningList(HashMap<String, Object> params);

	ArrayList<TeamDTO> warningListSearch(HashMap<String, Object> params);

	int warning(HashMap<String, Object> params);

	int warningCancel(HashMap<String, Object> params);

	//팀원 강퇴
	int remove(HashMap<String, Object> params);

	void removeAlarm(HashMap<String, Object> params);
	
	//유저 경고 기록 보기
	ArrayList<TeamDTO> warningHistory(int teamIdx, String userId);

	void removeNowAlarm(HashMap<String, Object> params);

	String getTeamIdx(String loginId);

	int teamLeadersChk(int teamIdx, String loginId);






	


	


}
