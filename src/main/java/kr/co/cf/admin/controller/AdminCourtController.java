package kr.co.cf.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.cf.admin.dto.AdminCourtDTO;
import kr.co.cf.admin.service.AdminCourtService;


@Controller
public class AdminCourtController {
	@Autowired AdminCourtService adminCourtService;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/adminCourt")
	public String adminCourt(Model model) {
		return "/admin/adminCourt";
	}
	@RequestMapping(value="/adminCourtPage.ajax")
	@ResponseBody
	public HashMap<String, Object> adminCourtPage (@RequestParam HashMap<String, String> params){
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info(params.get("page"));
		if(params.get("courtSearch").equals("default")) {
			ArrayList<AdminCourtDTO> courtList = adminCourtService.courtListPage(params);
			map.put("courtList", courtList);
			int cnt = adminCourtService.courtListCnt();
			logger.info("전체 코트 수 :"+cnt);
			map.put("courtListCnt", cnt);
		}else {
			ArrayList<AdminCourtDTO> courtList = adminCourtService.courtListSearchPage(params);
			map.put("courtList", courtList);
			int cnt = adminCourtService.courtListSearchCnt(params);
			logger.info("전체 코트 수 :"+cnt);
			map.put("courtListCnt", cnt);
		}
		return map;
	}
	
	@RequestMapping(value="/adminCourtUpdate.go")
	public String adminCourtUpate(@RequestParam String courtIdx, Model model) {
		
		AdminCourtDTO dto = adminCourtService.courtInfo(courtIdx);
		model.addAttribute("courtInfo",dto);
		ArrayList<AdminCourtDTO> list = adminCourtService.selectGu();
		model.addAttribute("guList",list);
		return "/admin/adminCourtUpdate";
	}
	
	@RequestMapping(value="/adminCourtUpdate.do")
	public String adminCourtUpdateDo(@RequestParam HashMap<String, String> params) {
		logger.info("수정으로 넘어온 값들 :"+params);
		adminCourtService.courtUpdate(params);
		return "redirect:/adminCourt";
	}
	
	@RequestMapping(value="/adminCourtDelete.do")
	public String adminCourtDelete(@RequestParam String courtIdx) {
		logger.info("어떤 농구장 삭제 :"+courtIdx);
		adminCourtService.courtDelete(courtIdx);
		return "redirect:/adminCourt";
	}
	
	@RequestMapping(value="/adminCourtTipOff")
	public String adminCourtTipOff(Model model) {
		return "/admin/adminCourtTipOff";
	}
	
	@RequestMapping(value="/adminCourtTipOff.ajax")
	@ResponseBody
	public HashMap<String, Object> adminCourtTipOffpaging(@RequestParam HashMap<String, String> params){
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<AdminCourtDTO> dto = adminCourtService.courtTipOffList(params);
		map.put("courtTipOffList", dto);
		int cnt = adminCourtService.courtTipOffCnt();
		map.put("courtTipOffCnt", cnt);
		return map;
	}
	@RequestMapping(value="/adminCourtTIpOffRegist.go")
	public String adminCourtRegistGo(@RequestParam String courtTipOffIdx,Model model) {
		model.addAttribute("courtTipOffIdx",courtTipOffIdx);
		AdminCourtDTO dto = new AdminCourtDTO();
		dto=adminCourtService.courtTipOffInfo(courtTipOffIdx);
		model.addAttribute("courtTipOffInfo",dto);
		ArrayList<AdminCourtDTO> list = adminCourtService.selectGu();
		model.addAttribute("guList",list);
		return "/admin/adminCourtTipOffRegist";
	}
	@RequestMapping(value="/adminCourtTipOffRegist.do")
	public String adminCourtTipOffRegist(@RequestParam HashMap<String, String> params) {
		logger.info("경기장 등록 시 넘어오는 값 :"+params);
		String courtTipOffIdx=params.get("courtTipOffIdx");
		int row = adminCourtService.adminCourtRegist(params);
		if(row == 1) {
			adminCourtService.courtTipOffDelete(courtTipOffIdx);
		}
		return "redirect:/adminCourtTipOff";
	}
	@RequestMapping(value="/adminCourtTipOffDelete.do")
	public String adminCourtTipOffDelete(@RequestParam String courtTipOffIdx) {
		logger.info("어떤 제보 삭제? :"+ courtTipOffIdx);
		adminCourtService.courtTipOffDelete(courtTipOffIdx);
		return "redirect:/adminCourtTipOff";
	}
	
	@RequestMapping(value="/adminCourtReRegist.do")
	public String adminCourtReRegist(@RequestParam String courtIdx) {
		logger.info("어떤 경기장 재등록? :"+courtIdx);
		adminCourtService.courtReRegist(courtIdx);
		return "redirect:/adminCourt";
	}
	
	@RequestMapping(value="/adminCourtRegist.go")
	public String adminCourtRegistGo(Model model) {
		ArrayList<AdminCourtDTO> list = adminCourtService.selectGu();
		model.addAttribute("guList",list);
		return "/admin/adminCourtRegist";
	}
	@RequestMapping(value="/adminCourtRegist.do")
	public String adminCourtRegist(@RequestParam HashMap<String, String> params) {
		logger.info("경기장 등록 시 넘어오는 값 :"+params);
		adminCourtService.adminCourtRegist(params);
		return "redirect:/adminCourt";
	}
	
			
		
}
