package com.ustrip.web.blog;

import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ustrip.common.Search;
import com.ustrip.service.asset.AssetService;
import com.ustrip.service.blog.BlogService;
import com.ustrip.service.domain.Blog;
import com.ustrip.service.domain.Place;
import com.ustrip.service.domain.TempBlog;
import com.ustrip.service.domain.Travel;
import com.ustrip.service.plan.PlanService;


@Controller
@RequestMapping("/blog/*")
public class BlogController {

	@Autowired
	@Qualifier("blogServiceImpl")
	private BlogService blogService;
	/*
	@Autowired
	@Qualifier("assetServiceImpl")
	private AssetService assetService;
	*/
	@Autowired
	@Qualifier("planServiceImpl")
	private PlanService planService;
	
	public BlogController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="addBlog", method=RequestMethod.GET)
	public String addBlog( @RequestParam("travelNo") int travelNo, @RequestParam("visitDate") String visitDate, Model model ) throws Exception {

		System.out.println("/addBlog : POST");
		Map<String, List<TempBlog>> map=new HashMap<String, List<TempBlog>>();
		
		List<TempBlog> list=planService.listPlace(travelNo);
		map.put("list", list);
		blogService.addBlog(map);
		planService.startBlog(travelNo);
		
		return "forward:/blog/listBlog?travelNo="+travelNo;
	}
	
	@RequestMapping(value={"getJsonBlog/{blogNo}"}, method=RequestMethod.GET)
	public void getJsonBlog( @PathVariable int blogNo, Model model ) throws Exception {
		
		System.out.println("/getJsonBlog : GET");
		
		Blog blog=blogService.getJsonBlog(blogNo);
		model.addAttribute("blog", blog);
	}

	
	@RequestMapping(value="listBlog", method=RequestMethod.GET)
	public String listBlog( @RequestParam("travelNo") int travelNo, @RequestParam( value="visitDate", required=false) String visitDate, Model model ) throws Exception {

		System.out.println("/listBlog : GET");
		String destination="forward:/view/blog/listBlog.jsp";
		
		Search search=new Search();
		
		List<Travel> travel=planService.checkBlogStart(travelNo);
		
		if(travel.get(0).getIsBlogStart()==1){
			search.setSearchKeyword(Integer.toString(travelNo));
			search.setSearchDate(visitDate);
			List<Integer> listPlaceNo=planService.listPlaceNo(search);
			
			search.setPlaceOrder(listPlaceNo);
			List<Blog> blog=blogService.listBlog(search);
			model.addAttribute("blog", blog);
		}else{
			model.addAttribute("travel", travel);
			destination="forward:/view/blog/addBlog.jsp";
		}
		
		
		return destination;
	}
}
