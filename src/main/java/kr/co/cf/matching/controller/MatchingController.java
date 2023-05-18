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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.cf.matching.dao.MatchingDAO;
import kr.co.cf.matching.dto.MatchingDTO;
import kr.co.cf.matching.service.MatchingService;

@Controller
public class MatchingController {

   @Autowired MatchingService matchingService;

   Logger logger = LoggerFactory.getLogger(this.getClass());

   @RequestMapping(value = "/matching/list.do")
   public String matchingList(Model model, HttpSession session) {
      
      // 로그인 여부 확인해서 로그인안되어 있는 아이디면 guest라고 내려보내기 
      logger.info("session" + session.getAttribute("loginId"));
      logger.info("모집글 리스트 불러오기");
      if(session.getAttribute("loginId") == null) {
        // model.addAttribute("loginId", "guest");
      }
      
      ArrayList<MatchingDTO> locationList = new ArrayList<MatchingDTO>();
      locationList = matchingService.locationList();
      model.addAttribute("locationList", locationList);
      
      return "/matching/matchingList";
   }
   
   
   
   @RequestMapping(value ="/matching/list.ajax")
   @ResponseBody
   public HashMap<String, Object> list(@RequestParam HashMap<String, Object> params) {
      logger.info("params : " + params);
      
      HashMap<String, Object> list =   matchingService.list(params);
   
      return list;   
      
   }
   
   
   @RequestMapping(value = "/matching/detail.go")
   public String matchingDetail(Model model, HttpSession session, @RequestParam String matchingIdx) {
      
      logger.info("모집글 matchingIdx : " + matchingIdx + "번 상세보기");

      // 모집글 내용
      MatchingDTO matchingDto = new MatchingDTO();
      matchingDto = matchingService.matchingDetail(matchingIdx);
      model.addAttribute("dto", matchingDto);

      // 해당 모집글의 댓글 불러 오기
      ArrayList<MatchingDTO> commentList = new ArrayList<MatchingDTO>();
      commentList = matchingService.commentList(matchingIdx);
      model.addAttribute("commentList", commentList);
      logger.info("모집글 commentList : " + commentList);
      
      // 로그인 정보가 없을 시
      if(session.getAttribute("loginId") == null) {
         //model.addAttribute("loginId", "guest");
      }
      // 로그인 정보가 있을 시
      if(session.getAttribute("loginId") != null) {      
      // 해당 경기 참가자 정보
         ArrayList<MatchingDTO> playerList = new ArrayList<MatchingDTO>();
         playerList = matchingService.playerList(matchingIdx);
         model.addAttribute("playerList", playerList);
         
         
         // 해당 경기 신청자 목록
         ArrayList<MatchingDTO> gameApplyList = new ArrayList<MatchingDTO>();
         gameApplyList = matchingService.gameApplyList(matchingIdx);
         model.addAttribute("gameApplyList", gameApplyList);
         
         // 전체 회원 목록 (신청자 목록, 경기 참가자 목록에 있는 사람 제외)
         ArrayList<MatchingDTO> userList = new ArrayList<MatchingDTO>();
         userList = matchingService.userList(matchingIdx);
         model.addAttribute("userList", userList);
         
         // 해당 경기 초대 목록
         ArrayList<MatchingDTO> gameInviteList = new ArrayList<MatchingDTO>();
         gameInviteList = matchingService.gameInviteList(matchingIdx);
         model.addAttribute("gameInviteList", gameInviteList);      
      
      }
      
      // MVP 결과 
      ArrayList<MatchingDTO> playerList = new ArrayList<MatchingDTO>();
      playerList = matchingService.playerList(matchingIdx);
      int mvpChk = playerList.size()/2; 
      logger.info("mvp  최소 득표수 : " + mvpChk);
      String mvp = "경기 MVP는 50% 이상의 표를 획득했을 때만 공개됩니다.";
      ArrayList<HashMap<String, String>> mvpCnt = matchingService.mvpCnt(matchingIdx);
      
      for (int i = 0; i < mvpCnt.size(); i++) {
         HashMap<String, String> map = mvpCnt.get(i);
         String realCnt = "";
         String realId = "";
         for(String key : map.keySet()){
            String value = String.valueOf(map.get(key));
            logger.info(key+" : "+value);
            if(key.equals("cnt")) {
               realCnt=String.valueOf(map.get(key));
            }
            if(key.equals("receiveId")) {
               realId=String.valueOf(map.get(key));
            }
         }
         if(Integer.parseInt(realCnt)>mvpChk) {
            mvp = realId;
         }
         
      }
      
      model.addAttribute("mvp",mvp);
      
      
      
      // float mannerPoint = matchingService.mannerPoint((String)session.getAttribute("loginId"));
      // model.addAttribute("mannerPoint", mannerPoint);
      
      
      
      return "/matching/matchingDetail";
   }
   
   

