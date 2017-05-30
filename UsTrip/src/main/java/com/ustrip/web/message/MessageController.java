package com.ustrip.web.message;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ustrip.service.domain.Message;
import com.ustrip.service.message.MessageService;

@Controller
@RequestMapping("/message/*")
public class MessageController {
	
	///Field
	@Autowired
	@Qualifier("messageServiceImpl")
	private MessageService messageService;
	
	public MessageController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="sendMsg", method=RequestMethod.GET )
	public String sendMsg() throws Exception{
	
		System.out.println("/message/sendMsg : GET");
		
		return "forward:/view/message/sendMsg.jsp";
	}
	
	@RequestMapping( value="sendMsg", method=RequestMethod.POST )
	public String sendMsg( @ModelAttribute("message") Message message) throws Exception{
	
		System.out.println("/message/sendMsg : POST");
		
		messageService.sendMsg(message);
		System.out.println("message :: " + message);
		
		return "redirect:/view/user/addUser.jsp";
	}
	
	
}
