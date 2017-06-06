package com.ustrip.web.community;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.ustrip.service.board.BoardService;
import com.ustrip.service.comment.CommentService;
import com.ustrip.service.domain.Board;
import com.ustrip.service.domain.Comment;

@Controller
@RequestMapping("/community/*")
public class CommunityController {
	
	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	@Autowired
	@Qualifier("commentServiceImpl")
	private CommentService commentService;
	
	public CommunityController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping(value="listCommunity")
	   public String listBoard(@ModelAttribute("search") Search search 
	                    ,HttpSession session,Model model
	                     ) throws Exception{
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		if(search.getOrder() == null || search.getOrder().equals("") || search.getOrder().length() < 1){
			search.setOrder("DESC");
		}
		search.setPageSize(pageSize);
		Map<String , Object> map = boardService.listBoard(search);	
		
		@SuppressWarnings("unchecked")
		List<Board> board = (List<Board>)map.get("list");
		List<Integer> noList = new ArrayList<Integer>();
		List<Comment> selComment = new ArrayList<Comment>();
		HashMap boards = new HashMap();
		
		for(Board b : board){
			noList.add(b.getBoardNo());
			System.out.println(b.getBoardNo());
		}		
		boards.put("boards", noList);			
		
		List<Comment> comment = commentService.listComment(boards);
		for(Board b : board){
			for(Comment c : comment){
				if(b.getBoardNo() == c.getBoardNo()){
					selComment.add(c);
				}//if end
			}// for c end
			b.setMyComment(selComment);
			selComment = new ArrayList<Comment>();
			b.setCountComment(b.getMyComment().size());			
		}//for b end						
		map.put("list", board);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		if(search.getBoardCategory() == 0){	/*
		model.addAttribute("category",0);
		model.addAttribute("order", arg1);*/
		return "forward:/view/community/listMentorView.jsp";
		}else{			
		//model.addAttribute("category",1);
		return "forward:/view/community/listPartyView.jsp";	
		}
		
	}
	
	/*@RequestMapping( value="getCommunityListJSON/{communityCategory}", method=RequestMethod.GET )
	public void getAssetOneJSON(@PathVariable int communityCategory, Model model) throws Exception{
		
		List<Board> board = boardService.listBoard(communityCategory);
		List<Integer> noList = new ArrayList<Integer>();
		List<Comment> selComment = new ArrayList<Comment>();
		HashMap boards = new HashMap();
		
		for(Board b : board){
			noList.add(b.getBoardNo());
			System.out.println(b.getBoardNo());
		}		
		boards.put("boards", noList);			
		
		List<Comment> comment = commentService.listComment(boards);
		for(Board b : board){
			for(Comment c : comment){
				if(b.getBoardNo() == c.getBoardNo()){
					selComment.add(c);
				}//if end
			}// for c end
			b.setMyComment(selComment);
			selComment = new ArrayList<Comment>();
			b.setCountComment(b.getMyComment().size());
			String format = new SimpleDateFormat("yyyy/mm/dd").format(b.getRegDate());
			@SuppressWarnings("deprecation")
			Date transDate = new Date(format);
			b.setRegDate(transDate);
		}//for b end		
		
		model.addAttribute("board",board);
	}*/

}
