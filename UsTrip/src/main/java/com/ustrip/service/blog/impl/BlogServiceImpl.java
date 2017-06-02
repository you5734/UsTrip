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
import com.ustrip.service.domain.Image;
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
	public void addImage(Map<String, List<Image>> map) throws Exception {
		blogDAO.addImage(map);
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
	public void updateScore(Blog blog) throws Exception {
		blogDAO.updateScore(blog);
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
	public List<Image> listPicture(int blogNo) throws Exception {
		return blogDAO.listPicture(blogNo);
	}
	
	@Override
	public List<Blog> listImgByBlogNo(List<Integer> blogNo) throws Exception {
		return blogDAO.listImgByBlogNo(blogNo);
	}

	@Override
	public List<Integer> listBlogNo(int travelNo) throws Exception {
		return blogDAO.listBlogNo(travelNo);
	}

	@Override
	public List<Blog> listBlogImage(Search search) throws Exception {
		return blogDAO.listBlogImage(search);
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
	public boolean checkLikeTravel(String userId, int travelNo) throws Exception {
		return blogDAO.checkLikeTravel(userId, travelNo);
	}

	@Override
	public Map<String, Object> listLikeTravel(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
