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
		
		var tagIndex=1;
		var assetIndex=1;
		
		function showDialog() {
			var dialog;
			
			dialog = $('#dialog-form').dialog({
				resizable:false,
				modal: true,
				width:'auto'
			});
		}
		
		
		
		$('body').on('click' , '.fa-pencil', function() {
			self.location="/blog/updateBlog?blogNo="+$(this).next().val();
			/* 
			var index=$(this).next().val();
			var scoreTag='<div class="col-md-4"><input type="text" name="score" id="score" size="25" placeholder="점수를 남겨주세요(0.1~5.0)">'
						+'<i class="fa fa-check-square-o" aria-hidden="true" id=""></i></div>';
			$($('.stars')[index]).html(scoreTag); */
			
		});
		
		$('body').on('click' , '#listPicture', function() {
			self.location="/blog/listBlog?travelNo="+$("#travNo").val();
		});
		
		
	}); 
	
	
	
		
	</script>
</head>
<body>
	
	<div class="container">
		<input type="button" class="btn btn-default" id="listPicture" value="사진첩">
		<c:if test='${isLiked}'>
		  	<input type="button" class="btn" id="cancel" value="좋아요취소" >
		</c:if>
		<c:if test='${!isLiked}'>
		  	<input type="button" class="btn" id="wishList" value="좋아요" >
		</c:if>
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
		                    <div class='timeline-head'>${blog.place}
			                    <i class="fa fa-pencil" aria-hidden="true" style="margin:10"></i>
			                    <input type="hidden" id="blogNo" name="blogNo" value="${blog.blogNo}"/>
			                    <i class="fa fa-times" aria-hidden="true"></i>
		                    </div>
		                    <span class="stars">${blog.score}</span>
		                    <br/>
		                    ${!empty blog.review? blog.review:""}<hr/>
		                    <c:forEach items="${blog.hashTags}" var="hashTags" varStatus="status2">
		                    	<span>
		                    		#${hashTags.hashTag}
		                    		<input type="hidden" value="${hashTags.tagNo}" name="tagNo">
		                    	</span>
		                    </c:forEach><hr/>
		                    <c:forEach items="${blog.images}" var="images" varStatus="status3">
		                    	<span class=images><a href="/images/upload/blog/${images.serverImgName}" rel="lightbox">
		                    	<img src="/images/upload/blog/${images.serverImgName}" class="img-responsive"></a></span>
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