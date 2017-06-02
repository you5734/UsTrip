package com.ustrip.service.board.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ustrip.service.board.BoardDao;
import com.ustrip.service.board.BoardService;
import com.ustrip.service.domain.Board;

@Service("boardServiceImpl")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	@Qualifier("boardDaoImpl")
	private BoardDao boardtDao;
	public void setBoardDao(BoardDao boardtDao) {
		this.boardtDao = boardtDao;
	}

	public BoardServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@Override
	public int addBoard(Board board) throws Exception {
		// TODO Auto-generated method stub
		return boardtDao.addBoard(board);
	}

	@Override
	public List<Board> listBoard(int boardCategory) throws Exception {
		// TODO Auto-generated method stub
		return boardtDao.listBoard(boardCategory);
	}

	@Override
	public int updateBoard(Board board) throws Exception {
		// TODO Auto-generated method stub
		return boardtDao.updateBoard(board);
	}

	@Override
	public int deleteBoard(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		return boardtDao.deleteBoard(boardNo);
	}

	@Override
	public Board getBoard(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		return boardtDao.getBoard(boardNo);
	}

}
