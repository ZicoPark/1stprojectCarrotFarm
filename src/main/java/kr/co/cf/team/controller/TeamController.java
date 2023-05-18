package kr.co.cf.team.controller;

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
import org.springframework.web.multipart.MultipartFile;

import kr.co.cf.matching.dto.MatchingDTO;
import kr.co.cf.team.dto.TeamDTO;
import kr.co.cf.team.service.TeamService;

@Controller
public class TeamController {
	
	@Autowired TeamService TeamService;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/team")
	public String list(HttpSession session, Model model) {		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : "+loginId);
		
		ArrayList<TeamDTO> locationList = new ArrayList<TeamDTO>();
	    locationList = TeamService.locationList();
	    model.addAttribute("locationList", locationList);
		
		if(loginId != null) {
			if(TeamService.teamUserChk(loginId) == 1) {
				model.addAttribute("teamUserChk", true);
			}
			
			String teamIdx = TeamService.getTeamIdx(loginId);
			logger.info("get teamIdx : "+teamIdx);
			model.addAttribute("teamIdx",teamIdx);
		}	
		
		String msg = (String) session.getAttribute("msg");
		logger.info(msg);
		if(msg != null) {
			model.addAttribute("msg",msg);
			//사용한 세션은 반드시 바로 삭제해야함
			session.removeAttribute("msg");
		}		
		return "/team/teamList";
	}
	
	@RequestMapping(value = "/team/teamList.go")
	public String teamList(HttpSession session, Model model) {
		
		String msg = (String) session.getAttribute("msg");
		logger.info(msg);
		if(msg != null) {
			model.addAttribute("msg",msg);
			//사용한 세션은 반드시 바로 삭제해야함
			session.removeAttribute("msg");
		}		
		return "redirect:/team";
	}

	@RequestMapping(value="/team/teamList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getList(HttpSession session, @RequestParam HashMap<String, Object> params){
		logger.info("list params : "+params);
		return TeamService.list(params);
	}

	@RequestMapping(value = "/team/teamRegist.go")
	public String teamRegistGo(HttpSession session, Model model) {
		
		String page = "redirect:/team";		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : "+loginId);
		
		if(loginId != null) {
			
			//현재 가입한 상태의 팀이 있는지 확인
			if(TeamService.teamUserChk(loginId) == 0) {
				page = "/team/teamRegist";
				model.addAttribute("loginId", loginId);
			}else {
				session.setAttribute("msg","하나의 팀에만 가입할 수 있습니다.");
			}
					
		}else {
			session.setAttribute("msg", "로그인 후 다시 시도해주세요!");
		}			
		return page;	
	}
	
	@RequestMapping(value = "/team/overlayTeamName.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> overlay(@RequestParam String teamName) {
		logger.info("overlay-controller : " + teamName);		
		return TeamService.overlay(teamName);
	}
	
	@RequestMapping(value = "/team/teamRegist.do", method = RequestMethod.POST)
	public String teamRegist(Model model,MultipartFile teamProfilePhoto,@RequestParam HashMap<String, String> params,HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		
		String page = TeamService.teamRegist(teamProfilePhoto,params,loginId);
		
		if(page != "") {
			session.setAttribute("msg","팀생성에 성공하였습니다.");
		}
		return page;
	}

