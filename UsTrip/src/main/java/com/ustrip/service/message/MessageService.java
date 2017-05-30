package com.ustrip.service.message;

import java.util.Map;

import com.ustrip.common.Search;
import com.ustrip.service.domain.Message;

public interface MessageService {
	
	//메세지보내기
	public void sendMsg(Message message) throws Exception;
	
	public Message getMsg(int msgNo) throws Exception;
	
	public void deleteMsg(int msgNo) throws Exception;

	public Map<String, Object> listSendMsg(Search search) throws Exception;
}
