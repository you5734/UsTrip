package com.ustrip.service.user;

import com.ustrip.service.domain.User;

public interface UserService {
	
	//ȸ������
	public void addUser(User user) throws Exception;
	
	//ȸ��ID �ߺ�Ȯ��
	public boolean checkUserId(String userId) throws Exception;
	
	//ȸ���г��� �ߺ�Ȯ��
	public boolean checkNickName(String nickName) throws Exception;	
	
	// ������Ȯ�� / �α���
	public User getUser(String userId) throws Exception;
	
	
		
		
		
		
		

}
