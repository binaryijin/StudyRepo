package com.yedam.member;

import java.sql.Date;

public class Member {
	
	private String memberId;
	private String memberPw;
	private String memberName;
	private String memberAuth;
	
	
	private int levelId;
	private String levelName;
	private Date startDate;
	private int duration;
	private String testApply;
	private String testResult;
	
	private String endDate;
	
	private String testApprove;
	
	
	public String getLevelName() {
		return levelName;
	}
	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}
	public String getTestApprove() {
		return testApprove;
	}
	public void setTestApprove(String testApprove) {
		this.testApprove = testApprove;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberAuth() {
		return memberAuth;
	}
	public void setMemberAuth(String memberAuth) {
		this.memberAuth = memberAuth;
	}
	public int getLevelId() {
		return levelId;
	}
	public void setLevelId(int levelId) {
		this.levelId = levelId;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public String getTestApply() {
		return testApply;
	}
	public void setTestApply(String testTarget) {
		this.testApply = testTarget;
	}
	public String getTestResult() {
		return testResult;
	}
	public void setTestResult(String testResult) {
		this.testResult = testResult;
	}
	

	
	
	
}