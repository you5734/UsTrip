package com.ustrip.service.user;

import com.ustrip.service.domain.User;

public interface UserService {
	
	// 내정보확인 / 로그인
		public User getUser(String userId) throws Exception;

}
