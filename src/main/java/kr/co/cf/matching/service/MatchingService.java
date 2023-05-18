package kr.co.cf.matching.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cf.matching.dao.MatchingDAO;
import kr.co.cf.matching.dto.MatchingDTO;

@Service
public class MatchingService {
	
	@Autowired MatchingDAO matchingDAO;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	

	public MatchingDTO matchingDetail(String matchingIdx) {
		
		matchingDAO.upHit(matchingIdx);
		return matchingDAO.matchingDetail(matchingIdx);
	}

	public void matchingWrite(MatchingDTO matchingDto) {
		matchingDAO.matchingWrite(matchingDto);
		
	}

	public void game(MatchingDTO matchingDto) {
		matchingDAO.game(matchingDto);
		
	}

	public void delete(String matchingIdx,String writerId) {
		
		// 삭제 전 해당 매칭글의 idx를 가진 알림을 모두 삭제 함
		String categoryId = matchingDAO.categoryIdChk(matchingIdx);
		String subject = matchingDAO.getSubject(matchingIdx);
		matchingDAO.deleteAlarm(matchingIdx,categoryId);
		
		
		// 삭제 전 해당 matchingIdx의 playerList에게 삭제알림을 보내야함
		ArrayList<MatchingDTO> playerList =  matchingDAO.playerList(matchingIdx);
		
		for (int i = 0; i < playerList.size(); i++) {
			String userId =playerList.get(i).getUserId();
			logger.info("userId" + userId);
			if(!(userId.equals(writerId))) {
				String delSubject="삭제 "+subject;
				logger.info("삭제 내용" + delSubject);
				matchingDAO.matchingDeleteAlarm(userId,matchingIdx,categoryId,delSubject);
			}
			
		}
		// 삭제 전 해당 matchingIdx의 gameApplyList에게 수정된 내용에 대한 알림을 보내야함
		
		ArrayList<MatchingDTO> gameApplyList = matchingDAO.gameApplyList(matchingIdx);
		
		for (int i = 0; i < gameApplyList.size(); i++) {
			String userId =gameApplyList.get(i).getUserId();
			if(!(userId.equals(writerId))) {
				String delSubject="삭제 "+subject;
				logger.info("삭제 내용" + delSubject);
				matchingDAO.matchingDeleteAlarm(userId,matchingIdx,categoryId,delSubject);
			}	
		}
		
		// game 테이블의 matchingIdx가 일치하는 것을 먼저 삭제 후 matching 테이블에서도 삭제해야됨
		matchingDAO.deleteGame(matchingIdx);
		matchingDAO.deleteMatching(matchingIdx);
		
	}

	public ArrayList<MatchingDTO> locationList() {
		return matchingDAO.locationList();
	}

	public MatchingDTO matchingWriterData(String writerId) {
		
		return matchingDAO.matchingWriterData(writerId);
	}

	public ArrayList<MatchingDTO> courtList() {
		ArrayList<MatchingDTO> list = matchingDAO.courtList();
		logger.info("locationIdx : " + list.get(0).getLocationIdx());
		return matchingDAO.courtList();
	}

	public void matchingUpdate(HashMap<String, String> params) {
		
		matchingDAO.matchingUpdate(params);
		
		// 업데이트 후 해당 matchingIdx의 playerList에게 수정된 내용에 대한 알림을 보내야함
		String matchingIdx = params.get("matchingIdx");
		ArrayList<MatchingDTO> playerList =  matchingDAO.playerList(matchingIdx);
		
		for (int i = 0; i < playerList.size(); i++) {
			
			String userId =playerList.get(i).getUserId();
			// 작성자 본인 제외
			if(!(userId.equals(params.get("writerId")))){
				params.put("userId", userId);
				logger.info("알람 수신 아이디 params"  +params);
				String categoryId = matchingDAO.categoryIdChk(matchingIdx);
				params.put("categoryId", categoryId);
				matchingDAO.matchingUpdateAlarm(params);
			}
			
		}
		// 업데이트 후 해당 matchingIdx의 gameApplyList에게 수정된 내용에 대한 알림을 보내야함
		
		ArrayList<MatchingDTO> gameApplyList = matchingDAO.gameApplyList(matchingIdx);
		
		for (int i = 0; i < gameApplyList.size(); i++) {
			String userId =gameApplyList.get(i).getUserId();
			if(!(userId.equals(params.get("writerId")))){
				params.put("userId", userId);
				logger.info("알람 수신 아이디 params"  +params);
				matchingDAO.matchingUpdateAlarm(params);
			}
			
		}
	}

	
	public ArrayList<MatchingDTO> commentList(String matchingIdx) {
		return matchingDAO.commentList(matchingIdx);
	}