   @RequestMapping(value = "/matching/write.go")
   public String matchingWriteGo(@RequestParam String categoryId, Model model, HttpSession session) {

      logger.info("모집글 작성 categoryIdx : " + categoryId);

      // 로그인 정보 받아 와 작성자 저장
      logger.info("session" + session.getAttribute("loginId"));
      String writerId = (String) session.getAttribute("loginId");
      model.addAttribute("writerId", writerId);

      // 저장된 작성자아이디를 이용해 사용자의 등록된 선호 위치 저장
      MatchingDTO writerData = new MatchingDTO();
      writerData = matchingService.matchingWriterData(writerId);
      model.addAttribute("writerData", writerData);

      // 지역 리스트 가져오기
      ArrayList<MatchingDTO> locationList = new ArrayList<MatchingDTO>();
      locationList = matchingService.locationList();
      model.addAttribute("locationList", locationList);

      // 경기장 정보 가져오기
      ArrayList<MatchingDTO> courtList = new ArrayList<MatchingDTO>();
      courtList = matchingService.courtList();
      /*
       * for (int i = 0; i < courtList.size(); i++) {
       * logger.info("idx : "+courtList.get(i).getLocationIdx()); }
       */
      logger.info("locationIdx : " + courtList);
      model.addAttribute("courtList", courtList);

      return "/matching/matchingWriteForm";
   }

   @RequestMapping(value = "/matching/write.do")
   public String matchingWrite(@RequestParam HashMap<String, String> params, HttpSession session) {

      logger.info("모집글 작성 정보 : " + params);

      MatchingDTO matchingDto = new MatchingDTO();
      matchingDto.setCategoryId(params.get("categoryId"));
      matchingDto.setContent(params.get("content"));
      matchingDto.setCourtIdx(Integer.parseInt(params.get("courtIdx")));
      matchingDto.setGameDate(params.get("gameDate"));

      matchingDto.setGamePlay(params.get("gamePlay"));
      matchingDto.setMatchingNum(Integer.parseInt(params.get("matchingNum")));
      matchingDto.setSubject(params.get("subject"));
      matchingDto.setWriterId(params.get("writerId"));

      matchingService.matchingWrite(matchingDto);

      matchingDto.setGameAppState("확정");

      matchingService.game(matchingDto);
      int matchingIdx = matchingDto.getMatchingIdx();
      
      String path = "redirect:/matching/detail.go?matchingIdx=" + matchingIdx;
      
      if(params.get("categoryId").equals("m02")) {
         path = "redirect:/matching/teamDetail.go?matchingIdx=" + matchingIdx;
      }

      return path;
   }

   @RequestMapping(value = "/matching/update.go")
   public String matchingUpdateGo(@RequestParam String matchingIdx, Model model, HttpSession session) {

      logger.info(matchingIdx + "번 모집글 수정");


      // 로그인 정보 받아 와 작성자 저장
      logger.info("session" + session.getAttribute("loginId"));
      String writerId = (String) session.getAttribute("loginId");
      model.addAttribute("writerId", writerId);

      // 저장된 작성자아이디를 이용해 사용자의 등록된 선호 위치 저장
      MatchingDTO writerData = new MatchingDTO();
      writerData = matchingService.matchingWriterData(writerId);
      model.addAttribute("writerData", writerData);

      // 지역 리스트 가져오기
      ArrayList<MatchingDTO> locationList = new ArrayList<MatchingDTO>();
      locationList = matchingService.locationList();
      model.addAttribute("locationList", locationList);

      // 경기장 정보 가져오기
      ArrayList<MatchingDTO> courtList = new ArrayList<MatchingDTO>();
      courtList = matchingService.courtList();
      /*
       * for (int i = 0; i < courtList.size(); i++) {
       * logger.info("idx : "+courtList.get(i).getLocationIdx()); }
       */
      logger.info("locationIdx : " + courtList);
      model.addAttribute("courtList", courtList);
      
      // 수정할 글 정보
      MatchingDTO matchingDto = new MatchingDTO();
      matchingDto = matchingService.matchingDetail(matchingIdx);
      model.addAttribute("dto", matchingDto);

      return "/matching/matchingUpdateForm";
   }

