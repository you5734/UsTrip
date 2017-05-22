package com.ustrip.service.domain;

public class Follow {
	
	//Field
	private int followNo;
	private String folUserId;
	private String targetUserId;

	//Controctor
	public Follow() {
	}

	public int getFollowNo() {
		return followNo;
	}

	public String getFolUserId() {
		return folUserId;
	}

	public String getTargetUserId() {
		return targetUserId;
	}

	public void setFollowNo(int followNo) {
		this.followNo = followNo;
	}

	public void setFolUserId(String folUserId) {
		this.folUserId = folUserId;
	}

	public void setTargetUserId(String targetUserId) {
		this.targetUserId = targetUserId;
	}

	@Override
	public String toString() {
		return "Follow [followNo=" + followNo + ", folUserId=" + folUserId + ", targetUserId=" + targetUserId + "]";
	}
	
	
}
