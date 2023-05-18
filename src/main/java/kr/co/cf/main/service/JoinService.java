package kr.co.cf.main.service;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.cf.main.dao.JoinDAO;
import kr.co.cf.main.dto.JoinDTO;
import kr.co.cf.matching.dto.MatchingDTO;
import kr.co.cf.team.dto.TeamDTO;


@Service
public class JoinService {
   
   @Autowired JoinDAO dao;
   
   Logger logger = LoggerFactory.getLogger(getClass());
   
   public HashMap<String, Object> idChk(String userId) {
         
         HashMap<String, Object> map = new HashMap<String, Object>();
         logger.info("service userId");
         int idChk = dao.idChk(userId);
         map.put("idChk", idChk);
         return map;
      }
   
   public HashMap<String, Object> nickChk(String nickName) {
         
         HashMap<String, Object> map = new HashMap<String, Object>();
         logger.info("service nickName");
         map.put("nickChk", dao.nickChk(nickName));

         return map;
      }
   
   
public String write(MultipartFile userProfile, HashMap<String, String> params) {
      logger.info("join service");
       String msg = "회원가입에 실패하였습니다.";
       int locationIdx = locationconf(params);

      JoinDTO dto = new JoinDTO();
      dto.setUserId(params.get("userId"));
      dto.setNickName(params.get("nickName"));
      dto.setUserPw(params.get("userPw"));
      dto.setHeight((params.get("height")));
      dto.setUserName(params.get("userName"));
      dto.setPosition(params.get("position"));
      dto.setLocationIdx(locationIdx);
      Date birthday = Date.valueOf(params.get("birthday"));
      dto.setBirthday(birthday);
      dto.setEmail(params.get("email"));
      dto.setFavTime(params.get("favTime"));
      
      if(!userProfile.getOriginalFilename().equals("")) {
            logger.info("파일 업로드 작업");
            String type="photoWrite";
            photoSave(userProfile,params,type);
      }else {
    	  	dao.photoDefalut(params.get("userId"));
      }
      
      if(dao.join(dto) == 1) {
         dao.joinData(dto);
            msg = "회원가입에 성공하였습니다.";
         }
         
         return msg;
      }

//사용자가 입력한 location의 idx를 받아오는 메서드
private int locationconf(HashMap<String, String> params) {
   String location = params.get("location");
   logger.info(location);
   
   int locationIdx = dao.locationFind(location);
   logger.info("locationIdx : "+locationIdx);
   return locationIdx;
}

private int photoSave(MultipartFile userProfile,HashMap<String, String> params, String type) {
    int photoWrite = 0;
    
    // 1. 파일을 C:/img/upload/ 에 저장
          //1-1. 원본 이름 추출
          String oriFileName = userProfile.getOriginalFilename();
          //1-2. 새이름 생성
          String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
          String photoName = params.get("userId")+System.currentTimeMillis()+ext;
          
          logger.info(photoName);
          try {
             byte[] bytes = userProfile.getBytes();//1-3. 바이트 추출
             //1-5. 추출한 바이트 저장
             Path path = Paths.get("C:/img/upload/"+photoName);
             Files.write(path, bytes);
             logger.info(photoName+" save OK");
             // 2. 저장 정보를 DB 에 저장
             //2-1. userProfile, photoName insert
             String userId = params.get("userId");
             if(type.equals("photoWrite")) {
            	 photoWrite = dao.photoWrite(photoName, userId);
            	 logger.info("프로필 사진 업로드 여부: "+photoWrite);
             }else {
            	 String oriPhotoName = dao.selectPhoto(userId);
            	 logger.info(oriPhotoName);
            	 File file = new File("c:/img/upload/"+oriPhotoName);
            	 if(file.exists()) {
            		 file.delete();
            	 }
            	 dao.photoUpdate(photoName,userId);
            	 
             }

                      
          } catch (IOException e) {
             e.printStackTrace();
          }
    return photoWrite;
 }

   public JoinDTO login(String id, String pw) {
      
      return dao.login(id,pw);
   }