   @RequestMapping(value = "/matching/update.do")
   public String matchingUpdate(@RequestParam HashMap<String, String> params) {

      logger.info("수정데이터" + params);

      matchingService.matchingUpdate(params);
      
      String categoryId = matchingService.categoryIdChk(params.get("matchingIdx"));
      
      String path = "redirect:/matching/detail.go?matchingIdx=" + params.get("matchingIdx");
      
      if(categoryId.equals("m02")) {
         path = "redirect:/matching/teamDetail.go?matchingIdx=" + params.get("matchingIdx");
      }
      return path;
   }

   @RequestMapping(value = "/matching/delete.do")
   public String matchingDelete(@RequestParam String matchingIdx, HttpSession session) {

      logger.info(matchingIdx + "번 모집글 삭제");
      String writerId = (String)session.getAttribute("loginId");
      logger.info("writerId" + writerId);
      
      String categoryId = matchingService.categoryIdChk(matchingIdx);
      matchingService.delete(matchingIdx,writerId);
      String path = "redirect:/matching/list.do";
      if(categoryId.equals("m02")) {
         path = "redirect:/matching/teamList.do";
      }
   
      return path;
   }
   
   
   
   

   @RequestMapping(value = "/matching/commentWrite.do")
   public String commentWrite(@RequestParam HashMap<String, String> params) {

      logger.info("댓글 정보" + params);

      matchingService.commentWrite(params);
      matchingService.downHit(params.get("comentId"));
      
      String path = "redirect:/matching/detail.go?matchingIdx=" + params.get("comentId");
      if(params.get("categoryId").equals("m02")) {
         path = "redirect:/matching/teamDetail.go?matchingIdx=" + params.get("comentId");
      }
      
      return path;
   }
   
   @RequestMapping(value = "/matching/commentDelete.do")
   public String commentDelete(@RequestParam String commentIdx,@RequestParam String matchingIdx) {

      logger.info("댓글 정보 commentIdx : " + commentIdx);
      matchingService.commentDelete(commentIdx);
      matchingService.downHit(matchingIdx);
      
      String categoryId = matchingService.categoryIdChk(matchingIdx);

      String path = "redirect:/matching/detail.go?matchingIdx=" + matchingIdx ;
      if(categoryId.equals("m02")) {
         path = "redirect:/matching/teamDetail.go?matchingIdx=" + matchingIdx ;
      }
   
      return path;
   }
   
   @RequestMapping(value = "/matching/commentUpdate.go")
   public String commentUpdateGo(@RequestParam String commentIdx,@RequestParam String matchingIdx, Model model, HttpSession session) {
      
      if(session.getAttribute("loginId") == null) {logger.info("로그인된 아이디가 없습니다. ");}
      logger.info("댓글 정보 commentIdx : " + commentIdx);
      
      // 모집글 내용
      MatchingDTO matchingDto = new MatchingDTO();
      matchingDto = matchingService.matchingDetail(matchingIdx);
      model.addAttribute("dto", matchingDto);

      // 해당 모집글의 댓글 불러 오기
      ArrayList<MatchingDTO> commentList = new ArrayList<MatchingDTO>();
      commentList = matchingService.commentList(matchingIdx);
      model.addAttribute("commentList", commentList);
      logger.info("모집글 commentList : " + commentList);
      
      
      // 로그인 정보가 없을 시
      if(session.getAttribute("loginId") == null) {
         model.addAttribute("loginId", "guest");
      }
      // 로그인 정보가 있을 시
      if(session.getAttribute("loginId") != null) {      
      // 해당 경기 참가자 정보
         ArrayList<MatchingDTO> playerList = new ArrayList<MatchingDTO>();
         playerList = matchingService.playerList(matchingIdx);
         model.addAttribute("playerList", playerList);
         
         
         // 해당 경기 신청자 목록
         ArrayList<MatchingDTO> gameApplyList = new ArrayList<MatchingDTO>();
         gameApplyList = matchingService.gameApplyList(matchingIdx);
         model.addAttribute("gameApplyList", gameApplyList);
         
         // 전체 회원 목록 (신청자 목록, 경기 참가자 목록에 있는 사람 제외)
         ArrayList<MatchingDTO> userList = new ArrayList<MatchingDTO>();
         userList = matchingService.userList(matchingIdx);
         model.addAttribute("userList", userList);
         
         // 해당 경기 초대 목록
         ArrayList<MatchingDTO> gameInviteList = new ArrayList<MatchingDTO>();
         gameInviteList = matchingService.gameInviteList(matchingIdx);
         model.addAttribute("gameInviteList", gameInviteList);


         // 수정할 댓글 commentIdx
         MatchingDTO commentDto = new MatchingDTO();
         commentDto = matchingService.commentGet(commentIdx);
         logger.info("수정할 코멘트 내용"+commentDto.getCommentContent());
         model.addAttribute("commentDto", commentDto);

			
			// 리뷰 작성 여부 
			String review = "no";
			int num = matchingService.review(matchingIdx,(String)session.getAttribute("loginId"));
			if (num != 0) {
				review = "yes";
			}
			model.addAttribute("review", review);
			
		

		}
		
		// MVP 결과 
				ArrayList<MatchingDTO> playerList = new ArrayList<MatchingDTO>();
				playerList = matchingService.playerList(matchingIdx);
				
				int mvpChk = playerList.size()/2; 
				logger.info("mvp  최소 득표수 : " + mvpChk);
				String mvp = "mvp미정";
				
				ArrayList<HashMap<String, String>> mvpCnt = matchingService.mvpCnt(matchingIdx);
				
				for (int i = 0; i < mvpCnt.size(); i++) {
					HashMap<String, String> map = mvpCnt.get(i);
					String realCnt = "";
					String realId = "";
					for(String key : map.keySet()){
						String value = String.valueOf(map.get(key));
						logger.info(key+" : "+value);
						if(key.equals("cnt")) {
							realCnt=String.valueOf(map.get(key));
						}
						if(key.equals("receiveId")) {
							realId=String.valueOf(map.get(key));
						}
					}
					if(Integer.parseInt(realCnt)>mvpChk) {
						mvp = realId;
					}
					
				}
				
				model.addAttribute("mvp",mvp);
				
				
				
					
		return "/matching/matchingCommentUpdate" ;
	}
	
