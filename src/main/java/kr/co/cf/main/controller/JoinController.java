package kr.co.cf.main.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.cf.main.dao.JoinDAO;
import kr.co.cf.main.dto.JoinDTO;
import kr.co.cf.main.service.JoinService;
import kr.co.cf.matching.dto.MatchingDTO;
import kr.co.cf.matching.service.MatchingService;

@Controller
public class JoinController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	
	@Autowired JoinService service;
	
	@Autowired MatchingService matchingService;
	
	@RequestMapping(value="/login")
	public String home() {
		return "login";
	}
	
	@RequestMapping(value = "/idChk.ajax", method = RequestMethod.POST)
	   @ResponseBody
	   public HashMap<String, Object> idChk(@RequestParam String userId) {
	      logger.info("idChk-controller");
	      return service.idChk(userId);
	}
	
	@RequestMapping(value = "/nickChk.ajax", method = RequestMethod.POST)
	   @ResponseBody
	   public HashMap<String, Object> nickChk(@RequestParam String nickName) {
	      logger.info("nickChk-controller");
	      return service.nickChk(nickName);
	   }
	
	@RequestMapping(value="/login.ajax")
	@ResponseBody
	public HashMap<String, Object> login(
			@RequestParam String id,@RequestParam String pw, 
			HttpSession session){
		
		logger.info(id+"/"+pw);
		JoinDTO dto = service.login(id,pw);

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		if(dto != null) {
			session.setAttribute("loginId", id);
			session.setAttribute("nickName", dto.getNickName());
			
			String loginPhotoName = service.findPhotoName(id);
			if(loginPhotoName == null) {
				loginPhotoName="기본프로필.png";
			}
			session.setAttribute("loginPhotoName", loginPhotoName);
			
			
			if(dto.getUserId().contains("admin")) {
				session.setAttribute("adminRight", "true");
				
			}
			map.put("user", dto);
		}
		

		
		return map;
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
       
       session.removeAttribute("loginId");
       if(session.getAttribute("adminRight")!=null) {
    	   
    	   session.removeAttribute("adminRight");
       }
       return "redirect:/";
    }

	/* 회원가입 */
	 @RequestMapping(value = "/join")
	    public String join(Model model) {
		 
	        return "join";
	    }
	 
	 @RequestMapping(value="/join.do", method = RequestMethod.POST)
		public String write(HttpSession session, Model model, MultipartFile userProfile, @RequestParam HashMap<String, String> params) {
		 String msg = service.write(userProfile,params);
			service.mannerDefalut(params.get("userId"));
			session.setAttribute("msg",msg);
			return "redirect:/";
		
	 }
	 
	 /* 아이디 찾기 */
	 @RequestMapping(value="/findIdView")
		public String findIdView() throws Exception{
			return"findIdView";
		}
		
		@RequestMapping(value="/findId")
		public String findId(JoinDTO dto,Model model) throws Exception{
			logger.info("email"+dto.getEmail());
					
			if(service.findIdCheck(dto.getEmail())==0) {
			model.addAttribute("msg", "해당 이메일이 존재하지 않습니다.");
			return "findIdView";
			}else {
			model.addAttribute("user", service.findId(dto.getEmail()));
			return "findId";
			}
		}
		
		/* 비밀번호 찾기 */
		@RequestMapping(value = "/findpw.go")
		public String findPwPOST1() throws Exception{
			return "findPw";
		}
		
		
		@RequestMapping(value = "/findpw")
		@ResponseBody
		public void findPwPOST(@RequestParam HashMap<String, String> params, Model model) throws Exception{
			logger.info("params : " + params);
			service.findPw(params);
		}
		
		@RequestMapping(value="/userdelete.go")
	      public String userdelete(HttpSession session) {  
	         
	         String page = "redirect:/";
	         
	         if(session.getAttribute("loginId") != null) {
	            page = "userDelete";
	         }
	         
	      return page;
	      }
	      
	      @RequestMapping(value="/userdelete.do")
	      public String userdeletetrue(HttpSession session) {  
	         
	         String page = "redirect:/";
	         
	         if(session.getAttribute("loginId") != null) {
	            service.userdeletetrue(session.getAttribute("loginId"));
	            session.removeAttribute("loginId");
	            page = "userDeleteComplete";
	         }
	         
	      return page;
	      }
	      
	      @RequestMapping(value="/userinfo.go")
	      public String userInfo(HttpSession session, Model model) {  
	         
	         String page = "login";      
	         
	         logger.info("아이디 : "+session.getAttribute("loginId"));
	         
	          if(session.getAttribute("loginId") != null) {
	             JoinDTO dto = service.userInfo(session.getAttribute("loginId"));             
	             model.addAttribute("user",dto);
	             page = "userInfo";
	          }
	         
	         return page;
	      }
	      
	      @RequestMapping(value = "/userinfoupdate.go")
	      public String userInfoUpdate(HttpSession session, Model model) {
	    	  
	    	String page = "redirect:/";		
	  		JoinDTO dto = service.userInfo(session.getAttribute("loginId"));
	  		if(dto != null) {
	  			page = "userInfoUpdate";
	  			model.addAttribute("user", dto);
	  		}				
	  		return page;
	  	}
	      
	      @RequestMapping(value="/userinfoupdate.do", method = RequestMethod.POST)
	  	  public String userInfoUpdate(HttpSession session, @RequestParam HashMap<String, String> params, Model model, MultipartFile photo) {
	  		logger.info("params : "+params);
	  		
	  		String path = service.userInfoUpdate(params,photo);
	  		
	  		String loginPhotoName = service.findPhotoName(params.get("userId"));
	  		
	  		session.setAttribute("loginPhotoName", loginPhotoName);
	  		
	  		return path;
	  	}
	      
	      
	      @RequestMapping(value="/mygames")
	  	public String myGameList(Model model,HttpSession session) {
	    	  if(session.getAttribute("loginId") != null) {
		             JoinDTO dto = service.userInfo(session.getAttribute("loginId"));             
		             model.addAttribute("user",dto);
		             
		          }
	    	  return "myGames";
	  	}
	  	
	  	@RequestMapping(value="/mygameList.ajax", method = RequestMethod.POST)
	  	@ResponseBody
	  	public HashMap<String, Object> myGameList(@RequestParam HashMap<String, Object> params){
	  		logger.info("myGameList params : "+params);
	  		return service.reviewList(params);
	  	}
	  	
	  	
	  	@RequestMapping(value="/allgames")
	  	public String allGameList(Model model,HttpSession session) {
	    	  if(session.getAttribute("loginId") != null) {
		             JoinDTO dto = service.userInfo(session.getAttribute("loginId"));             
		             model.addAttribute("user",dto);
		             
		          }
	    	  return "allGames";
	  	}
	  	
	  	@RequestMapping(value="/allgameList.ajax", method = RequestMethod.POST)
	  	@ResponseBody
	  	public HashMap<String, Object> allGameList(@RequestParam HashMap<String, Object> params){
	  		logger.info("allGameList params : "+params);
	  		return service.allGameList(params);
	  	}
	  	
	  	@RequestMapping(value="/userprofile.go")
	  	public String userprofile(@RequestParam String userId, Model model, HttpSession session) {
	  		logger.info(userId);
	  		ArrayList<JoinDTO> list= service.profileGames(userId);
	  		model.addAttribute("profileGames",list);
	  		
	  		JoinDTO dto = service.profileInfo(userId);
	  		model.addAttribute("profileInfo", dto);
	  		
	  		float mannerPoint = matchingService.mannerPoint(userId);
	  		model.addAttribute("mannerPoint", mannerPoint);
	  		
	  		 if(session.getAttribute("loginId") != null) {
	             dto = service.userInfo(session.getAttribute("loginId"));             
	             model.addAttribute("user",dto);
	             
	          }
	  		
	  		return "userProfile";
	  	}
	  	
	  	@RequestMapping(value="/userprofilepop.go")
	  	public String userProfilePop(@RequestParam String userId, Model model) {
	  		logger.info(userId);
	  		ArrayList<JoinDTO> list= service.profileGames(userId);
	  		model.addAttribute("profileGames",list);
	  		
	  		JoinDTO dto = service.profileInfo(userId);
	  		model.addAttribute("profileInfo", dto);
	  		
	  		float mannerPoint = matchingService.mannerPoint(userId);
	  		model.addAttribute("mannerPoint", mannerPoint);
	  		
	  		return "userProfilePop";
	  	}
	  	
	  	@RequestMapping(value = "/userReport.go")
	  	public String userReportPage(Model model, @RequestParam String userId, @RequestParam String userIdx) {
	  		model.addAttribute("userId",userId);
	  		model.addAttribute("userIdx",userIdx);
	  		return "userReport";
	  	}
	  	@RequestMapping(value = "/userReport.do")
	  	public String userReport(@RequestParam HashMap<String, String> params) {
	  		logger.info("유저 신고 con: "+params);
	  		params.put("reportContent",params.get("report")+params.get("content") );
	  		service.userReport(params);
	  		return "redirect:/userReport.go?userId="+params.get("reportId")+"&userIdx="+params.get("userIdx");
	  	}
	  	

}
