package com.ustrip.service.user.test;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.ustrip.service.blog.BlogService;
import com.ustrip.service.board.BoardService;
import com.ustrip.service.domain.Asset;
import com.ustrip.service.domain.Board;
import com.ustrip.service.domain.Image;

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
public class blogServerTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("blogServiceImpl")
	private BlogService blogService;
	
	@Test
	public void testfindpur() throws Exception {
		List<Image> images = new ArrayList();
		Image image = new Image();
		
		image.setTravNo(4);
		image.setBlogNo(30001);
		image.setOriginalName("0280020001122.jpg");
		image.setServerImgName("7ac19098-6c1a-465b-8969-843a2538b5da.jpg");
		images.add(image);
		
		 image = new Image();
			
			image.setTravNo(4);
			image.setBlogNo(30001);
			image.setOriginalName("AdventureTime_2304x1296_hperticarati.jpg");
			image.setServerImgName("8ff20ed4-e396-42be-8189-4de09c8e3957.jpg");
			images.add(image);
		
		System.out.println(images);
		int check = blogService.addImage(images);

		Assert.assertEquals(2, check);
				
	}
	
	
	
}
	
	//@Test
