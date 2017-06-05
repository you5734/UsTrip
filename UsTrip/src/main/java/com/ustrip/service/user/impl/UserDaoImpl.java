package com.ustrip.service.user.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ustrip.common.Search;
import com.ustrip.service.domain.Follow;
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
	
	public void addUser(User user) throws Exception {
		sqlSession.insert("UserMapper.addUser", user);
	}
	
	public void extraUserInfo(User user) throws Exception{
		sqlSession.insert("UserMapper.extraUserInfo", user);
	}
	
	public User getUser(String userId) throws Exception {
		return sqlSession.selectOne("UserMapper.getUser", userId);
	}
	
	//´Ð³×ÀÓÁ¶È¸
	public User getUser2(String nickName) throws Exception{
		return sqlSession.selectOne("UserMapper.getUser2", nickName);
	}
	
	public void updateUser(User user) throws Exception {
		sqlSession.update("UserMapper.updateUser", user);
	}
	
	public List<User> getUserList(Search search) throws Exception{
		return sqlSession.selectList("UserMapper.getUserList", search);
	}
	
	public int getTotalCount(Search search) throws Exception{
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}
	//È¸¿øÅ»Åð
	public  void withdrawUser(String userId) throws Exception{
		sqlSession.update("UserMapper.withdrawUser", userId);
	}
	
	public void addFollow(Map<String, Object> map) throws Exception{
		System.out.println("map :::::::::::::::: " + map);
		sqlSession.insert("FollowMapper.addFollow", map);
	}

}
