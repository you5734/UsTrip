package com.ustrip.service.user;

import com.ustrip.service.domain.User;

public interface UserDao {
	
	// SELECT ONE
		public User getUser(String userId) throws Exception ;

}
