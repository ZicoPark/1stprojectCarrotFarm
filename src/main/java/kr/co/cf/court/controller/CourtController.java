package kr.co.cf.court.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cf.court.dto.CourtDTO;
import kr.co.cf.court.service.CourtService;

@Controller
public class CourtController {
	@Autowired CourtService courtService;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping("/court")
	public String court(Model model) {
		
		
		ArrayList<CourtDTO> list = courtService.list();
		model.addAttribute("totalPages",list.size());
		model.addAttribute("courtList",list);
		ArrayList<CourtDTO> guList = courtService.guList();
		model.addAttribute("guList",guList);
		model.addAttribute("address", "서울특별시");
		return "court3";
	}
	
	@RequestMapping("/courtDetail.do")
	public String courtDetail(Model model, @RequestParam String courtIdx,HttpSession session) {
		logger.info("디테일 가기");
		logger.info(courtIdx);
		CourtDTO dto =courtService.courtDetail(courtIdx);
		model.addAttribute("courtInfo",dto);
		logger.info("경기장 정보 불러오기");
		ArrayList<CourtDTO> courtReviewList = courtService.courtReviewList(courtIdx);
		logger.info("리뷰 목록 "+courtReviewList);
		if(session.getAttribute("reviewMsg") != null) {
			String msg=(String)session.getAttribute("reviewMsg");
			session.removeAttribute("reviewMsg");
			model.addAttribute("msg",msg);
		}
		model.addAttribute("courtReviewList",courtReviewList);
		ArrayList<CourtDTO> reviewPhotoList = courtService.reviewPhotoList(courtIdx);
		for(int i=0;i<reviewPhotoList.size();i++) {
			logger.info("photoName :"+reviewPhotoList.get(i).getPhotoName());
		}
		model.addAttribute("reviewPhotoList",reviewPhotoList);
		return "courtDetail";
		
	}
	
	@RequestMapping("/courtNameSearch.do")
	public String courtNameSearch(Model model, @RequestParam String searchCourt) {
		String page;
		logger.info(searchCourt);
		CourtDTO courtdto = courtService.courtNameSearch(searchCourt);
		if(courtdto == null) {
			model.addAttribute("msg","검색 결과가 없습니다.");
			page = "redirect:/";
		}else {
			model.addAttribute("courtNameSerach",courtdto);
			page ="court2";
		}
		return page;
	}
	
	@RequestMapping(value="/courtReviewWrite.do", method = RequestMethod.POST)
	public String courtReviewWrite(Model model,@RequestParam HashMap<String, String> params,HttpSession session,MultipartFile photo) {
		logger.info("넘어오는 값: "+params);
		String userId = courtService.reviewWriter(params);
		logger.info(userId);
		String page = "redirect:/courtDetail.do?courtIdx="+params.get("courtIdx");
		if(userId==null) {
			page = courtService.courtReviewWrite(params,photo);
			logger.info("params : " + params);
		}else {
			session.setAttribute("reviewMsg","이미 리뷰를 작성하셨습니다.");
		}
		
		return page;
	}
	@RequestMapping(value="/courtReviewDelete.do")
	public String courtReviewDelete(@RequestParam HashMap<String, String> params) {
		logger.info("리뷰 삭제 시 받아오는 값 :"+params);
		courtService.courtReviewDelete(params);
		return "redirect:/courtDetail.do?courtIdx="+params.get("courtIdx");
	}
	