	public void commentWrite(HashMap<String, String> params) {
		matchingDAO.commentWrite(params);
	}

	public void commentDelete(String commentIdx) {
		matchingDAO.commentDelete(commentIdx);
	}

	public MatchingDTO commentGet(String commentIdx) {
		return matchingDAO.commentGet(commentIdx);
	}

	public void commentUpdate(HashMap<String, String> params) {
		matchingDAO.commentUpdate(params);
	}

	public HashMap<String, Object> list(HashMap<String, Object> params) {
		
		
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		String gamePlay = String.valueOf(params.get("gamePlay"));
		String categoryId = String.valueOf(params.get("categoryId"));
		String locationIdx = String.valueOf(params.get("locationIdx"));
		String search = String.valueOf(params.get("search"));
		logger.info(page + "를 선택된 경기방식이" +gamePlay+"때만 보여줘");
		logger.info("한페이지에 " + 10 +"개씩 보여줄 것 ");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// 1페이지  offset 0
		// 2페이지 offset 5
		// 3 페이지 offset 10
		int offset = 10*(page-1);
		
		logger.info("offset : " + offset);
		
		// 만들 수 있는 총 페이지 수 : 전체 게시글의 수 / 페이지당 보여줄 수 있는 수
		int total = 0;
		
		if(search.equals("default") || search.equals("")) {
			if(gamePlay.equals("default") && locationIdx.equals("default")) {
			// 전체 보여주기
			total = matchingDAO.totalCount(categoryId);
			}else if(!(gamePlay.equals("default")) && locationIdx.equals("default")){
				
				// 게임 방식만 선택 된 경우 
				total = matchingDAO.totalCountGamePlay(params);
				
			}else if(gamePlay.equals("default") && !(locationIdx.equals("default"))){
				
				// 선호 지역만 선택 된 경우
				total = matchingDAO.totalCountLocationIdx(params);
				
			}else {
				// 게임 방식, 선호 지역 둘다 선택 된 경우 
				total = matchingDAO.totalCountAll(params);
			}
		}else {
			// 검색기능 작동
			total = matchingDAO.totalCountSearch(categoryId,search);
		}
		
		
		
		int range = total%10  == 0 ? total/10 : total/10+1;
		
		logger.info("총게시글 수 : "+ total);
		logger.info("총 페이지 수 : "+ range);
		
		page = page>range ? range:page;
		
		ArrayList<MatchingDTO> list = null;
		
		
		params.put("offset", offset);
		
		
		logger.info("params : " + params);
		if(search.equals("default") ||search.equals("")) {
			if(gamePlay.equals("default") && locationIdx.equals("default")) {
				// 전체 보여주기
				list = matchingDAO.list(offset,categoryId);
			}else if(!(gamePlay.equals("default")) && locationIdx.equals("default")) {
				// 게임 방식만 선택 된 경우 
				list = matchingDAO.listGamePlay(params);
			}
			
			else if(gamePlay.equals("default") && !(locationIdx.equals("default"))){
				// 선호 지역만 선택 된 경우
				list = matchingDAO.listLocationIdx(params);
			}else {
				// 경기 방식, 선호 지역 모두 선택
				list = matchingDAO.listAll(params);
			}
		}else {
			// 검색 기능
			list = matchingDAO.listSearch(params);
		}
		

		
		
		//logger.info("list size : "+ list.size());
		map.put("list", list);
		map.put("currPage", page);
		map.put("pages", range);
		
		return map;
	
	}

	public MatchingDTO userData(String loginId) {
		return matchingDAO.userData(loginId);
	}
	
	// 참가 신청 여부 확인
	public int applyGameChk(String matchingIdx, String userId) {
		return matchingDAO.applyGameChk(matchingIdx,userId);
	}
	
	public void applyGame(String matchingIdx, String userId) {
		String categoryId = matchingDAO.categoryIdChk(matchingIdx);
		matchingDAO.applyGameAlarm(categoryId,matchingIdx,userId);
		matchingDAO.applyGame(matchingIdx,userId);
	}

