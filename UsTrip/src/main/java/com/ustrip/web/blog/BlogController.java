package com.ustrip.web.blog;

import java.util.Date;
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ustrip.common.Search;
import com.ustrip.service.asset.AssetService;
import com.ustrip.service.blog.BlogService;
import com.ustrip.service.domain.Asset;
import com.ustrip.service.domain.Blog;
import com.ustrip.service.domain.HashTag;
import com.ustrip.service.domain.Image;
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
	
	@Autowired
	@Qualifier("assetServiceImpl")
	private AssetService assetService;
	
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
	
	@RequestMapping(value={"addJsonTag/{tag}/{blogNo}"}, method=RequestMethod.GET)
	public void addJsonTag( @PathVariable int blogNo, @PathVariable String tag, Model model ) throws Exception {
		
		System.out.println("/addJsonTag : GET");
		
		HashTag hashtag=new HashTag();
		hashtag.setBlogNo(blogNo);
		hashtag.setHashTag(tag);
		
		blogService.addJsonTag(hashtag);
		
		model.addAttribute("hashTag", hashtag);
	}
	
	@RequestMapping(value={"addJsonAsset/{charge}/{blogNo}/{travNo}/{assetCategory}/{usage}"})
	public void addJsonAsset( @ModelAttribute("asset") Asset asset, Model model ) throws Exception {
		
		System.out.println("/addJsonAsset : GET");
		Blog blog=blogService.getJsonBlog(asset.getBlogNo());
		asset.setVisitDate(blog.getVisitDate());
		
		assetService.addAsset(asset);
		System.out.println(asset);
		model.addAttribute("asset", asset);
	}
	
	@RequestMapping(value={"getJsonBlog/{blogNo}"}, method=RequestMethod.GET)
	public void getJsonBlog( @PathVariable int blogNo, Model model ) throws Exception {
		
		System.out.println("/getJsonBlog : GET");
		
		Blog blog=blogService.getJsonBlog(blogNo);
		List<Asset> asset=assetService.getAssetByBlogNo(blogNo);
		blog.setAssets(asset);
		
		System.out.println(blog);
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
			List<Asset> asset=assetService.getAssetByBlogNo(blog.get(0).getBlogNo());
			model.addAttribute("list", blog);
			model.addAttribute("asset",asset);
		}else{
			model.addAttribute("travel", travel);
			destination="forward:/view/blog/addBlog.jsp";
		}
		
		
		return destination;
	}
	
	@RequestMapping(value="updateBlog", method=RequestMethod.GET)
	public String updateBlog( @RequestParam("blogNo") int blogNo, Model model) throws Exception {
		
		System.out.println("/updateBlog : GET");
		
		Blog blog=blogService.getJsonBlog(blogNo);
		List<Asset> asset=assetService.getAssetByBlogNo(blogNo);
		blog.setAssets(asset);
		model.addAttribute("blog", blog);
		
		return "forward:/view/blog/updateBlog.jsp";
	}
	
	@RequestMapping(value="updateBlog", method=RequestMethod.POST)
	public String updateBlog( @ModelAttribute("blog") Blog blog, HttpSession session) throws Exception {
		
		System.out.println("/updateBlog : POST");
		/*List<MultipartFile> files = blog.getFiles();
		
        if (null != files && files.size() > 0) 
        {
            for (MultipartFile multipartFile : files) {
            	
                String fileName = multipartFile.getOriginalFilename();
                String newFileName=UUID.randomUUID().toString()+"."+fileName.substring(fileName.lastIndexOf(".")+1);
 
                File imageFile = new File(session.getServletContext().getRealPath("/")+"images/upload/blog/", newFileName);
                multipartFile.transferTo(imageFile);
            }
            
        }*/
        
        System.out.println(blog);
        
        /*blogService.updateBlog(blog);
        for(Asset i: blog.getAssets()){
        	assetService.addAsset(i);
        }*/
        
		return "forward:/view/blog/updateBlg.jsp";
	}
	
	@RequestMapping(value={"updateJsonScore/{score}"}, method=RequestMethod.GET)
	public void updateJsonScore( @PathVariable int score ) throws Exception {
		
		System.out.println("/updateJsonScore : GET");

		blogService.updateScore(score);
	}
	
	@RequestMapping(value={"deleteJsonTag/{tagNo}"}, method=RequestMethod.GET)
	public void deleteJsonTag( @PathVariable int tagNo ) throws Exception {
		
		System.out.println("/deleteJsonTag : GET");

		blogService.deleteTag(tagNo);
	}
	
	@RequestMapping(value={"updateJsonReview/{blogNo}/{review}"}, method=RequestMethod.GET)
	public void updateJsonReview( @ModelAttribute Blog blog ) throws Exception {
		
		System.out.println("/updateJsonReview : GET");

		blogService.updateJsonReview(blog);
	}

}