	@RequestMapping(value="/courtList.ajax")
	@ResponseBody
	public HashMap<String, Object> courtList(@RequestParam HashMap<String,String> params) {
		String gu=params.get("gu");
		String inOut=params.get("inOut");
		String type=params.get("type");
		String searchCourt=params.get("searchCourt");
		String page=params.get("page");
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(params.get("type").equals("courtSearch")){
			int totalList = courtService.searchTotalList(searchCourt);
			map.put("totalList",totalList);
			ArrayList<CourtDTO> courtSearch = courtService.courtSearch(searchCourt,page);
			map.put("courtList",courtSearch);
		}else {
			if(gu.equals("서울특별시")||gu.equals("none")) {
				gu = "";
			}
			if(inOut.equals("none")) {
				inOut="";
			}
			int totalList = courtService.sortTotalList(gu,inOut);
			map.put("totalList", totalList);
			ArrayList<CourtDTO> courtList = courtService.courtList(gu,inOut,page);
			map.put("courtList",courtList);
		}
		
		/*if(gu.equals("서울특별시")||gu.equals("none")) {
			ArrayList<CourtDTO> courtList = courtService.list();
			map.put("courtList", courtList);
		}else {
			ArrayList<CourtDTO> courtList = courtService.courtList(gu);
			map.put("courtList", courtList);
		}*/
		
		return map;
	}
	@RequestMapping(value="/courtPage.ajax")
	@ResponseBody
	public HashMap<String, Object> courtPage(@RequestParam HashMap<String,String> params) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<CourtDTO> paging = courtService.paging(params.get("page"));
		map.put("courtList", paging);
		return map;
		
	}
	
	@RequestMapping(value="/courtReviewUpdate.go")
	public String courtReviewUpdate(@RequestParam String courtReviewIdx, @RequestParam String courtIdx,Model model) {
		CourtDTO userCourtReview = courtService.userCourtReview(courtReviewIdx);
		model.addAttribute("userCourtReview",userCourtReview);
		CourtDTO userCourtReviewPhoto = courtService.userCourtReviewPhoto(courtReviewIdx);
		if(userCourtReviewPhoto!=null) {
			model.addAttribute("userCourtReviewPhoto",userCourtReviewPhoto);
		}
		return "courtReviewUpdate";
	}
	@RequestMapping(value="/courtReviewUpdate.do")
	public String userCourtReviewUpdate(@RequestParam HashMap<String, String> params, MultipartFile photo) {
		logger.info(params.get("courtStar"));
		courtService.reviewUpdate(params,photo);
		return "redirect:/courtReviewUpdate.go?courtReviewIdx="+params.get("courtReviewIdx")+"&courtIdx="+params.get("courtIdx");
	}
	@RequestMapping(value="/courtReviewPhoto.do")
	public String courtReviewPhoto(@RequestParam String courtIdx, Model model) {
		ArrayList<CourtDTO> courtReviewPhoto= courtService.reviewPhotoList(courtIdx);
		model.addAttribute("courtReviewPhoto",courtReviewPhoto);
		return "courtReviewPhoto";
		
	}
	@RequestMapping(value="/courtReviews.do")
	public String courtReviews(@RequestParam String courtIdx, Model model) {
		ArrayList<CourtDTO> courtReviews= courtService.courtReviewList(courtIdx);
		model.addAttribute("courtReviews",courtReviews);
		model.addAttribute("courtIdx",courtIdx);
		return "courtReviews";
		
	}
	@RequestMapping(value="/courtTipOff.go")
	public String courtTipOff() {
		return "courtTipOff";
	}
	@RequestMapping(value="/courtTipOff.do")
	public String courtTipOff(@RequestParam HashMap<String, String> params) {
		logger.info("경기장 제보에서 넘어온 값: "+params);
		courtService.courtTipOff(params);
		return "courtTipOff";
	}
	
	@RequestMapping(value="/courtReviewReport.go")
	public String courtReviewReportGo(@RequestParam HashMap<String, String> params,Model model) {
		logger.info("리뷰 신고 눌렀을 때 넘어오는 값들: "+params);
		model.addAttribute("courtReviewIdx",params.get("courtReviewIdx"));
		model.addAttribute("courtIdx",params.get("courtIdx"));
		model.addAttribute("reportUserId",params.get("reportUserId"));
		return "courtReviewReport";
	}
	@RequestMapping(value="/courtReviewReport.do")
	public String courtReviewReport(@RequestParam HashMap<String, String> params,Model model) {
		logger.info("리뷰 신고 제출 시 넘어오는 값들: "+params);
		params.put("reportContent",params.get("report")+" "+params.get("content"));
		courtService.courtReviewReport(params);
		return "redirect:/courtReviewReport.go?courtReviewIdx="+params.get("courtReviewIdx")+"&reportUserId="+params.get("reportUserId");
	}
}
