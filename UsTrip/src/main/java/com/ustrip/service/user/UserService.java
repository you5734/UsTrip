package com.ustrip.service.user;

import java.util.Map;

import com.ustrip.common.Search;
import com.ustrip.service.domain.Follow;
import com.ustrip.service.domain.User;

public interface UserService {
	
	//ȸ������
	public void addUser(User user) throws Exception;
	
	//Ÿ�����α��� �� ȸ������
	public void extraUserInfo(User user) throws Exception;
	
	//ȸ��ID �ߺ�Ȯ��
	public boolean checkUserId(String userId) throws Exception;
	
	//ȸ���г��� �ߺ�Ȯ��
	public boolean checkNickName(String nickName) throws Exception;	
	
	// ������Ȯ�� / �α���
	public User getUser(String userId) throws Exception;
	
	//�г������� ������ȸ
	public User getUserNickName(String nickName) throws Exception;
	
	// ����������
	public void updateUser(User user) throws Exception;
		
	// ���ȸ������Ʈ
	public Map<String, Object> getUserList(Search search) throws Exception;
	
	//ȸ��Ż��
	public void withdrawUser(String userId) throws Exception;
	
	public String getRandomPassword(int length) throws Exception;
	
	public void addFollow(String targetUserId, String sessionId) throws Exception;
	
	public Map<String, Object> listFollow(Search search, String folUserId) throws Exception;
	
	public Follow getFollow(String folUserId, String targetUserId) throws Exception;	
	
	public Map<String, Object> listFollowing(Search search, String targetUserId) throws Exception;

	public void deleteFollow(String folUserId, String targetUserId ) throws Exception;
}
