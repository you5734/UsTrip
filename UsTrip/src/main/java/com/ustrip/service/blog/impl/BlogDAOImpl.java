package com.ustrip.service.blog.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ustrip.common.Search;
import com.ustrip.service.blog.BlogDAO;
import com.ustrip.service.domain.Blog;
import com.ustrip.service.domain.HashTag;
import com.ustrip.service.domain.Image;
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
	public int addJsonTag(HashTag hashtag) throws Exception {
		return sqlSession.insert("BlogMapper.addHashTag", hashtag);
	}

	@Override
	public Blog getJsonBlog(int blogNo) throws Exception {
		return sqlSession.selectOne("BlogMapper.getBlog", blogNo);
	}

	@Override
	public void addImage(Map<String, List<Image>> map) throws Exception {
		sqlSession.insert("BlogMapper.addImage", map);
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
	public void updateScore(Blog blog) throws Exception {
		sqlSession.update("BlogMapper.updateScore", blog);
	}

	@Override
	public void updateReview(Blog blog) throws Exception {
		sqlSession.update("BlogMapper.updateReview", blog);
	}

	@Override
	public void deleteTag(int tagNo) throws Exception {
		sqlSession.delete("BlogMapper.deleteHashTag", tagNo);
	}

	@Override
	public List<Image> listPicture(int blogNo) throws Exception {
		return sqlSession.selectList("BlogMapper.listPicture", blogNo);
	}

	@Override
	public List<Blog> listImgByBlogNo(List<Integer> blogNo) throws Exception {
		List<Blog> list=new ArrayList<Blog>();
		for(int i=0; i<blogNo.size(); i++){
			Blog blog=sqlSession.selectOne("BlogMapper.getBlog", blogNo.get(i));
			List<Image> temp=sqlSession.selectList("BlogMapper.listImgByBlogNo", blogNo.get(i));
			blog.setImages(temp);
			list.add(blog);
		}
		return list;
	}

	@Override
	public List<Integer> listBlogNo(int travelNo) throws Exception {
		return sqlSession.selectList("BlogMapper.listBlogNo", travelNo);
	}

	@Override
	public List<Blog> listBlogImage(Search search) throws Exception {
		/*Map<Integer, List<Image>> map=new HashMap<Integer, List<Image>>();
		for(int i=0; i<search.getPlaceOrder().size(); i++){
			List<Image> temp=sqlSession.selectList("BlogMapper.listImgByBlogNo", search.getPlaceOrder().get(i));
			map.put(search.getPlaceOrder().get(i), temp);
		}*/
		return sqlSession.selectList("BlogMapper.listBlogImage", search);
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
		Search search=new Search();
		search.setSearchKeyword(userId);
		search.setSearchCondition(Integer.toString(travelNo));
		
		int count=sqlSession.selectOne("BlogMapper.checkLikeTravel", search);
		if(count==0){
			return false;
		}else{
			return true;
		}
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
