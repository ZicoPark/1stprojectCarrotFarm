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


import kr.co.cf.team.dto.TeamBoardDTO;
import kr.co.cf.team.service.TeamBoardService;

@Controller
public class TeamBoardController {
	
	@Autowired TeamBoardService service;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	// 팀 사진첩 --------------------------------------------------------------------------------------------------------------------------
	
	@RequestMapping(value="/tplist.ajax", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> tpalist(@RequestParam String page, @RequestParam String search, @RequestParam String teamIdx){
		logger.info("search : " + search);
		logger.info("teamIdx ="+teamIdx);
		String userId=service.selectUserId(teamIdx);
		
		return service.tpalist(Integer.parseInt(page), search, userId);
		
	}
	
	@RequestMapping(value = "/teampictureboardList.do")
	public String tplist(Model model, HttpSession session, @RequestParam String teamIdx) {
		logger.info("session : " + session.getAttribute("loginId"));
		logger.info("tplist 불러오기");
		model.addAttribute("teamIdx" , teamIdx);
		String userId=service.selectUserId(teamIdx);
		ArrayList<TeamBoardDTO> tplist = service.tplist(userId);
		logger.info("tplist cnt : " + tplist.size());
		model.addAttribute("list", tplist);
		
		return "/board/teampictureboardList";
	}
	
	@RequestMapping(value="/teampictureboardWrite.go")
	public String tpwriteForm(Model model, HttpSession session,@RequestParam String teamIdx) {
		
		logger.info("글쓰기로 이동");
		model.addAttribute("userId", session.getAttribute("loginId"));
		model.addAttribute("teamIdx",teamIdx);
		return "/board/teampictureboardWriteForm";
	}
	
	@RequestMapping(value="/teampictureboardWrite.do", method=RequestMethod.POST)
	public String tpwrite(MultipartFile[] photo, @RequestParam HashMap<String, String> params) {
		logger.info("Params : " + params);
		logger.info("fileName : "+photo);
		return service.tpwrite(photo, params);
	}	
	
	@RequestMapping(value="/teampictureboardDetail.do")
	public String tpdetail(Model model, @RequestParam String bidx, HttpSession session, @RequestParam String teamIdx) {
		logger.info("tpdetail : " + bidx);
		String page = "redirect:/board/teampictureboardList.do";
		model.addAttribute("teamIdx",teamIdx);
		if(session.getAttribute("loginId") == null) {logger.info("로그인된 아이디가 없습니다. ");}
		logger.info("게시글 bidx : " + bidx + "번 상세보기");
		
		ArrayList<TeamBoardDTO> dto = service.tpdetail(bidx,"detail");
		
		if(dto != null) {
			page = "/board/teampictureboardDetail";
			model.addAttribute("dto", dto);

		}
	
		ArrayList<TeamBoardDTO> tpcommentList = new ArrayList<TeamBoardDTO>();
		tpcommentList = service.tpcommentList(bidx);
		model.addAttribute("tpcommentList", tpcommentList);
		logger.info("모집글 tpcommentList : " + tpcommentList);
		return "/board/teampictureboardDetail";

	}
	
	
	@RequestMapping(value = "/teampictureboardDelete.do")
	public String tpdelete(Model model, @RequestParam String bidx, @RequestParam String teamIdx) {
		model.addAttribute("teamIdx",teamIdx);
		service.tpdelete(bidx);
		return "redirect:/teampictureboardList.do";
	}
	
	@RequestMapping(value = "/teampictureboardUpdate.go")
	public String tpupdateForm(Model model, @RequestParam String bidx, @RequestParam String teamIdx) {
		logger.info("tpupdate : " + bidx);
		String page = "redirect:/board/teampictureboardList.do";
		
		ArrayList<TeamBoardDTO> dto = service.tpdetail(bidx,"/board/teampictureboardUpdate");
		model.addAttribute("teamIdx", teamIdx);
		if(dto != null) {
			page = "/board/teampictureboardUpdateForm";
			model.addAttribute("dto", dto);
		}
		
		return page;
	}
	
	@RequestMapping(value="/teampictureboardUpdate.do", method=RequestMethod.POST)
	public String tpupdate(MultipartFile photo, @RequestParam HashMap<String, String> params) {
		logger.info("Params : " + params);
		return service.tpupdate(photo, params);
	}
	

	@RequestMapping(value = "teampictureboardcommentWrite.do")
	public String tpcommentWrite(Model model, @RequestParam HashMap<String, String> params, @RequestParam String teamIdx) {
		model.addAttribute("teamIdx",teamIdx);
		logger.info("댓글 작성" + params);

		service.tpcommentWrite(params);
		return "redirect:/teampictureboardDetail.do?bidx=" + params.get("comentId")+"&teamIdx="+params.get("teamIdx");
	}
	
	@RequestMapping(value = "teampictureboardcommentDelete.do")
	public String tpcommentDelete(Model model, @RequestParam String commentIdx,@RequestParam String bidx, @RequestParam String teamIdx) {

		logger.info("댓글 지우기 commentIdx : " + commentIdx);
		model.addAttribute("teamIdx",teamIdx);
		service.tpcommentDelete(commentIdx);
		return "redirect:/teampictureboardDetail.do?bidx=" + bidx ;
	}
	
	
	@RequestMapping(value = "teampictureboardcommentUpdate.go")
	public String tpcommentUpdateGo(@RequestParam String commentIdx,@RequestParam String bidx, Model model, HttpSession session, @RequestParam String teamIdx) {

		logger.info("댓글 수정 commentIdx : " + commentIdx);
		model.addAttribute("teamIdx",teamIdx);
		//TeamBoardDTO dto = new TeamBoardDTO();
		ArrayList<TeamBoardDTO> dto = service.tpdetail(bidx, commentIdx);
		model.addAttribute("dto", dto);

		ArrayList<TeamBoardDTO> tpcommentList = new ArrayList<TeamBoardDTO>();
		tpcommentList = service.tpcommentList(bidx);
		model.addAttribute("tpcommentList", tpcommentList);
		logger.info("모집글 tpcommentList : " + tpcommentList);
		
		if(session.getAttribute("loginId") == null) {
			model.addAttribute("loginId", "guest");
		};
		
		
		if(session.getAttribute("loginId") != null) {
		TeamBoardDTO tpcommentDto = new TeamBoardDTO();
		tpcommentDto = service.tpcommentGet(commentIdx);
		logger.info("수정할 코멘트 내용 : " +tpcommentDto.getCommentContent());
		model.addAttribute("tpcommentDto", tpcommentDto);
				
		};
		

		model.addAttribute("bidxx", bidx);
		return "/board/teampictureboardCommentUpdate" ;
	}
	
	@RequestMapping(value = "teampictureboardcommentUpdate.do")
	public String tpcommentUpdateDo(@RequestParam HashMap<String, String> params) {

		service.tpcommentUpdate(params);
		logger.info("params : "+ params);		
		String bidx = params.get("bidx");
		String teamIdx = params.get("teamIdx");
		logger.info("bidx : "+ bidx);		
		return "redirect:/teampictureboardDetail.do?bidx="+bidx + "&teamIdx=" +  teamIdx;
	};
	
	@RequestMapping(value= "teampictureboardReport.go")
	public String tpboardReportGo(Model model, @RequestParam String bidx, HttpSession session) {
		
		TeamBoardDTO dto = new TeamBoardDTO();
		dto.setBidx(Integer.parseInt(bidx));
		
		model.addAttribute("dto", dto);
		return "/board/tpboardReportDo";
	};
	
	@RequestMapping(value= "teampictureboardReport.do")
	public String tpboardReportDo(@RequestParam HashMap<String, String> params) {
		logger.info("params : " + params);
		
		params.put("reportContent", params.get("report") + " : " + params.get("content"));
		service.tpboardReport(params);
		return "/board/tpboardReportSubmit";
	};
	
	@RequestMapping(value= "teampictureboardCReport.go")
	public String tpboardCReportGo(Model model, String commentIdx, HttpSession session) {
		
		TeamBoardDTO dto = new TeamBoardDTO();
		dto.setCommentIdx(commentIdx);
		
		model.addAttribute("dto", dto);
		return "/board/tpboardCommentReportDo";
	};
	
	@RequestMapping(value= "teampictureboardCReport.do")
	public String tpboardCReportDo(@RequestParam HashMap<String, String> params) {
		logger.info("params : " + params);
		
		params.put("reportContent", params.get("report") + " : " + params.get("content"));
		service.tpboardCommentReport(params);
		return "/board/tpboardReportSubmit";
	};
	
	
	// 자유 게시판 --------------------------------------------------------------------------------------------------------------------------
	
		@RequestMapping(value="/tflist.ajax", method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> tfalist(@RequestParam String page, @RequestParam String search){
			logger.info("search : " + search);
			
			return service.tfalist(Integer.parseInt(page), search);	
		}
		
		
		@RequestMapping(value = "/teamfreeboardList.do")
		public String tflist(Model model, HttpSession session) {
			logger.info("session : " + session.getAttribute("loginId"));
			logger.info("tflist 불러오기");
			ArrayList<TeamBoardDTO> tflist = service.tflist();
			logger.info("tflist cnt : " + tflist.size());
			model.addAttribute("tflist", tflist);
			
			return "/board/teamfreeboardList";
		}
		
		
		@RequestMapping(value="/teamfreeboardWrite.go")
		public String tfwriteForm(Model model, HttpSession session) {		
			logger.info("글쓰기로 이동");
			model.addAttribute("userId", session.getAttribute("loginId"));
			return "/board/teamfreeboardWriteForm";
		}
		
		
		@RequestMapping(value="/teamfreeboardWrite.do", method=RequestMethod.POST)
		public String tfwrite(MultipartFile photo, @RequestParam HashMap<String, String> params) {
			logger.info("Params : " + params);
			
			return service.tfwrite(photo, params);
		}
		
		
		@RequestMapping(value="/teamfreeboardDetail.do")
		public String tfdetail(Model model, @RequestParam String bidx, HttpSession session) {
			logger.info("tfdetail : " + bidx);
			String page = "redirect:/board/teamfreeboardList.do";
			
			if(session.getAttribute("loginId") == null) {logger.info("로그인된 아이디가 없습니다. ");}
			logger.info("게시글 bidx : " + bidx + "번 상세보기");
			
			TeamBoardDTO dto = service.tfdetail(bidx,"detail");
			
			if(dto != null) {
				page = "/board/teamfreeboardDetail";
				model.addAttribute("dto", dto);
				logger.info("사진이름" +dto.getPhotoName());
			}
			
			ArrayList<TeamBoardDTO> tfcommentList = new ArrayList<TeamBoardDTO>();
			tfcommentList = service.tfcommentList(bidx);
			model.addAttribute("tfcommentList", tfcommentList);
			logger.info("모집글 tfcommentList : " + tfcommentList);
			
			return page;
		}
		
		
		@RequestMapping(value = "/teamfreeboardDelete.do")
		public String tfdelete(@RequestParam String bidx) {
			service.tfdelete(bidx);
			
			return "redirect:/teamfreeboardList.do";
		}

		
		@RequestMapping(value = "/teamfreeboardUpdate.go")
		public String tfupdateForm(Model model, @RequestParam String bidx) {
			logger.info("tfupdate : " + bidx);
			String page = "redirect:/board/teamfreeboardList.do";
			TeamBoardDTO dto = service.tfdetail(bidx,"/board/teamfreeboardUpdate");
			
			if(dto != null) {
				page = "/board/teamfreeboardUpdateForm";
				model.addAttribute("dto", dto);
			}
		
			service.tfdownHit(bidx);
			
			return page;
		}
		
		
		@RequestMapping(value="/teamfreeboardUpdate.do", method=RequestMethod.POST)
		public String tfupdate(MultipartFile photo, @RequestParam HashMap<String, String> params) {
			logger.info("Params : " + params);
			
			return service.tfupdate(photo, params);
		}
		

		@RequestMapping(value = "teamfreeboardcommentWrite.do")
		public String tfcommentWrite(@RequestParam HashMap<String, String> params) {
			logger.info("댓글 작성" + params);
			service.tfcommentWrite(params);
			service.tfdownHit(params.get("comentId"));
			
			return "redirect: ./teamfreeboardDetail.do?bidx=" + params.get("comentId");
		}
		
		
		@RequestMapping(value = "teamfreeboardcommentDelete.do")
		public String tfcommentDelete(@RequestParam String commentIdx,@RequestParam String bidx) {
			logger.info("댓글 지우기 commentIdx : " + commentIdx);
			service.tfcommentDelete(commentIdx);
			service.tfdownHit(bidx);
			
			return "redirect: ./teamfreeboardDetail.do?bidx=" + bidx ;
		}
		
		
		@RequestMapping(value = "teamfreeboardcommentUpdate.go")
		public String tfcommentUpdateGo(@RequestParam String commentIdx,@RequestParam String bidx, Model model, HttpSession session) {

			logger.info("댓글 수정 commentIdx : " + commentIdx);
			TeamBoardDTO dto = new TeamBoardDTO();
			dto = service.tfdetail(bidx, commentIdx);
			model.addAttribute("dto", dto);
			
			ArrayList<TeamBoardDTO> tfcommentList = new ArrayList<TeamBoardDTO>();
			tfcommentList = service.tfcommentList(bidx);
			model.addAttribute("tfcommentList", tfcommentList);
			logger.info("모집글 tfcommentList : " + tfcommentList);
			
			if(session.getAttribute("loginId") == null) {
				model.addAttribute("loginId", "guest");
			};
			
			if(session.getAttribute("loginId") != null) {
			TeamBoardDTO tfcommentDto = new TeamBoardDTO();
			tfcommentDto = service.tfcommentGet(commentIdx);
			logger.info("수정할 코멘트 내용 : " +tfcommentDto.getCommentContent());
			model.addAttribute("tfcommentDto", tfcommentDto);
			};
			
			service.tfdownHit(bidx);
			
			return "/board/teamfreeboardCommentUpdate" ;
		}
		
		
		@RequestMapping(value = "teamfreeboardcommentUpdate.do")
		public String tfcommentUpdateDo(@RequestParam HashMap<String, String> params) {
			service.tfcommentUpdate(params);
			String bidx = params.get("bidx");
			logger.info("bidx : "+ bidx);		
			
			return "redirect: ./teamfreeboardDetail.do?bidx="+bidx ;
		};
		
		
		@RequestMapping(value= "teamfreeboardReport.go")
		public String tfboardReportGo(Model model, @RequestParam String bidx, HttpSession session) {
			TeamBoardDTO dto = new TeamBoardDTO();
			dto.setBidx(Integer.parseInt(bidx));
			model.addAttribute("dto", dto);
			
			return "/board/tpboardReportDo";
		};
		
		
		@RequestMapping(value= "teamfreeboardReport.do")
		public String tfboardReportDo(@RequestParam HashMap<String, String> params) {
			logger.info("params : " + params);	
			params.put("reportContent", params.get("report") + " : " + params.get("content"));
			service.tfboardReport(params);
			
			return "/board/tpboardReportSubmit";
		};
		
		@RequestMapping(value= "teamfreeboardCReport.go")
		public String tfboardCReportGo(Model model, String commentIdx, HttpSession session) {		
			TeamBoardDTO dto = new TeamBoardDTO();
			dto.setCommentIdx(commentIdx);
			model.addAttribute("dto", dto);
			
			return "/board/tpboardCommentReportDo";
		};
		
		
		@RequestMapping(value= "teamfreeboardCReport.do")
		public String tfboardCReportDo(@RequestParam HashMap<String, String> params) {
			logger.info("params : " + params);		
			params.put("reportContent", params.get("report") + " : " + params.get("content"));
			service.tfboardCommentReport(params);
			
			return "/board/tpboardReportSubmit";
		};
		
		
		
		
		// 공지사항 게시판 --------------------------------------------------------------------------------------------------------------------------
		
		
		@RequestMapping(value="/tnlist.ajax", method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> tnalist(@RequestParam String page, @RequestParam String search, @RequestParam String teamIdx){
			logger.info("search : " + search);
			logger.info("teamIdx :"+ teamIdx);
			String userId=service.selectUserId(teamIdx);
			logger.info(userId);
			return service.tnalist(Integer.parseInt(page), search,userId);	
		}
		
		
		@RequestMapping(value = "/teamnoticeboardList.do")
		public String tnlist(Model model, HttpSession session,@RequestParam String teamIdx) {
			logger.info("session : " + session.getAttribute("loginId"));
			logger.info("tnlist 불러오기");
			
			String userId=service.selectUserId(teamIdx);
			
			ArrayList<TeamBoardDTO> tnlist = service.tnlist(userId);
			logger.info("tnlist cnt : " + tnlist.size());
			model.addAttribute("tnlist", tnlist);
			model.addAttribute("teamIdx",teamIdx);
			
			return "/board/teamnoticeboardList";
		}
		
		
		@RequestMapping(value="/teamnoticeboardWrite.go")
		public String tnwriteForm(Model model, HttpSession session,@RequestParam String teamIdx) {		
			logger.info("글쓰기로 이동");
			model.addAttribute("userId", session.getAttribute("loginId"));
			model.addAttribute("teamIdx",teamIdx);
			return "/board/teamnoticeboardWriteForm";
		}
		
		
		@RequestMapping(value="/teamnoticeboardWrite.do", method=RequestMethod.POST)
		public String tnwrite(MultipartFile photo, @RequestParam HashMap<String, String> params) {
			logger.info("Params : " + params);
			
			return service.tnwrite(photo, params);
		}
		
		
		@RequestMapping(value="/teamnoticeboardDetail.do")
		public String tndetail(Model model, @RequestParam String bidx, HttpSession session, @RequestParam String teamIdx) {
			logger.info("tndetail : " + bidx);
			String page = "redirect:/board/teamnoticeboardList.do";
			
			if(session.getAttribute("loginId") == null) {logger.info("로그인된 아이디가 없습니다. ");}
			logger.info("게시글 bidx : " + bidx + "번 상세보기");
			
			TeamBoardDTO dto = service.tndetail(bidx,"detail");
			
			if(dto != null) {
				page = "/board/teamnoticeboardDetail";
				model.addAttribute("dto", dto);
				logger.info("사진이름" +dto.getPhotoName());
			}
			model.addAttribute("teamIdx",teamIdx);
			
			return page;
		}
		
		
		@RequestMapping(value = "/teamnoticeboardDelete.do")
		public String tndelete(@RequestParam String bidx) {
			service.tndelete(bidx);
			
			return "redirect:/teamnoticeboardList.do";
		}

		
		@RequestMapping(value = "/teamnoticeboardUpdate.go")
		public String tnupdateForm(Model model, @RequestParam String bidx) {
			logger.info("tnupdate : " + bidx);
			String page = "redirect:/board/teamnoticeboardList.do";
			TeamBoardDTO dto = service.tndetail(bidx,"/board/teamnoticeboardUpdate");
			
			if(dto != null) {
				page = "/board/teamnoticeboardUpdateForm";
				model.addAttribute("dto", dto);
			}
		
			service.tndownHit(bidx);
			
			return page;
		}
		
		
		@RequestMapping(value="/teamnoticeboardUpdate.do", method=RequestMethod.POST)
		public String tnupdate(MultipartFile photo, @RequestParam HashMap<String, String> params) {
			logger.info("Params : " + params);
			
			return service.tnupdate(photo, params);
		}
		
		@RequestMapping(value="/tnuserRight.ajax")
		@ResponseBody
		public String tnuserRight(HttpSession session){
			String loginId = String.valueOf(session.getAttribute("loginId"));
			logger.info(loginId);
			logger.info("통신성공");
			
			return service.tnuserRight(loginId);
		}
		
		
		
		// 문의 게시판 --------------------------------------------------------------------------------------------------------------------------
		
			@RequestMapping(value="/tilist.ajax", method = RequestMethod.POST)
			@ResponseBody
			public HashMap<String, Object> tialist(@RequestParam String page, @RequestParam String search){
				logger.info("search : " + search);
				
				return service.tialist(Integer.parseInt(page), search);	
			}
			
			
			@RequestMapping(value = "/teaminquiryboardList.do")
			public String tilist(Model model, HttpSession session) {
				logger.info("session : " + session.getAttribute("loginId"));
				logger.info("tilist 불러오기");
				ArrayList<TeamBoardDTO> tilist = service.tilist();
				logger.info("tilist cnt : " + tilist.size());
				model.addAttribute("tilist", tilist);
				
				return "/board/teaminquiryboardList";
			}
			
			
			@RequestMapping(value="/teaminquiryboardWrite.go")
			public String tiwriteForm(Model model, HttpSession session) {		
				logger.info("글쓰기로 이동");
				model.addAttribute("userId", session.getAttribute("loginId"));
				return "/board/teaminquiryboardWriteForm";
			}
			
			
			@RequestMapping(value="/teaminquiryboardWrite.do", method=RequestMethod.POST)
			public String tiwrite(MultipartFile photo, @RequestParam HashMap<String, String> params) {
				logger.info("Params : " + params);
				
				return service.tiwrite(photo, params);
			}
			
			
			@RequestMapping(value="/teaminquiryboardDetail.do")
			public String tidetail(Model model, @RequestParam String bidx, HttpSession session ) {
				logger.info("tidetail : " + bidx);
				String page = "redirect:/board/teaminquiryboardList.do";
				
				if(session.getAttribute("loginId") == null) {logger.info("로그인된 아이디가 없습니다. ");}
				logger.info("게시글 bidx : " + bidx + "번 상세보기");
				
				TeamBoardDTO dto = service.tidetail(bidx,"detail");
				
				if(dto != null) {
					page = "/board/teaminquiryboardDetail";
					model.addAttribute("dto", dto);
					logger.info("사진이름" +dto.getPhotoName());
				}
				
				ArrayList<TeamBoardDTO> ticommentList = new ArrayList<TeamBoardDTO>();
				ticommentList = service.ticommentList(bidx);
				model.addAttribute("ticommentList", ticommentList);
				logger.info("모집글 ticommentList : " + ticommentList);
				
				return page;
			}
			
			
			@RequestMapping(value = "/teaminquiryboardDelete.do")
			public String tidelete(@RequestParam String bidx) {
				service.tidelete(bidx);
				
				return "redirect:/teaminquiryboardList.do";
			}

			
			@RequestMapping(value = "/teaminquiryboardUpdate.go")
			public String tiupdateForm(Model model, @RequestParam String bidx) {
				logger.info("tiupdate : " + bidx);
				String page = "redirect:/board/teaminquiryboardList.do";
				TeamBoardDTO dto = service.tidetail(bidx,"/board/teaminquiryboardUpdate");
				logger.info("dto 들어갔음? : " + dto);
				
				if(dto != null) {
					page = "/board/teaminquiryboardUpdateForm";
					model.addAttribute("dto", dto);
				}
			
				service.tidownHit(bidx);
				
				return page;
			}
			
			
			@RequestMapping(value="/teaminquiryboardUpdate.do", method=RequestMethod.POST)
			public String tiupdate(MultipartFile photo, @RequestParam HashMap<String, String> params) {
				logger.info("Params : " + params);
				
				return service.tiupdate(photo, params);
			}
			

			@RequestMapping(value = "teaminquiryboardcommentWrite.do")
			public String ticommentWrite(@RequestParam HashMap<String, String> params) {
				logger.info("댓글 작성" + params);
				service.ticommentWrite(params);
				service.tidownHit(params.get("comentId"));
				
				return "redirect: ./teaminquiryboardDetail.do?bidx=" + params.get("comentId");
			}
			
			
			@RequestMapping(value = "teaminquiryboardcommentDelete.do")
			public String ticommentDelete(@RequestParam String commentIdx,@RequestParam String bidx) {
				logger.info("댓글 지우기 commentIdx : " + commentIdx);
				service.ticommentDelete(commentIdx);
				service.tidownHit(bidx);
				
				return "redirect: ./teaminquiryboardDetail.do?bidx=" + bidx ;
			}
			
			
			@RequestMapping(value = "teaminquiryboardcommentUpdate.go")
			public String ticommentUpdateGo(@RequestParam String commentIdx,@RequestParam String bidx, Model model, HttpSession session) {

				logger.info("댓글 수정 commentIdx : " + commentIdx);
				TeamBoardDTO dto = new TeamBoardDTO();
				dto = service.tidetail(bidx, commentIdx);
				model.addAttribute("dto", dto);
				
				ArrayList<TeamBoardDTO> ticommentList = new ArrayList<TeamBoardDTO>();
				ticommentList = service.ticommentList(bidx);
				model.addAttribute("ticommentList", ticommentList);
				logger.info("모집글 ticommentList : " + ticommentList);
				
				if(session.getAttribute("loginId") == null) {
					model.addAttribute("loginId", "guest");
				};
				
				if(session.getAttribute("loginId") != null) {
				TeamBoardDTO ticommentDto = new TeamBoardDTO();
				ticommentDto = service.ticommentGet(commentIdx);
				logger.info("수정할 코멘트 내용 : " +ticommentDto.getCommentContent());
				model.addAttribute("ticommentDto", ticommentDto);
				};
				
				service.tidownHit(bidx);
				
				return "/board/teaminquiryboardCommentUpdate" ;
			}
			
			
			@RequestMapping(value = "teaminquiryboardcommentUpdate.do")
			public String ticommentUpdateDo(@RequestParam HashMap<String, String> params) {
				service.ticommentUpdate(params);
				String bidx = params.get("bidx");
				logger.info("bidx : "+ bidx);		
				
				return "redirect: ./teaminquiryboardDetail.do?bidx="+bidx ;
			};
			
			@RequestMapping(value="/tiuserRight.ajax")
			@ResponseBody
			public String tiuserRight(HttpSession session){
				String loginId = String.valueOf(session.getAttribute("loginId"));
				logger.info(loginId);
				logger.info("통신성공");
				
				return service.tiuserRight(loginId);
			}
	
	
	
};