package com.ustrip.web.plan;
/*
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PlanController {
	///Field
		@Autowired
		@Qualifier("purchaseServiceImpl")
		private PurchaseService purchaseService;
		
		@Autowired
		@Qualifier("productServiceImpl")
		private ProductService productService;
		
		@Autowired
		@Qualifier("userServiceImpl")
		private UserService userService;
			
		public PlanController(){
			System.out.println(this.getClass());
		}
		
		//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
		//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
		@Value("#{commonProperties['pageUnit']}")
		//@Value("#{commonProperties['pageUnit'] ?: 3}")
		int pageUnit;
		
		@Value("#{commonProperties['pageSize']}")
		//@Value("#{commonProperties['pageSize'] ?: 2}")
		int pageSize;
		
		
		//@RequestMapping("/addPurchaseView.do")
		@RequestMapping( value="addPurchase", method=RequestMethod.GET )
		public ModelAndView addPurchaseView(@RequestParam("prodNo") int prodNo ,@ModelAttribute("purchase") Purchase purchase,Model model) throws Exception {
			
			Product product = productService.findProduct(prodNo);
			ModelAndView modelAndView=new ModelAndView();
	
			
			modelAndView.addObject("product",product);
			modelAndView.setViewName("/purchase/addPurchaseView.jsp");
			
			return modelAndView;		
			}
		
		//@RequestMapping("/addPurchase.do")
		@RequestMapping( value="addPurchase", method=RequestMethod.POST )
		public String addPurchase(@RequestParam("userId") String userId, @RequestParam("prodNo") String stringProdNo, @ModelAttribute("purchase") Purchase purchase, Model model) throws Exception {
			
			System.out.println("/purchase/addPurchase : POST");
			
			int prodNo = Integer.parseInt(stringProdNo);
			Product purchaseProd = productService.findProduct(prodNo);
			purchase.setPurchaseProd(purchaseProd);
			
			User buyer = userService.getUser(userId);
			purchase.setBuyer(buyer);
			
			purchaseService.addPurchase(purchase);
			
			model.addAttribute("purchase",purchase);
			
			return "forward:/purchase/addPurchase.jsp";
		}
		public String addPurchase(@ModelAttribute("purchase") Purchase purchase,Model model) throws Exception {

			
			//Business Logic
			System.out.println("sssssssssssssssssssssss"+purchase);
			Product product=productService.findProduct(prodNo);
			User user = userService.getUser(userId);
			purchase.setBuyer(user);
			purchase.setPurchaseProd(product);
			//System.out.println("잘됐으면 좋겠당"+user);
			purchaseService.addPurchase(purchase);
			System.out.println("왜 안나와"+purchase);
			
			model.addAttribute("purchase",purchase);
			
			return "forward:/purchase/addPurchase.jsp";
		}
		
		@RequestMapping( value="getPurchase")
		public String getPurchase( @RequestParam("tranNo") int tranNo ,HttpSession session, Model model ) throws Exception {
			
			System.out.println("/getPurchase.do");
			//Business Logic
			Purchase purchase = purchaseService.getPurchase(tranNo);
			// Model 과 View 연결
			model.addAttribute("purchase", purchase);
			
			return "forward:/purchase/getPurchase.jsp";
		}
		
		
		@RequestMapping(value = "updatePurchaseView", method=RequestMethod.GET)
		public String updatePurchase(@RequestParam("tranNo") int tranNo , Model model) throws Exception{

			System.out.println("/updatePurchaseView");
			
			Purchase purchase = purchaseService.getPurchase(tranNo);
			
			model.addAttribute("purchase", purchase);
			//Business Logic
			//purchaseService.updatePurchase(purchase);
			
			return "forward:/purchase/updatePurchaseView.jsp";
		}
		
		@RequestMapping(value = "updatePurchaseView" , method = RequestMethod.POST)
		public String updatePurchase(@ModelAttribute ("purchase") Purchase purchase ,@RequestParam("buyerId")String buyerId ) throws Exception{
			
			User user = userService.getUser(buyerId);
			purchase.setBuyer(user);
			
			purchaseService.updatePurchase(purchase);
			
			return "redirect:/purchase/listPurchase";
		}
		
		
		@RequestMapping(value = "listPurchase")
		//@RequestMapping( value="addPurchase", method=RequestMethod.POST )
		public String listPurchase( @ModelAttribute("search") Search search , HttpSession session ,Model model , HttpServletRequest request) throws Exception{
			System.out.println("1빠");
			
			String buyerId = ((User)session.getAttribute("user")).getUserId();
			
			System.out.println("/listPurchase.do");
			
			if(search.getCurrentPage() ==0 ){
				search.setCurrentPage(1);
			}
			search.setPageSize(pageSize);
			System.out.println("2빠");
			// Business logic 수행
			Map<String , Object> map=purchaseService.getPurchaseList(search,buyerId);
			System.out.println("3빠");
			Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			System.out.println(resultPage);
			System.out.println("4빠");
			// Model 과 View 연결
			model.addAttribute("list", map.get("list"));
			model.addAttribute("resultPage", resultPage);
			model.addAttribute("search", search);
			System.out.println("5빠");
			return "forward:/purchase/listPurchase.jsp";
		}
		
		@RequestMapping(value="updateTranCodeByProd")
		public String UpdateTranCodeByProdAction(@RequestParam("prodNo") int prodNo ) throws Exception {
			
			Purchase purchase = purchaseService.getPurchase2(prodNo);
			purchaseService.updateTranCode(purchase);
			
			return "redirect:/product/listProduct?menu=manage";
		}
		
		@RequestMapping(value="updateTranCode")
		public String UpdateTranCode(@RequestParam("tranNo") int tranNo ) throws Exception {
			
			Purchase purchase = purchaseService.getPurchase(tranNo);
			purchaseService.updateTranCode(purchase);		
			
			return "redirect:/purchase/listPurchase.jsp";
		}
	}*/