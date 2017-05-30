package com.ustrip.service.message;

import java.util.List;

import com.ustrip.common.Search;
import com.ustrip.service.domain.Message;

public interface MessageDao {
	
	//�޼���������
	public void sendMsg(Message message) throws Exception;
	
	public Message getMsg(int msgNo) throws Exception;
	
	public void updateIsRead(int msgNo) throws Exception;
	
	public void deleteMsg(int msgNo) throws Exception;

	//���������Ը���Ʈ
	public List<Message> listSendMsg(Search search) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
}
