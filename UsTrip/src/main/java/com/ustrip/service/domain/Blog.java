package com.ustrip.service.domain;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Blog {
	
	private int blogNo;
	private String memo;
	private int travNo;
	private Date visitDate;
	private int placeNo;
	private int cityNo;
	private String review;
	private float score;
	private String place;
	private List<Image> images;
	private List<MultipartFile> files;
	private List<HashTag> hashTags;
	private List<Asset> assets;

	public Blog() {
		// TODO Auto-generated constructor stub
	}

	public int getBlogNo() {
		return blogNo;
	}

	public void setBlogNo(int blogNo) {
		this.blogNo = blogNo;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public int getTravNo() {
		return travNo;
	}

	public void setTravNo(int travNo) {
		this.travNo = travNo;
	}

	public Date getVisitDate() {
		return visitDate;
	}

	public void setVisitDate(Date visitDate) {
		this.visitDate = visitDate;
	}

	public int getPlaceNo() {
		return placeNo;
	}

	public void setPlaceNo(int placeNo) {
		this.placeNo = placeNo;
	}

	public int getCityNo() {
		return cityNo;
	}

	public void setCityNo(int cityNo) {
		this.cityNo = cityNo;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public float getScore() {
		return score;
	}

	public void setScore(float score) {
		this.score = score;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}
	
	public List<Image> getImages() {
		return images;
	}

	public void setImages(List<Image> images) {
		this.images = images;
	}

	public List<MultipartFile> getFiles() {
		return files;
	}

	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}

	public List<HashTag> getHashTags() {
		return hashTags;
	}

	public void setHashTags(List<HashTag> hashTags) {
		this.hashTags = hashTags;
	}

	public List<Asset> getAssets() {
		return assets;
	}

	public void setAssets(List<Asset> assets) {
		this.assets = assets;
	}

	@Override
	public String toString() {
		return "Blog [blogNo=" + blogNo + ", memo=" + memo + ", travNo=" + travNo + ", visitDate=" + visitDate
				+ ", placeNo=" + placeNo + ", cityNo=" + cityNo + ", review=" + review + ", score=" + score + ", place="
				+ place + ", images=" + images + ", files=" + files + ", hashTags=" + hashTags + ", assets=" + assets
				+ "]";
	}

}
