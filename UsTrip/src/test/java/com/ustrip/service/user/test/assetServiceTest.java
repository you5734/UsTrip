package com.ustrip.service.user.test;


import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ustrip.service.asset.AssetService;
import com.ustrip.service.domain.Asset;

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
public class assetServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("assetServiceImpl")
	private AssetService assetService;
	
	@Test
	public void testfindpur() throws Exception {
		
		Asset asset = new Asset();
		SimpleDateFormat format = new SimpleDateFormat("yyyy/mm/dd");
		Date visit = format.parse("1970/01/02");
		
		asset.setTravNo(4);
		asset.setBlogNo(30001);
		asset.setVisitDate(visit);
		asset.setUsage("����«��");
		asset.setAssetCategory("�ĺ�");
		asset.setCharge(6500);
		
		int check = assetService.addAsset(asset);

		Assert.assertEquals(1, check);
				
	}
	
	//@Test
	public void testUpdate()throws Exception{
		Asset asset = new Asset();
		Date visit = new Date(90/10/10);
		
		asset.setAssetNo(60043);
		asset.setTravNo(4);
		asset.setBlogNo(30001);
		asset.setVisitDate(visit);
		asset.setUsage("���ɴ�");
		asset.setAssetCategory("�ĺ�");
		asset.setCharge(4500);
		
		int check = assetService.updateAsset(asset);

		Assert.assertEquals(1, check);
	}
	
}
	
	//@Test
