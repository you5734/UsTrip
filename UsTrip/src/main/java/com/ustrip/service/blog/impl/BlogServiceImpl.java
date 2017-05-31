package com.ustrip.service.blog.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ustrip.common.Search;
import com.ustrip.service.blog.BlogDAO;
import com.ustrip.service.blog.BlogService;
import com.ustrip.service.domain.Blog;
import com.ustrip.service.domain.HashTag;
import com.ustrip.service.domain.Place;
import com.ustrip.service.domain.TempBlog;


@Service("blogServiceImpl")
public class BlogServiceImpl implements BlogService{
	
	@Autowired
	@Qualifier("blogDAOImpl")
	private BlogDAO blogDAO;
	
	public BlogServiceImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void addBlog(Map<String, List<TempBlog>> map) throws Exception {
		blogDAO.addBlog(map);
	}

	@Override
	public void addJsonTag(HashTag hashtag) throws Exception {
		blogDAO.addJsonTag(hashtag);
	}

	@Override
	public Blog getJsonBlog(int blogNo) throws Exception {
		return blogDAO.getJsonBlog(blogNo);
	}

	@Override
	public int deleteBlog(int blogNo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Blog> listBlog(Search search) throws Exception {
		return blogDAO.listBlog(search);
	}
	
	@Override
	public void updateScore(int score) throws Exception {
		blogDAO.updateScore(score);
	}

	@Override
	public void updateJsonReview(Blog blog) throws Exception {
		blogDAO.updateReview(blog);
	}

	@Override
	public void deleteTag(int tagNo) throws Exception {
		blogDAO.deleteTag(tagNo);
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


}
