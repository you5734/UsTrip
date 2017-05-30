package com.ustrip.service.message.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ustrip.service.domain.Message;
import com.ustrip.service.message.MessageDao;

@Repository("messageDaoImpl")
public class MessageDaoImpl implements MessageDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public MessageDaoImpl() {
		System.out.println(this.getClass());
	}
	
	public void sendMsg(Message message) throws Exception {
		sqlSession.insert("MessageMapper.sendMsg", message);
	}
	
}