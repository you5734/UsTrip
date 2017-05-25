package com.ustrip.service.user;

import com.ustrip.service.domain.User;

public interface UserDao {
	
	//INSERT
	public void addUser(User user) throws Exception;
	
	// SELECT ONE
	public User getUser(String userId) throws Exception;
	
	// SELECT ONE
	public User getUser2(String nickName) throws Exception;
		
	

}
