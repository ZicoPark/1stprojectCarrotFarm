package kr.co.cf.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cf.matching.dto.MatchingDTO;
import kr.co.cf.member.dao.AlarmDAO;

@Service
public class AlarmService {
	
	@Autowired AlarmDAO alarmDAO;
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public HashMap<String, Object> list(HashMap<String, Object> params) {
		
		
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		String userId = String.valueOf(params.get("userId"));
		
		logger.info(page +"페이지 보여줘");
		logger.info("한페이지에 " + 10 +"개씩 보여줄 것 ");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int offset = 10*(page-1);
		
		logger.info("offset : " + offset);
		
		// 만들 수 있는 총 페이지 수 : 전체 게시글의 수 / 페이지당 보여줄 수 있는 수
		int total = 0;
		
		total = alarmDAO.totalCount(userId);
		
		int range = total%10  == 0 ? total/10 : total/10+1;
		
		logger.info("총게시글 수 : "+ total);
		logger.info("총 페이지 수 : "+ range);
		
		page = page>range ? range:page;
		
		ArrayList<MatchingDTO> list = null;

		params.put("offset", offset);
		
		
		list = alarmDAO.list(offset,userId);
		
		map.put("list", list);
		map.put("currPage", page);
		map.put("pages", range);
		
		return map;
	
	}

	public HashMap<String, Object> noticeList(HashMap<String, Object> params) {
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		String userId = String.valueOf(params.get("userId"));
		
		logger.info(page +"페이지 보여줘");
		logger.info("한페이지에 " + 10 +"개씩 보여줄 것 ");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int offset = 10*(page-1);
		
		logger.info("offset : " + offset);
		
		// 만들 수 있는 총 페이지 수 : 전체 게시글의 수 / 페이지당 보여줄 수 있는 수
		int total = 0;
		
		total = alarmDAO.totalNoticeCount(userId);
		
		int range = total%10  == 0 ? total/10 : total/10+1;
		
		logger.info("총게시글 수 : "+ total);
		logger.info("총 페이지 수 : "+ range);
		
		page = page>range ? range:page;
		
		ArrayList<MatchingDTO> list = null;

		params.put("offset", offset);
		
		
		list = alarmDAO.noticeList(offset,userId);
		
		map.put("list", list);
		map.put("currPage", page);
		map.put("pages", range);
		
		return map;
	}

	public HashMap<String, Object> warningList(HashMap<String, Object> params) {
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		String userId = String.valueOf(params.get("userId"));
		
		logger.info(page +"페이지 보여줘");
		logger.info("한페이지에 " + 10 +"개씩 보여줄 것 ");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int offset = 10*(page-1);
		
		logger.info("offset : " + offset);
		
		// 만들 수 있는 총 페이지 수 : 전체 게시글의 수 / 페이지당 보여줄 수 있는 수
		int total = 0;
		
		total = alarmDAO.totalWarningCount(userId);
		
		int range = total%10  == 0 ? total/10 : total/10+1;
		
		logger.info("총게시글 수 : "+ total);
		logger.info("총 페이지 수 : "+ range);
		
		page = page>range ? range:page;
		
		ArrayList<MatchingDTO> list = null;

		params.put("offset", offset);
		
		
		list = alarmDAO.warningList(offset,userId);
		
		map.put("list", list);
		map.put("currPage", page);
		map.put("pages", range);
		
		return map;
	}

	public HashMap<String, Object> teamList(HashMap<String, Object> params) {
		int page = Integer.parseInt(String.valueOf(params.get("page")));
		String userId = String.valueOf(params.get("userId"));
		
		logger.info(page +"페이지 보여줘");
		logger.info("한페이지에 " + 10 +"개씩 보여줄 것 ");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int offset = 10*(page-1);
		
		logger.info("offset : " + offset);
		
		// 만들 수 있는 총 페이지 수 : 전체 게시글의 수 / 페이지당 보여줄 수 있는 수
		int total = 0;
		
		total = alarmDAO.totalTeamCount(userId);
		
		int range = total%10  == 0 ? total/10 : total/10+1;
		
		logger.info("총게시글 수 : "+ total);
		logger.info("총 페이지 수 : "+ range);
		
		page = page>range ? range:page;
		
		ArrayList<MatchingDTO> list = null;

		params.put("offset", offset);
		
		
		list = alarmDAO.teamList(offset,userId);
		
		map.put("list", list);
		map.put("currPage", page);
		map.put("pages", range);
		
		return map;
	}
}
