package com.ustrip.service.domain;

import java.sql.Date;

public class TempBlog {
	
		private String memo;
		private int travelNo;
		private String visitDate;
		private int placeNo;
		private int cityNo;
		private String place;
		
		public String getMemo() {
			return memo;
		}
		public void setMemo(String memo) {
			this.memo = memo;
		}
		public int getTravelNo() {
			return travelNo;
		}
		public void setTravelNo(int travelNo) {
			this.travelNo = travelNo;
		}
		public String getVisitDate() {
			return visitDate;
		}
		public void setVisitDate(String visitDate) {
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
		public String getPlace() {
			return place;
		}
		public void setPlace(String place) {
			this.place = place;
		}
		
		@Override
		public String toString() {
			return "TempBlog [memo=" + memo + ", travelNo=" + travelNo + ", visitDate=" + visitDate + ", placeNo=" + placeNo
					+ ", cityNo=" + cityNo + ", place=" + place + "]";
		}

}
