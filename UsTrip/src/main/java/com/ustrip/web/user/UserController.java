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
	/// Ÿ���� �α����ϰ� �߰����� �Է� �� addUser ó��, ��й�ȣ�� �ӽú�й�ȣ �ֱ�
	@RequestMapping( value="extraUserInfo", method=RequestMethod.POST )
	public String extraUserInfo( @ModelAttribute("user") User user) throws Exception{
	
		System.out.println("/user/extraUserInfo : POST");
		user.setUserId(user.getUserId().replace(",", "."));
		
		userService.extraUserInfo(user);
		System.out.println("userId ��������:: " +user.getUserId());
		
		return "forward:/view/user/addUser.jsp";
	}
	
	@RequestMapping( value="checkUserId/{userId}", method=RequestMethod.GET)
	public void checkUserId(  @PathVariable String userId, Model model) throws Exception {
		
		System.out.println("/user/checkUserId : GET");
		
		userId = userId.replace(",", ".");
		boolean result = userService.checkUserId(userId);
		System.out.println("result �����̳� :: " + result);
		
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
		System.out.println("user ����" + dbUser);
		
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
		// Model �� View ����
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
		
		// Business logic ����
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
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
//	    tomail  = tomail.replace(",", ".");       // �޴� ��� �̸���
	    System.out.println("userId :: " + userId);
	    String title   = "UsTrip :: test :: �ӽú�й�ȣ�Դϴ�.";      // ������ ��� �̸���
	   
	    //�ӽú�й�ȣ����	    
	    String password = userService.getRandomPassword(6);
	    //�ӽú�й�ȣ�� ����
	    
	    User user = userService.getUser(userId);
	    user.setPassword(password);
	    userService.updateUser(user);
//	    System.out.println("user���� �ٲ����??????????????????? :: " + user);
	  
	    String content = "\n\nUsTrip test :: �ӽú�й�ȣ������\n\n�ӽú�й�ȣ�� \"" + password + "\" �Դϴ�.\n�ݵ�� �α��� �� ��й�ȣ�� �������ּ���!";
	    
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "EUC-KR");
	 
	      messageHelper.setFrom(setfrom);  // �����»�� �����ϰų� �ϸ� �����۵��� ����
	      messageHelper.setTo(userId);     // �޴»�� �̸���
	      messageHelper.setSubject(title); // ���������� ������ �����ϴ�
	      messageHelper.setText(content);  // ���� ����
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      System.out.println(e);
	    }
	   
	    return "redirect:/user/login";
	  }
	
	
}
