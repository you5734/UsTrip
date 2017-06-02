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
	<script src="/js/jquery.form.js"></script>
	<link href="/css/lightbox.css" rel="stylesheet">
  	<script src="/js/lightbox.js"></script>
	
	<style>
	    #dialog-form { display:none; }
    	input.text { width:60%; padding: .4em; }
		.validateTips { border: solid transparent; padding: 0.3em; color:blue; }
  	</style>
  	
	<script type="text/javascript">
	
	$(function() {

		var blogNo=$('#blogNo').val();
		var travNo=$('#travNo').val();
	
	/* $(function() {
		$( "#add" ).on("click" , function() {
			 document.forms["updateBlog"].submit(); 
		});
	}); */	
	
	
		
		
		
		$('body').on('click' , '.fa-pencil', function() {
			
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
			var tag=$('#hashTag').val();
			var blogNo=$('#blogNo').val();/* 
			alert(tagCount);
			if(tagCount<=10){ */
				$.ajax( 
						{
							url : "/blog/addJsonTag/"+tag+"/"+blogNo,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							context : this,
							success : function(serverData , status) {
								var addTag='<span name="hashTag">#'+serverData.hashTag.hashTag+'</span>'
					    				  +'<i class="fa fa-times" aria-hidden="true" id="deleteTag"></i>'
					    				  +'<input type="hidden" value="'+serverData.hashTag.tagNo+'">';
					    				  
								$($("#tagSpan")).prepend(addTag);
								$(this).prev('input').val("");
								/* tagCount++; */
							}
						});
			/* }else{
				alert("태그는 최대 10개까지 가능합니다.");
			} */
			
		});
		
		$('body').on('click' , '#assetPlus', function() {
			var assetCategory=$('#assetCategory').val();
			var usage=$('#usage').val();
			var charge=$('#charge').val();
			$.ajax( 
					{
						url : "/blog/addJsonAsset/"+charge+"/"+blogNo+"/"+travNo+"/"+assetCategory+"/"+usage,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						context : this,
						success : function(serverData , status) {
							var addAsset='<div class="form-group" id="'+serverData.asset.assetNo+'">'
		         	 				   +'<label class="col-md-2 col-sm-2 col-xs-2 control-label" for="textinput"><i class="fa fa-usd" aria-hidden="true"></i></i></label>'
		         	 				   +'<div class="col-md-3 col-sm-3 col-xs-3">'
		         	 				   +'<input type="text" class="form-control" name="category" value="'+serverData.asset.assetCategory+'" readonly/></div>'
		         	 				   +'<div class="col-md-3 col-sm-3 col-xs-3">'
		         	 				   +'<input type="text" class="form-control" name="usage" value="'+serverData.asset.usage+'" readonly/>'
		         	 				   +'</div><div class="col-md-3 col-sm-3 col-xs-3">'
		         	 				   +'<input type="text" class="form-control" name="charge" value="'+serverData.asset.charge+'" readonly/></div>'
		         	 				   +'<label class="col-md-1 col-sm-1 col-xs-1 control-label" for="textinput"><i class="fa fa-times" aria-hidden="true" id="deleteAsset"></i>'
		         	 				   +'<input type="hidden" value="'+serverData.asset.assetNo+'"></label></div>';
		         	 				   
		         	 		$(addAsset).insertBefore($("#asset:last"));
		         	 		$('#charge').last().val("");
		         	 		$('#usage').last().val("");
						}
					});
		});
		
		$('body').on('click' , '#deleteTag', function() {
			tagNo=$(this).next().val();
			
			$.ajax( 
					{
						url : "/blog/deleteJsonTag/"+tagNo,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						context : this,
						success : function(serverData , status) {
							$(this).prev('span').remove();
							$(this).remove();
						}
					});
		});
		
		$('body').on('click' , '#deleteAsset', function() {
			var assetNo=$(this).next().val();
			
			$.ajax( 
					{
						url : "/asset/deleteAssetJSON/"+assetNo,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						context : this,
						success : function(serverData , status) {
							$('#'+assetNo+'').remove();
							$(this).remove();
						}
					});
		});
		
		$('body').on('click' , '#updateScore', function() {
			var score=$("#score").val();
			
			if(0.1<=score&&score<=5){
				$.ajax( 
						{
							url : "/blog/updateJsonScore/"+score+"/"+blogNo,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							context : this,
							success : function(serverData , status) {
								alert("점수업데이트");
								$("#score").val(score);
							}
						});
			}else{
				alert("점수는 0.1~5.0까지 가능합니다.")
			}
		});
		
		$('body').on('click' , '#updateReview', function() {
			var review=$("#review").val();
			
			$.ajax( 
					{
						url : "/blog/updateJsonReview/"+blogNo+"/"+review,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						context : this,
						success : function(serverData , status) {
							$('#review').val(review);
							alert("리뷰업데이트");
						}
					});
		});
		
		$("#btn").click(function(){
			
			$('#addImage').ajaxForm({
		    	complete : function(serverData) {
							/* var addImage+'<span class=images><a href="/images/upload/blog/'+serverData.image[i].serverImgName+'" rel="lightbox">'
				 			+'<img src="/images/upload/blog/'+serverData.image[i].serverImgName+'" class="img-responsive"></a></span>'; */

					 /* alert(JSON.stringify(serverData));
					 	 	
					 
			 	 	 alert("dd"); */
				}
		   	}); 
		});
		
		$('body').on('click' , '#confirm', function() {
			var date=$('#visitDate').val().split("-");
			
			
			self.location="/blog/listBlog?travelNo="+travNo+"&visitDate="+date[0]+date[1]+date[2];
		});
		
	});

