package com.ustrip.service.user.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ustrip.service.domain.User;
import com.ustrip.service.user.UserDao;

@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
		public UserDaoImpl() {
			System.out.println(this.getClass());
		}
		
		public User getUser(String userId) throws Exception {
			return sqlSession.selectOne("UserMapper.getUser", userId);
		}

}