   public ArrayList<JoinDTO> findId(String email)throws Exception{
      return dao.findId(email);
   }
   
   public int findIdCheck(String email)throws Exception{
      return dao.findIdCheck(email);
   }
   
   // 비밀번호 찾기
   public void sendEmail(@RequestParam HashMap<String, String> params, String div) throws Exception {
      // Mail Server 설정
      String charSet = "utf-8";
      String hostSMTP = "smtp.naver.com"; //네이버 이용시 smtp.naver.com / 구글 사용시 smtp.gmail.com
      String hostSMTPid = "jumpxhtna@naver.com";
      String hostSMTPpwd = "ehdgus~9256";

      // 보내는 사람 EMail, 제목, 내용
      String fromEmail = "jumpxhtna@naver.com";
      String fromName = "당근농장";
      String subject = "";
      String msg = "";

      if(div.equals("findpw")) {
         subject = "당근농장 임시 비밀번호 입니다.";
         msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
         msg += "<h3 style='color: orange;'>";
         msg += params.get("email") + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
         msg += "<p>임시 비밀번호 : ";
         msg += params.get("pw") + "</p></div>";
      }

      // 받는 사람 E-Mail 주소
      String mail = params.get("email");
      try {
         HtmlEmail email = new HtmlEmail();
         email.setDebug(true);
         email.setCharset(charSet);
         email.setSSL(true);
         email.setHostName(hostSMTP);
         email.setSmtpPort(587); //네이버 이용시 587 / 구글 이용시 465

         email.setAuthentication(hostSMTPid, hostSMTPpwd);
         email.setTLS(true);
         email.addTo(mail, charSet);
         email.setFrom(fromEmail, fromName, charSet);
         email.setSubject(subject);
         email.setHtmlMsg(msg);
         email.send();
      } catch (Exception e) {
         System.out.println("메일발송 실패 : " + e);
      }
   }
   
   // 임시 비밀번호
   public void findPw(@RequestParam HashMap<String, String> params) throws Exception {
      // 임시 비밀번호 생성
      
      String pw = "";
      for (int i = 0; i < 12; i++) {
         pw += (char) ((Math.random() * 26) + 97);
      }
      params.put("pw",pw);
      // 비밀번호 변경
      dao.updatePw(params);
      // 비밀번호 변경 메일 발송
      sendEmail(params, "findpw");
      
      
   }
   // 회원 탈퇴
   public int deleteuser(Object removeAttribute) {

         return dao.userdelete(removeAttribute);
      }

      public int userdeletetrue(Object attribute) {

         return dao.userdelete(attribute);
      }
      
      // 회원 정보
      public JoinDTO userInfo(Object attribute) {

          return dao.userInfo(attribute);
    }
      
      public String userInfoUpdate(HashMap<String, String> params, MultipartFile photo) {		
  		String userId = params.get("userId");
  		int locationIdx = locationconf(params);
  		int row = dao.userInfoUpdate(params);
  		row = dao.userInfoUpdatedata(params);
  		row = dao.userInfoUpdateloc(locationIdx,userId);
  		String page = row>0 ? "redirect:/userinfo.go?userId="+userId : "redirect:/userinfo.go";
  		logger.info("update => "+page);
  		 if(!photo.getOriginalFilename().equals("")) {
  			String type="fileChange";
  			 photoSave(photo,params,type); 
  		 }
  		 
  		return page;
  	}
      
