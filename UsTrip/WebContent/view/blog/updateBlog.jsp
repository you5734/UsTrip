<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="/css/timeline.css">
	<link href='https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css' rel="stylesheet" text='text/css'>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
	
	<style>
	    #dialog-form { display:none; }
    	input.text { width:60%; padding: .4em; }
		.validateTips { border: solid transparent; padding: 0.3em; color:blue; }
  	</style>
  	
	<script type="text/javascript">
	
	$(function() {
		
		var tagIndex=1;
		var assetIndex=1;
	
	
	
	/* $(function() {
		$( "#add" ).on("click" , function() {
			 document.forms["updateBlog"].submit(); 
		});
	}); */	
	
	
		
		
		
		$('body').on('click' , '.fa-pencil', function() {
			var blogNo=$(this).next().val();
			
			$.ajax( 
					{
						url : "/blog/getJsonBlog/"+blogNo,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						context : this,
						success : function(serverData , status) {
							$("#dialog-form").attr('title',serverData.blog.place);
							if(serverData.blog.review!=null){
								$("#review").html(serverData.blog.review);
							}
							$("#score").val(serverData.blog.score);
							showDialog();
						}
					});
				
			});
		
		$('body').on('click' , '#tagPlus', function() {
			var addTag='<input type="text" name="hashTags['+tagIndex+'].hashTag" id="hashTag" class="form-control" style="width: 70px;" maxlength="10" id="hashTag" value="" >';
			$(this).before(addTag);
			tagIndex++;
		});
		
		$('body').on('click' , '#assetPlus', function() {
			var addTag='<div class="form-group">'
	         	 	  +'<label class="col-md-2 col-sm-2 col-xs-2 control-label" for="textinput"><i class="fa fa-usd" aria-hidden="true"></i></i></label>'
	         	 	  +'<div class="col-md-3 col-sm-3 col-xs-3">'
	         	 	  +'<select class="form-control" name="assets['+assetIndex+'].assetCategory" id="assetCategory" >'
	         	 	  +'<option value="식비" selected="selected">식비</option>'
	         	 	  +'<option value="교통비">교통비</option>'
	         	 	  +'<option value="숙박비">숙박비</option>'
	         	 	  +'<option value="쇼핑">쇼핑</option>'
	         	 	  +'<option value="입장료">입장료</option>'
	         	 	  +'<option value="기타">기타</option>'
	         	 	  +'</select></div><div class="col-md-3 col-sm-3 col-xs-3">'
	         	 	  +'<input type="text" name="assets['+assetIndex+'].usage" class="form-control" placeholder="사용처" /></div>'
	         	 	  +'<div class="col-md-3 col-sm-3 col-xs-3"><input type="text" name="assets['+assetIndex+'].charge" class="form-control" placeholder="사용금액" />'
	         	 	  +'</div><div><i class="fa fa-plus" aria-hidden="true" id="assetPlus"></i></div></div>';
			$('#asset').after(addTag);
			$(this).replaceWith('<i class="fa fa-times" aria-hidden="true"></i>');
			assetIndex++;
		});
		
		
	}); 
	

	</script>
</head>
	<body>
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<form class="form-horizontal" enctype="multipart/form-data" method="POST" action="updateBlog">
					<fieldset>
						<input type="hidden" name="blogNo" value="${blog.blogNo}"><%-- 
						<input type="hidden" name="hashTag[0].blogNo" value="${blog.blogNo}">
						<input type="hidden" name="assets[0].travNo" value="${blog.travNo}">
						<input type="hidden" name="assets[0].visitDate" value="${blog.visitDate}">
						<input type="hidden" name="assets[0].blogNo" value="${blog.blogNo}"> --%>
			          	<legend><i class="fa fa-map-marker" aria-hidden="true"></i>${blog.place}</legend>
			
			          	<div class="form-group">
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></label>
			            	<div class="col-sm-10">
			              		<textarea class="form-control" style="width:350px; height:150px;" maxlength="250" name="review" id="review" placeholder="리뷰를 남겨주세요"></textarea>
			            	</div>
			          	</div>
						
			          	<div class="form-group">
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i></label>
			            	<div class="col-sm-8">
			              		<input type="text" class="form-control" name="score" id="score" placeholder="점수를 남겨주세요(0.1~5.0)">
			            	</div>
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-check-square-o" aria-hidden="true"></i></label>
			          	</div>
			
			          	<!-- <div class="form-group">
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-camera" aria-hidden="true"></i></label>
			            	<div class="col-sm-10">
			              		<input type="file" name="files[]" id="file" multiple/>
			            	</div>
			          	</div> -->
			          
			          	<div class="form-group" id="asset">
			         	 	<label class="col-md-2 col-sm-2 col-xs-2 control-label" for="textinput"><i class="fa fa-usd" aria-hidden="true"></i></i></label>
			              	<div class="col-md-3 col-sm-3 col-xs-3">
			                  	<select class="form-control" name="assets[0].assetCategory" id="assetCategory" >
									<option value="식비" selected="selected">식비</option>
									<option value="교통비">교통비</option>
									<option value="숙박비">숙박비</option>
									<option value="쇼핑">쇼핑</option>
									<option value="입장료">입장료</option>
									<option value="기타">기타</option>
							 	</select>
			              	</div>
			         	  	<div class="col-md-3 col-sm-3 col-xs-3">
			              		<input type="text" class="form-control" placeholder="사용처" />
			              	</div>
			       	      	<div class="col-md-3 col-sm-3 col-xs-3">
			              		<input type="text" class="form-control" placeholder="사용금액" />
			              	</div>
			            	<div>
			              		<i class="fa fa-plus" aria-hidden="true" id="assetPlus"></i>
			            	</div>
			         	</div>
			
			          	<div class="form-group">
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-hashtag" aria-hidden="true"></i></label>
			            	<div class="col-sm-8">
			              		<input type="text" name="hashTags[0].hashTag" id="hashTags[0].hashTag" class="form-control" style="width: 70px;" maxlength="10" id="hashTag" value="" >
			            	</div>
			            	<div class="col-sm-2">
						  		<i class="fa fa-plus" aria-hidden="true" id="tagPlus"></i>
			           	 	</div>         
						</div>
						
					    <br/>
			         	<div class="col-sm-offset-2 col-sm-10">
			         		<div class="pull-right">
			            		<input type="submit" class="btn btn-default" id="update" value="확인">
			                	<input type="button" class="btn btn-default" id="cancel" value="취소">
			            	</div>
			         	</div>
	        		</fieldset>
	      		</form>
	    	</div>
		</div>
	</body>
</html>