	public void matchigStateToFinish(String matchingIdx, String matchigState) {
		matchingDAO.matchigStateToFinish(matchingIdx,matchigState);
		// 모집글 상태가 모집 종료로 변경되었으므로 해당 경기의 신청, 초대 목록은 삭제
		matchingDAO.matchigStateToFinishDelete(matchingIdx);
		// 신청 초대 목록이 삭제 되었으므로 신청 초대 알림도 삭제
		matchingDAO.matchigStateToFinishDeleteAlarm(matchingIdx);
	}
	
	public void matchigStateToReview(String matchingIdx, String matchigState) {
			matchingDAO.matchigStateToReview(matchingIdx,matchigState);
	}
	
	public ArrayList<MatchingDTO> playerList(String matchingIdx) {
		return matchingDAO.playerList(matchingIdx);
	}
	
	public ArrayList<MatchingDTO> playerTeamList(String matchingIdx) {
		return matchingDAO.playerTeamList(matchingIdx);
	}
		
	public void playerDelete(String matchingIdx, String userId) {
		String categoryId = matchingDAO.categoryIdChk(matchingIdx);
		matchingDAO.playerDelete(matchingIdx,userId);
		matchingDAO.playerDeleteAlarm(matchingIdx,userId,categoryId);
	}

	public ArrayList<MatchingDTO> gameApplyList(String matchingIdx) {
		return matchingDAO.gameApplyList(matchingIdx);
	}
	

	public ArrayList<MatchingDTO> teamApplyList(String matchingIdx) {
		return matchingDAO.teamApplyList(matchingIdx);
	}

	public void gameApplyAccept(String matchingIdx, String userId) {
		String categoryId = matchingDAO.categoryIdChk(matchingIdx);
		matchingDAO.gameApplyAccept(matchingIdx,userId);
		
		// 게임 신청 수락시 초대, 초대 알림 삭제
		int inviteChk = matchingDAO.inviteChk(matchingIdx,userId);
		logger.info("inviteChk : " +inviteChk);
		if(inviteChk!=0) {
			// 신청 accept 하면서 초대 지우기 
			HashMap<String, Object> params = new HashMap<String, Object>();
			params.put("matchingIdx", matchingIdx);
			params.put("userId", userId);
			matchingDAO.cancelGameInvite(params);
			
			// 초대알림도 지우기
			matchingDAO.gameInviteCancelAlarm(params);
		}
		
		// 신청 알림 지우기
		matchingDAO.applyGameAlarmDelete(matchingIdx, userId);
		
		matchingDAO.gameApplyAcceptAlarm(matchingIdx,userId,categoryId);
	}
	
	public void gameApplyReject(String matchingIdx, String userId) {
		String categoryId = matchingDAO.categoryIdChk(matchingIdx);
		matchingDAO.gameApplyReject(matchingIdx,userId);
		
		// 게임 신청 거절시 초대, 초대 알림 삭제
				int inviteChk = matchingDAO.inviteChk(matchingIdx,userId);
				if(inviteChk!=0) {
					// 신청 거절 하면서 초대 지우기 
					HashMap<String, Object> params = new HashMap<String, Object>();
					params.put("matchingIdx", matchingIdx);
					params.put("userId", userId);
					matchingDAO.cancelGameInvite(params);
					
					// 초대알림도 지우기
					matchingDAO.gameInviteCancelAlarm(params);
				}
		// 신청 알림 지우기
		matchingDAO.applyGameAlarmDelete(matchingIdx, userId);
				
		matchingDAO.gameApplyRejectAlarm(matchingIdx,userId,categoryId);
	}

	public ArrayList<MatchingDTO> userList(String matchingIdx) {
		return matchingDAO.userList(matchingIdx);
	}

	public void gameInvite(HashMap<String, Object> params) {
		matchingDAO.gameInvite(params);
		logger.info("params"+params);
		matchingDAO.gameInviteAlarm(params);
	}

	public void cancelGameInvite(HashMap<String, Object> params) {
		matchingDAO.cancelGameInvite(params);
		logger.info("params"+params);
		matchingDAO.gameInviteCancelAlarm(params);
	}

	public ArrayList<MatchingDTO> gameInviteList(String matchingIdx) {
		return matchingDAO.gameInviteList(matchingIdx);
	}
	
