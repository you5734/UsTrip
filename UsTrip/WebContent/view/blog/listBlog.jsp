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
			self.location='/blog/updateBlog?blogNo='+$(this).next().val();
		});
		
		
	}); 
	
	
	
		
	</script>
</head>
<body>
	
	<div class="container">
		<div class="row">
	        <div class="timeline-centered">
			<c:forEach items="${list}" var="blog" varStatus="status">
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
		                    	<span class="stars">${blog.score}</span>
		                    </div><br/><hr/>
		                    <div class="timeline-head">${blog.memo}</div><br/>
		                    <img src="http://themes.laborator.co/neon/assets/images/timeline-image-3.png" class="img-responsive img-rounded full-width">
		                </div>
		            </div>
		        </article>
			</c:forEach>
	   	 	</div>
	   	 	<!-- 
	   	 	<i class="fa fa-map-marker" aria-hidden="true"></i><div id="dialog-form" title="블로그수정">										 
			<form enctype="multipart/form-data" >
				<div class="col-md-4">
					<i class="fa fa-pencil-square-o" aria-hidden="true"></i>
					<textarea style="width:300px; height:150px;" maxlength="250" name="review" id="review" placeholder="리뷰를 남겨주세요"></textarea>
				</div><hr/>
				<div class="col-md-4">
					<i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
					<input type="text" name="score" id="score" size="25" placeholder="점수를 남겨주세요(0.1~5.0)">
					<div id="checkpw" style="color:red; font-size:12px;"></div><hr/>
				</div>
				<div class="col-md-4">
					<i class="fa fa-camera" aria-hidden="true"></i>
					<input type="file" name="files" id="fileName" multiple/><hr/>
				</div> 
				<div class="col-md-4">
					<i class="fa fa-hashtag" aria-hidden="true"></i>
					<input type="text" name="hashTag" id="hashTag" size="5" maxlength="10" id="hashTag" value="" >
					<i class="fa fa-plus" aria-hidden="true" id="tagPlus"></i>
				</div><hr/>
				<div class="col-md-4">
					<i class="fa fa-usd" aria-hidden="true"></i>&nbsp;
					<select name="assetCategory" id="assetCategory" style="width: 70px; height: 25px; color:black" maxLength="20">
							<option value="1" selected="selected">식비</option>
							<option value="2">교통비</option>
							<option value="3">숙박비</option>
							<option value="4">쇼핑</option>
							<option value="5">입장료</option>
							<option value="6">기타</option>
					</select>
					<input type="text" name="usage" id="usage" placeholder="사용처" size="7">
					<input type="text" name="charge" id="charge" placeholder="사용금액" size="9">
					<i class="fa fa-plus" aria-hidden="true" id="assetPlus"></i>
				</div><hr/>
				<div class="form-group">
					<div class=" col-sm-offset text-center">
					<input type="button" class="btn btn-info btn" id="update" value="확인">
					<input type="button" class="btn btn-info" id="cancel" value="취소">
					</div>
				</div> 
				<input type="hidden" value="" id="blogNo" name="blogNo">
			</form> 
			</div>-->
		</div>
	</div>
</body>
</html>