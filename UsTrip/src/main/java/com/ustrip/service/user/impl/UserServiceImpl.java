package com.ustrip.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ustrip.common.Search;
import com.ustrip.service.domain.User;
import com.ustrip.service.user.UserDao;
import com.ustrip.service.user.UserService;

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
	
	//타계정로그인 후 회원가입
	public void extraUserInfo(User user) throws Exception{
		userDao.extraUserInfo(user);
	}
	
	public boolean checkUserId(String userId) throws Exception{
		
		boolean result = true;
		
		User user = userDao.getUser(userId);
		
		if(user != null ) {	//userId가 존재한다면 false
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
	
	public void updateUser(User user) throws Exception {
		userDao.updateUser(user);
	}
	
	public Map<String, Object> getUserList(Search search) throws Exception{
		List<User> list = userDao.getUserList(search);
		int totalCount  = userDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}
	
	//회원탈퇴
	public void withdrawUser(String userId) throws Exception{
		userDao.withdrawUser(userId);
	}
	


}