	@RequestMapping(value = "/matching/commentUpdate.do")
	public String commentUpdateGo(@RequestParam HashMap<String, String> params) {
		
		matchingService.commentUpdate(params);
		String matchingIdx = params.get("matchingIdx");
		logger.info("matchingIdx"+matchingIdx);		
		return "redirect:/matching/detail.go?matchingIdx="+matchingIdx ;
	}
	
	@RequestMapping(value="/matching/matchigStateUpdate")
	public String matchigStateUpdate(@RequestParam String matchingIdx, @RequestParam String matchigState) {
		
		if(matchigState.equals("matching")) {
			matchingService.matchigStateToFinish(matchingIdx,matchigState);
		}
		if(matchigState.equals("finish")) {
			matchingService.matchigStateToReview(matchingIdx,matchigState);
			ArrayList<MatchingDTO> alarmList = matchingService.playerList(matchingIdx);
			for (int i = 0; i < alarmList.size(); i++) {
				String userId = alarmList.get(i).getUserId();
				matchingService.reviewAlarm(userId,matchingIdx);
			}
		}
		
		matchingService.downHit(matchingIdx);
		
		String categoryId = matchingService.categoryIdChk(matchingIdx);

		String path = "redirect:/matching/detail.go?matchingIdx=" + matchingIdx ;
		if(categoryId.equals("m02")) {
			path = "redirect:/matching/teamDetail.go?matchingIdx=" + matchingIdx ;
		}
	
		return path;
	}
	
	@RequestMapping(value="/matching/playerDelete")
	public String playerDelete(@RequestParam String matchingIdx, @RequestParam String userId) {
		
		matchingService.playerDelete(matchingIdx,userId);
		
		String categoryId = matchingService.categoryIdChk(matchingIdx);
		
		String path = "redirect:/matching/detail.go?matchingIdx=" + matchingIdx;
		
		if(categoryId.equals("m02")) {
			path = "redirect:/matching/teamDetail.go?matchingIdx=" + matchingIdx;
		}
		
		matchingService.downHit(matchingIdx);
		return path;
	}
	
	@RequestMapping(value="/matching/applyGame")
	public String applyGame(@RequestParam String matchingIdx, HttpSession session) {
		
		String userId = (String)session.getAttribute("loginId");
		int applyGameChk = matchingService.applyGameChk(matchingIdx,userId);
		int playListChk = matchingService.playChk(userId, matchingIdx);
		
		if(applyGameChk == 0 && playListChk==0) {
			matchingService.applyGame(matchingIdx,userId);
		}
		
		
		matchingService.downHit(matchingIdx);
		
		String categoryId = matchingService.categoryIdChk(matchingIdx);

      String path = "redirect:/matching/detail.go?matchingIdx=" + matchingIdx ;
      if(categoryId.equals("m02")) {
         path = "redirect:/matching/teamDetail.go?matchingIdx=" + matchingIdx ;
      }
   
      return path;
   }
	