      public HashMap<String, Object> reviewList(HashMap<String, Object> params) { 
  		
  		int page = Integer.parseInt((String) params.get("page"));
  		String selectedGameDate = String.valueOf(params.get("selectedGameDate"));
  		String searchText = String.valueOf(params.get("searchText"));
  		logger.info(page+" 페이지 보기");
  		logger.info("한 페이지에 "+10+" 개씩 보기");
  		
  		ArrayList<JoinDTO> list = new ArrayList<JoinDTO>();
  		HashMap<String, Object> map = new HashMap<String, Object>();	

  		//총 페이지 수 
  		int offset = (page-1)*10;
  		
  		params.put("offset", offset);
  		
  				
  				if(searchText.equals("default") || searchText.equals("")) {
  					if(selectedGameDate.equals("default")) {
  						// 전체 보여주기
  							list = dao.reviewList(params);
  							logger.info("gameList size : "+list.size());					
  					}else{
  						// 경기순을 선택한 경우
  						if(selectedGameDate.equals("DESC")) {
  								list = dao.GameDateListDesc(params);
  								logger.info("GameDateList size : "+list.size());		
  						}else {
  							params.put("range", "ASC");
  							list = dao.GameDateListAsc(params);
  							logger.info("GameDateList size : "+list.size());					
  						}
  					}
  				}else {
  					// 검색어 입력한 경우
  						list = dao.SearchGameList(params);		
  						logger.info("SearchGameList size : "+list.size());
  				}
  		
  		logger.info("totalGameList size : "+list.size());
  		
  		// 만들 수 있는 총 페이지 수 
  		// 전체 게시물 / 페이지당 보여줄 수
  		int total = list.size();
  		logger.info("total "+total);
  		int range = total%10 == 0 ? total/10 : (total/10)+1;
  		logger.info("전체 게시물 수 : "+total);
  		logger.info("총 페이지 수 : "+range);
  		
  		page = page > range ? range : page;
  		
  		map.put("currPage", page);
  		map.put("pages", range);
  				
  		logger.info("list : "+ list);
  		map.put("list", list);
  		logger.info("map : "+ map);
  		return map;
  	}
      
      
      public HashMap<String, Object> allGameList(HashMap<String, Object> params) { 
    		
    		int page = Integer.parseInt((String) params.get("page"));
    		String selectedGameDate = String.valueOf(params.get("selectedGameDate"));
    		String searchText = String.valueOf(params.get("searchText"));
    		logger.info(page+" 페이지 보기");
    		logger.info("한 페이지에 "+10+" 개씩 보기");
    		
    		ArrayList<JoinDTO> list = new ArrayList<JoinDTO>();
    		HashMap<String, Object> map = new HashMap<String, Object>();	

    		//총 페이지 수 
    		int offset = (page-1)*10;
    		
    		params.put("offset", offset);
    		
    				
    				if(searchText.equals("default") || searchText.equals("")) {
    					if(selectedGameDate.equals("default")) {
    						// 전체 보여주기
    							list = dao.allGameList(params);
    							logger.info("gameList size : "+list.size());					
    					}else{
    						// 경기순을 선택한 경우
    						if(selectedGameDate.equals("DESC")) {
    								list = dao.allGameDateListDesc(params);
    								logger.info("GameDateList size : "+list.size());		
    						}else {
    							params.put("range", "ASC");
    							list = dao.allGameDateListAsc(params);
    							logger.info("GameDateList size : "+list.size());					
    						}
    					}
    				}else {
    					// 검색어 입력한 경우
    						list = dao.allSearchGameList(params);		
    						logger.info("SearchGameList size : "+list.size());
    				}
    		
    		logger.info("totalGameList size : "+list.size());
    		
    		// 만들 수 있는 총 페이지 수 
    		// 전체 게시물 / 페이지당 보여줄 수
    		int total = list.size();
    		logger.info("total "+total);
    		int range = total%10 == 0 ? total/10 : (total/10)+1;
    		logger.info("전체 게시물 수 : "+total);
    		logger.info("총 페이지 수 : "+range);
    		
    		page = page > range ? range : page;
    		
    		map.put("currPage", page);
    		map.put("pages", range);
    				
    		logger.info("list : "+ list);
    		map.put("list", list);
    		logger.info("map : "+ map);
    		return map;
    	}

	public ArrayList<JoinDTO> profileGames(String userId) {
		return dao.profileGames(userId);
	}

	public JoinDTO profileInfo(String userId) {
		
		return dao.profileInfo(userId);
	}

	public void mannerDefalut(String userId) {
		
		dao.mannerDefalut(userId);
	}

	public void userReport(HashMap<String, String> params) {
		dao.userReport(params);
		
	}

	public String findPhotoName(String id) {
		return dao.findPhotoName(id);
		
	}
	
	


      
}