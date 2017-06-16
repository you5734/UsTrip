package com.ustrip.web.blog;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONObject;
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
import com.ustrip.service.domain.LikeTravel;
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
	public String addBlog( @RequestParam("travelNo") int travelNo, Model model ) throws Exception {

		System.out.println("/addBlog : POST");
		Map<String, List<TempBlog>> map=new HashMap<String, List<TempBlog>>();
		
		List<TempBlog> list=planService.listPlace(travelNo);
		map.put("list", list);
		blogService.addBlog(map);
		planService.startBlog(travelNo);
		
		return "forward:/blog/listBlog?travelNo="+travelNo;
	}
	
	@RequestMapping(value="addJsonTag", method=RequestMethod.POST)
	public void addJsonTag( @ModelAttribute("hashTag")HashTag hashTag, Model model ) throws Exception {
		
		System.out.println("/addJsonTag : POST");
				
		blogService.addJsonTag(hashTag);
		
		model.addAttribute("hashTag", hashTag);
	}
	
	@RequestMapping(value="addJsonAsset", method=RequestMethod.POST)
	public void addJsonAsset( @ModelAttribute("asset")Asset asset, Model model ) throws Exception {
		System.out.println("================"+asset);
		System.out.println("/addJsonAsset : POST");
		Blog blog=blogService.getJsonBlog(asset.getBlogNo());
		asset.setVisitDate(blog.getVisitDate());
		
		assetService.addAsset(asset);
		
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
        blogService.addImage(map);
        Blog blog2=blogService.getJsonBlog(blog.getBlogNo());
        map.put("list2", blog2.getImages());
        model.addAttribute("list",map.get("list2"));
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
	public String listBlog( @RequestParam("travNo") int travelNo, 
			@RequestParam(value="userId", required=false) String userId, Model model ) throws Exception {

		System.out.println("/listBlog : GET");
		String destination="forward:/view/blog/listBlog.jsp";
		int islike=0;
		
		Search search=new Search();
			List<Travel> travel=planService.checkBlogStart(travelNo);
			
			if(travel.get(0).getIsBlogStart()==1){
				List<Integer> listPlaceNo=planService.listPlaceNoTemp(travelNo);
				search.setSearchKeyword(Integer.toString(travelNo));
				search.setPlaceOrder(listPlaceNo);
				List<Blog> blog=blogService.listBlog(search);
				for(int i=0; i<blog.size(); i++){
					List<Asset> asset=assetService.getAssetByBlogNo(blog.get(i).getBlogNo());
					blog.get(i).setAssets(asset);
				}
				
				if(userId != null){
					List<LikeTravel> travNoLike = blogService.checkLikeTravel(travelNo);
					for(LikeTravel T : travNoLike){
						if(T.getUserId().equals(userId)){
							islike=1;
						}
					}
				}
				
				model.addAttribute("list", blog);
				model.addAttribute("isLiked",islike);
				model.addAttribute("writer", travel.get(0).getUserId());
			}else{
				model.addAttribute("travel", travel);
				destination="forward:/view/blog/addBlog.jsp";
			}		
		
		return destination;
	}
	
	@RequestMapping(value="listPicture", method=RequestMethod.GET)
	public String listPicture( @RequestParam("travelNo") int travelNo, Model model ) throws Exception {

		System.out.println("/listPicture : GET");
		
		List<Integer> blogNo=blogService.listBlogNo(travelNo);
		System.out.println("**************************");
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
	
	@RequestMapping(value="updateBlogJSON/{blogNo}", method=RequestMethod.GET)
	public void updateBlogJSON( @PathVariable int blogNo, Model model) throws Exception {
		
		System.out.println("/updateBlogJSON : GET");
		
		Blog blog=blogService.getJsonBlog(blogNo);
		List<Asset> asset=assetService.getAssetByBlogNo(blogNo);
		blog.setAssets(asset);
		model.addAttribute("blog", blog);
		
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
	
	@RequestMapping(value="updateJsonReview", method=RequestMethod.POST)
	public void updateJsonReview( @ModelAttribute("blog") Blog blog, Model model ) throws Exception {
		
		System.out.println("/updateJsonReview : POST");

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
	
	public void checkLikeTravel( int travelNo) throws Exception {
		
		System.out.println("/checkLikeTravel");

		blogService.checkLikeTravel(travelNo);
	}
	
	
	
	enum Type {

	    IMAGES("/upload/images", ".jpg", ".bmp", ".gif", ".png", ".jpeg"),
	    VIDEOS("/upload/videos", ".avi", ".mpeg", ".mpg", ".mp4", ".mov", ".mkv", ".flv"),
	    MUSICS("/upload/musics", ".mp3", ".wav");

	    private String path;
	    private String[] formats;

	    Type(String path, String... format) {
	        this.path = path;
	        this.formats = format;
	    }

	    public String[] getFormats() {
	        return formats;
	    }

	    public String getPath() {
	        return path;
	    }
	}

	private static String parseFileFormat(String fileName) {
	    fileName = fileName.toLowerCase();
	    int dotPosition = fileName.lastIndexOf(".");
	    String format = fileName.substring(dotPosition, fileName.length());
	    return format;
	}

	private Type getType(String fileName) {
	    String format = parseFileFormat(fileName);
	    Type[] values = Type.values();
	    for (int i = 0; i < values.length; i++) {
	        for (int j = 0; j < values[i].getFormats().length; j++) {
	            if (values[i] == Type.IMAGES && values[i].getFormats()[j].equals(format)) {
	                return Type.IMAGES;
	            } else if (values[i] == Type.VIDEOS && values[i].getFormats()[j].equals(format)) {
	                return Type.VIDEOS;
	            } else if (values[i] == Type.MUSICS && values[i].getFormats()[j].equals(format)) {
	                return Type.MUSICS;
	            }
	        }
	    }
	    return null;
	}
	
	@RequestMapping("test/{blogNo}")
	public void getJsontest(HttpServletRequest request,
			   HttpServletResponse response, @PathVariable int blogNo)
					   throws ServletException, IOException {
		
		 ServletContext context = request.getSession().getServletContext();
		    if (ServletFileUpload.isMultipartContent(request)) {
		        try {
		            String fileName = null;
		            String filePath;
		            Type type = null;
		            List<FileItem> multiparts = new ServletFileUpload(
		                    new DiskFileItemFactory()).parseRequest(request);
		            System.out.println("*****"+multiparts);
		            System.out.println("Multipart size: " + multiparts.size());
		            for (FileItem item : multiparts) {
		                if (item.getName() == null || item.getName() == "") {
		                    continue;
		                }
		                System.out.println("Part : " + item.getName());
		                if (!item.isFormField()) {
		                    fileName = new File(item.getName()).getName();
		                    type = getType(fileName);
		                    filePath = context.getRealPath(type.path);
		                    if (type != null) {
		                        SecureRandom random = new SecureRandom();
		                        fileName = new BigInteger(130, random).toString(32) +
		                                parseFileFormat(fileName);
		                        item.write(new File(filePath + File.separator + fileName));
		                        System.out.println("File uploaded successfully");
		                        // System.out.println("File path: " + context.getRealPath(type.path));
		                    } else {
		                        throw new IllegalStateException("Wrong file format!");
		                    }
		                }
		            }
		        	
		        	/*System.out.println("++++"+blogNo);
		        	String saveFolder = "C:\\Users\\B\\git\\UsTrip\\UsTrip\\WebContent\\images\\upload\\blog\\"+blogNo;
		        	File targetDir = new File(saveFolder);  
		            
		            if(!targetDir.exists()) {    //叼泛配府 绝栏搁 积己.
		             targetDir.mkdirs();
		            }
		            
		            DiskFileItemFactory factory = new DiskFileItemFactory();
		            factory.setRepository(targetDir);
		            ServletFileUpload upload = new ServletFileUpload(factory);
		            
		            List<FileItem> items = upload.parseRequest(request);
		            System.out.println("******"+items);*/
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    } else {
		        System.out.println("Sorry this Servlet only handles file upload request");
		    }
		    PrintWriter out = response.getWriter();
		    JSONObject json = new JSONObject();
		    json.put("", "");	
		    response.setContentType("application/x-json; charset=UTF-8");		    			    
		    out.print(json);
		    out.flush();
	}

}
