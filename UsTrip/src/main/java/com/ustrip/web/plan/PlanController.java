package com.ustrip.web.plan;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//Travel ���̺�
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
		System.out.println("���ľƾƾƾƾƾ�\n"+
				session.getAttribute("travel"));
		session.setAttribute("travel", planService.getTravel(travel));

		return "redirect:/view/plan/addCity.jsp";
	}

	
/*
	//City ���̺�
	@RequestMapping( value="addCity", method=RequestMethod.POST )
	public String addCity(@ModelAttribute("city") City city, 
			@RequestBody JSONPObject data ,
								HttpSession session) throws Exception{
		
		System.out.println("/plan/addCity : POST : jsonp");
		
		String orgName = data.toString();
	//	planService.addCity(city);
		System.out.println("===========================");
		System.out.println(orgName);
		System.out.println("===========================");
	//	session.setAttribute("city", planService.getCity(city));
		
		return "redirect:/view/plan/addPlaceJsonTest.jsp";
	}
	*/
	
	//City ���̺� ajax
	@RequestMapping( value="addCity", method=RequestMethod.POST )
	public void addCity(@RequestParam("a") String data,
						City city) throws Exception{
		
		
		System.out.println("/plan/addCity : POST : ajax");
		System.out.println("########################################################");
		System.out.println(data);
		System.out.println("########################################################");
				
		city = new ObjectMapper().readValue(data, City.class);
		planService.addCity(city);
		
		/*int sfd = planService.getCity(city).getCityNo();
		HttpServletResponse response,
		response.getWriter().print(sfd);
		System.out.println("��Ƽ��ȣ: "+sfd);*/
		
	}
	/*
	@RequestMapping( value="getCity", method=RequestMethod.GET )
	public void getCity(@RequestParam("jsonVD") String data,
							City city) throws Exception{
		
		System.out.println("/plan/getCity : GET : ajax");
		System.out.println("########################################################");
		
		String strStay = data.split(",")[0];
		strStay = strStay.split(":")[1];
		
		String strNO = data.split(",")[1];
		strNO = strNO.split(":")[1].replaceAll("}", "");
		
		System.out.println("########################################################");
		
		System.out.println(strStay);
		System.out.println(strNO);
		
		Date stayStart=java.sql.Date.valueOf(strStay);

		city.setStayStart(stayStart);
		city.setTravelNo(Integer.parseInt(strNO));
		
		System.out.println("��Ƽ�ǰٽ����̽�ŸƮ"+city.getStayStart());
		System.out.println("��Ƽ�ǰٽ����̽�ŸƮ"+city.getTravelNo());
		
		
	}
	*/
	
	//Place ���̺�
	
	@RequestMapping( value="addPlace", method=RequestMethod.GET )
	public String addPlace(@RequestParam("data")String data,
							City city,
							HttpSession session) throws Exception{
		
		//int tNo = Integer.parseInt(data.split("/")[0]);
		String tNo = data.split("/")[0];
		String cId = data.split("/")[1];
		
		System.out.println("��=======================================================================��");
		//System.out.println(planService.getCityNo(tNo ,cId));
		String str = planService.getCityNo(tNo ,cId).toString();
		String cNo = ""; 
		System.out.println("��������������������"+str
				+tNo+cId);
		for (int i = 14; i < 19; i++) {
			cNo += str.charAt(i);
		}
	
		
		//session.setAttribute("cityData", cNo);
		
		
		//session.setAttribute("city", planService.getCityNo(tNo ,cId));
		
	//	System.out.println("���ľƾƾƾƾƾ�\n"+session.getAttribute("city"));
		
		System.out.println("��=======================================================================��");
		data = data.split("/")[0]+"?"
			 + cNo+"?"//�̰� ���̵𿡼� ��ȣ get�ؿͼ� �ٲ� 
			 + data.split("/")[2]+"?"
			 + data.split("/")[3]+"?"
			 + data.split("/")[4]+"?"
			 + data.split("/")[5]+"?"
			 + data.split("/")[6];
		
		
		
		
		return "redirect:/view/plan/addPlace.jsp?"+data;
	}
	
	@RequestMapping( value="addPlace", method=RequestMethod.POST )
	public void addPlace(@RequestParam("a") String data,
							Place place) throws Exception{
		
		System.out.println("/plan/addPlace : POST : ajax");
		System.out.println("########################################################");
		System.out.println(data);
		System.out.println("########################################################");
		
		place = new ObjectMapper().readValue(data, Place.class);
		planService.addPlace(place);
		
	}
	
	/*
	//City ���̺�
	@RequestMapping( value="addCity", method=RequestMethod.POST )
	public String addCity(@ModelAttribute("city") City city, 
								HttpSession session) throws Exception{
		
		System.out.println("/plan/addCity : POST");
		
		planService.addCity(city);
		
		session.setAttribute("city", planService.getCity(city));
		
		return "redirect:/view/plan/addPlace.jsp";
	}
	
	
	//Place ���̺�
	@RequestMapping( value="addPlace", method=RequestMethod.POST )
	public String addPlace(@ModelAttribute("place") Place place) throws Exception{
		
		System.out.println("/plan/addPlace : POST");
		
		planService.addPlace(place);
		
		return "redirect:/view/plan/addTravel.jsp";
	}
	*/
	
	@RequestMapping( value="getCity", method=RequestMethod.POST )
	public String getCity(@ModelAttribute("travNo") int travNo, Model model) throws Exception{
		
		System.out.println("/plan/getCity : POST");
		
		List<City> city = planService.getCity(travNo);
		
		model.addAttribute("city", city);
		
		return "redirect:/view/plan/getCity.jsp";
	}
	
	@RequestMapping( value="getCalendar", method=RequestMethod.GET )
	public String getCalendar(@RequestParam("travNo") int travNo,
								Model model) throws Exception{
		
		System.out.println("/plan/getCalendar : POST");
		
		model.addAttribute("calendarTravNo",travNo);

		return "forward:/view/plan/calendar.jsp";
	}
	
	@RequestMapping( value="getCalendarJSON/{travNo}", method=RequestMethod.GET )
	public void getCalendarJSON(@PathVariable int travNo, Model model) throws Exception{
		System.out.println("/plan/getCalendarData : GET");
		
		List<City> listCity = planService.blogCity(travNo);
		for(City city : listCity){
			List<Place> listPlace = planService.blogPlace(city.getCityNo());
			city.setListPlace(listPlace);
			String[] splitCity = city.getCity().split("_");
			city.setCity(splitCity[0]);
		}
		model.addAttribute("listCity",listCity);
	}
		
}// end of class PlanController