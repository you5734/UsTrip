package com.ustrip.web.blog;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;



import javax.servlet.http.HttpServletRequest;

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
	
	@RequestMapping(value={"addJsonAsset/{charge}/{blogNo}/{travNo}/{assetCategory}/{usage}"}, method=RequestMethod.GET)
	public void addJsonAsset( @ModelAttribute("asset") Asset asset, Model model ) throws Exception {
		
		System.out.println("/addJsonAsset : GET");
		Blog blog=blogService.getJsonBlog(asset.getBlogNo());
		asset.setVisitDate(blog.getVisitDate());
		
		assetService.addAsset(asset);
		System.out.println(asset);
		model.addAttribute("asset", asset);
	}
	
	@RequestMapping(value={"addJsonImage"}, method=RequestMethod.POST)
	public void addJsonImage( @ModelAttribute("blog") Blog blog, Model model, HttpServletRequest request ) throws Exception {
		
		System.out.println("/addJsonImage : GET");
		
		List<MultipartFile> files = blog.getFiles();
        List<String> fileNames = new ArrayList<String>();
        Map<String, List<Image>> map=new HashMap<String, List<Image>>();
        if (null != files && files.size() > 0) 
        {	
        	int i=0;
            for (MultipartFile multipartFile : files) {
 
                String fileName = multipartFile.getOriginalFilename();
                String newFileName=UUID.randomUUID().toString()+"."+fileName.substring(fileName.lastIndexOf(".")+1);
                
                File imageFile = new File(request.getSession().getServletContext().getRealPath("/")+"images/upload/blog/", newFileName);
                multipartFile.transferTo(imageFile);
                Image image=new Image();
                image.setServerImgName(newFileName);
                image.setBlogNo(blog.getBlogNo());
                image.setTravelNo(blog.getTravNo());
                
                blog.getImages().add(image);
            }
        }
        map.put("list", blog.getImages());
       /* blogService.addImage(map);*/
        /*Blog blog2=blogService.getJsonBlog(blog.getBlogNo());*/
     /*   map.put("list2", blog2.getImages());
        model.addAttribute("list",map.get("list2"));*/
	}
	
	@RequestMapping(value={"addJsonLike/{travNo}"}, method=RequestMethod.GET)
	public void addJsonLike( @PathVariable int travNo, Model model ) throws Exception {
		
		System.out.println("/addJsonLike : GET");
		String userId="user01"; //技记贸府秦具窃
		blogService.addJsonLike(travNo, userId);
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
		String userId="user01"; //技记贸府秦具窃
		
		Search search=new Search();

		if(visitDate!=null){
			List<Travel> travel=planService.checkBlogStart(travelNo);
			
			if(travel.get(0).getIsBlogStart()==1){
				search.setSearchKeyword(Integer.toString(travelNo));
				search.setSearchDate(visitDate);
				List<Integer> listPlaceNo=planService.listPlaceNo(search);
				
				search.setPlaceOrder(listPlaceNo);
				List<Blog> blog=blogService.listBlog(search);
				for(int i=0; i<blog.size(); i++){
					List<Asset> asset=assetService.getAssetByBlogNo(blog.get(i).getBlogNo());
					blog.get(i).setAssets(asset);
				}
				
				model.addAttribute("list", blog);
				model.addAttribute("isLiked",this.checkLikeTravel(userId, travelNo));
				model.addAttribute("writer", travel.get(0).getUserId());
			}else{
				model.addAttribute("travel", travel);
				destination="forward:/view/blog/addBlog.jsp";
			}
		}else{
			List<Integer> listPlaceNo=planService.listPlaceNoTemp(travelNo);
			search.setPlaceOrder(listPlaceNo);
			List<Blog> blog=blogService.listBlogImage(search);
			model.addAttribute("list", blog);
			destination="forward:/view/blog/listPicture.jsp";
		}
		
		
		return destination;
	}
	
	@RequestMapping(value="listPicture", method=RequestMethod.GET)
	public String listPicture( @RequestParam("travelNo") int travelNo, Model model ) throws Exception {

		System.out.println("/listPicture : GET");
		
		List<Integer> blogNo=blogService.listBlogNo(travelNo);
		List<Blog> list=blogService.listImgByBlogNo(blogNo);
		
		model.addAttribute("list", list);
		
		return "forward:/view/blog/listPicture.jsp";
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
	
	@RequestMapping(value={"updateJsonScore/{score}/{blogNo}"}, method=RequestMethod.GET)
	public void updateJsonScore( @ModelAttribute Blog blog ) throws Exception {
		
		System.out.println("/updateJsonScore : GET");

		blogService.updateScore(blog);
	}
	
	@RequestMapping(value="updatePlace", method=RequestMethod.GET)
	public String updatePlace( @RequestParam("travelNo") int travelNo, @RequestParam("visitDate") String visitDate, Model model ) throws Exception {

		System.out.println("/updatePlace : GET");
		Search search=new Search();
		
		search.setSearchKeyword(Integer.toString(travelNo));
		search.setSearchDate(visitDate);
		List<Integer> listPlaceNo=planService.listPlaceNo(search);
		
		search.setPlaceOrder(listPlaceNo);
		List<Blog> blog=blogService.listBlog(search);
		
		model.addAttribute("blog", blog);
		
		return "forward:/view/blog/updatePlace.jsp";
	}
	
	@RequestMapping(value={"updateJsonReview/{blogNo}/{review}"}, method=RequestMethod.GET)
	public void updateJsonReview( @ModelAttribute Blog blog ) throws Exception {
		
		System.out.println("/updateJsonReview : GET");

		blogService.updateJsonReview(blog);
	}
	
	@RequestMapping(value={"deleteJsonTag/{tagNo}"}, method=RequestMethod.GET)
	public void deleteJsonTag( @PathVariable int tagNo ) throws Exception {
		
		System.out.println("/deleteJsonTag : GET");

		blogService.deleteTag(tagNo);
	}
	
	@RequestMapping(value={"deleteJsonLike/{travNo}"}, method=RequestMethod.GET)
	public void deleteJsonLike( @PathVariable int travNo ) throws Exception {
		
		System.out.println("/deleteJsonLike : GET");
		String userId="user01";
		blogService.deleteJsonLike(travNo, userId);
	}
	
	@RequestMapping(value={"deleteJsonImage/{imgNo}"}, method=RequestMethod.GET)
	public void deleteJsonImage( @PathVariable int imgNo ) throws Exception {
		
		System.out.println("/deleteJsonImage : GET");
		blogService.deleteJsonImage(imgNo);
	}
	
	@RequestMapping(value={"deleteBlog/{blogNo}"}, method=RequestMethod.GET)
	public void deleteBlog( @PathVariable int blogNo ) throws Exception {
		
		System.out.println("/deleteBlog : GET");
		blogService.deleteBlog(blogNo);
	}
	
	public boolean checkLikeTravel(String userId, int travelNo) throws Exception {
		
		System.out.println("/checkLikeTravel");

		return blogService.checkLikeTravel(userId, travelNo);
	}

}
