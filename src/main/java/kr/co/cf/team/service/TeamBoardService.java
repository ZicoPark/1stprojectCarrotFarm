package kr.co.cf.team.service;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


import kr.co.cf.team.dao.TeamBoardDAO;
import kr.co.cf.team.dto.TeamBoardDTO;

@Service
public class TeamBoardService {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired TeamBoardDAO dao;

	// 팀 사진첩 --------------------------------------------------------------------------------------------------------------------------
	
	
	public ArrayList<TeamBoardDTO> tplist(String userId) {
		return dao.tplist(userId);
	}
	
	public HashMap<String, Object> tpalist(int page, String search, String userId) {
		
		logger.info(page + "페이지 보여줘");
		logger.info("search : " + search);

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int offset =(page-1) * 10;
		
		int total = dao.tpatotalCount();
		
		if (search.equals("default") || search.equals("")) {
			total = dao.tpatotalCount();
			
		} else {
			total = dao.tpatotalCountSearch(search);
		};
		
		

		int range = total%10 == 0 ? total/10 : (total/10)+1;
		logger.info("전체 게시물 수 : " + total);
		logger.info("총 페이지 수 : " + range);
		
		page = page >range ? range : page;
		
		ArrayList<TeamBoardDTO> tpalist = dao.tpalist(10, offset,userId);
		
		//params.put("offset", offset);
		
		if (search.equals("default") || search.equals("")) {
			tpalist = dao.tpalist(10, offset,userId);
			
		} else {
			tpalist = dao.tpalistSearch(search);
		}
		
		map.put("currPage", page);
		map.put("pages", range);
		
		map.put("teampictureboardList", tpalist);
		return map;
	}
	
	public String tpwrite(MultipartFile[] photos, HashMap<String, String> params) {
		
		String page = "redirect:/teampictureboardList.do";
		
		TeamBoardDTO dto = new TeamBoardDTO();
		dto.setSubject(params.get("subject"));
		dto.setUserId(params.get("userId"));
		dto.setContent(params.get("content"));
		dto.setCategoryId(params.get("categoryId"));
		
		
		
		int row = dao.tpwrite(dto);
		logger.info("업데이트 row : " + row);
		
		int bidx = dto.getBoardIdx();
		logger.info("방금 인서트한 bidx : " + bidx);
		
		 for (MultipartFile photo : photos) {
	         logger.info("photo 여부 :"+photo.isEmpty());
	         if(photo.isEmpty()==false) {
	            
	            tpfileSave(bidx, photo);
	            
	            try {
	               Thread.sleep(1);
	            } catch (InterruptedException e) {
	               e.printStackTrace();
	            }
	            
	         }
		 }
		 page = "redirect:/teampictureboardDetail.do?bidx=" + bidx+"&teamIdx="+params.get("teamIdx");
		 return page;
	}
	

