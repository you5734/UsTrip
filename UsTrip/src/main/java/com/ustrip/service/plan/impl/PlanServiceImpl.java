package com.ustrip.service.plan.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ustrip.common.Search;
import com.ustrip.service.domain.City;
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
	public void setPlanDao(PlanDAO planDAO){
		this.planDAO = planDAO;
	}
	
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
	
	public PlanServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addTravel(Travel travel) throws Exception {
		planDAO.addTravel(travel);
	}
	
	public void addCity(City city) throws Exception{
		planDAO.addCity(city);
	}
	
	public void addPlace(Place place) throws Exception{
		planDAO.addPlace(place);
	}
	
	public Travel getTravel(Travel travel) throws Exception {
		return planDAO.getTravel(travel);
	}
	
	public City getCity(City city) throws Exception{
		return planDAO.getCity(city);
	}
	
	public Place getPlace(Place place) throws Exception{
		return planDAO.getPlace(place);
	}
	
	
	public void addPlan(Travel travel, City city, Place place) throws Exception {
		planDAO.addTravel(travel);
		planDAO.addCity(city);
		planDAO.addPlace(place);
	}

	
}