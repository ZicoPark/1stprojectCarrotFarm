package kr.co.cf.member.dao;

import java.util.ArrayList;

import kr.co.cf.matching.dto.MatchingDTO;

public interface AlarmDAO {

	int totalCount(String userId);

	ArrayList<MatchingDTO> list(int offset, String userId);

	int totalNoticeCount(String userId);

	ArrayList<MatchingDTO> noticeList(int offset, String userId);

	int totalWarningCount(String userId);

	ArrayList<MatchingDTO> warningList(int offset, String userId);

	int totalTeamCount(String userId);

	ArrayList<MatchingDTO> teamList(int offset, String userId);

}
