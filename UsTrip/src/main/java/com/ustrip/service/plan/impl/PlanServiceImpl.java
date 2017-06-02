package com.ustrip.service.plan.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ustrip.common.Search;
import com.ustrip.service.domain.Place;
import com.ustrip.service.domain.TempBlog;
import com.ustrip.service.domain.Travel;
import com.ustrip.service.plan.PlanDAO;
import com.ustrip.service.plan.PlanService;

@Service("planServiceImpl")
public class PlanServiceImpl implements PlanService{

	@Autowired
	@Qualifier("planDAOImpl")
	private PlanDAO planDAO;
	
	@Override
	public List<TempBlog> listPlace(int travelNo) throws Exception {
		return planDAO.listPlace(travelNo);
	}

	@Override
	public List<Travel> checkBlogStart(int travelNo) throws Exception {
		return planDAO.checkBlogStart(travelNo);
	}

	@Override
	public void startBlog(int travelNo) throws Exception {
		planDAO.startBlog(travelNo);
	}

	@Override
	public List<Integer> listPlaceNo(Search search) {
		return planDAO.listPlaceNo(search);
	}

	@Override
	public List<Integer> listPlaceNoTemp(int travelNo) throws Exception {
		return planDAO.listPlaceNoTemp(travelNo);
	}

	
}