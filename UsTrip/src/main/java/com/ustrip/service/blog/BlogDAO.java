package com.ustrip.service.blog;

import java.util.List;
import java.util.Map;

import com.ustrip.common.Search;
import com.ustrip.service.domain.Blog;
import com.ustrip.service.domain.HashTag;
import com.ustrip.service.domain.Image;
import com.ustrip.service.domain.Place;
import com.ustrip.service.domain.TempBlog;


public interface BlogDAO {

	public void addBlog(Map<String, List<TempBlog>> map) throws Exception;
	
	public int deleteBlog(int blogNo) throws Exception;
	
	public List<Blog> listBlog(Search search) throws Exception;
	
	public void listPicture(int travNo) throws Exception;
	
	public void addLikeTravel(Search search) throws Exception;
	
	public void deleteLikeTravel(Search search) throws Exception;
	
	public void checkLikeTravel(Search search) throws Exception;
	
	public Map<String, Object> listLikeTravel(Search search) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;

	public Blog getJsonBlog(int blogNo) throws Exception;

	public void deleteTag(int tagNo) throws Exception;

	public int addJsonTag(HashTag hashtag) throws Exception;

	public void updateScore(Blog blog) throws Exception;

	public void updateReview(Blog blog) throws Exception;

	public void addImage(Map<String, List<Image>> map) throws Exception;

}
