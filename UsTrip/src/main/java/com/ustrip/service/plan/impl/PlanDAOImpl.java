package com.ustrip.service.plan.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ustrip.common.Search;
import com.ustrip.service.domain.TempBlog;
import com.ustrip.service.domain.Travel;
import com.ustrip.service.plan.PlanDAO;


@Repository("planDAOImpl")
public class PlanDAOImpl implements PlanDAO {
	
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public List<TempBlog> listPlace(int travelNo) {
		return sqlSession.selectList("PlaceMapper.listPlace", travelNo);
	}

	@Override
	public List<Travel> checkBlogStart(int travelNo) {
		return sqlSession.selectList("TravelMapper.checkBlogStart", travelNo);
	}

	@Override
	public void startBlog(int travelNo) {
		sqlSession.update("TravelMapper.startBlog", travelNo);
	}
	
	@Override
	public List<Integer> listPlaceNo(Search search) {
		return sqlSession.selectList("PlaceMapper.listPlaceNo", search);
	}

}
