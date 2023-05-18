package kr.co.cf.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.cf.matching.service.MatchingService;
import kr.co.cf.member.service.AlarmService;

@Controller
public class AlarmController {
	
	@Autowired AlarmService alramService;
	@Autowired MatchingService matchingService;

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/userGameAlarm")
	public String userGameAlarm() {
		
		return "/alarm/gameAlarm";
	}
	
	@RequestMapping(value="/userGameAlarm.ajax")
	@ResponseBody
	   public HashMap<String, Object> userGameAlarm(@RequestParam HashMap<String, Object> params) {
	      logger.info("params : " + params);
	      
	      HashMap<String, Object> list = new HashMap<String, Object>();
	      
	      list = alramService.list(params);
	   
	      return list;   
	      
	   }
	
	@RequestMapping(value="/userNoticeAlarm")
	public String userNoticeAlarm() {
		
		return "/alarm/noticeAlarm";
	}
	
	@RequestMapping(value="/userNoticeAlarm.ajax")
	@ResponseBody
	   public HashMap<String, Object> userNoticeAlarm(@RequestParam HashMap<String, Object> params) {
	      logger.info("params : " + params);
	      
	      HashMap<String, Object> list = new HashMap<String, Object>();
	      
	      list = alramService.noticeList(params);
	   
	      return list;   
	      
	 }

	
	@RequestMapping(value="/userWarningAlarm")
	public String userWarningAlarm() {
		
		return "/alarm/warningAlarm";
	}
	
	@RequestMapping(value="/userWarningAlarm.ajax")
	@ResponseBody
	   public HashMap<String, Object> userWarningAlarm(@RequestParam HashMap<String, Object> params) {
	      logger.info("params : " + params);
	      
	      HashMap<String, Object> list = new HashMap<String, Object>();
	      
	      list = alramService.warningList(params);
	   
	      return list;   
	      
	 }
	
	@RequestMapping(value="/userTeamAlarm")
	public String userTeamAlarm() {
		
		return "/alarm/teamAlarm";
	}
	
	@RequestMapping(value="/userTeamAlarm.ajax")
	@ResponseBody
	   public HashMap<String, Object> userTeamAlarm(@RequestParam HashMap<String, Object> params) {
	      logger.info("params : " + params);
	      
	      HashMap<String, Object> list = new HashMap<String, Object>();
	      
	      list = alramService.teamList(params);
	   
	      return list;   
	      
	 }
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value="/inviteAccept")
	public String inviteAccept(@RequestParam String matchingIdx, HttpSession session) {
		String userId =String.valueOf(session.getAttribute("loginId"));
		logger.info("matchingIdx : "+matchingIdx+" / userId : " + userId);
		
		// 초대 수락 할떄 생각해야 할것 
		// 1. game 테이블 확정으로 변경
		matchingService.inviteAccept(matchingIdx,userId);
		
		
		// 2. alarm 테이블에 초대 알림 삭제
		matchingService.inviteAlarmDelete(matchingIdx,userId);
		
		// 3. 만약 초대 받기 전에 해당 경기를 신청 했다면 
		int applyChk = matchingService.applyGameChk(matchingIdx, userId);
		if(applyChk!=0) {
			// 1. game 테이블 신청 내역을 삭제 해야함
			matchingService.applyGameDelete(matchingIdx, userId);
			
			// 2.  신청 알림을 삭제해야함
			matchingService.applyGameAlarmDelete(matchingIdx, userId);
		}
		
		
		
		return "/alarm/gameAlarm";
	}
	
	@RequestMapping(value="/inviteReject")
	public String inviteReject(@RequestParam String matchingIdx, HttpSession session) {
		String userId =String.valueOf(session.getAttribute("loginId"));
		logger.info("matchingIdx : "+matchingIdx+" / userId : " + userId);
		
		// 초대 거절할떄 생각해야 할 것 
		
		// 1. game 테이블애 초대 삭제 
		matchingService.inviteReject(matchingIdx,userId);
		
		
		// 2. alarm 테이블에 초대 알림 삭제
		matchingService.inviteAlarmDelete(matchingIdx,userId);
		
		// 3. 만약 초대 받기 전에 해당 경기를 신청 했다면 
		int applyChk = matchingService.applyGameChk(matchingIdx, userId);
		if(applyChk!=0) {
			// 1. game 테이블 신청 내역을 삭제 해야함
			matchingService.applyGameDelete(matchingIdx, userId);
			
			// 2.  신청 알림을 삭제해야함
			matchingService.applyGameAlarmDelete(matchingIdx, userId);
		}
		
		
		
		return "/alarm/gameAlarm";
	}
	
	
	@RequestMapping(value="/deleteAlarm.ajax")
	@ResponseBody
	public HashMap<String, Object> deleteAlarm(@RequestParam(value="delList[]") ArrayList<String> delList){
		// 배열로 받을 경우 @RequestParam에 value를 반드시 명시 해야함
		logger.info("delList : " + delList);
		return matchingService.delete(delList);
	}
}
