package com.ustrip.web.plan;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ustrip.service.domain.City;
import com.ustrip.service.domain.Place;
import com.ustrip.service.domain.Travel;
import com.ustrip.service.plan.PlanService;
import com.ustrip.service.user.UserService;

@Controller
@RequestMapping("/plan/*")
public class PlanController {
	///Field
	@Autowired
	@Qualifier("planServiceImpl")
	private PlanService planService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
		
	public PlanController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//Travel 테이블
	@RequestMapping( value="addTravel", method=RequestMethod.GET )
	public String addTravel() throws Exception{
		
		System.out.println("/plan/addTravel : GET");

		return "redirect:/view/plan/addTravel.jsp";
	}
	
	
	@RequestMapping( value="addTravel", method=RequestMethod.POST )
	public String addTravel(@ModelAttribute("travel") Travel travel,
								HttpSession session) throws Exception{
		
		System.out.println("/plan/addTravel : POST");
		
		planService.addTravel(travel);
		
		session.setAttribute("travel", planService.getTravel(travel));
		
		return "redirect:/view/plan/addCity.jsp";
	}

	
	//City 테이블
	@RequestMapping( value="addCity", method=RequestMethod.POST )
	public String addCity(@ModelAttribute("city") City city, 
								HttpSession session) throws Exception{
		
		System.out.println("/plan/addCity : POST");
		
		planService.addCity(city);
		
		session.setAttribute("city", planService.getCity(city));
		
		return "redirect:/view/plan/addPlace.jsp";
	}
	
	
	//Place 테이블
	@RequestMapping( value="addPlace", method=RequestMethod.POST )
	public String addPlace(@ModelAttribute("place") Place place) throws Exception{
		
		System.out.println("/plan/addPlace : POST");
		
		planService.addPlace(place);
		
		return "redirect:/view/plan/addTravel.jsp";
	}
	
	
	
}// end of class PlanController