	 @RequestMapping(value="/team/teamPage.go")
	   public String teamPage(Model model, @RequestParam String teamIdx,HttpSession session) {
	      logger.info("teamPage : "+teamIdx);
	      String page = "redirect:/team";      
	      
	      String loginId = (String) session.getAttribute("loginId");
	      logger.info("loginId : " + loginId);
	      
	      TeamDTO TeamDTO = TeamService.teamInfo(Integer.parseInt(teamIdx));
	      logger.info("teamInfo");
	      if(TeamDTO != null) {
	         model.addAttribute("team", TeamDTO);
	         
	         ArrayList<TeamDTO> list = TeamService.tagReview(Integer.parseInt(teamIdx));
	         logger.info("list : " + list.size());      
	         if(list != null) {            
	            model.addAttribute("list", list);   

	            //팀 신청 여부 확인
	            if(loginId != null) {
	               int row = TeamService.joinAppChk(Integer.parseInt(teamIdx),loginId);
	               logger.info("chkRow : "+row);
	               
	               if(row != 0){
	                  //해당 팀에 가입신청을 하지 않은 경우
	                  model.addAttribute("joinAppChk",true);
	                  logger.info("true");
	               }else if(row == 0){
	                  //해당 팀에 가입신청을 한 경우
	                  model.addAttribute("joinAppChk",false);
	               }
	               //해당 팀 팀장여부 확인
	               if(TeamService.teamLeadersChk(Integer.parseInt(teamIdx),loginId) == 1) {
	            	   model.addAttribute("teamLeadersChk",true);
	               }
	               
	            }   
	            
	            //가입신청 버튼 노출 여부 확인(로그인 안했을 경우)
	            if(session.getAttribute("loginId") == null) {
	               model.addAttribute("joinAppChk",false);
	               logger.info("false");
	            }
	            
	            //가입신청 버튼 노출 여부 확인(가입한 팀이 있을 경우)
	            if(session.getAttribute("loginId") != null) {
	               if(TeamService.teamJoinChk(loginId) == 0){
	                  logger.info("가입한 팀이 없음");   
	                  model.addAttribute("joinTeam",false);
	               }
	            }
	            
	            //팀 탈퇴 버튼 노출 여부 확인(해당 팀 가입 여부 확인)             
	            if(session.getAttribute("loginId") != null) {
	               if(TeamService.teamUserChk(Integer.parseInt(teamIdx),loginId) == 1){
	                  logger.info("해당 팀 팀원 확인");   
	                  model.addAttribute("teamUserChk",true);
	               }
	            }
	         }   
	         page = "/team/teamPage";
	      }      
	      
	      String msg = (String) session.getAttribute("msg");
	      if(msg != null) {
	         model.addAttribute("msg",msg);
	         //사용한 세션은 반드시 바로 삭제해야함
	         session.removeAttribute("msg");
	      }
	      return page;
	   }
	
	@RequestMapping(value="/team/teamPagePop.go")
	public String teamPagePop(Model model, @RequestParam String teamIdx,HttpSession session) {
		
		TeamDTO TeamDTO = TeamService.teamInfo(Integer.parseInt(teamIdx));
		logger.info("teamInfo");
		if(TeamDTO != null) {
			model.addAttribute("team", TeamDTO);
			
			ArrayList<TeamDTO> list = TeamService.tagReview(Integer.parseInt(teamIdx));
			logger.info("list : " + list.size());		
			if(list != null) {				
				model.addAttribute("list", list);					
			}				
		}
		return "/team/teamPagePop";
	}
	
