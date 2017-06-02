package com.ustrip.service.domain;

public class Image {
	
	private int imgNo;
	private int blogNo;
	private String serverImgName;
	private int travelNo;
	
	public Image() {
	}

	public int getImgNo() {
		return imgNo;
	}

	public void setImgNo(int imgNo) {
		this.imgNo = imgNo;
	}

	public int getBlogNo() {
		return blogNo;
	}

	public void setBlogNo(int blogNo) {
		this.blogNo = blogNo;
	}

	public String getServerImgName() {
		return serverImgName;
	}

	public void setServerImgName(String serverImgName) {
		this.serverImgName = serverImgName;
	}

	public int getTravelNo() {
		return travelNo;
	}

	public void setTravelNo(int travelNo) {
		this.travelNo = travelNo;
	}

	@Override
	public String toString() {
		return "Image [imgNo=" + imgNo + ", blogNo=" + blogNo + ", serverImgName=" + serverImgName + ", travelNo="
				+ travelNo + "]";
	}
	
}
