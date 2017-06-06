package com.ustrip.service.user.test;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ustrip.common.Page;
import com.ustrip.common.Search;
import com.ustrip.service.asset.AssetService;
import com.ustrip.service.board.BoardService;
import com.ustrip.service.domain.Asset;
import com.ustrip.service.domain.Board;

/*
 *	FileName :  UserServiceTest.java
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test)
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����,DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */
@RunWith(SpringJUnit4ClassRunner.class)

//==> Meta-Data �� �پ��ϰ� Wiring ����...
//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class boardServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	//@Test
	public void testfindpur() throws Exception {
		
		Board board = new Board();
		
		board.setTravNo(4);
		board.setNickName("user001");;
		board.setHits(0);;
		board.setBoardContent("�����ٶ󸶹ٻ�ƾ��������J���÷�");
		board.setBoardTitle("�Ϻ� �� ����;��!");
		board.setBoardCategory(1);
		
		int check = boardService.addBoard(board);

		Assert.assertEquals(1, check);
				
	}
	
	//@Test
	public void testupdate() throws Exception {
		
		Board board = new Board();
		
		board.setBoardNo(70002);
		board.setTravNo(4);
		board.setNickName("user001");;
		board.setHits(0);;
		board.setBoardContent("�����ٶ󸶹ٻ�ƾ��������J���÷�");
		board.setBoardTitle("��������");
		board.setBoardCategory(0);
		
		int check = boardService.updateBoard(board);

		Assert.assertEquals(1, check);
				
	}
	
	//@Test
	public void testdel() throws Exception {
		
		int check = boardService.deleteBoard(70003);

		Assert.assertEquals(1, check);
		
	}
	
	//@Test
	public void testget() throws Exception {
		
		Board check = boardService.getBoard(70002);

		Assert.assertEquals("��������", check.getBoardTitle());
		
	}
	
	@Test
	public void testlist() throws Exception {
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setOrder("DESC");
		search.setBoardCategory(0);
		search.setPageSize(5);
		
		Map<String , Object> map = boardService.listBoard(search);
		List<Board> reci = (List<Board>)map.get("list");	
		int a = Integer.parseInt((String) map.get("totalCount"));
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 3, 5);
		
		Assert.assertEquals(3, a );
		
	}
	
}
	
	//@Test