	public ArrayList<MatchingDTO> teamInviteList(String matchingIdx) {
		return matchingDAO.teamInviteList(matchingIdx);
	}
	public ArrayList<MatchingDTO> teamList(String matchingIdx) {
		return matchingDAO.teamList(matchingIdx);
	}

	public void mvp(HashMap<String, Object> params) {
		matchingDAO.mvp(params);
		
	}
	
	public void manner(String matchingIdx, String writerId, String receiveId, String userMannerScore) {
		matchingDAO.manner(matchingIdx,writerId,receiveId,userMannerScore);		
	}


	public int review(String matchingIdx, String writerId) {
		return matchingDAO.review(matchingIdx,writerId);
	}

	public float mannerPoint(String loginId) {
		return matchingDAO.mannerPoint(loginId);
	}

	public int cntReview(String userId, String matchingIdx) {
		return matchingDAO.cntReview(userId,matchingIdx);
	}

	public void matchingReport(HashMap<String, String> params) {
		matchingDAO.matchingReport(params);
	}

	public void commentReport(HashMap<String, String> params) {
		matchingDAO.commentReport(params);
		
	}
	
	public void downHit(String matchingIdx) {
		matchingDAO.downHit(matchingIdx);
	}

	public String leaderChk(String userId) {
		// 본인이 리더인 (해체되지 않은)팀이 있는지
		return matchingDAO.leaderChk(userId);
	}
	
	public int leaderQ(String userId) {
		// TODO Auto-generated method stub
		return matchingDAO.leaderQ(userId);
	}
	
	public MatchingDTO matchingTeamData(String teamName) {
		return matchingDAO.matchingTeamData(teamName);
	}

	public String categoryIdChk(String categoryId) {
		return matchingDAO.categoryIdChk(categoryId);
	}

	public MatchingDTO myTeam(String userId) {
		return matchingDAO.myTeam(userId);
	}


	public int playChk(String loginId, String matchingIdx) {
		return matchingDAO.playChk(loginId,matchingIdx);
	}

	public ArrayList<MatchingDTO> teamMemberList(String userId, String matchingIdx) {
		return matchingDAO.teamMemberList(matchingIdx, userId);
	}

	public void teamRegist(HashMap<String, Object> params) {
		String categoryId = matchingDAO.categoryIdChk(String.valueOf(params.get("matchingIdx")));
		params.put("categoryId", categoryId);
		
		matchingDAO.teamRegist(params);
		matchingDAO.teamRegistAlarm(params);
	}

	public void cancelRegist(HashMap<String, Object> params) {
		matchingDAO.cancelRegist(params);
	}

	public ArrayList<HashMap<String, String>> mvpCnt(String matchingIdx) {
		return matchingDAO.mvpCnt(matchingIdx);
	}

	public ArrayList<MatchingDTO> tagList() {
		return matchingDAO.tagList();
	}

	public void teamTagReview(String matchingIdx, String teamId, String tagIdx) {
		matchingDAO.teamTagReview(matchingIdx,teamId,tagIdx);
	}

	public int tagChk(String matchingIdx, String teamId) {
		return matchingDAO.tagChk(matchingIdx,teamId);
	}

	public void inviteAccept(String matchingIdx, String userId) {
		matchingDAO.inviteAccept(matchingIdx,userId);
		
	}
	
	public void inviteReject(String matchingIdx, String userId) {
		matchingDAO.inviteReject(matchingIdx,userId);
	}
	
	public void inviteAlarmDelete(String matchingIdx, String userId) {
		matchingDAO.inviteAlarmDelete(matchingIdx,userId);
		
	}

	public void applyGameDelete(String matchingIdx, String userId) {
		matchingDAO.applyGameDelete(matchingIdx,userId);
	}

	public void applyGameAlarmDelete(String matchingIdx, String userId) {
		matchingDAO.applyGameAlarmDelete(matchingIdx,userId);
	}

	public void reviewAlarm(String userId, String matchingIdx) {
		String categoryId = matchingDAO.categoryIdChk(matchingIdx);
		matchingDAO.reviewAlarm(categoryId,userId, matchingIdx);
	}

	public HashMap<String, Object> delete(ArrayList<String> delList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int delSize = delList.size();
		int successCnt = 0;
		for (String alarmIdx : delList) {
			successCnt += matchingDAO.delete(alarmIdx);
		}
		map.put("msg", "선택한 알람 "+successCnt+"개를 삭제했습니다. ");
		map.put("success",true);
		return map;
	}

	



	
}
