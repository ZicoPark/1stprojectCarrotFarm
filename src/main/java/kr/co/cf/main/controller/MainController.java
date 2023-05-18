package kr.co.cf.main.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cf.main.service.MainService;
import kr.co.cf.matching.dto.MatchingDTO;


@Controller
public class MainController {
	
	@Autowired MainService mainService;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value = "/")
	public String main(Model model,HttpSession session) {
		
		ArrayList<MatchingDTO> matchingList = new ArrayList<MatchingDTO>();
		matchingList = mainService.matchingList();
		model.addAttribute("matchingList", matchingList);
		
		ArrayList<MatchingDTO> teamList = new ArrayList<MatchingDTO>();
		teamList = mainService.teamList();
		model.addAttribute("teamList", teamList);
		
		ArrayList<MatchingDTO> noticeList = new ArrayList<MatchingDTO>();
		noticeList = mainService.noticeList();
		model.addAttribute("noticeList", noticeList);
		
		
		String msg = (String) session.getAttribute("msg");
	      logger.info(msg);
	      if(msg != null) {
	         model.addAttribute("msg",msg);
	         //사용한 세션은 반드시 바로 삭제해야함
	         session.removeAttribute("msg");
	      }    
		return "main";
	}
	
	@RequestMapping(value = "/GNB")
	public String gnb() {		
		return "GNB";
	}
}
