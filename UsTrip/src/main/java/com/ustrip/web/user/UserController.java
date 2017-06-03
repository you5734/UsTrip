package com.ustrip.web.user;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ustrip.common.Page;
import com.ustrip.common.Search;
import com.ustrip.service.domain.User;
import com.ustrip.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	@Autowired
	 private JavaMailSender mailSender;
	
	public UserController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
	
		System.out.println("/user/addUser : GET");
		
		return "redirect:/view/user/addUser.jsp";
	}
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user, 
					@RequestParam("file") MultipartFile file, HttpServletRequest request) throws Exception {

		System.out.println("/user/addUser : POST");		
		
		String fileName = file.getOriginalFilename();
		String newFileName=UUID.randomUUID().toString()+"."+fileName.substring(fileName.lastIndexOf(".")+1);		
		user.setProfileImage(newFileName);		
		//System.out.println("fileName :: " + fileName);
		//System.out.println("newFileName :: " + newFileName);
		
		try{
			
			File imageFile = new File(request.getSession().getServletContext().getRealPath("/") + "images/upload/profile/", newFileName );
			System.out.println("imageFile :: " + imageFile);
			file.transferTo(imageFile);
		} catch(IOException e) {
			e.printStackTrace();
		}	
		//Business Logic
		userService.addUser(user);
		
		return "forward:/view/user/login.jsp";
	}
	/// 타계정 로그인하고 추가정보 입력 후 addUser 처리, 비밀번호는 임시비밀번호 넣기
	@RequestMapping( value="extraUserInfo", method=RequestMethod.POST )
	public String extraUserInfo( @ModelAttribute("user") User user) throws Exception{
	
		System.out.println("/user/extraUserInfo : POST");
		user.setUserId(user.getUserId().replace(",", "."));
		
		userService.extraUserInfo(user);
		System.out.println("userId 가져오닝:: " +user.getUserId());
		
		return "forward:/view/user/addUser.jsp";
	}
	
	@RequestMapping( value="checkUserId/{userId}", method=RequestMethod.GET)
	public void checkUserId(  @PathVariable String userId, Model model) throws Exception {
		
		System.out.println("/user/checkUserId : GET");
		
		userId = userId.replace(",", ".");
		boolean result = userService.checkUserId(userId);
		System.out.println("result 무엇이냐 :: " + result);
		
		model.addAttribute("result", new Boolean(result));
		
	}
	
	@RequestMapping( value="checkNickName/{nickName}", method=RequestMethod.GET)
	public void checkNickName(  @PathVariable String nickName, Model model) throws Exception {
		
		System.out.println("/user/checkNickName : GET");
		
		boolean result = userService.checkNickName(nickName);
		
		model.addAttribute("result", new Boolean(result));
		
	}
	
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login() throws Exception{
		
		System.out.println("/user/logon : GET");

		return "redirect:/view/user/login.jsp";
	}
	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session, Model model ) throws Exception{
		
		System.out.println("/user/login : POST");

		String destinate = "redirect:/user/login";
		
		User dbUser=userService.getUser(user.getUserId());
		System.out.println("user 뭐닝" + dbUser);
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
			model.addAttribute("user", user);
			/*destinate="redirect:/user/getUser?userId="+dbUser.getUserId();*/
			destinate="redirect:/view/user/listTravel.jsp";
		} 		
		System.out.println(session.getAttribute("user"));
		
		return destinate;
//		return "redirect:/user/getUser?userId="+dbUser.getUserId();
	}
	
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{

		System.out.println("/user/updateUser : GET");

		User user = userService.getUser(userId);

		model.addAttribute("user", user);
		
		return "forward:/view/user/updateUser.jsp";
	}

	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user, @RequestParam("file") MultipartFile file,
			Model model , HttpSession session, HttpServletRequest request) throws Exception{

		System.out.println("/user/updateUser : POST");
		
		String fileName = file.getOriginalFilename();
		String newFileName=UUID.randomUUID().toString()+"."+fileName.substring(fileName.lastIndexOf(".")+1);		
		user.setProfileImage(newFileName);		
		//System.out.println("fileName :: " + fileName);
		//System.out.println("newFileName :: " + newFileName);
		
		try{
			//request.getSession().getServletContext().getRealPath("/")
			File imageFile = new File(request.getSession().getServletContext().getRealPath("/") + "images/upload/profile/", newFileName );
			System.out.println("imageFile :: " + imageFile);
			file.transferTo(imageFile);
		} catch(IOException e) {
			e.printStackTrace();
		}	

		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
		
		System.out.println("/user/getUser : GET");
		//Business Logic
		User user = userService.getUser(userId);
		// Model 과 View 연결
		model.addAttribute("user", user);
		
		return "forward:/view/user/getUser.jsp";
	}
	
	@RequestMapping( value="withdrawUser", method=RequestMethod.GET )
	public String withdrawUser( @RequestParam("userId") String userId ) throws Exception {
		
		System.out.println("/user/withdrawUser : GET");

		 userService.withdrawUser(userId);

		return "forward:/user/login";
	}
	
	@RequestMapping( value="getUserList" )
	public String getUserList( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/getUserList : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/view/user/getUserList.jsp";
	}
	
	@RequestMapping(value = "findPwd", method=RequestMethod.POST)
	  public String findPwd( @RequestParam("userId") String userId) throws Exception {

		System.out.println("/user/mailSending :: GET");
	  
	   String setfrom = "eun090878@gmail.com";
	   userId = userId.replace(",", ".");
//	    tomail  = tomail.replace(",", ".");       // 받는 사람 이메일
	    System.out.println("userId :: " + userId);
	    String title   = "UsTrip :: test :: 임시비밀번호입니다.";      // 보내는 사람 이메일
	   
	    //임시비밀번호생성	    
	    String password = userService.getRandomPassword(6);
	    //임시비밀번호로 변경
	    
	    User user = userService.getUser(userId);
	    user.setPassword(password);
	    userService.updateUser(user);
//	    System.out.println("user정보 바뀌었니??????????????????? :: " + user);
	  
	    String content = "\n\nUsTrip test :: 임시비밀번호보내기\n\n임시비밀번호는 \"" + password + "\" 입니다.\n반드시 로그인 후 비밀번호를 수정해주세요!";
	    
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "EUC-KR");
	 
	      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(userId);     // 받는사람 이메일
	      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	      messageHelper.setText(content);  // 메일 내용
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      System.out.println(e);
	    }
	   
	    return "redirect:/user/login";
	  }
	
	
}
