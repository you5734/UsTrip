package com.ustrip.service.board;

import java.util.List;
import java.util.Map;

import com.ustrip.common.Search;
import com.ustrip.service.domain.Board;

public interface BoardService {
	
	public int addBoard(Board board)throws Exception;
	
	public List<Board> listBoard(Search search)throws Exception;
	
	public int updateBoard(Board board)throws Exception;
	
	public int deleteBoard(int boardNo)throws Exception;
	
	public Board getBoard(int boardNo)throws Exception;
	
	public int getTotalCount(Search search)throws Exception;
	
}
