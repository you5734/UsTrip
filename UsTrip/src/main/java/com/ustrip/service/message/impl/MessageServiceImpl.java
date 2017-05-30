package com.ustrip.service.message.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ustrip.common.Search;
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
	
	public Message getMsg(int msgNo) throws Exception {
//		messageDao.updateIsRead(msgNo);
		return messageDao.getMsg(msgNo);
	}
	
	public void deleteMsg(int msgNo) throws Exception {
		messageDao.deleteMsg(msgNo);
	}
	
	public Map<String, Object> listSendMsg(Search search, String sender) throws Exception{
		
		search.setSearchKeyword(sender);
		System.out.println("search ::" +search );
		
		
		List<Message> list = messageDao.listSendMsg(search);
		int totalCount = messageDao.sendCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	public Map<String, Object> listReceivMsg(Search search, String receiver) throws Exception{
		
		search.setSearchKeyword(receiver);
		System.out.println("search ::" +search );
		
		
		List<Message> list = messageDao.listReceivMsg(search);
		int totalCount = messageDao.receiveCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
}