	private void tpfileSave(int photoIdx, MultipartFile photo) {
		String OriginalFileName = photo.getOriginalFilename();
		String ext = OriginalFileName.substring(OriginalFileName.lastIndexOf("."));
		String newFileName = System.currentTimeMillis() + ext;
		logger.info(OriginalFileName + " -> " + newFileName);
		
		try {
			byte[] bytes = photo.getBytes();
			Path path = Paths.get("C:/img/upload/" + newFileName);
			Files.write(path,bytes);
			logger.info(newFileName + "세이브 완료");
			dao.tpfileWrite(photoIdx, newFileName);
			logger.info("포토인덱스 : " + photoIdx + "포토네임 : " + newFileName);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
	}

	public ArrayList<TeamBoardDTO> tpdetail(String boardIdx, String flag) {
		if(flag.equals("detail")) {
			dao.tpupHit(boardIdx);
		}
		ArrayList<TeamBoardDTO> dto = dao.tpdetail(boardIdx);
		logger.info("boardIdx : " + boardIdx);
		logger.info("dto : " + dto);
		
		return dto;
	}

	public void tpdelete(String bidx) {
		String newFileName = dao.tpfindFile(bidx);
		logger.info("파일 이름 : " + newFileName);
		
		int row = dao.tpdelete(bidx);
		logger.info("삭제 데이터 : " + row);
		
		if (newFileName != null && row > 0) {
			File file = new File("C:/img/upload/" + newFileName);
			if (file.exists()) {
				file.delete();
			}
		}
	}

	public String tpupdate(MultipartFile photo, HashMap<String, String> params) {
		int bidx = Integer.parseInt(params.get("bidx"));
		int row = dao.tpupdate(params);
		logger.info("bidx 값 : " + bidx);
		logger.info("row 값 : " + row);
		
		if(photo != null && !photo.getOriginalFilename().equals("")) {
			tpfileSave(bidx, photo);
		}
		
		String page = row >0 ? "redirect:/teampictureboardDetail.do?bidx=" + bidx +"&teamIdx="+params.get("teamIdx"): "redirect:/teampictureboardList.do?teamIdx="+params.get("teamIdx");
		logger.info("update => " + page);
		return page;
	}
	
	
	public ArrayList<TeamBoardDTO> tpcommentList(String bidx) {
		return dao.tpcommentList(bidx);
	}

	public void tpcommentWrite(HashMap<String, String> params) {
		dao.tpcommentWrite(params);
	}

	public void tpcommentDelete(String commentIdx) {
		dao.tpcommentDelete(commentIdx);
	}

	public TeamBoardDTO tpcommentGet(String commentIdx) {
		return dao.tpcommentGet(commentIdx);
	}

	public void tpcommentUpdate(HashMap<String, String> params) {
		dao.tpcommentUpdate(params);
	}

	public void tpboardReport(HashMap<String, String> params) {
		dao.tpboardReport(params);
		
	}

	public void tpboardCommentReport(HashMap<String, String> params) {
		dao.tpboardCommentReport(params);	
	}
	
	
	// 자유 게시판 --------------------------------------------------------------------------------------------------------------------------

	public ArrayList<TeamBoardDTO> tflist() {
		return dao.tflist();
	}
	
	public HashMap<String, Object> tfalist(int page, String search) {
		
		logger.info(page + "페이지 보여줘");
		logger.info("search : " + search);

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int offset =(page-1) * 10;
		
		int total = dao.tfatotalCount();
		
		if (search.equals("default") || search.equals("")) {
			total = dao.tfatotalCount();
			
		} else {
			total = dao.tfatotalCountSearch(search);
		};
		
		

		int range = total%10 == 0 ? total/10 : (total/10)+1;
		logger.info("전체 게시물 수 : " + total);
		logger.info("총 페이지 수 : " + range);
		
		page = page >range ? range : page;
		
		ArrayList<TeamBoardDTO> tfalist = dao.tfalist(10, offset);
		
		//params.put("offset", offset);
		
		if (search.equals("default") || search.equals("")) {
			tfalist = dao.tfalist(10, offset);
			
		} else {
			tfalist = dao.tfalistSearch(search);
		}
		
		map.put("currPage", page);
		map.put("pages", range);
		
		map.put("teamfreeboardList", tfalist);
		return map;
	}
	
	public String tfwrite(MultipartFile photo, HashMap<String, String> params) {
		
		String page = "redirect:/teamfreeboardList.do";
		TeamBoardDTO dto = new TeamBoardDTO();
		dto.setSubject(params.get("subject"));
		dto.setUserId(params.get("userId"));
		dto.setContent(params.get("content"));
		dto.setCategoryId(params.get("categoryId"));
		
		
		
		int row = dao.tfwrite(dto);
		logger.info("업데이트 row : " + row);
		
		int bidx = dto.getBoardIdx();
		logger.info("방금 인서트한 bidx : " + bidx);
		
		page = "redirect:/teamfreeboardDetail.do?bidx=" + bidx;
		
		if (!photo.getOriginalFilename().equals("")) {
			logger.info("파일 업로드 작업");
			
			tffileSave(bidx,photo);
		}
		return page;
	}
		
	private void tffileSave(int photoIdx, MultipartFile photo) {
		String OriginalFileName = photo.getOriginalFilename();
		String ext = OriginalFileName.substring(OriginalFileName.lastIndexOf("."));
		String photoId = System.currentTimeMillis() + ext;
		logger.info(OriginalFileName + " -> " + photoId);
		
		try {
			byte[] bytes = photo.getBytes();
			Path path = Paths.get("C:/img/upload/" + photoId);
			Files.write(path,bytes);
			logger.info(photoId + "세이브 완료");
			dao.tffileWrite(photoIdx, photoId);
			logger.info("포토인덱스 : " + photoIdx + "포토네임 : " + photoId);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
	}

	public TeamBoardDTO tfdetail(String boardIdx, String flag) {
		if(flag.equals("detail")) {
			dao.tfupHit(boardIdx);
		}
		TeamBoardDTO dto = dao.tfdetail(boardIdx);
		logger.info("boardIdx : " + boardIdx);
		logger.info("dto : " + dto);
		
		logger.info("사진이름" +dto.getPhotoName());
		return dto;
	}

	public void tfdelete(String bidx) {
		String newFileName = dao.tffindFile(bidx);
		logger.info("파일 이름 : " + newFileName);
		
		int row = dao.tfdelete(bidx);
		logger.info("삭제 데이터 : " + row);
		
		if (newFileName != null && row > 0) {
			File file = new File("C:/img/upload/" + newFileName);
			if (file.exists()) {
				file.delete();
			}
		}
	}

	public String tfupdate(MultipartFile photo, HashMap<String, String> params) {
		int bidx = Integer.parseInt(params.get("bidx"));
		int row = dao.tfupdate(params);
		logger.info("bidx 값 : " + bidx);
		logger.info("row 값 : " + row);
		
		if(photo != null && !photo.getOriginalFilename().equals("")) {
			tffileSave(bidx,photo);
		}
		
		String page = row >0 ? "redirect:/teamfreeboardDetail.do?bidx=" + bidx : "redirect:/teamfreeboardList.do";
		logger.info("update => " + page);
		return page;
	}
	
	
	public ArrayList<TeamBoardDTO> tfcommentList(String bidx) {
		return dao.tfcommentList(bidx);
	}

	public void tfcommentWrite(HashMap<String, String> params) {
		dao.tfcommentWrite(params);
	}

	public void tfcommentDelete(String commentIdx) {
		dao.tfcommentDelete(commentIdx);
	}

	public TeamBoardDTO tfcommentGet(String commentIdx) {
		return dao.tfcommentGet(commentIdx);
	}

	public void tfcommentUpdate(HashMap<String, String> params) {
		dao.tfcommentUpdate(params);
	}

	public void tfboardReport(HashMap<String, String> params) {
		dao.tfboardReport(params);
		
	}

	public void tfboardCommentReport(HashMap<String, String> params) {
		dao.tfboardCommentReport(params);
		
	}
	
	public void tfdownHit(String bidx) {
		dao.tfdownHit(bidx);
		
	}

	
	// 공지사항 게시판 --------------------------------------------------------------------------------------------------------------------------
	
	
	public ArrayList<TeamBoardDTO> tnlist(String userId) {
		return dao.tnlist(userId);
	}
	
	public HashMap<String, Object> tnalist(int page, String search, String userId) {
		
		logger.info(page + "페이지 보여줘");
		logger.info("search : " + search);

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int offset =(page-1) * 10;
		
		int total = dao.tnatotalCount();
		
		if (search.equals("default") || search.equals("")) {
			total = dao.tnatotalCount();
			
		} else {
			total = dao.tnatotalCountSearch(search);
		};
		
		

		int range = total%10 == 0 ? total/10 : (total/10)+1;
		logger.info("전체 게시물 수 : " + total);
		logger.info("총 페이지 수 : " + range);
		
		page = page >range ? range : page;
		
		ArrayList<TeamBoardDTO> tnalist = dao.tnalist(10, offset, userId);
		
		//params.put("offset", offset);
		
		if (search.equals("default") || search.equals("")) {
			tnalist = dao.tnalist(10, offset,userId);
			
		} else {
			tnalist = dao.tnalistSearch(search);
		}
		
		map.put("currPage", page);
		map.put("pages", range);
		
		map.put("teamnoticeboardList", tnalist);
		return map;
	}
	
	public String tnwrite(MultipartFile photo, HashMap<String, String> params) {
		
		String page = "redirect:/teamnoticeboardList.do";
		TeamBoardDTO dto = new TeamBoardDTO();
		dto.setSubject(params.get("subject"));
		dto.setUserId(params.get("userId"));
		dto.setContent(params.get("content"));
		dto.setCategoryId(params.get("categoryId"));
		
		
		
		int row = dao.tnwrite(dto);
		logger.info("업데이트 row : " + row);
		
		int bidx = dto.getBoardIdx();
		logger.info("방금 인서트한 bidx : " + bidx);
		
		page = "redirect:/teamnoticeboardDetail.do?bidx=" + bidx+"&teamIdx="+params.get("teamIdx");
		
		if (!photo.getOriginalFilename().equals("")) {
			logger.info("파일 업로드 작업");
			
			tnfileSave(bidx,photo);
		}
		return page;
	}
		
	private void tnfileSave(int photoIdx, MultipartFile photo) {
		String OriginalFileName = photo.getOriginalFilename();
		String ext = OriginalFileName.substring(OriginalFileName.lastIndexOf("."));
		String photoId = System.currentTimeMillis() + ext;
		logger.info(OriginalFileName + " -> " + photoId);
		
		try {
			byte[] bytes = photo.getBytes();
			Path path = Paths.get("C:/img/upload/" + photoId);
			Files.write(path,bytes);
			logger.info(photoId + "세이브 완료");
			dao.tnfileWrite(photoIdx, photoId);
			logger.info("포토인덱스 : " + photoIdx + "포토네임 : " + photoId);
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
	}

	public TeamBoardDTO tndetail(String boardIdx, String flag) {
		if(flag.equals("detail")) {
			dao.tnupHit(boardIdx);
		}
		TeamBoardDTO dto = dao.tndetail(boardIdx);
		logger.info("boardIdx : " + boardIdx);
		logger.info("dto : " + dto);
		
		logger.info("사진이름" +dto.getPhotoName());
		return dto;
	}

	public void tndelete(String bidx) {
		String newFileName = dao.tnfindFile(bidx);
		logger.info("파일 이름 : " + newFileName);
		
		int row = dao.tndelete(bidx);
		logger.info("삭제 데이터 : " + row);
		
		if (newFileName != null && row > 0) {
			File file = new File("C:/img/upload/" + newFileName);
			if (file.exists()) {
				file.delete();
			}
		}
	}

	public String tnupdate(MultipartFile photo, HashMap<String, String> params) {
		int bidx = Integer.parseInt(params.get("bidx"));
		int row = dao.tnupdate(params);
		logger.info("bidx 값 : " + bidx);
		logger.info("row 값 : " + row);
		
		if(photo != null && !photo.getOriginalFilename().equals("")) {
			tnfileSave(bidx,photo);
		}
		
		String page = row >0 ? "redirect:/teamnoticeboardDetail.do?bidx=" + bidx : "redirect:/teamnoticeboardList.do";
		logger.info("update => " + page);
		return page;
	}
	
	public void tndownHit(String bidx) {
		dao.tndownHit(bidx);
		
	}
	
	public String tnuserRight(String loginId) {
		return dao.tnuserRight(loginId);
	}
	
	
	// 문의 게시판 --------------------------------------------------------------------------------------------------------------------------

		public ArrayList<TeamBoardDTO> tilist() {
			return dao.tilist();
		}
		
		public HashMap<String, Object> tialist(int page, String search) {
			
			logger.info(page + "페이지 보여줘");
			logger.info("search : " + search);

			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int offset =(page-1) * 10;
			
			int total = dao.tiatotalCount();
			
			if (search.equals("default") || search.equals("")) {
				total = dao.tiatotalCount();
				
			} else {
				total = dao.tiatotalCountSearch(search);
			};
			
			

			int range = total%10 == 0 ? total/10 : (total/10)+1;
			logger.info("전체 게시물 수 : " + total);
			logger.info("총 페이지 수 : " + range);
			
			page = page >range ? range : page;
			
			ArrayList<TeamBoardDTO> tialist = dao.tialist(10, offset);
			
			//params.put("offset", offset);
			
			if (search.equals("default") || search.equals("")) {
				tialist = dao.tialist(10, offset);
				
			} else {
				tialist = dao.tialistSearch(search);
			}
			
			map.put("currPage", page);
			map.put("pages", range);
			
			map.put("teaminquiryboardList", tialist);
			return map;
		}
		
		public String tiwrite(MultipartFile photo, HashMap<String, String> params) {
			
			String page = "redirect:/teaminquiryboardList.do";
			TeamBoardDTO dto = new TeamBoardDTO();
			dto.setSubject(params.get("subject"));
			dto.setUserId(params.get("userId"));
			dto.setContent(params.get("content"));
			dto.setCategoryId(params.get("categoryId"));
			
			
			
			int row = dao.tiwrite(dto);
			logger.info("업데이트 row : " + row);
			
			int bidx = dto.getBoardIdx();
			logger.info("방금 인서트한 bidx : " + bidx);
			
			page = "redirect:/teaminquiryboardDetail.do?bidx=" + bidx;
			
			if (!photo.getOriginalFilename().equals("")) {
				logger.info("파일 업로드 작업");
				
				tifileSave(bidx,photo);
			}
			return page;
		}
			
		private void tifileSave(int photoIdx, MultipartFile photo) {
			String OriginalFileName = photo.getOriginalFilename();
			String ext = OriginalFileName.substring(OriginalFileName.lastIndexOf("."));
			String photoId = System.currentTimeMillis() + ext;
			logger.info(OriginalFileName + " -> " + photoId);
			
			try {
				byte[] bytes = photo.getBytes();
				Path path = Paths.get("C:/img/upload/" + photoId);
				Files.write(path,bytes);
				logger.info(photoId + "세이브 완료");
				dao.tifileWrite(photoIdx, photoId);
				logger.info("포토인덱스 : " + photoIdx + "포토네임 : " + photoId);
			} catch (IOException e) {
				
				e.printStackTrace();
			}
			
		}

		public TeamBoardDTO tidetail(String boardIdx, String flag) {
			if(flag.equals("detail")) {
				dao.tfupHit(boardIdx);
			}
			TeamBoardDTO dto = dao.tidetail(boardIdx);
			logger.info("boardIdx : " + boardIdx);
			logger.info("dto : " + dto);
			
			logger.info("사진이름" +dto.getPhotoName());
			return dto;
		}

		public void tidelete(String bidx) {
			String newFileName = dao.tifindFile(bidx);
			logger.info("파일 이름 : " + newFileName);
			
			int row = dao.tidelete(bidx);
			logger.info("삭제 데이터 : " + row);
			
			if (newFileName != null && row > 0) {
				File file = new File("C:/img/upload/" + newFileName);
				if (file.exists()) {
					file.delete();
				}
			}
		}

		public String tiupdate(MultipartFile photo, HashMap<String, String> params) {
			int bidx = Integer.parseInt(params.get("bidx"));
			int row = dao.tiupdate(params);
			logger.info("bidx 값 : " + bidx);
			logger.info("row 값 : " + row);
			
			if(photo != null && !photo.getOriginalFilename().equals("")) {
				tifileSave(bidx,photo);
			}
			
			String page = row >0 ? "redirect:/teaminquiryboardDetail.do?bidx=" + bidx : "redirect:/teaminquiryboardList.do";
			logger.info("update => " + page);
			return page;
		}
		
		
		public ArrayList<TeamBoardDTO> ticommentList(String bidx) {
			return dao.ticommentList(bidx);
		}

		public void ticommentWrite(HashMap<String, String> params) {
			dao.ticommentWrite(params);
		}

		public void ticommentDelete(String commentIdx) {
			dao.ticommentDelete(commentIdx);
		}

		public TeamBoardDTO ticommentGet(String commentIdx) {
			return dao.ticommentGet(commentIdx);
		}

		public void ticommentUpdate(HashMap<String, String> params) {
			dao.ticommentUpdate(params);
		}
		
		public void tidownHit(String bidx) {
			dao.tidownHit(bidx);
			
		}
		
		public String tiuserRight(String loginId) {
			return dao.tiuserRight(loginId);
		}

		public String selectUserId(String teamIdx) {
			return dao.selectUserId(teamIdx);
		}	
};
