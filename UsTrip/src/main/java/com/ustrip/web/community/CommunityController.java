package com.ustrip.web.community;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ustrip.service.board.BoardService;
import com.ustrip.service.comment.CommentService;
import com.ustrip.service.domain.Asset;
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
	
	@RequestMapping(value="getCommunity",method=RequestMethod.POST)
	   public String listBoard(@ModelAttribute("asset")Asset asset
	                    ,HttpSession session,Model model
	                     ) throws Exception{
		return "forward:/view/asset/addAsset.jsp";
		
	}
	
	@RequestMapping( value="getCommunityListJSON/{communityCategory}", method=RequestMethod.GET )
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
		}//for b end		
		
		model.addAttribute("board",board);
	}

}
