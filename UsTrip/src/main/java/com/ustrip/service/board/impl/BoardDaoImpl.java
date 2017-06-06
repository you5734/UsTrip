package com.ustrip.service.board.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ustrip.common.Search;
import com.ustrip.service.board.BoardDao;
import com.ustrip.service.domain.Board;

@Repository("boardDaoImpl")
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public BoardDaoImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@Override
	public int addBoard(Board board) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("BoardMapper.addBoard",board);
	}
	@Override
	public int updateBoard(Board board) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("BoardMapper.updateBoard",board);
	}

	@Override
	public int deleteBoard(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("BoardMapper.deleteBoard",boardNo);
	}

	@Override
	public Board getBoard(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("BoardMapper.getBoard", boardNo);
	}

	@Override
	public List<Board> listBoardDESC(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("BoardMapper.getBoardDESC",search);
	}

	@Override
	public List<Board> listBoardASC(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("BoardMapper.getBoardASC",search);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("BoardMapper.getTotalCount",search);
	}

}
