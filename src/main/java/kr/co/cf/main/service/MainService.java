package kr.co.cf.main.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cf.main.dao.MainDAO;
import kr.co.cf.matching.dto.MatchingDTO;

@Service
public class MainService {
	
	@Autowired MainDAO mainDAO;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());

	public ArrayList<MatchingDTO> matchingList() {
		return mainDAO.matchingList();
	}

	public ArrayList<MatchingDTO> teamList() {
		return mainDAO.teamList();
	}

	public ArrayList<MatchingDTO> noticeList() {
		return mainDAO.noticeList();
	}

}
