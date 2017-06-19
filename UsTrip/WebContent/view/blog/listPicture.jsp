<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet" type="text/css" href="/css/timeline.css">
	<link href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css' rel="stylesheet" text='text/css'>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  	<link href="/css/lightbox.css" rel="stylesheet">
  	<script src="/js/lightbox.js"></script>
	
  	
	<script type="text/javascript">
	
	
	$(function() {
		
		$('body').on('click' , '.fa-pencil', function() {
			self.location="/blog/updateBlog?blogNo="+$(this).next().val();
			/* 
			var index=$(this).next().val();
			var scoreTag='<div class="col-md-4"><input type="text" name="score" id="score" size="25" placeholder="점수를 남겨주세요(0.1~5.0)">'
						+'<i class="fa fa-check-square-o" aria-hidden="true" id=""></i></div>';
			$($('.stars')[index]).html(scoreTag); */
			
		});
		
		
	}); 
	
	
	
		
	</script>
</head>
<body>
	<div class="container">
		<div class="row">
	        <div class="timeline-centered">
	        <c:set var="i" value="0" />
			<c:forEach items="${list}" var="blog" varStatus="status">
				<input type="hidden" name="travNo" id="travNo" value="${blog.travNo}">
		        <article class="timeline-entry">
		            <div class="timeline-entry-inner">
		                <div class="timeline-icon bg-warning">
		                    <i class="fa fa-map-marker" aria-hidden="true"></i>
		                </div>
		                <div class="timeline-label">
		                    <div class='timeline-head'>${blog.place}( <fmt:formatDate value="${blog.visitDate}" pattern="yyyy/MM/dd"/> )
			                    <input type="hidden" id="blogNo" name="blogNo" value="${blog.blogNo}"/>
		                    </div>
		                    
		                    <c:forEach items="${blog.images}" var="images" varStatus="status3">
		                    	<span class=images><a href="/images/upload/blog/${images.travNo}/${images.serverImgName}" rel="lightbox">
		                    	<img src="/images/upload/blog/${images.travNo}/${images.serverImgName}" class="img-responsive"></a></span>
		                    </c:forEach><hr/>
		                </div>
		            </div>
		        </article>
			</c:forEach>
		</div>
	</div>
</body>
</html>