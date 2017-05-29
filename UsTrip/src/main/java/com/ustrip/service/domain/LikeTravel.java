package com.ustrip.service.domain;

public class LikeTravel {
	
	private int likeTravNo;
	private String userId;
	private int travNo;

	public LikeTravel() {
		// TODO Auto-generated constructor stub
	}
	
	public int getLikeTravNo() {
		return likeTravNo;
	}
	public void setLikeTravNo(int likeTravNo) {
		this.likeTravNo = likeTravNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getTravNo() {
		return travNo;
	}
	public void setTravNo(int travNo) {
		this.travNo = travNo;
	}

	@Override
	public String toString() {
		return "LikeTravel [likeTravNo=" + likeTravNo + ", userId=" + userId + ", travNo=" + travNo + "]";
	}
	
}
