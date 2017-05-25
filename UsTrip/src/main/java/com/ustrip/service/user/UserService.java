package com.ustrip.service.user;

import com.ustrip.service.domain.User;

public interface UserService {
	
	//회원가입
	public void addUser(User user) throws Exception;
	
	//회원ID 중복확인
	public boolean checkUserId(String userId) throws Exception;
	
	//회원닉네임 중복확인
	public boolean checkNickName(String nickName) throws Exception;	
	
	// 내정보확인 / 로그인
	public User getUser(String userId) throws Exception;
	
	
		
		
		
		
		

}
