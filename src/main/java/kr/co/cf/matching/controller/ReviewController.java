package kr.co.cf.matching.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.cf.matching.dto.MatchingDTO;
import kr.co.cf.matching.service.MatchingService;

@Controller
public class ReviewController {
	
	@Autowired MatchingService matchingService;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value ="/matching/review.go")
	public String reviewGo(Model model,@RequestParam String matchingIdx, HttpSession session) {
		
		String page = "/matching/reviewReject";
		
		// matchingIdx와 session을 이용해서 game테이블에 해당 경기가 review상태이며 해당 회원이 참가한게 맞는지 확인해야함
		// 해당 경기에 참여했는지 여부
		int playChk = matchingService.playChk(String.valueOf(session.getAttribute("loginId")),matchingIdx);
		
		// mvp 테이블에 해당 회원이 투표한 기록이 있는지 확인해야함 
		int reviewChk = matchingService.review(matchingIdx,(String)session.getAttribute("loginId"));
		
		// 팀경기라면 확인할것 
		String categoryId = matchingService.categoryIdChk(matchingIdx);
		
		if(categoryId.equals("m02")) {
			// 팀경기의 경우 팀장인지, 팀장이라면 팀 이름 뭔지
			String myTeamName= "";
			String yourTeamName= "";
			int teamIdx= 0;
			int leaderQ = matchingService.leaderQ((String)session.getAttribute("loginId"));
			
			if(leaderQ==0) {
				// 팀경기인데 나 리더 아님 그럼 일반 리뷰만
				if(playChk==1 && reviewChk==0) {
					page = "/matching/review";
					
					// 경기 참여자 정보
					ArrayList<MatchingDTO> playerList = new ArrayList<MatchingDTO>();
					playerList = matchingService.playerList(matchingIdx);
					model.addAttribute("playerList", playerList);
					
				}
				
				if(reviewChk==1) {
					page = "/matching/reviewDone";
				}
			}
			if(leaderQ==1) {
				myTeamName = matchingService.leaderChk((String)session.getAttribute("loginId"));
				if(myTeamName.equals("")) {
					
				}else {
					// 해당 경기 참가자 정보 아이디 + 팀이름 + 팀 아이디
					ArrayList<MatchingDTO> playerList = new ArrayList<MatchingDTO>();
					playerList = matchingService.playerTeamList(matchingIdx);
					
					for (int i = 0; i < playerList.size(); i++) {				
						if(!playerList.get(i).getTeamName().equals(myTeamName)) {
							yourTeamName = playerList.get(i).getTeamName();
							teamIdx =playerList.get(i).getTeamIdx();
						}
					}
					
				}
				
				logger.info("myTeamName : " + myTeamName);
				logger.info("yourTeamName : " + yourTeamName);
				logger.info("teamIdx : " + teamIdx);
				
				if(playChk==1 && reviewChk==0) {
					
					
					int tagChk = matchingService.tagChk(matchingIdx,String.valueOf(teamIdx));
					
					logger.info("tagChk" + tagChk);
					
					if(tagChk!=0) {
						
						page = "/matching/review";
						// 경기 참여자 정보
						ArrayList<MatchingDTO> playerList = new ArrayList<MatchingDTO>();
						playerList = matchingService.playerList(matchingIdx);
						model.addAttribute("playerList", playerList);
						
					}else {
						page = "/matching/teamReview";
						
						model.addAttribute("myTeamName", myTeamName);
						model.addAttribute("yourTeamName", yourTeamName);
						model.addAttribute("teamIdx", teamIdx);
						
						ArrayList<MatchingDTO> tagList = new ArrayList<MatchingDTO>();
						tagList = matchingService.tagList();
						model.addAttribute("tagList", tagList);
					}
					
		
					
					
				}
				
			}
			
			
			if(reviewChk==1) {
				page = "/matching/reviewDone";
			}
		}
		
		
		
		if(categoryId.equals("m01")){
			if(playChk==1 && reviewChk==0) {
				page = "/matching/review";
				
				// 경기 참여자 정보
				ArrayList<MatchingDTO> playerList = new ArrayList<MatchingDTO>();
				playerList = matchingService.playerList(matchingIdx);
				model.addAttribute("playerList", playerList);
				
				model.addAttribute("matchingIdx", matchingIdx);
				
			}
			
			if(reviewChk==1) {
				page = "/matching/reviewDone";
			}
		}
				
				
		
		model.addAttribute("matchingIdx", matchingIdx);
		return page;		
	}
	
	@RequestMapping(value ="/matching/review.do")
	public String review(@RequestParam HashMap<String, Object> params) {
		logger.info("review : " + params);
		
		// mvp 투표
		matchingService.mvp(params);
		
		String matchingIdx = String.valueOf(params.get("matchingIdx"));
		String writerId = String.valueOf(params.get("writerId"));
		// manner 점수 평가
		params.remove("writerId");
		params.remove("receiveId");
		params.remove("matchingIdx");
		
		logger.info("review : " + params);

		// params
		 
		for(String key : params.keySet()){
		    String value = params.get(key).toString();
		    logger.info(key+" : "+value);
		    matchingService.manner(matchingIdx,writerId,key,value);
		}

		
		return "/matching/reviewDone";
	}
	
	@RequestMapping(value="/matching/teamReview.do")
	public String teamReview(@RequestParam HashMap<String, String> params, Model model ) {
		
		logger.info("팀 리뷰 정보 : " + params);
		
		String matchingIdx = params.get("matchingIdx");
		String teamId = params.get("teamId");
		
		params.remove("matchingIdx");
		params.remove("teamId");
		
		for(String key : params.keySet()){		    
		    logger.info(key);
		    matchingService.teamTagReview(matchingIdx,teamId,key);
		}
		
		ArrayList<MatchingDTO> playerList = new ArrayList<MatchingDTO>();
		playerList = matchingService.playerList(matchingIdx);
		model.addAttribute("playerList", playerList);
		
		model.addAttribute("matchingIdx", matchingIdx);
		
		return "/matching/review";
	}
}
