package com.ustrip.service.domain;

import java.sql.Date;

public class City {
	
	private int cityNo;
	private int travelNo; //수정해야함
	private String cityId;
	private String city;
	private double cityX;
	private double cityY;
	private int preCityNo;
	private int nextCityNo;
	private int stayDate;
	private Date stayStart;
	private Date stayEnd;
	
	public City(){
	}

	public int getCityNo() {
		return cityNo;
	}

	public void setCityNo(int cityNo) {
		this.cityNo = cityNo;
	}

	public int getTravelNo() {
		return travelNo;
	}

	public void setTravelNo(int travelNo) {
		this.travelNo = travelNo;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public double getCityX() {
		return cityX;
	}

	public void setCityX(double cityX) {
		this.cityX = cityX;
	}

	public double getCityY() {
		return cityY;
	}

	public void setCityY(double cityY) {
		this.cityY = cityY;
	}

	public int getPreCityNo() {
		return preCityNo;
	}

	public void setPreCityNo(int preCityNo) {
		this.preCityNo = preCityNo;
	}

	public int getNextCityNo() {
		return nextCityNo;
	}

	public void setNextCityNo(int nextCityNo) {
		this.nextCityNo = nextCityNo;
	}

	public int getStayDate() {
		return stayDate;
	}

	public void setStayDate(int stayDate) {
		this.stayDate = stayDate;
	}

	public Date getStayStart() {
		return stayStart;
	}

	public void setStayStart(Date stayStart) {
		this.stayStart = stayStart;
	}

	public Date getStayEnd() {
		return stayEnd;
	}

	public void setStayEnd(Date stayEnd) {
		this.stayEnd = stayEnd;
	}

	@Override
	public String toString() {
		return "City [cityNo=" + cityNo + ", travelNo=" + travelNo + ", cityId=" + cityId + ", city=" + city
				+ ", cityX=" + cityX + ", cityY=" + cityY + ", preCityNo=" + preCityNo + ", nextCityNo=" + nextCityNo
				+ ", stayDate=" + stayDate + ", stayStart=" + stayStart + ", stayEnd=" + stayEnd + "]";
	}

}
