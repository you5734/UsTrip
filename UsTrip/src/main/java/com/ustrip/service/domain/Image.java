package com.ustrip.service.domain;

public class Image {
	
	private int imgNo;
	private int blogNo;
	private String serverImgName;
	
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

	@Override
	public String toString() {
		return "Image [imgNo=" + imgNo + ", blogNo=" + blogNo + ", serverImgName="
				+ serverImgName + "]";
	}
	
	
}
