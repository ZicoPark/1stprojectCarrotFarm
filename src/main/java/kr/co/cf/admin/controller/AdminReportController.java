package kr.co.cf.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.cf.admin.dto.AdminReportDTO;
import kr.co.cf.admin.service.AdminReportService;

@Controller
public class AdminReportController {
	
	@Autowired AdminReportService adminReportService;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/adminReport")
	public String adminReport() {
		return "/admin/adminReport";
	}
	@RequestMapping(value="/adminReportList.ajax")
	@ResponseBody
	public HashMap<String, Object> adminReportList(@RequestParam HashMap<String, String> params){
		logger.info("리스트 출력 :"+params);
		return adminReportService.adminReportList(params);
	}
	
	@RequestMapping(value="/adminReportDetail.go")
	public String adminReportDetailGO(@RequestParam HashMap<String, String> params, Model model) {
		String page;
		String adminRecordState = adminReportService.adminRecordState(params);
		logger.info(adminRecordState);
		if(adminRecordState == null || adminRecordState.equals("0")) {
			page="/admin/adminReportDetail";

		}else {
			page="/admin/adminReportDone";
		}
		logger.info("신고 상세보기 넘어오는 값들 :"+params);
		AdminReportDTO reportInfo = adminReportService.reportInfo(params);
		logger.info(reportInfo.getAddress());
		model.addAttribute("reportInfo",reportInfo);
		ArrayList<AdminReportDTO> recordList = adminReportService.recordList(params);
		if(recordList == null) {
			model.addAttribute("recordMsg","처리 결과가 없습니다.");
		}else {
			model.addAttribute("recordList",recordList);
		}
		
		String warningCount = adminReportService.warningCount(params);
		model.addAttribute("warningCount",warningCount);
		logger.info("경고 받은 횟수 :"+warningCount);
		if(warningCount==null) {
			logger.info("경고를 받은 적이 없습니다");
		}else {
			logger.info("경고 받은 횟수 :"+warningCount);
		}
		return page;
	}
	
	@RequestMapping(value="/adminReportPro.do")
	public String adminReportPro(@RequestParam HashMap<String, String> params) {
		logger.info("신고 처리시 넘어오는 값들 :"+params);
		adminReportService.adminReportPro(params);
		return "redirect:/adminReportDetail.go?reportIdx="+params.get("reportIdx")+"&reportId="+params.get("reportId")+"&categoryId="+params.get("categoryId")+"&reportUserId="+params.get("reportUserId");                       
	}	
	
	@RequestMapping(value="/adminReportCancel.go")
	public String adminReportCancelPage(@RequestParam HashMap<String, String> params) {
		logger.info("취소 시 넘어오는 값들: "+params);
		adminReportService.adminReportCancel(params);
		return "redirect:/adminReportDetail.go?reportIdx="+params.get("reportIdx")+"&reportId="+params.get("reportId")+"&categoryId="+params.get("categoryId");
	}
	
	@RequestMapping(value="/adminReportProcess.do")
	public String adminReport(@RequestParam HashMap<String, String> params) {
		logger.info("처리완료 버튼누를 시 넘어오는 값 :"+params);
		adminReportService.adminReportProcess(params);
		return "redirect:/adminReport";
	}

}
