package kr.co.cf.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.cf.admin.service.AdminTeamService;

@Controller
public class AdminTeamController {	
	
	@Autowired AdminTeamService adminTeamService;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/adminTeam")
	public String adminTeam() {
		return "/admin/AdminTeam";
	}
	
	@RequestMapping(value="/adminTeamList.ajax")
	@ResponseBody
	public HashMap<String, Object> adminTeamList(@RequestParam HashMap<String, String> params){
		logger.info("params :"+params);
		return adminTeamService.adminTeamList(params);
	}
	
	@RequestMapping(value="/adminTeamNameChange.do")
	public String adminNicknameChange(@RequestParam String teamIdx) {
		logger.info("몇번 팀 닉네임 변경? "+teamIdx);
		adminTeamService.adminTeamNameChange(teamIdx);
		return "redirect:/adminTeam";
	}
	
	@RequestMapping(value="/adminTeamProfileChange.do")
	public String adminTeamProfileChange(@RequestParam String teamIdx) {
		logger.info("몇번 팀 프로필 변경? "+teamIdx);
		adminTeamService.adminTeamProfileChange(teamIdx);
		return "redirect:/adminTeam";
	}
	
	@RequestMapping(value="/adminTeamNamesChange.ajax")
	@ResponseBody
	public HashMap<String, Object> adminTeamNamesChange(@RequestParam(value="teamNameChangeList[]")ArrayList<String> teamNameChangeList){
		logger.info("어떤 팀들 닉네임 수정? "+teamNameChangeList);
		return adminTeamService.adminTeamNamesChange(teamNameChangeList);
	}
	
	@RequestMapping(value="/adminTeamProfilesChange.ajax")
	@ResponseBody
	public HashMap<String, Object> adminTeamProfilesChange(@RequestParam(value="teamProfileChangeList[]")ArrayList<String> teamProfileChangeList){
		logger.info("어떤 팀들 프로필 수정? "+teamProfileChangeList);
		return adminTeamService.adminTeamProfilesChange(teamProfileChangeList);
	}
	
	
	
}
	
