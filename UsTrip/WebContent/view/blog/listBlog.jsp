<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" type="text/css" href="/css/timeline.css">
	<link href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css' rel="stylesheet" text='text/css'>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  	<link href="/css/lightbox.css" rel="stylesheet">
  	<script src="/js/lightbox.js"></script>
	
	<style>
	    #dialog-form { display:none; }
    	input.text { width:60%; padding: .4em; }
		.validateTips { border: solid transparent; padding: 0.3em; color:blue; }
  	</style>
  	
	<script type="text/javascript">
	

	$.fn.stars = function() {
	    return $(this).each(function() {
	        var val = parseFloat($(this).html());
	        var size = Math.max(0, (Math.min(5, val))) * 16;
	        var $span = $('<span />').width(size);
	        $(this).html($span);
	    });
	}
	
	
	
	/* $(function() {
		$( "#add" ).on("click" , function() {
			 document.forms["updateBlog"].submit(); 
		});
	}); */	
	
	$(function() {
    	$('span.stars').stars();
	});
	
	$(function() {

		$('body').on('click' , '.fa-pencil', function() {
			self.location="/blog/updateBlog?blogNo="+$(this).next().val();
		});
		
		$('body').on('click' , '.fa-times', function() {
			self.location="/blog/deleteBlog?blogNo="+$(this).prev().val();
		});
		
		$('body').on('click' , '#listPicture', function() {
			self.location="/blog/listPicture?travelNo="+$("#travNo").val();
		});
		
		$('body').on('click' , '#travLike', function() {
			
			if($(this).val()=='좋아요취소'){
				$.ajax( 
						{
							url : "/blog/deleteJsonLike/"+$("#travNo").val(),
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							context : this,
							success : function(serverData , status) {
								$(this).val('좋아요');
							}
						});
			}else{
				$.ajax( 
						{
							url : "/blog/addJsonLike/"+$("#travNo").val(),
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							context : this,
							success : function(serverData , status) {
								$(this).val('좋아요취소');
							}
						});
			}
			
		});
		
		$('body').on('click' , '#addPlace', function() {
			self.location="/blog/updatePlace?travelNo="+$("#travNo").val()+"?"+$("#visitDate").val();
		});
	}); 
	
	
	
		
	</script>
</head>
<body>
	<div class="container">
		<input type="button" class="btn btn-default" id="listPicture" value="사진첩">
		<%-- <c:if test='${user.userId}==${writer}'> --%>
			<input type="button" class="btn btn-default" id="addPlace" value="장소추가">
		<%-- </c:if> --%>
		<%-- <c:if test='${user.userId}=!${writer}'> --%>
			<c:if test='${isLiked}'>
			  	<input type="button" class="btn" id="travLike" value="좋아요취소" >
			</c:if>
			<c:if test='${!isLiked}'>
			  	<input type="button" class="btn" id="travLike" value="좋아요" >
			</c:if>
		<%-- </c:if> --%>
		
		<div class="row">
	        <div class="timeline-centered">
	        <c:set var="i" value="0" />
			<c:forEach items="${list}" var="blog" varStatus="status">
				<input type="hidden" name="travNo" id="travNo" value="${blog.travNo}">
				<input type="hidden" name="visitDate" id="visitDate" value="${blog.visitDate}">
		        <article class="timeline-entry">
		            <div class="timeline-entry-inner">
		                <div class="timeline-icon bg-warning">
		                </div>
		                <div class="timeline-label">
		                	<div id="wrapper">
		                		<div id="first">
		                			<i class="fa fa-map-marker" aria-hidden="true"></i>
		                		</div>
			                    <div id="second">${blog.place}
			                    	<span class="myIcon">
				                    	<i class="fa fa-pencil" aria-hidden="true" style="margin-right:10px"></i>
				                   	 	<input type="hidden" id="blogNo" name="blogNo" value="${blog.blogNo}"/>
				                    	<i class="fa fa-times" aria-hidden="true"></i>
				                    </span>
			                    </div>
			                </div>
			                <div id="wrapper">
		                		<div id="first">
		                		</div>
		                		<div id="second">
			               		<span class="stars">${blog.score}</span>
			               		</div>
			               	</div>
		                    <br/>
		                    ${!empty blog.review? blog.review:""}<hr/>
		                    <c:forEach items="${blog.hashTags}" var="hashTags" varStatus="status2">
		                    	<span>
		                    		#${hashTags.hashTag}
		                    	</span>
		                    </c:forEach><hr/>
		                    
		                    <c:forEach items="${blog.images}" var="images" varStatus="status3">
		                    	<span class=images><a href="/images/upload/blog/${images.serverImgName}" rel="lightbox">
		                    	<img src="/images/upload/blog/${images.serverImgName}" class="img-responsive"></a></span>
		                    </c:forEach><hr/>
		                    
		                    <c:forEach items="${blog.assets}" var="assets" varStatus="status4">
		                    	<span style="border-left: 1px solid #eee;">${assets.assetCategory}</span>
		                    	<span style="border-left: 1px solid #eee;">${assets.usage}</span>
		                    	<span style="border-left: 1px solid #eee;">${assets.charge}</span>
		                    	<br/>
		                    </c:forEach><hr/>
		                	
		                	<div class="timeline-head">${blog.memo}</div>
		                </div>
		            </div>
		        </article>
			</c:forEach>
		</div>
	</div>
</body>
</html>