	@RequestMapping(value="/matching/gameApplyAccept")
	   public String gameApplyAccept(@RequestParam String matchingIdx, @RequestParam String userId) {
	      
		// 참가자 명단에 없다면 수락
		  int playListChk = matchingService.playChk(userId, matchingIdx);
		  if(playListChk==0) {
			   matchingService.gameApplyAccept(matchingIdx,userId);
		  }
	     
	      // Redirect라서 조회수 -1해주기
	      matchingService.downHit(matchingIdx);
	      
	      // 모집글 종류에 따라서 redirect지정
	      String categoryId = matchingService.categoryIdChk(matchingIdx);

	      String path = "redirect:/matching/detail.go?matchingIdx=" + matchingIdx ;
	      if(categoryId.equals("m02")) {
	         path = "redirect:/matching/teamDetail.go?matchingIdx=" + matchingIdx ;
	      }
	   
	      return path;
	   }
   
   @RequestMapping(value="/matching/gameApplyReject")
   public String gameApplyReject(@RequestParam String matchingIdx, @RequestParam String userId) {
      
      matchingService.gameApplyReject(matchingIdx,userId);
      
      matchingService.downHit(matchingIdx);
      
      String categoryId = matchingService.categoryIdChk(matchingIdx);

      String path = "redirect:/matching/detail.go?matchingIdx=" + matchingIdx ;
      if(categoryId.equals("m02")) {
         path = "redirect:/matching/teamDetail.go?matchingIdx=" + matchingIdx ;
      }
   
      return path;
   }
   

   @RequestMapping(value ="/matching/gameInvite.ajax")
   @ResponseBody
   public HashMap<String, Object> gameInvite(@RequestParam HashMap<String, Object> params) {
      logger.info("params : " + params);
      String matchingIdx = String.valueOf(params.get("matchingIdx"));
      String categoryId = matchingService.categoryIdChk(matchingIdx);
      
      params.put("categoryId", categoryId);
      
      matchingService.gameInvite(params);
      
      logger.info("params : " + params);
      HashMap<String, Object> data = new HashMap<String, Object>();
      data.put("msg", "초대 성공");
      return data;
   }
   
   @RequestMapping(value ="/matching/cancelGameInvite.ajax")
   @ResponseBody
   public HashMap<String, Object> cancelGameInvite(@RequestParam HashMap<String, Object> params) {
      logger.info("params : " + params);
      matchingService.cancelGameInvite(params);
      HashMap<String, Object> data = new HashMap<String, Object>();
      data.put("msg", "초대 취소 성공");
      return data;
   }
   
   
   
   
   @RequestMapping(value ="/matching/matchingReport.go")
   public String matchingReportGo(Model model,@RequestParam String matchingIdx,@RequestParam String reportUserId, HttpSession session) {
      
      MatchingDTO dto = new MatchingDTO();
      dto.setMatchingIdx(Integer.parseInt(matchingIdx));
      dto.setReportUserId(reportUserId);
      
      model.addAttribute("dto", dto);
      
      return "/matching/matchingReport";
   }
   
   @RequestMapping(value ="/matching/matchingReport.do")
   public String matchingReport(@RequestParam HashMap<String, String> params) {
      logger.info("params"+params);
      
      params.put("reportContent", params.get("report")+params.get("content"));
      matchingService.matchingReport(params);
      
      return "/matching/matchingReportDone";
   }
   
   @RequestMapping(value ="/matching/commentReport.go")
   public String commentReportGo(Model model,@RequestParam String commentIdx, @RequestParam String reportUserId,HttpSession session) {
      
      MatchingDTO dto = new MatchingDTO();
      dto.setCommentIdx(commentIdx);
      dto.setReportUserId(reportUserId);
      
      model.addAttribute("dto", dto);
      
      return "/matching/commentReport";
   }
   
   @RequestMapping(value ="/matching/commentReport.do")
   public String commentReport(@RequestParam HashMap<String, String> params) {
      logger.info("params"+params);
      
      params.put("reportContent", params.get("report")+params.get("content"));
      matchingService.commentReport(params);
      
      return "/matching/matchingReportDone";
   }
   
   
}