package kr.co.cf.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.cf.admin.dto.AdminUserDTO;
import kr.co.cf.admin.service.AdminUserService;

@Controller
public class AdminUserController {
	
	@Autowired AdminUserService adminUserService;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/adminUser", method = RequestMethod.GET)
	public String home(Model model) {
		return "/admin/adminUser";
	}
	
	@RequestMapping(value="/adminUserList.ajax")
	@ResponseBody
	public HashMap<String, Object> adminUserList(@RequestParam HashMap<String, String> params){
		logger.info("params :"+params);
		return adminUserService.adminUserList(params);
	}
	
	@RequestMapping(value="/adminNicknameChange.do")
	public String adminNickNameChange(@RequestParam String userIdx,@RequestParam String userId) {
		logger.info("어떤 사람의 닉네임 변경? :"+userId+"/"+userIdx);
		adminUserService.nickNameChange(userIdx,userId);
		return "redirect:/adminUser";
	}
	
	@RequestMapping(value="/adminprofileChange.do")
	public String adminprofileChange(@RequestParam String userIdx,@RequestParam String userId) {
		logger.info("어떤 사람의 프로필 변경? :"+userId+"/"+userIdx);
		adminUserService.profileChange(userIdx,userId);
		return "redirect:/adminUser";
	}
	
	@RequestMapping(value="/adminNicknamesChange.ajax")
	@ResponseBody
	public HashMap<String, Object> adminNicknamesChange(@RequestParam(value="nickChangeList[]")ArrayList<String> nickChangeList) {
		logger.info("어떤 사람들 닉네임 변경?"+nickChangeList);
		return adminUserService.nickNamesChange(nickChangeList);
	}
	
	@RequestMapping(value="/adminProfilesChange.ajax")
	@ResponseBody
	public HashMap<String, Object> adminProfilesChange(@RequestParam(value="profileChangeList[]")ArrayList<String> profileChangeList) {
		logger.info("어떤 사람들 프로필 변경?"+profileChangeList);
		return adminUserService.profilesChange(profileChangeList);
	}
}
