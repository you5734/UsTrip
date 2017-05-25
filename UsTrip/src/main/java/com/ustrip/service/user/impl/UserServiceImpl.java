package com.ustrip.service.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ustrip.service.user.UserService;
import com.ustrip.service.domain.User;
import com.ustrip.service.user.UserDao;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
	
	///Field
	@Autowired
	@Qualifier("userDaoImpl")
	
	private UserDao userDao;
	
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	///Constructor
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}
	
	public void addUser(User user) throws Exception{
		userDao.addUser(user);
	}
	
	public boolean checkUserId(String userId) throws Exception{
		
		boolean result = true;
		
		User user = userDao.getUser(userId);
		
		if(user != null ) {
			result = false;
		}
		return result;
	}
	
	public boolean checkNickName(String nickName) throws Exception{
		
		boolean result = true;
		
		User user = userDao.getUser2(nickName);
		
		if(user != null ) {
			result = false;
		}
		return result;		
		
	}

	public User getUser(String userId) throws Exception {
		return userDao.getUser(userId);
	}
	


}
