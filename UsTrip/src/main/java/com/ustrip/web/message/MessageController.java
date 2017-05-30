package com.ustrip.web.message;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ustrip.common.Page;
import com.ustrip.common.Search;
import com.ustrip.service.domain.Message;
import com.ustrip.service.message.MessageService;

@Controller
@RequestMapping("/message/*")
public class MessageController {
	
	///Field
	@Autowired
	@Qualifier("messageServiceImpl")
	private MessageService messageService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
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
		
		return "forward:/message/listSendMsg";
	}
	
	@RequestMapping( value="listSendMsg")
	public String listSendMsg( @ModelAttribute("search") Search search, Model model ) throws Exception{
		
		System.out.println("/message/listSendMsg");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=messageService.listSendMsg(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/view/message/listSendMsg.jsp";
	}
	
	@RequestMapping( value="getMsg", method=RequestMethod.GET )
	public String sendMsg( @RequestParam int msgNo ) throws Exception{
	
		System.out.println("/message/getMsg : GET");
		
		Message message = messageService.getMsg(msgNo);
		System.out.println("message :: " + message);
		
		return "forward:/view/message/getMsg.jsp";
	}
	
	
}
