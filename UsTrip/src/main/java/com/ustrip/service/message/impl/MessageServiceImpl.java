package com.ustrip.service.message.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ustrip.service.domain.Message;
import com.ustrip.service.message.MessageDao;
import com.ustrip.service.message.MessageService;

@Service("messageServiceImpl")
public class MessageServiceImpl implements MessageService {
	
	///Field
	@Autowired
	@Qualifier("messageDaoImpl")	
	private MessageDao messageDao;
	
	public void setUserDao(MessageDao messageDao) {
		this.messageDao = messageDao;
	}
	
	public void sendMsg(Message message) throws Exception{
		messageDao.sendMsg(message);
	}
	
}
