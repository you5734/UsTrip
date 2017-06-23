package com.ustrip.service.user;

import java.util.List;
import java.util.Map;

import com.ustrip.common.Search;
import com.ustrip.service.domain.Follow;
import com.ustrip.service.domain.User;

public interface UserDao {
	
	//INSERT
	public void addUser(User user) throws Exception;
	
	//INSERT
	public void extraUserInfo(User user) throws Exception;
	
	// SELECT ONE
	public User getUser(String userId) throws Exception;
	
	// SELECT ONE �г�����ȸ
	public User getUser2(String nickName) throws Exception;
		
	// UPDATE
	public void updateUser(User user) throws Exception;
	
	//SELECT LIST
	public List<User> getUserList(Search search) throws Exception;
	
	//pageó���� ���� ��ü row return
	public int getUserTotalCount(Search search) throws Exception;
	
	//ȸ��Ż��
	public void withdrawUser(String userId) throws Exception;
	
	//follow �߰�
	public void addFollow(Map<String, Object> map) throws Exception;
	
	public List<Follow> listFollow(Search search) throws Exception;

	public int getFollowTotalCount(Search search) throws Exception;
	
	public Follow getFollow(String folUserId, String targetUserId) throws Exception;
	
	public void updateFollow(Follow follow ) throws Exception;
	
	public List<Follow> listFollowing(Search search) throws Exception;
	
	public List<Follow> isFollowing(Search search) throws Exception;
	
	public int getFollowingTotalCount(Search search) throws Exception;
	
	public void deleteFollow(Map<String, Object> map) throws Exception;
	
	public String getUserId(String nickName) throws Exception;
		
}