	@RequestMapping(value="/team/teamPageUpdate.go")
	public String updateForm(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("updateForm : "+teamIdx);
		
		String page = "redirect:/team/teamPage.go";		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : "+loginId);
		
		if(loginId != null) {	
			String teamLeaderId = TeamService.getTeamLeader(Integer.parseInt(teamIdx));
			logger.info("teamLeaderId : "+teamLeaderId);
			if(teamLeaderId.equals(loginId)){
				logger.info("로그인확인&팀장확인 완료");
				TeamDTO TeamDTO = TeamService.updateForm(teamIdx);
				if(TeamDTO != null) {
					page = "/team/teamPageUpdate";
					model.addAttribute("team", TeamDTO);
				}
			}else {
				session.setAttribute("msg","팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);	
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);	
		}

		return page;
	}

	@RequestMapping(value = "/team/teamPageUpdate.do", method = RequestMethod.POST)
	public String teamPageUpdate(Model model,MultipartFile teamProfilePhoto,@RequestParam HashMap<String, String> params) {
		logger.info("teamPageUpdate " + params);
		
		String page = TeamService.teamPageUpdate(teamProfilePhoto,params);
		logger.info("update 완료");
		
		if(page != "") {
			model.addAttribute("msg","팀정보가 수정되었습니다.");
		}
		return page;
	}

	@RequestMapping(value="/team/teamDisbanding.go")
	public String disbandForm(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("DisbandingForm : "+teamIdx);			
		
		String page = "redirect:/team/teamPage.go";		
		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : "+loginId);
		
		if(loginId != null) {	
			if((TeamService.getTeamLeader(Integer.parseInt(teamIdx))).equals(loginId)){
				logger.info("로그인확인&팀장확인 완료");
					page = "/team/teamDisbanding";
					model.addAttribute("teamIdx", teamIdx);	
			}else {
				session.setAttribute("msg","팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}		
		return page;
	}
	
	@RequestMapping(value="/team/teamDisbanding.do")
	public String disband(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("Disbanding : "+teamIdx);			
		
		String page = "redirect:/team/teamPage.go";		
		
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId != null) {	
			if((TeamService.getTeamLeader(Integer.parseInt(teamIdx))).equals(loginId)){
				logger.info("로그인확인&팀장확인 완료");
					//팀 해체 신청
					if(TeamService.disband(Integer.parseInt(teamIdx)) == 1) {
						//팀 해체 신청 알림 전송
						TeamService.disbandAlarm(Integer.parseInt(teamIdx));
					}
					page = "redirect:/team/teamDisbandCancle.go?teamIdx="+teamIdx;
			}else {
				session.setAttribute("msg","팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}		
		return page;
	}
	
	@RequestMapping(value="/team/teamDisbandCancle.go")
	public String disbandCancleForm(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("disbandCancleForm : "+teamIdx);		

		String page = "redirect:/team/teamPage.go";		
		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : "+loginId);
		
		if(loginId != null) {	
			if((TeamService.getTeamLeader(Integer.parseInt(teamIdx))).equals(loginId)){
				logger.info("로그인확인&팀장확인 완료");
					model.addAttribute("teamIdx", teamIdx);		
					page = "/team/teamDisbandCancle";
			}else {
				session.setAttribute("msg","팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}			
		return page;
	}

	@RequestMapping(value="/team/teamDisbandCancle.do")
	public String disbandCancle(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("disbandCancle : "+teamIdx);			

		String page = "redirect:/team/teamPage.go";		
		
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId != null) {	
			if((TeamService.getTeamLeader(Integer.parseInt(teamIdx))).equals(loginId)){
				logger.info("로그인확인&팀장확인 완료");
				if(TeamService.disbandCancle(Integer.parseInt(teamIdx)) == 1) {
					model.addAttribute("teamIdx", teamIdx);	
					//팀 해체 신청 알림 전송
					TeamService.disbandCancleAlarm(Integer.parseInt(teamIdx));
					
					page = "redirect:/team/teamDisbanding.go";
				}	
				
			}else {
				session.setAttribute("msg","팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}	
		return page;
	}
	
	@RequestMapping(value="/team/teamGame.go")
	public String teamGameList(Model model, @RequestParam String teamIdx) {
		logger.info("teamGameList : "+teamIdx);		
		model.addAttribute("teamIdx", teamIdx);		
		return "/team/teamGame";
	}
	
	@RequestMapping(value="/team/gameList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> gameList(@RequestParam HashMap<String, Object> params){
		logger.info("list params : "+params);
		return TeamService.gameList(params);
	}
	
	@RequestMapping(value="/team/gameMatchingRequest.go")
	public String gameMatchingRequest(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("teamGameList : "+teamIdx);		

		String page = "redirect:/team/teamPage.go";				
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId != null) {	
			//로그인한 아이디가 팀장, 부팀장인지 확인
			if(TeamService.teamLeadersConf(Integer.parseInt(teamIdx),loginId) == 1){
				logger.info("로그인확인&직급확인 완료");
				model.addAttribute("teamIdx", teamIdx);	
				page = "/team/gameMatchingRequest";
			}else {
				session.setAttribute("msg","팀장, 부팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}	
		return page;
	}
	
	@RequestMapping(value="/team/gameMatchingRequest.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> gameMatchingRequest(@RequestParam HashMap<String, Object> params){
		logger.info("list params : "+params);
		return TeamService.gameMatchingRequest(params);
	}
	
	@RequestMapping(value="/team/teamJoinAppAlarm.go")
	public String teamJionAppAlarm(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("teamAlarm : "+teamIdx);		
		
		String page = "redirect:/team/teamPage.go";				
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId != null) {	
			//로그인한 아이디가 팀장, 부팀장인지 확인
			if(TeamService.teamLeadersConf(Integer.parseInt(teamIdx),loginId) == 1){
				logger.info("로그인확인&직급확인 완료");
				model.addAttribute("teamIdx", teamIdx);	
				page = "/team/teamJoinAppAlarm";
			}else {
				session.setAttribute("msg","팀장, 부팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}			
		return page;
	}
	
	//신청한 게임 모집글 변경사항 알림
	@RequestMapping(value="/team/appGameUpdateAlarm.go")
	public String appGameUpdateAlarm(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("appGameUpdateAlarm : "+teamIdx);			

		String page = "redirect:/team/teamPage.go";				
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId != null) {	
			//로그인한 아이디가 팀장, 부팀장인지 확인
			if(TeamService.teamLeadersConf(Integer.parseInt(teamIdx),loginId) == 1){
				logger.info("로그인확인&직급확인 완료");
				
				//모집중인 경기 참가신청 알림 불러오기
				ArrayList<TeamDTO> list = TeamService.appGameUpdateAlarm(teamIdx);
				logger.info("list size : "+list.size());
				
				model.addAttribute("list", list);
				model.addAttribute("teamIdx", teamIdx);	
				page = "/team/appGameUpdateAlarm";
				
			}else {
				session.setAttribute("msg","팀장, 부팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}			
		return page;
	}
	
	//경기 초대 알림
	@RequestMapping(value="/team/matchingInviteAlarm.go")
	public String matcingInviteAlram(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("matchingInviteAlarm : "+teamIdx);			

		String page = "redirect:/team/teamPage.go";				
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId != null) {	
			//로그인한 아이디가 팀장, 부팀장인지 확인
			if(TeamService.teamLeadersConf(Integer.parseInt(teamIdx),loginId) == 1){
				logger.info("로그인확인&직급확인 완료");
				
				//모집중인 경기 참가신청 알림 불러오기
				ArrayList<TeamDTO> list = TeamService.matchingInviteAlarm(teamIdx);
				logger.info("list size : "+list.size());
				
				model.addAttribute("list", list);
				model.addAttribute("teamIdx", teamIdx);	
				page = "/team/matchingInviteAlarm";
				
			}else {
				session.setAttribute("msg","팀장, 부팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}			
		return page;
	}
	
	//경기 참가신청 알림 
	@RequestMapping(value="/team/gameMatchingAppAlarm.go")
	public String gameMatchingAppAlarm(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("gameMatchingAppAlarm : "+teamIdx);			

		String page = "redirect:/team/teamPage.go";				
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId != null) {	
			//로그인한 아이디가 팀장, 부팀장인지 확인
			if(TeamService.teamLeadersConf(Integer.parseInt(teamIdx),loginId) == 1){
				logger.info("로그인확인&직급확인 완료");
				
				//모집중인 경기 참가신청 알림 불러오기
				ArrayList<TeamDTO> list = TeamService.gameMatchingAppAlarm(teamIdx);
				logger.info("list size : "+list.size());
				
				model.addAttribute("list", list);
				model.addAttribute("teamIdx", teamIdx);	
				page = "/team/gameMatchingAppAlarm";
				
			}else {
				session.setAttribute("msg","팀장, 부팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}			
		return page;
	}
	
	//작성한 모집글 리스트 보기
	@RequestMapping(value="/team/writeMatchingList.go")
	public String writeMatchingList(Model model, @RequestParam String teamIdx,HttpSession session) {
		logger.info("writeMatchingList : "+teamIdx);	
		
		String page = "redirect:/team/teamPage.go";				
		String loginId = (String) session.getAttribute("loginId");
		
		if(loginId != null) {	
			//로그인한 아이디가 팀장, 부팀장인지 확인
			if(TeamService.teamLeadersConf(Integer.parseInt(teamIdx),loginId) == 1){
				logger.info("로그인확인&직급확인 완료");
				
				//작성한 모집글 리스트 불러오기
				ArrayList<TeamDTO> list = TeamService.writeMatchingList(Integer.parseInt(teamIdx));
				logger.info("list size : "+list.size());
				model.addAttribute("list", list);
				model.addAttribute("teamIdx",teamIdx);
				page = "/team/writeMatchingList";
				
			}else {
				session.setAttribute("msg","팀장, 부팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}			
		return page;
	}
	
	@RequestMapping(value="/team/joinApp.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> joinApp(@RequestParam String teamIdx,HttpSession session,Model model){
		logger.info("joinApp teamIdx : "+teamIdx);
		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId"+loginId);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(loginId != null) {	
			logger.info("팀 가입여부 확인");
			//팀 가입여부 확인
			if(TeamService.teamJoinChk(loginId) == 0){
				logger.info("가입한 팀이 없음");	
				
				//강퇴회원 확인
				if(TeamService.removeChk(Integer.parseInt(teamIdx),loginId) == 1) {
					logger.info("강퇴회원");	
					map.put("removeChk", 1);
				}else {
					//팀 가입신청 테이블에 회원정보 저장
					if(TeamService.teamJoinApp(Integer.parseInt(teamIdx),loginId) == 1) {
						logger.info("신청 완료");	
						map.put("joinChk", 0);
					}
				}								
			}else {
				logger.info("가입한 팀이 있음");
				map.put("joinChk", 1);
			}
		}else {
			logger.info("로그인 안함");
			map.put("joinChk", "false");
		}			
		
		return map;
	}
	
	@RequestMapping(value="/team/joinCancel.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> joinCancel(@RequestParam String teamIdx,HttpSession session,Model model){		
		logger.info("teamIdx : "+teamIdx);
		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : " + loginId);
		
		HashMap<String, Object> map = new HashMap<String, Object>();

		//팀 신청 여부 확인
		if(loginId != null) {
			int row = TeamService.joinAppChk(Integer.parseInt(teamIdx),loginId);
			logger.info("chkRow : "+row);
			
			if(row == 1){
				TeamService.joinCancel(Integer.parseInt(teamIdx),loginId);
				logger.info("가입신청 취소 완료");
			}			
		}		
		return map;
	}
	
	@RequestMapping(value="/team/teamJoinAppList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> teamJoinAppList(@RequestParam String teamIdx){
		logger.info("teamJoinAppList teamIdx : "+teamIdx);
		return TeamService.teamJoinAppList(Integer.parseInt(teamIdx));
	}
	
	@RequestMapping(value="/team/teamJoinAccept.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> teamJoinAccept(@RequestParam String teamIdx, @RequestParam String userId){
		logger.info("teamJoinAccept "+ "teamIdx : "+teamIdx+ "userId : "+userId);
		return TeamService.teamJoinAccept(Integer.parseInt(teamIdx),userId);
	}
	
	@RequestMapping(value="/team/teamJoinReject.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> teamJoinReject(@RequestParam String teamIdx, @RequestParam String userId){
		logger.info("teamJoinReject "+ "teamIdx : "+teamIdx+ " / userId : "+userId);
		return TeamService.teamJoinReject(Integer.parseInt(teamIdx),userId);
	}
	
	@RequestMapping(value="/team/leaveTeam.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> leaveTeam(@RequestParam String teamIdx,HttpSession session){
		String userId = (String) session.getAttribute("loginId");
		logger.info("leaveTeam "+ "teamIdx : "+teamIdx+ " / userId : "+userId);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(userId != null) {
			if((TeamService.getTeamLeader(Integer.parseInt(teamIdx))).equals(userId)){
				logger.info("로그인확인&팀장확인 완료");
				
				//팀장권한 양도
				TeamService.teamGradeUpdate(Integer.parseInt(teamIdx),userId);
				logger.info("양도 완료");
			}
				map = 	TeamService.leaveTeam(Integer.parseInt(teamIdx),userId);
		}
		return map;
	}
	
	@RequestMapping(value = "/team/teamUserList.go")
	public String teamUserListForm(HttpSession session, Model model, @RequestParam String teamIdx) {
		logger.info("teamUserList : "+teamIdx);
		model.addAttribute("teamIdx",teamIdx);
		
		String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("loginId",loginId);
		return "/team/teamUserList";
	}
	
	@RequestMapping(value="/team/teamUserList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> teamUserList(@RequestParam HashMap<String, Object> params,HttpSession session){
		String loginId = (String) session.getAttribute("loginId");
		logger.info("teamUserList : "+loginId);

		if(loginId != null) {	
			params.put("userId", loginId);
		}else {
			params.put("userId", "로그인안함");
			logger.info("로그인안함");
		}

		return TeamService.teamUserList(params);
	}
	
	@RequestMapping(value = "/team/teamUserListLeader.go")
	public String teamUserListLeader(HttpSession session, Model model, @RequestParam String teamIdx) {
		logger.info("teamUserListLeader : "+teamIdx);
		model.addAttribute("teamIdx",teamIdx);
		
		String page = "redirect:/team/teamPage.go";
		
		String loginId = (String) session.getAttribute("loginId");
		if(loginId != null) {	
			if((TeamService.getTeamLeader(Integer.parseInt(teamIdx))).equals(loginId)){
				logger.info("로그인확인&팀장확인 완료");
					page = "/team/teamUserListLeader";
					model.addAttribute("teamIdx", teamIdx);	
			}else {
				session.setAttribute("msg","팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}		
		
		return page;
	}
	
	@RequestMapping(value="/team/teamUserListLeader.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> teamUserListLeader(@RequestParam HashMap<String, Object> params,HttpSession session){
		return TeamService.teamUserListLeader(params);
	}
	
	@RequestMapping(value="/team/changeTeamGrade.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> changeTeamGrade(@RequestParam HashMap<String, Object> params,HttpSession session){
		return TeamService.changeTeamGrade(params);
	}
	
	//팀원 경고 리스트 보기
	@RequestMapping(value = "/team/warningTeamUser.go")
	public String warningTeamUser(HttpSession session, Model model, @RequestParam String teamIdx) {
		logger.info("warningTeamUser : "+teamIdx);
		model.addAttribute("teamIdx",teamIdx);
		
		String page = "redirect:/team/teamPage.go";
		
		String loginId = (String) session.getAttribute("loginId");
		if(loginId != null) {	
			if((TeamService.getTeamLeader(Integer.parseInt(teamIdx))).equals(loginId)){
				logger.info("로그인확인&팀장확인 완료");
					page = "/team/warningTeamUser";
					model.addAttribute("teamIdx", teamIdx);	
			}else {
				session.setAttribute("msg","팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}		
		
		return page;
	}
	
	@RequestMapping(value="/team/warningList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> warningList(@RequestParam HashMap<String, Object> params,HttpSession session){
		return TeamService.warningList(params);
	}
	
	//경고
	@RequestMapping(value = "/team/warning.go")
	public String warningForm(HttpSession session, Model model,@RequestParam String teamIdx,@RequestParam String userId) {

		String page = "redirect:/team/teamPage.go";		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : "+loginId);
		
		if(loginId != null) {	
			//로그인한 아이디가 팀장, 부팀장인지 확인
			if(TeamService.teamLeadersConf(Integer.parseInt(teamIdx),loginId) == 1){
				logger.info("로그인확인&직급확인 완료");
				
				model.addAttribute("userId",userId);
				logger.info("warning userId : "+userId);
				
				model.addAttribute("teamIdx",teamIdx);
				logger.info("warning teamIdx : "+teamIdx);
				
				page = "/team/warningPop";
				
			}else {
				session.setAttribute("msg","팀장, 부팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}				
		return page;
	}
	
	@RequestMapping(value = "/team/warning.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> warning(HttpSession session, Model model,@RequestParam HashMap<String, Object> params) {		
		logger.info("warning : "+params);
		
		if(params.get("warning").equals("기타")) {
			params.put("reason", params.get("content"));
		}else {
			params.put("reason", params.get("warning"));
		}
			
		TeamService.warning(params);
		logger.info("경고완료");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", 1);
		
		return map;
	}
	
	//경고 취소
	@RequestMapping(value = "/team/warningCancel.go")
	public String warningCancelForm(HttpSession session, Model model,@RequestParam String teamIdx,@RequestParam String userId) {

		String page = "redirect:/team/teamPage.go";		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : "+loginId);
		
		if(loginId != null) {	
			//로그인한 아이디가 팀장, 부팀장인지 확인
			if(TeamService.teamLeadersConf(Integer.parseInt(teamIdx),loginId) == 1){
				logger.info("로그인확인&직급확인 완료");
				
				model.addAttribute("userId",userId);
				logger.info("warningCancel userId : "+userId);
				
				model.addAttribute("teamIdx",teamIdx);
				logger.info("warningCancel teamIdx : "+teamIdx);
				
				page = "/team/warningCancelPop";
				
			}else {
				session.setAttribute("msg","팀장, 부팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}				
		return page;
	}
	
	@RequestMapping(value = "/team/warningCancel.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> warningCancel(HttpSession session, Model model,@RequestParam HashMap<String, Object> params) {		
		logger.info("warningCancel : "+params);

		TeamService.warningCancel(params);
		logger.info("취소완료");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", 1);
		
		return map;
	}
	
	//팀원 강퇴
	@RequestMapping(value = "/team/remove.go")
	public String removeForm(HttpSession session, Model model,@RequestParam String teamIdx,@RequestParam String userId) {
		
		String page = "redirect:/team/teamPage.go";		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : "+loginId);
		
		if(loginId != null) {	
			//로그인한 아이디가 팀장, 부팀장인지 확인
			if(TeamService.teamLeadersConf(Integer.parseInt(teamIdx),loginId) == 1){
				logger.info("로그인확인&직급확인 완료");
				
				model.addAttribute("userId",userId);
				logger.info("remove userId : "+userId);
				
				model.addAttribute("teamIdx",teamIdx);
				logger.info("remove teamIdx : "+teamIdx);
				
				page = "/team/removePop";
				
			}else {
				session.setAttribute("msg","팀장, 부팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}					
	
		return page;
	}
	
	@RequestMapping(value = "/team/remove.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> remove(HttpSession session, Model model,@RequestParam HashMap<String, Object> params) {		
		logger.info("remove : "+params);

		if(TeamService.remove(params) == 1) {
			logger.info("강퇴완료");
			
			TeamService.removeAlarm(params);
			logger.info("알림전송 완료");
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", 1);
		
		return map;
	}
	
	//경고 히스토리 보기
	@RequestMapping(value = "/team/warningDetail.go")
	public String warningHistory(HttpSession session, Model model,@RequestParam String teamIdx,@RequestParam String userId) {
		logger.info("warningHistory");
		
		String page = "redirect:/team/teamPage.go";		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : "+loginId);
		
		if(loginId != null) {	

			ArrayList<TeamDTO> list = TeamService.warningHistory(Integer.parseInt(teamIdx),userId);
			logger.info("list : " + list.size());		
			if(list != null) {		
				

				if((TeamService.getTeamLeader(Integer.parseInt(teamIdx))).equals(loginId)){
					logger.info("팀장확인 완료");
						model.addAttribute("teamLeaderChk", true);	
				}				
				
				model.addAttribute("list", list);				
				model.addAttribute("userId",userId);
				model.addAttribute("teamIdx",teamIdx);
				logger.info("warningDetail userId : "+userId);

				page = "/team/warningHistory";
			}	

		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}			
		return page;
	}
	
	//즉시강퇴
	@RequestMapping(value = "/team/removeNow.go")
	public String removeNowForm(HttpSession session, Model model,@RequestParam String teamIdx,@RequestParam String userId) {

		String page = "redirect:/team/teamPage.go";		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : "+loginId);
		
		if(loginId != null) {	
			//로그인한 아이디가 팀장, 부팀장인지 확인
			if(TeamService.teamLeadersConf(Integer.parseInt(teamIdx),loginId) == 1){
				logger.info("로그인확인&직급확인 완료");
				
				model.addAttribute("userId",userId);
				logger.info("remove userId : "+userId);
				
				model.addAttribute("teamIdx",teamIdx);
				logger.info("remove teamIdx : "+teamIdx);
				
				page = "/team/removeNowPop";
				
			}else {
				session.setAttribute("msg","팀장, 부팀장만 접근 가능합니다.");	
				model.addAttribute("teamIdx", teamIdx);
			}
		}else {
			session.setAttribute("msg","로그인 후 다시 시도해주세요.");	
			model.addAttribute("teamIdx", teamIdx);
		}		
	
		return page;
	}
	
	@RequestMapping(value = "/team/removeNow.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> removeNow(HttpSession session, Model model,@RequestParam HashMap<String, Object> params) {		
		logger.info("removeNow : "+params);

		if(TeamService.remove(params) == 1) {
			logger.info("강퇴완료");
			
			if(params.get("remove").equals("기타")) {
				params.put("reason", params.get("content"));
			}else {
				params.put("reason", params.get("remove"));
			}
			TeamService.removeNowAlarm(params);
			logger.info("알림전송 완료");
		}
				
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", 1);
		
		return map;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
