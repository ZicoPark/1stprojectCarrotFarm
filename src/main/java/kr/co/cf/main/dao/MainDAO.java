package kr.co.cf.main.dao;

import java.util.ArrayList;

import kr.co.cf.matching.dto.MatchingDTO;

public interface MainDAO {

	ArrayList<MatchingDTO> matchingList();

	ArrayList<MatchingDTO> teamList();

	ArrayList<MatchingDTO> noticeList();

}
