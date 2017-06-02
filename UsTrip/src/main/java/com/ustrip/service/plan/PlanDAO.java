package com.ustrip.service.plan;

import java.util.List;
import java.util.Map;

import com.ustrip.common.Search;
import com.ustrip.service.domain.TempBlog;
import com.ustrip.service.domain.Travel;

public interface PlanDAO {

	public List<TempBlog> listPlace(int travelNo);
	
	public List<Travel> checkBlogStart(int travelNo);
	
	public void startBlog(int travelNo);

	public List<Integer> listPlaceNo(Search search);

	public List<Integer> listPlaceNoTemp(int travelNo);
}
