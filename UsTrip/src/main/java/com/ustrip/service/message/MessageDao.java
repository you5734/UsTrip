package com.ustrip.service.message;

import com.ustrip.service.domain.Message;

public interface MessageDao {
	
	//�޼���������
	public void sendMsg(Message message) throws Exception;

}
