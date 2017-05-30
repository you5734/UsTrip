package com.ustrip.service.blog.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ustrip.common.Search;
import com.ustrip.service.blog.BlogDAO;
import com.ustrip.service.domain.Blog;
import com.ustrip.service.domain.TempBlog;



@Repository("blogDAOImpl")
public class BlogDAOImpl implements BlogDAO{
	
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public BlogDAOImpl() {
		System.out.println(this.getClass());
	}
	@Override
	public void addBlog(Map<String, List<TempBlog>> map) throws Exception {
		sqlSession.selectList("BlogMapper.addBlog", map);
	}

	@Override
	public Blog getJsonBlog(int blogNo) throws Exception {
		return sqlSession.selectOne("BlogMapper.getBlog", blogNo);
	}
	
	@Override
	public int deleteBlog(int blogNo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Blog> listBlog(Search search) throws Exception {
		return sqlSession.selectList("BlogMapper.listBlog", search);
	}

	@Override
	public void updateBlog(Blog blog) throws Exception {
		sqlSession.update("BlogMapper.updateBlog", blog);
		sqlSession.insert("BlogMapper.addHashTag", blog.getHashTags());
		sqlSession.insert("BlogMapper.addImage",blog.getImages());
	}

	@Override
	public void listPicture(int travNo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addLikeTravel(Search search) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteLikeTravel(Search search) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void checkLikeTravel(Search search) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Map<String, Object> listLikeTravel(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}


}
