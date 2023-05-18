package kr.co.cf.board.dto;

import java.sql.Date;

public class BoardDTO {
	
	private int boardIdx;
	private String subject;
	private String content;
	private String userId;
	private int bHit;
	private Date writeTime;
	private int photoIdx;
	private String newFileName;
	private String categoryId;
	private int bidx;
	private String photoName;
	private int photoId;
	private Date commentWriteTime;
	private String commentContent;
	private String commentIdx;
	private String freeboardType;
	private String freeboardSearchInput;
	

	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getbHit() {
		return bHit;
	}
	public void setbHit(int bHit) {
		this.bHit = bHit;
	}
	public Date getWriteTime() {
		return writeTime;
	}
	public void setWriteTime(Date writeTime) {
		this.writeTime = writeTime;
	}
	public int getPhotoIdx() {
		return photoIdx;
	}
	public void setPhotoIdx(int photoIdx) {
		this.photoIdx = photoIdx;
	}
	public String getNewFileName() {
		return newFileName;
	}
	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}

	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}
	public int getBidx() {
		return bidx;
	}
	public void setBidx(int bidx) {
		this.bidx = bidx;
	}
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public int getPhotoId() {
		return photoId;
	}
	public void setPhotoId(int photoId) {
		this.photoId = photoId;
	}
	public Date getCommentWriteTime() {
		return commentWriteTime;
	}
	public void setCommentWriteTime(Date commentWriteTime) {
		this.commentWriteTime = commentWriteTime;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public String getCommentIdx() {
		return commentIdx;
	}
	public void setCommentIdx(String commentIdx) {
		this.commentIdx = commentIdx;
	}
	public String getFreeboardType() {
		return freeboardType;
	}
	public void setFreeboardType(String freeboardType) {
		this.freeboardType = freeboardType;
	}
	public String getFreeboardSearchInput() {
		return freeboardSearchInput;
	}
	public void setFreeboardSearchInput(String freeboardSearchInput) {
		this.freeboardSearchInput = freeboardSearchInput;
	}


}