</script>
</head>
	<body>
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<form class="form-horizontal" enctype="multipart/form-data" id="addImage" name="addImage" action="addJsonImage" method="POST">
					<fieldset>
						<input type="hidden" name="blogNo" id="blogNo" value="${blog.blogNo}">
						<input type="hidden" name="travNo" id="travNo" value="${blog.travNo}">
						<input type="hidden" name="visitDate" id="visitDate" value="${blog.visitDate}">
			          	<legend><i class="fa fa-map-marker" aria-hidden="true"></i>${blog.place}</legend>
			
			          	<div class="form-group">
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></label>
			            	<div class="col-sm-8">
			              		<textarea class="form-control" style="width:350px; height:150px;" maxlength="250" name="review" id="review" placeholder="리뷰를 남겨주세요" >${!empty blog.review? blog.review : ""}</textarea>
			            	</div>
			            	<label class="col-sm-2 control-label" for="textinput">
				              		<i class="fa fa-check" aria-hidden="true" id="updateReview"></i>
				            </label>
			          	</div>
		                <hr/>
						
			          	<div class="form-group">
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-thumbs-o-up" aria-hidden="true"></i></label>
			            	<div class="col-sm-6">
			              		<input type="text" class="form-control" name="score" id="score" value="${!blog.score.equals("0.0")? blog.score:"점수입력(0.1~5.0)"}" >
			            	</div>
			            	<div class="col-sm-4">
			            		<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-check" aria-hidden="true" id="updateScore"></i></label>
			            	</div>
			          	</div>
						<hr/>
						
						
						<div class="form-group">
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-camera" aria-hidden="true"></i></label>
			            	<div class="col-sm-8">
			            		<c:forEach items="${blog.images}" var="images" varStatus="status3">
				              		<span class=images><a href="/images/upload/blog/${images.serverImgName}" rel="lightbox">
		                    		<img src="/images/upload/blog/${images.serverImgName}" class="img-responsive"></a></span>
			            		</c:forEach>
			            	</div>
			            	<label class="col-sm-2 control-label" for="textinput">
				              		
				            </label>
			          	</div>
						
			          	<div class="form-group">
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-camera" aria-hidden="true"></i></label>
			            	<div class="col-sm-8">
			              		<input type="file" name="files" id="fileName" multiple/>
			            	</div>
			            	<label class="col-sm-2 control-label" for="textinput">
				              		<input type="submit" id="btn" value="확인">
				            </label>
			          	</div>
			          	<hr/>
	      			
			          	<c:forEach items="${blog.assets}" var="assets" varStatus="status">
		               		<div class="form-group" id="${assets.assetNo}">
			         	 		<label class="col-md-2 col-sm-2 col-xs-2 control-label" for="textinput"><i class="fa fa-usd" aria-hidden="true"></i></i></label>
				              	<div class="col-md-3 col-sm-3 col-xs-3">
				              		<input type="text" class="form-control" name="category" value="${assets.assetCategory}" readonly/>
				              	</div>
				         	  	<div class="col-md-3 col-sm-3 col-xs-3">
				              		<input type="text" class="form-control" name="usage" value="${assets.usage}" readonly/>
				              	</div>
				       	      	<div class="col-md-3 col-sm-3 col-xs-3">
				              		<input type="text" class="form-control" name="charge" value="${assets.charge}" readonly/>
				              	</div>
				            	<label class="col-md-1 col-sm-1 col-xs-1 control-label" for="textinput">
				              		<i class="fa fa-times" aria-hidden="true" id="deleteAsset"></i>
				              		<input type="hidden" value="${assets.assetNo}">
				            	</label>
			         		</div>
		                </c:forEach>
			          	
			          	<div class="form-group" id="asset">
			         	 	<label class="col-md-2 col-sm-2 col-xs-2 control-label" for="textinput"><i class="fa fa-usd" aria-hidden="true"></i></i></label>
			              	<div class="col-md-3 col-sm-3 col-xs-3">
			                  	<select class="form-control" name="assetCategory" id="assetCategory" >
									<option value="식비" selected="selected">식비</option>
									<option value="교통비">교통비</option>
									<option value="숙박비">숙박비</option>
									<option value="쇼핑">쇼핑</option>
									<option value="입장료">입장료</option>
									<option value="기타">기타</option>
							 	</select>
			              	</div>
			         	  	<div class="col-md-3 col-sm-3 col-xs-3">
			              		<input type="text" class="form-control" placeholder="사용처" id="usage" />
			              	</div>
			       	      	<div class="col-md-3 col-sm-3 col-xs-3">
			              		<input type="text" class="form-control" placeholder="사용금액" id="charge" />
			              	</div>
			            	<label class="col-md-1 col-sm-1 col-xs-1 control-label" for="textinput">
			              		<i class="fa fa-check" aria-hidden="true" id="assetPlus"></i>
			            	</label>
			         	</div>
			         	
		                <hr/>
			         	
			         	<div class="form-group">
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-hashtag" aria-hidden="true"></i></label>
			            	<div class="col-sm-8">
			            		<c:forEach items="${blog.hashTags}" var="hashTags" varStatus="status2">
			                		<span id="tagSpan">#${hashTags.hashTag}</span>
			                		<i class="fa fa-times" aria-hidden="true" id="deleteTag"></i>
			                		<input type="hidden" value="${hashTags.tagNo}">
			                		<input type="hidden" value="${status2.index}" id="tagCount">
			                	</c:forEach>
		                	</div>
		                </div>
			
			          	<div class="form-group">
			            	<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-hashtag" aria-hidden="true"></i></label>
			            	<div class="col-sm-2">
			              		<input type="text" name="hashTag" id="hashTag" class="form-control" style="width: 70px;" maxlength="10" id="hashTag" value="" >
			            	</div>   
			            	<div class="col-sm-8">
			            		<label class="col-sm-2 control-label" for="textinput"><i class="fa fa-check" aria-hidden="true" id="tagPlus"></i></label>
			            	</div>
						</div>
						
					    <br/>
		                <hr/>
			         	<div class="col-sm-offset-2 col-sm-10">
			         		<div class="pull-right">
			            		<input type="button" class="btn btn-default" id="confirm" value="확인">
			                	<input type="button" class="btn btn-default" id="cancel" value="취소">
			            	</div>
			         	</div>
	        		</fieldset>
	        	</form>
	    	</div>
		</div>
	</body>
</html>