package com.ustrip.service.message;

import com.ustrip.service.domain.Message;

public interface MessageService {
	
	//메세지보내기
	public void sendMsg(Message message) throws Exception;

}
