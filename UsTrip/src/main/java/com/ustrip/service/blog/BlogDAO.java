package com.ustrip.service.blog;

import java.util.List;
import java.util.Map;

import com.ustrip.common.Search;
import com.ustrip.service.domain.Blog;
import com.ustrip.service.domain.HashTag;
import com.ustrip.service.domain.Image;
import com.ustrip.service.domain.LikeTravel;
import com.ustrip.service.domain.Place;
import com.ustrip.service.domain.TempBlog;


public interface BlogDAO {

	public void addBlog(Map<String, List<TempBlog>> map) throws Exception;
	
	public void deleteBlog(int blogNo) throws Exception;
	
	public List<Blog> listBlog(Search search) throws Exception;
	
	public List<Blog> listImgByBlogNo(List<Integer> blogNo) throws Exception;
	
	public List<LikeTravel> checkLikeTravel(int travelNo) throws Exception;
	
	public List<LikeTravel> listLikeTravel(String userId) throws Exception;

	public Blog getJsonBlog(int blogNo) throws Exception;

	public void deleteTag(int tagNo) throws Exception;

	public int addJsonTag(HashTag hashtag) throws Exception;

	public void updateScore(Blog blog) throws Exception;

	public void updateReview(Blog blog) throws Exception;

	public void addImage(Map<String, List<Image>> map) throws Exception;

	public List<Integer> listBlogNo(int travelNo) throws Exception;

	public List<Blog> listBlogImage(Search search) throws Exception;

	public void deleteJsonLike(int travNo, String userId) throws Exception;

	public void addJsonLike(int travNo, String userId) throws Exception;

	public void deleteImage(int imgNo) throws Exception;

}
