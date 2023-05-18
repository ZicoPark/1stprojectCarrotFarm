package kr.co.cf.team.dao;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.cf.board.dto.BoardDTO;
import kr.co.cf.team.dto.TeamBoardDTO;

public interface TeamBoardDAO {
	
	ArrayList<TeamBoardDTO> tplist(String userId);

	ArrayList<TeamBoardDTO> tpalist(int cnt, int offset, String userId);
	
	ArrayList<TeamBoardDTO> tpalistSearch(String search);
	
	int tpatotalCount();
	
	int tpatotalCountSearch(String search);
	
	int tpwrite(TeamBoardDTO dto);

	void tpfileWrite(int photoIdx, String photoId);

	void tpupHit(String boardIdx);

	ArrayList<TeamBoardDTO> tpdetail(String boardIdx);

	String tpfindFile(String bidx);

	int tpdelete(String bidx);

	int tpupdate(HashMap<String, String> params);
	

	ArrayList<TeamBoardDTO> tpcommentList(String bidx);

	void tpcommentWrite(HashMap<String, String> params);

	void tpcommentDelete(String commentIdx);

	TeamBoardDTO tpcommentGet(String commentIdx);

	void tpcommentUpdate(HashMap<String, String> params);
	
	void tpboardReport(HashMap<String, String> params);

	void tpboardCommentReport(HashMap<String, String> params);


	
	
	ArrayList<TeamBoardDTO> tflist();

	ArrayList<TeamBoardDTO> tfalist(int cnt, int offset);
	
	ArrayList<TeamBoardDTO> tfalistSearch(String search);
	
	int tfatotalCount();
	
	int tfatotalCountSearch(String search);
	
	int tfwrite(TeamBoardDTO dto);

	void tffileWrite(int photoIdx, String photoId);

	void tfupHit(String boardIdx);

	TeamBoardDTO tfdetail(String boardIdx);

	String tffindFile(String bidx);

	int tfdelete(String bidx);

	int tfupdate(HashMap<String, String> params);
	
	ArrayList<TeamBoardDTO> tfcommentList(String bidx);

	void tfcommentWrite(HashMap<String, String> params);

	void tfcommentDelete(String commentIdx);

	TeamBoardDTO tfcommentGet(String commentIdx);

	void tfcommentUpdate(HashMap<String, String> params);
	
	void tfboardReport(HashMap<String, String> params);

	void tfboardCommentReport(HashMap<String, String> params);
	
	void tfdownHit(String bidx);

	
	
	
	
	ArrayList<TeamBoardDTO> tnlist(String userId);
	
	ArrayList<TeamBoardDTO> tnalist(int cnt, int offset, String userId);
	
	ArrayList<TeamBoardDTO> tnalistSearch(String search);
	
	int tnatotalCount();
	
	int tnatotalCountSearch(String search);
	
	int tnwrite(TeamBoardDTO dto);

	void tnfileWrite(int photoIdx, String photoId);

	void tnupHit(String boardIdx);

	TeamBoardDTO tndetail(String boardIdx);

	String tnfindFile(String bidx);

	int tndelete(String bidx);

	int tnupdate(HashMap<String, String> params);
	
	void tndownHit(String bidx);
	
	String tnuserRight(String loginId);
	

	
	
	
	ArrayList<TeamBoardDTO> tilist();

	ArrayList<TeamBoardDTO> tialist(int cnt, int offset);
	
	ArrayList<TeamBoardDTO> tialistSearch(String search);
	
	int tiatotalCount();
	
	int tiatotalCountSearch(String search);
	
	int tiwrite(TeamBoardDTO dto);

	void tifileWrite(int photoIdx, String photoId);

	void tiupHit(String boardIdx);

	TeamBoardDTO tidetail(String boardIdx);

	String tifindFile(String bidx);

	int tidelete(String bidx);

	int tiupdate(HashMap<String, String> params);
	
	ArrayList<TeamBoardDTO> ticommentList(String bidx);

	void ticommentWrite(HashMap<String, String> params);

	void ticommentDelete(String commentIdx);

	TeamBoardDTO ticommentGet(String commentIdx);

	void ticommentUpdate(HashMap<String, String> params);
	
	void tidownHit(String bidx);

	String tiuserRight(String loginId);

	String selectUserId(String teamIdx);

	
	
}
