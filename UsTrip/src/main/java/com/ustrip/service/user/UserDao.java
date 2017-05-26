package com.ustrip.service.user;

import java.util.List;

import com.ustrip.common.Search;
import com.ustrip.service.domain.User;

public interface UserDao {
	
	//INSERT
	public void addUser(User user) throws Exception;
	
	//INSERT
	public void extraUserInfo(User user) throws Exception;
	
	// SELECT ONE
	public User getUser(String userId) throws Exception;
	
	// SELECT ONE 닉네임조회
	public User getUser2(String nickName) throws Exception;
		
	// UPDATE
	public void updateUser(User user) throws Exception;
	
	//SELECT LIST
	public List<User> getUserList(Search search) throws Exception;
	
	//page처리를 위한 전체 row return
	public int getTotalCount(Search search) throws Exception;

}
