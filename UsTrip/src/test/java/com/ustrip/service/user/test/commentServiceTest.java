package com.ustrip.service.user.test;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ustrip.service.asset.AssetService;
import com.ustrip.service.board.BoardService;
import com.ustrip.service.comment.CommentService;
import com.ustrip.service.domain.Asset;
import com.ustrip.service.domain.Board;
import com.ustrip.service.domain.Comment;

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
public class commentServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("commentServiceImpl")
	private CommentService commentdService;
	
	//@Test
	public void testfindpur() throws Exception {
		
		Comment comment = new Comment();
		
		comment.setBoardNo(70001);
		comment.setNickName("user001");;
		comment.setPrivateComment(0);
		comment.setCommentContent("�ַ����پƾƎ������þ�");
		
		int check = commentdService.addComment(comment);

		Assert.assertEquals(1, check);
				
	}
	
	//@Test
	public void testupdate() throws Exception {		
		
		Comment comment = new Comment();
		
		comment.setCommentNo(80003);
		comment.setBoardNo(70002);
		comment.setNickName("user001");;
		comment.setPrivateComment(1);
		comment.setCommentContent("����Ĥ�������J���÷�");
		
		int check = commentdService.updateComment(comment);

		Assert.assertEquals(1, check);
				
	}
	
	//@Test
	public void testdel() throws Exception {
		
		int check = commentdService.deleteComment(80003);
		Assert.assertEquals(1, check);
		
	}
	
	//@Test
	public void testget() throws Exception {
		
		HashMap hm = new HashMap();
		List<Integer> no = new ArrayList();
		String order = "DESC";
		no.add(70002);
		//no.add(70004);
		no.add(70001);
		hm.put("boards", no);
				
		List<Comment> comment = commentdService.listComment(hm);
		Assert.assertEquals(2, comment.size());
		
	}
	
	//@Test
		public void testget1() throws Exception {
			
			List<Comment> check = commentdService.getComment(70004);
			Assert.assertEquals(3, check.size());
			
		}
		
}
	
	//@Test
