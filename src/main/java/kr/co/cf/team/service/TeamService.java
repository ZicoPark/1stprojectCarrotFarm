package kr.co.cf.team.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cf.team.dao.TeamDAO;
import kr.co.cf.team.dto.TeamDTO;

@Service
public class TeamService {
	
	@Autowired TeamDAO TeamDAO;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	

	public int teamUserChk(String loginId) {
		return TeamDAO.teamUserCount(loginId);
	}

	public HashMap<String, Object> overlay(String teamName) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		//logger.info("service teamName");
		map.put("overlay", TeamDAO.overlay(teamName));
		
		return map;
	}

	public String teamRegist(MultipartFile teamProfilePhoto, HashMap<String, String> params, String loginId) {
		logger.info("teamRegist service");
		
		String msg = "팀생성에 실패하였습니다.";

		int locationIdx = locationconf(params);
		int photoSave = 0;
		
		TeamDTO TeamDTO = new TeamDTO();
		TeamDTO.setTeamName(params.get("teamName"));
		TeamDTO.setTeamFavTime(params.get("teamFavTime"));
		TeamDTO.setTeamIntroduce(params.get("teamIntroduce"));
		TeamDTO.setTeamFavNum(Integer.parseInt(params.get("teamFavNum")));	
		TeamDTO.setTeamMatchState("모집중");
		TeamDTO.setTeamDisband(false);
		TeamDTO.setLocationIdx(locationIdx);
		
		int teamIdx = 0;
		//팀 개설 
		if(TeamDAO.teamRegist(TeamDTO) == 1) {
			//방금 개설한 teamIdx 가져오기 
			teamIdx = TeamDTO.getTeamIdx();
			logger.info("teamIdx :"+teamIdx);
			
			//팀 개설한 회원을 팀장으로 저장
			TeamDAO.addTeamLeader(teamIdx,loginId);
			
			if(!(teamProfilePhoto == null)) {
				logger.info("파일 업로드 작업");
				photoSave(teamProfilePhoto,teamIdx);
				logger.info("파일 업로드 성공");
			}
		}

		return "redirect:/team/teamPage.go?teamIdx="+teamIdx;
	}

	private void photoSave(MultipartFile teamProfilePhoto,int teamIdx) {
		
		// 1. 파일을 C:/carrot_farm/t01/ 에 저장
				//1-1. 원본 이름 추출
				String oriFileName = teamProfilePhoto.getOriginalFilename();
				
				//1-2. 새이름 생성
				String photoName = teamIdx+oriFileName;
				try {
				byte[] bytes = teamProfilePhoto.getBytes();//1-3. 바이트 추출
				//1-5. 추출한 바이트 저장
				Path path = Paths.get("C:/img/upload/"+photoName);
				Files.write(path, bytes);
				logger.info(photoName+" save OK");
				} catch (IOException e) {
					e.printStackTrace();
				}
				// 2. 저장 정보를 DB 에 저장
				//2-1. teamProfilePhoto, photoName insert
				TeamDAO.photoWrite(photoName,teamIdx);
				logger.info("photoName 저장완료");							
	}

	//사용자가 입력한 location의 idx를 받아오는 메서드
	private int locationconf(HashMap<String, String> params) {
		String location = params.get("location");
		logger.info(location);
		
		int locationIdx = TeamDAO.locationFind(location);
		logger.info("locationIdx : "+locationIdx);
		return locationIdx;
	}

	public ArrayList<TeamDTO> locationList() {
		return TeamDAO.locationList();
	}

	public HashMap<String, Object> list(HashMap<String, Object> params) {
		
		int page = Integer.parseInt((String) params.get("page"));
		String matchState = String.valueOf(params.get("matchState"));
		String searchText = String.valueOf(params.get("searchText"));
		logger.info(page+" 페이지 보여줘");
		logger.info("한 페이지에 "+10+" 개씩 보여줄거야");
		
		HashMap<String, Object> map = new HashMap<String, Object>();		

		//총 페이지 수 
		int offset = (page-1)*10;
		
		// 만들 수 있는 총 페이지 수 
		// 전체 게시물 / 페이지당 보여줄 수
		int total = 0;
		
		ArrayList<TeamDTO> list = null;		
		params.put("offset", offset);
		
		if(searchText.equals("default") || searchText.equals("")) {
			if(matchState.equals("default")) {
				// 전체 보여주기
				list = TeamDAO.teamList(params);
				logger.info("list size : "+list.size());
			}else{
				// 모집상태를 선택한 경우
				list = TeamDAO.MatchStateList(params);
				logger.info("MatchStateList size : "+list.size());
			}		
		}else {
			// 검색어 입력한 경우
			list = TeamDAO.SearchList(params);		
			logger.info("SearchList size : "+list.size());
		}
		
		total = list.size();
		
		int range = total%10 == 0 ? total/10 : (total/10)+1;
		logger.info("전체 게시물 수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		
		map.put("currPage", page);
		map.put("pages", range);

		map.put("list", list);
		return map;
	}

	public TeamDTO teamInfo(int teamIdx) {
		return TeamDAO.teamInfo(teamIdx);
	}

	public ArrayList<TeamDTO> tagReview(int teamIdx) {
		return TeamDAO.tagReview(teamIdx);
	}

	public TeamDTO updateForm(String teamIdx) {		
		return TeamDAO.updateForm(teamIdx);
	}

	public String teamPageUpdate(MultipartFile teamProfilePhoto, HashMap<String, String> params) {
		logger.info("service params : "+params);
		
		TeamDTO TeamDTO = new TeamDTO();
		TeamDTO.setTeamIdx(Integer.parseInt(params.get("teamIdx")));
		TeamDTO.setTeamName(params.get("teamName"));
		TeamDTO.setTeamMatchState(params.get("teamMatchState"));
		TeamDTO.setTeamFavTime(params.get("teamFavTime"));
		TeamDTO.setTeamIntroduce(params.get("teamIntroduce"));
		TeamDTO.setTeamFavNum(Integer.parseInt(params.get("teamFavNum")));	
		TeamDTO.setLocationIdx(locationconf(params));		
		TeamDTO.setPhotoName(params.get("photoName")); 
		
		//팀 정보 수정
		int row = TeamDAO.teamPageUpdate(TeamDTO);
		logger.info("update row : "+row);
		
		int photoUpRow = 0;
		
		String photoName = params.get("teamName");
		int teamIdx = Integer.parseInt(params.get("teamIdx"));
		
		//팀 프로필 사진 업로드 및 변경
		if(photoName.equals("")) {
			logger.info("파일 업로드 작업");
			photoSave(teamProfilePhoto,teamIdx);
			logger.info("파일 업로드 성공");
		}else if(!photoName.equals("")){
			photoUpRow = photoUpdateSave(teamProfilePhoto,photoName,teamIdx);
			logger.info("photoUpRow row : "+photoUpRow);
			
			File file = new File("C:/carrot_farm/t01/"+photoName);
			if(file.exists()) {// 2. 해당 파일이 존재 하는지?
				file.delete();// 3. 삭제
			}	
		}
		String page = row>0 ? "redirect:/team/teamPage.go?teamIdx="+teamIdx : "redirect:/team";
		logger.info("update => "+page);
		
		return page;
	}

	private int photoUpdateSave(MultipartFile teamProfilePhoto,String photoName,int teamIdx) {
		int photoUpRow = 0;	
		
		
		// 1. 파일을 C:/carrot_farm/t01/ 에 저장
			//1-1. 원본 이름 추출
			String oriFileName = teamProfilePhoto.getOriginalFilename();
			//1-2. 새이름 생성
			String newPhotoName = teamIdx+oriFileName;
			logger.info(photoName);
			try {
				byte[] bytes = teamProfilePhoto.getBytes();//1-3. 바이트 추출
				//1-5. 추출한 바이트 저장
				Path path = Paths.get("C:/carrot_farm/t01/"+newPhotoName);
				Files.write(path, bytes);
				logger.info(newPhotoName+" save OK");
				// 2. 저장 정보를 DB 에 저장
				//2-1. teamProfilePhoto, newPhotoName insert
				
				
				photoUpRow = TeamDAO.teamProfilePhotoUpdate(newPhotoName,teamIdx);
				logger.info("photoName 저장완료");
							
			} catch (IOException e) {
				e.printStackTrace();
			}					
		return photoUpRow;
		}

	public int disband(int teamIdx) {		
		logger.info("disband teamIdx : "+teamIdx);
		return TeamDAO.disband(teamIdx);
	}

	public int disbandCancle(int teamIdx) {
		logger.info("disbandCancle teamIdx : "+teamIdx);
		return TeamDAO.disbandCancle(teamIdx);
	}

	public void disbandAlarm(int teamIdx) {
		
		//ArrayList<TeamDTO> teamUserList = TeamDAO.getTeamUser(teamIdx);
		ArrayList<String> teamUserList = TeamDAO.getTeamUser(teamIdx);
		logger.info("teamUserList : "+teamUserList);
		
		int row = 0;
		
		for (int i = 0; i < teamUserList.size(); i++) {
			
			String userId = (teamUserList.get(i));			
			logger.info("userID : "+userId);
			
			TeamDAO.disbandAlarm(teamIdx,userId);
			logger.info("알람전송 성공");
			row += 1;			
		}
		logger.info("sendAlarmCount : "+row);		
	}
	
	public void disbandCancleAlarm(int teamIdx) {
		//ArrayList<TeamDTO> teamUserList = TeamDAO.getTeamUser(teamIdx);
		ArrayList<String> teamUserList = TeamDAO.getTeamUser(teamIdx);
		logger.info("teamUserList : "+teamUserList);
		
		int row = 0;
		
		for (int i = 0; i < teamUserList.size(); i++) {
			
			String userId = (teamUserList.get(i));			
			logger.info("userID : "+userId);
			
			TeamDAO.disbandCancleAlarm(teamIdx,userId);
			logger.info("알람전송 성공");
			row += 1;			
		}
		logger.info("sendAlarmCount : "+row);			
	}

	public HashMap<String, Object> gameList(HashMap<String, Object> params) { 
		
		int page = Integer.parseInt((String) params.get("page"));
		String selectedGameDate = String.valueOf(params.get("selectedGameDate"));
		String searchText = String.valueOf(params.get("searchText"));
		logger.info(page+" 페이지 보여줘");
		logger.info("한 페이지에 "+10+" 개씩 보여줄거야");
		
		int teamIdx = Integer.parseInt((String) params.get("teamIdx"));
		//ArrayList<TeamDTO> teamUserList = TeamDAO.getTeamUser(teamIdx);
		ArrayList<String> teamUserList = TeamDAO.getTeamUser(teamIdx);
		logger.info("teamUserList : "+teamUserList);
		
		ArrayList<TeamDTO> list = new ArrayList<TeamDTO>();
		ArrayList<TeamDTO> newList = new ArrayList<TeamDTO>();
		HashSet<TeamDTO> set = null;
		HashMap<String, Object> map = new HashMap<String, Object>();	

		//총 페이지 수 
		int offset = (page-1)*10;
		params.put("offset", offset);		
		
		if(teamUserList != null) {
			for (int i = 0; i < teamUserList.size(); i++) {
				
				String userId = (teamUserList.get(i));			
				logger.info("userID : "+userId);
				params.put("userId", userId);
				
				if(searchText.equals("default") || searchText.equals("")) {
					if(selectedGameDate.equals("default")) {
						// 전체 보여주기
							list = TeamDAO.gameList(params);
							logger.info("gameList size : "+list.size());												 
					}else{
						// 경기순을 선택한 경우
						if(selectedGameDate.equals("DESC")) {
								list = TeamDAO.GameDateListDesc(params);
								logger.info("GameDateList size : "+list.size());	
						}else {
							params.put("range", "ASC");
							list = TeamDAO.GameDateListAsc(params);
								logger.info("GameDateList size : "+list.size());	
						}
					}
				}else {
					// 검색어 입력한 경우
						list = TeamDAO.SearchGameList(params);		
						logger.info("SearchGameList size : "+list.size());
				}
				// 중복 list 값 제거 과정
				set = new LinkedHashSet<TeamDTO>(list);
			}
			newList = new ArrayList<TeamDTO>(set);
			logger.info("newList : "+ newList.size());
		}
		logger.info("totalGameList size : "+newList.size());
		
		// 만들 수 있는 총 페이지 수 
		// 전체 게시물 / 페이지당 보여줄 수
		int total = newList.size();
		logger.info("total "+total);
		int range = total%10 == 0 ? total/10 : (total/10)+1;
		logger.info("전체 게시물 수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		
		map.put("currPage", page);
		map.put("pages", range);
				
		logger.info("list : "+ newList);
		map.put("list", newList);
		
		logger.info("map : "+ map);
		return map;
	}
	
	public HashMap<String, Object> gameMatchingRequest(HashMap<String, Object> params) {
		logger.info("service 도착");
		logger.info("params : "+params);
		String selectedGameDate = String.valueOf(params.get("selectedGameDate"));
		

		int teamIdx = Integer.parseInt((String) params.get("teamIdx"));
		String leaderId = TeamDAO.getTeamLeader(teamIdx);
		logger.info("getTeamLeader : "+leaderId);
		params.put("userId", leaderId);

		
		ArrayList<TeamDTO> list = new ArrayList<TeamDTO>();
		HashMap<String, Object> map = new HashMap<String, Object>();		
		
		if(selectedGameDate.equals("default")) {
			// 전체 보여주기
				list = TeamDAO.matchingRequestList(leaderId);
				logger.info("matchingRequestList size : "+list.size());					
		}else{
			// 경기순을 선택한 경우
			if(selectedGameDate.equals("DESC")) {
					list = TeamDAO.matchingRequestListDesc(leaderId);
					logger.info("matchingRequestListDesc size : "+list.size());		
			}else {
				params.put("range", "ASC");
				list = TeamDAO.matchingRequestListAsc(leaderId);
					logger.info("matchingRequestListAsc size : "+list.size());					
			}
		}				
		logger.info("totalMatchingRequestList size : "+list.size());

		map.put("list", list);
		logger.info("map : "+ map);
		return map;
	}

	public ArrayList<TeamDTO> appGameUpdateAlarm(String teamIdx) {
		
		String userId = TeamDAO.getTeamLeader(Integer.parseInt(teamIdx));
		logger.info("getTeamLeader : "+userId);
		
		return TeamDAO.appGameUpdateAlarm(userId);
	}

	public ArrayList<TeamDTO> matchingInviteAlarm(String teamIdx) {

		String userId = TeamDAO.getTeamLeader(Integer.parseInt(teamIdx));
		logger.info("getTeamLeader : "+userId);
		
		return TeamDAO.matchingInviteAlarm(userId);
	}

	public ArrayList<TeamDTO> gameMatchingAppAlarm(String teamIdx) {

		String userId = TeamDAO.getTeamLeader(Integer.parseInt(teamIdx));
		logger.info("getTeamLeader : "+userId);
		
		return TeamDAO.gameMatchingAppAlarm(userId);
	}

	public ArrayList<TeamDTO> writeMatchingList(int teamIdx) {
		
		String userId = TeamDAO.getTeamLeader(teamIdx);
		logger.info("getTeamLeader : "+userId);
		
		ArrayList<TeamDTO> list = TeamDAO.writeMatchingList(userId);

		return list;
	}

	public String getTeamLeader(int teamIdx) {
		return TeamDAO.getTeamLeader(teamIdx);
	}

	public int teamLeadersConf(int teamIdx, String loginId) {
		return TeamDAO.teamLeadersConf(teamIdx, loginId);
	}

	public int teamJoinChk(String loginId) {
		return TeamDAO.teamJoinChk(loginId);
	}

	public int removeChk(int teamIdx, String loginId) {
		return TeamDAO.removeChk(teamIdx,loginId);
	}

	public int teamJoinApp(int teamIdx, String loginId) {
		return TeamDAO.teamJoinApp(teamIdx,loginId);
	}

	public int joinAppChk(int teamIdx, String loginId) {
		return TeamDAO.joinAppChk(teamIdx,loginId);
	}

	public void joinCancel(int teamIdx, String loginId) {
		TeamDAO.joinAppCancel(teamIdx,loginId);
	}

	public HashMap<String, Object> teamJoinAppList(int teamIdx) {
		logger.info("teamJoinAppList call : "+teamIdx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();		
		
		ArrayList<TeamDTO> list = TeamDAO.teamJoinAppList(teamIdx);
		logger.info("list size() : "+list.size());
		
		map.put("list", list);
		logger.info("map size() : "+map.size());
		
		return map;
	}

	public HashMap<String, Object> teamJoinAccept(int teamIdx, String userId) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();  
		
		if(TeamDAO.teamJoinAccept(teamIdx,userId) == 1) {
			logger.info("수락완료");
			
			if(TeamDAO.teamAppDel(userId) == 1) {
				map.put("data","수락완료");
			}
		}
		return map;
	}

	public HashMap<String, Object> teamJoinReject(int teamIdx, String userId) {

		HashMap<String, Object> map = new HashMap<String, Object>();  
		
		if(TeamDAO.teamJoinReject(teamIdx,userId) == 1) {
			logger.info("거절완료");
			map.put("data","거절완료");
		}
		return map;
	}

	public int teamUserChk(int teamIdx, String userId) {
		return TeamDAO.teamUserChk(teamIdx, userId);
	}
	
	//팀 탈퇴(팀장권한 양도)
	public void teamGradeUpdate(int teamIdx, String userId) {
		TeamDAO.teamGradeUpdate(teamIdx, userId);
	}

	//팀 탈퇴
	public HashMap<String, Object> leaveTeam(int teamIdx, String userId) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();  
		
		int row = TeamDAO.leaveTeam(teamIdx, userId);
		if(row == 1) {
			map.put("liveTeam", row);
		}
		
		return map;
	}

	public HashMap<String, Object> teamUserList(HashMap<String, Object> params) {
		
		int page = Integer.parseInt((String) params.get("page"));
		String teamJoinDate = String.valueOf(params.get("teamJoinDate"));
		logger.info(teamJoinDate);
		String searchText = String.valueOf(params.get("searchText"));
		logger.info(page+" 페이지 보여줘");
		logger.info("한 페이지에 "+10+" 개씩 보여줄거야");
		
		HashMap<String, Object> map = new HashMap<String, Object>();		

		//총 페이지 수 
		int offset = (page-1)*10;
		
		// 만들 수 있는 총 페이지 수 
		// 전체 게시물 / 페이지당 보여줄 수
		int total = 0;
		
		ArrayList<TeamDTO> list = new ArrayList<TeamDTO>();
		params.put("offset", offset);
		
		if(searchText.equals("default") || searchText.equals("")) {
			if(teamJoinDate.equals("default")) {
				// 전체 보여주기
				list.addAll(TeamDAO.teamUserListMy(params));
				list.addAll(TeamDAO.teamLeaderList(params));
				list.addAll(TeamDAO.teamUserList(params));
				logger.info("teamUserList size : "+list);	
			}else{
				// 경기순을 선택한 경우
				if(teamJoinDate.equals("DESC")) {//최신순
						list = TeamDAO.teamUserListDesc(params);
						logger.info("최신순 size : "+list.size());	
				}else {//오래된 순
					list = TeamDAO.teamUserListAsc(params);
						logger.info("오래된순 size : "+list.size());	
				}
			}
		}else {
			// 검색어 입력한 경우
				list = TeamDAO.teamUserListSearch(params);		
				logger.info("teamUserListSearch size : "+list.size());
		}
		
		total = list.size();
		
		int range = total%10 == 0 ? total/10 : (total/10)+1;
		logger.info("전체 게시물 수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		
		map.put("currPage", page);
		map.put("pages", range);

		map.put("list", list);
		
		return map;
	}

	public HashMap<String, Object> teamUserListLeader(HashMap<String, Object> params) {
		
		int page = Integer.parseInt((String) params.get("page"));
		String teamJoinDate = String.valueOf(params.get("teamJoinDate"));
		logger.info(teamJoinDate);
		String searchText = String.valueOf(params.get("searchText"));
		logger.info(page+" 페이지 보여줘");
		logger.info("한 페이지에 "+10+" 개씩 보여줄거야");
		
		HashMap<String, Object> map = new HashMap<String, Object>();		

		//총 페이지 수 
		int offset = (page-1)*10;
		
		// 만들 수 있는 총 페이지 수 
		// 전체 게시물 / 페이지당 보여줄 수
		int total = 0;
		
		ArrayList<TeamDTO> list = new ArrayList<TeamDTO>();
		params.put("offset", offset);
		
		if(searchText.equals("default") || searchText.equals("")) {
			if(teamJoinDate.equals("default")) {
				// 전체 보여주기
				list.addAll(TeamDAO.teamLeaderList(params));
				list.addAll(TeamDAO.teamUserList(params));
				logger.info("teamUserList size : "+list);	
			}else{
				// 경기순을 선택한 경우
				if(teamJoinDate.equals("DESC")) {//최신순
						list = TeamDAO.teamUserListDesc(params);
						logger.info("최신순 size : "+list.size());	
				}else {//오래된 순
					list = TeamDAO.teamUserListAsc(params);
						logger.info("오래된순 size : "+list.size());	
				}
			}
		}else {
			// 검색어 입력한 경우
				list = TeamDAO.teamUserListSearch(params);		
				logger.info("teamUserListSearch size : "+list.size());
		}
		
		total = list.size();
		
		int range = total%10 == 0 ? total/10 : (total/10)+1;
		logger.info("전체 게시물 수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		
		map.put("currPage", page);
		map.put("pages", range);

		map.put("list", list);
		
		return map;
	}

	public HashMap<String, Object> changeTeamGrade(HashMap<String, Object> params) {
		logger.info("changeTeamGrade : "+params);
		
		HashMap<String, Object> map = new HashMap<String, Object>();	
		
		if(TeamDAO.changeTeamGrade(params) == 1) {
			map.put("data", 1);
		}
		
		return map;
	}

	public HashMap<String, Object> warningList(HashMap<String, Object> params) {
		
		int page = Integer.parseInt((String) params.get("page"));
		String searchText = String.valueOf(params.get("searchText"));
		logger.info(page+" 페이지 보여줘");
		logger.info("한 페이지에 "+10+" 개씩 보여줄거야");
		
		HashMap<String, Object> map = new HashMap<String, Object>();		

		//총 페이지 수 
		int offset = (page-1)*10;
		
		// 만들 수 있는 총 페이지 수 
		// 전체 게시물 / 페이지당 보여줄 수
		int total = 0;
		
		ArrayList<TeamDTO> list = new ArrayList<TeamDTO>();
		params.put("offset", offset);
		
		if(searchText.equals("default") || searchText.equals("")) {
			list = TeamDAO.warningList(params);
			logger.info("warningList size : "+list.size());
		}else {
			// 검색어 입력한 경우
				list = TeamDAO.warningListSearch(params);		
				logger.info("teamUserListSearch size : "+list.size());
		}
		
		total = list.size();
		
		int range = total%10 == 0 ? total/10 : (total/10)+1;
		logger.info("전체 게시물 수 : "+total);
		logger.info("총 페이지 수 : "+range);
		
		page = page > range ? range : page;
		
		map.put("currPage", page);
		map.put("pages", range);

		map.put("list", list);
		
		return map;
	}

	public void warning(HashMap<String, Object> params) {
		int row = TeamDAO.warning(params);	
		logger.info("update row : "+row);
	}

	public void warningCancel(HashMap<String, Object> params) {
		int row = TeamDAO.warningCancel(params);	
		logger.info("update row : "+row);
	}

	public int remove(HashMap<String, Object> params) {
		return TeamDAO.remove(params);
	}

	public void removeAlarm(HashMap<String, Object> params) {
		TeamDAO.removeAlarm(params);
	}

	public ArrayList<TeamDTO> warningHistory(int teamIdx, String userId) {
		return TeamDAO.warningHistory(teamIdx,userId);
	}

	public void removeNowAlarm(HashMap<String, Object> params) {
		TeamDAO.removeNowAlarm(params);
	}

	public String getTeamIdx(String loginId) {
		return TeamDAO.getTeamIdx(loginId);
	}

	public ArrayList<TeamDTO> getTeamLeaders(int teamIdx) {
		return TeamDAO.getTeamLeaders(teamIdx);
	}

	public int teamLeadersChk(int teamIdx, String loginId) {
		return TeamDAO.teamLeadersChk(teamIdx,loginId);
	}





	
	
	
	
	
	
	
	
	
	
	

}
