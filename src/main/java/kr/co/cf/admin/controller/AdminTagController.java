package kr.co.cf.admin.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.cf.admin.dto.AdminTagDTO;
import kr.co.cf.admin.service.AdminTagService;

@Controller
public class AdminTagController {
	
	@Autowired AdminTagService adminTagService;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/adminTag")
	public String adminTag() {
		return "/admin/adminTag";
	}
	
	@RequestMapping(value="/adminTagList.ajax")
	@ResponseBody
	public HashMap<String, Object> adminTagList(@RequestParam HashMap<String, String> params){
		return adminTagService.adminTagList(params);
	}
	
	@RequestMapping(value="/adminTagUpdate.go")
	public String adminTagUpdateGo(@RequestParam String tagIdx, Model model) {
		AdminTagDTO dto  = adminTagService.tagInfo(tagIdx);
		model.addAttribute("tagInfo",dto);
		return "/admin/adminTagUpdate";
	}
	
	@RequestMapping(value="/adminTagUpdate.do")
	public String adminTagUpdate(@RequestParam HashMap<String, String> params) {
		String tagContent = params.get("tagContent");
		int tagIdx= Integer.parseInt(params.get("tagIdx"));
		logger.info("수정할 내용: "+tagContent);
		adminTagService.tagUpdate(tagContent,tagIdx);
		return "redirect:/adminTagUpdate.go?tagIdx="+tagIdx;
	}
	
	@RequestMapping(value="/tagContentChk.ajax")
	@ResponseBody
	public HashMap<String, Object> tagContentChk(@RequestParam String tagContent){
		logger.info(tagContent);
		return adminTagService.tagContentChk(tagContent);
	}
	
	@RequestMapping(value="/adminTagRegist.go")
	public String adminTagRegistGo() {
		return "/admin/adminTagRegist";
	}
	
	@RequestMapping(value="/tagIdChk.ajax")
	@ResponseBody
	public HashMap<String, Object> tagIdChk(@RequestParam String tagId){
		logger.info(tagId);
		return adminTagService.tagIdChk(tagId);
	}
	
	@RequestMapping(value="adminTagRegist.do")
	public String adminTagRegist(@RequestParam HashMap<String, String> params) {
		logger.info("태그 등록시 넘어오는 값: "+params);
		adminTagService.tagRegist(params);
		return "redirect:/adminTagRegist.go";
	}
	@RequestMapping(value="adminCategory")
	public String adminCategory() {
		return "/admin/adminCategory";
	}
	
}
