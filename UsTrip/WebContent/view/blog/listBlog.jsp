<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" media="all" type="text/css"/>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
  	
  	<link href="/css/star-rating.min.css" rel="stylesheet" media="all" type="text/css"/>
  	<script src="/js/star-rating.min.js" type="text/javascript"></script>
  	
  	<link href="/css/lightbox.css" rel="stylesheet" media="all" type="text/css"/>
  	<script src="/js/lightbox.js" type="text/javascript"></script>
	
	<style>
@import url('https://fonts.googleapis.com/css?family=Lato:300,400,700,900');

* {
	pading: 0;
	margin: 0;
	font-family: "Lato", sans-serif;
	position: relative;
}

.timeline {
	padding: 40px 0px;
	width: 80%;
	margin-left: 10%;
	margin-bottom: 40px;
}

.timeline:before {
	content: "";
	position: absolute;
	top: 40px;
	left: 65px;
	width: 3px;
	height: calc(100% - 80px);
	background: #c0392b;
}

.timeline .column {
	margin: 40px 40px 40px 120px;
}

.timeline .column .title h1 {
	font-size: 120px;
	font-weight:600;
	color: rgba(0,0,0,0.1);
	font-family: serif;
	letter-spacing: 3px;
}

.timeline .column .title h1:before {
	content: "";
	position: absolute;
	left: -62px;
	top: 86px;
	width: 10px;
	height: 10px;
	background: #fff;
	border: 3px solid #c0392b;
}

.timeline .column .title h2 {
	font-weight:600;
	margin-top: -60px;
	font-size: 33px;
}

.timeline .column .description p {
	font-size: 13px;
	line-height: 20px;
	margin-left: 20px;
	margin-top: 10px;
	font-family: serif;
}

/* .timeline .column .description {
	border-left: 1px solid #000;
} */

.main {
	width: 80%;
	margin-left: 10%;
	margin-top: 80px;
}

.main h1 {
	font-size: 80px;
	line-height: 60px;
}

.main p {
	font-size: 13px;
	line-height: 20px;
	font-family: serif;
	text-align: right;
}


</style>
  	
	<script type="text/javascript">
		
	$(function() {
				
		$('body').on('click' , '.fa-pencil', function() {
			self.location="/blog/updateBlog?blogNo="+$(this).attr('temp');
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
		
		 $('.kv-fa').rating({	   
			  hoverOnClear: false,
	            	filledStar: '<i class="fa fa-star"></i>',
	                emptyStar: '<i class="fa fa-star-o"></i>',
	                clearButton: '<i class="fa fa-lg fa-minus-circle"></i>',
	                displayOnly: true, step: 0.5
	        });
		 
	}); 
	
	
	
		
	</script>
</head>
<body>
	
		<input type="button" class="btn btn-default" id="listPicture" value="사진첩">
		<%-- <c:if test='${user.userId}==${writer}'> --%>
			<input type="button" class="btn btn-default" id="addPlace" value="장소추가">
		<%-- </c:if> --%>
		<%-- <c:if test='${user.userId}=!${writer}'> --%>
			<c:if test='${isLiked == 1}'>
			  	<input type="button" class="btn" id="travLike" value="좋아요취소" >
			</c:if>
			<c:if test='${isLiked == 0}'>
			  	<input type="button" class="btn" id="travLike" value="좋아요" >
			</c:if>
		<%-- </c:if> --%>
	
	<c:set var="i" value="0" />
	<c:forEach items="${list}" var="blog" varStatus="status">
		<input type="hidden" name="travNo" id="travNo" value="${blog.travNo}">
		<input type="hidden" name="visitDate" id="visitDate" value="${blog.visitDate}">
		<input type="hidden" id="blogNo" name="blogNo" value="${blog.blogNo}"/>
		<div class="timeline">
			<div class="column">
			
				<div class="title">
					<h1> <fmt:formatDate value="${blog.visitDate}" pattern="yyyy/MM/dd"/> </h1>
					<h2>  ${blog.place}</h2>			
				</div>
				<div class="row">
    				<div class="col-md-6 text-left">
						<input class="kv-fa rating-loading " data-size="xs" id="score" value="${blog.score}">
					</div>
					<div class="col-md-6 text-right" style="font-size:20px;">
					<i class="fa fa-pencil" aria-hidden="true" style="margin-right:10px" temp="${blog.blogNo}"></i>/<i class="fa fa-times" aria-hidden="true"></i>
					</div>
				</div>
		
				<div class="description text-default">		
		
           <div>
				<c:forEach items="${blog.images}" var="images" varStatus="status3">
		        	<%-- <span class=images><a href="/images/upload/blog/${images.travNo}/${images.serverImgName}" rel="lightbox">
		        	<img src="/images/upload/blog/${images.travNo}/${images.serverImgName}" class="img-responsive" data-lightbox="roadtrip"></a></span> --%>
		        	
		        	<a class="image-link" href="/images/upload/blog/${images.travNo}/${images.serverImgName}" data-lightbox="set" data-title="${images.originalName}">
		        	<img class="image" src="/images/upload/blog/${images.travNo}/${images.serverImgName}" alt="${images.originalName}" style="width:150px; height:100px;"></a>
		        	
		        </c:forEach></div><hr/>
		
		 			&nbsp;${!empty blog.review? blog.review:""}<hr/>
		 			
		 		<c:forEach items="${blog.hashTags}" var="hashTags" varStatus="status2">
                	<span>&nbsp;#${hashTags.hashTag}</span>
                </c:forEach><hr/>
		                    
               <c:forEach items="${blog.assets}" var="assets" varStatus="status4">
               	<span > &nbsp;${assets.assetCategory}</span>
               	<span > &nbsp;${assets.usage}</span>
               	<span > &nbsp;${assets.charge}</span>
               	<br/>
               </c:forEach><hr/>
               
		           &nbsp;${blog.memo}
		                     
				</div>
				
			</div>
		</div>
</c:forEach>
		
</body>
</html>