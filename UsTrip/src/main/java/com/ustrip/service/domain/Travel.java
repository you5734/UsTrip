package com.ustrip.service.domain;

import java.util.Date;
import java.util.List;


public class Travel {
	
	private int travelNo;
	private String userId; // �����ؾ���
	private String travTitle;
	private String travTheme;
	private int memberCount;
	private String startDate;
	private int totalDate;
	private int isBlogStart;
	private String thumbNail;
	private List<City> cities;
	private String nickName;
	
	
	public Travel(){
	}
	
	

	public int getTravelNo() {
		return travelNo;
	}
	public void setTravelNo(int travelNo) {
		this.travelNo = travelNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTravTitle() {
		return travTitle;
	}
	public void setTravTitle(String travTitle) {
		this.travTitle = travTitle;
	}
	public String getTravTheme() {
		return travTheme;
	}
	public void setTravTheme(String travTheme) {
		this.travTheme = travTheme;
	}
	public int getMemberCount() {
		return memberCount;
	}
	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public int getTotalDate() {
		return totalDate;
	}
	public void setTotalDate(int totalDate) {
		this.totalDate = totalDate;
	}
	public int getIsBlogStart() {
		return isBlogStart;
	}
	public void setIsBlogStart(int isBlogStart) {
		this.isBlogStart = isBlogStart;
	}
	public String getThumbNail() {
		return thumbNail;
	}
	public void setThumbNail(String thumbNail) {
		this.thumbNail = thumbNail;
	}

	public String getNickName() {
		return nickName;
	}
	
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	@Override
	public String toString() {
		return "Travel [travNo=" + travelNo + ", userId=" + userId + ", travTitle=" + travTitle + ", travTheme="
				+ travTheme + ", memberCount=" + memberCount + ", startDate=" + startDate + ", totalDate=" + totalDate
				+ ", isBlogStart=" + isBlogStart + ", thumbNail=" + thumbNail + ", cities=" + cities + ", nickName="
				+ nickName + "]";
	}

}
