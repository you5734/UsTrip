package com.ustrip.service.plan;

import java.util.List;
import java.util.Map;

import com.ustrip.common.Search;
import com.ustrip.service.domain.TempBlog;
import com.ustrip.service.domain.Travel;

public interface PlanService {

	public List<TempBlog> listPlace(int travelNo) throws Exception;
	
	public List<Travel> checkBlogStart(int travelNo) throws Exception;
	
	public void startBlog(int travelNo) throws Exception;
	
	public List<Integer> listPlaceNo(Search search) throws Exception;

	public List<Integer> listPlaceNoTemp(int travelNo) throws Exception;
}
