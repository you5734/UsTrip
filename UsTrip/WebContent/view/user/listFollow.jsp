<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	
	<!-- Bootstrap Core CSS -->
    <!-- <link href="../../css/bootstrap.min.css" rel="stylesheet"> -->
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
     
	<script src="/js/jquery.min.js"></script>
	<script src="/js/jquery.scrolly.min.js"></script>
	<script src="/js/skel.min.js"></script>
	<script src="/js/util.js"></script>
	<script src="/js/main.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script type="text/javascript">
	
		 $(function() {
			 listFollow();
			 
				/* $( ".btn.btn-info" ).on("click" , function() {
					var targetUserId = $(this).next().val();
					alert("targetUserid :: " + targetUserId);
					
					targetUserId=targetUserId.split(".");
					
					$.ajax(
							{
								url : '/user/deleteFollow/'+targetUserId,
								dataType : "json",
								headers : {
									 "Accept" : "application/json",
									 "Content-Type" : "application/json"
								 },
								 context : this,
								 success : function(JSONData, status) {
									/*  $("#follow").val("following").css('background-color', '#3897f0').css('color', '#fff'); 
									/* location.reload(); 
									 a();
								 }
							}		
						)
					}); */
				});	
		 var listFollow = function() {
			 $('.result-profile-sidebar').html('');
			 $.ajax(
						{
							url : '/user/listFollow.json',
							method : "GET",
							dataType : "json",
							headers : {
								 "Accept" : "application/json",
								 "Content-Type" : "application/json"
							 },
							 context : this,
							 success : function(JSONData, status) {
								 for (var i = 0; i < JSONData.follow.list.length; i++) {
									 var result = JSONData.follow.list[i];
									 
									 var $div = $('<div></div>').addClass('profile-pic').css({'width' : '180px', 'float' : 'left'}),
									 	$img = $('<img></img>').addClass('img-responsive'),
									 	$span = $('<span></span>'),
									 	$button = $('<button></button>').addClass('btn btn-info btn-sm').text('Following');		
									 $button.attr('data-followTarget', result.targetUserId);
									 
									 $img.attr('src', '/images/upload/profile/' + result.profileImage);
									 $span.html(result.nickName);
									 
									 $div.append($img).append($span).append($button);
									 $('.result-profile-sidebar').append($div);
									 
								/*  $("#follow").val("following").css('background-color', '#3897f0').css('color', '#fff'); */
								/* location.reload(); */
							 	}
									 $('.btn.btn-info').click(function () {
										 console.log($(this));
										var data = $(this).data();
										deleteFollow(data);
									 });
							 }
					});
		 }
		 
		 var deleteFollow = function(data) {
			 console.log(data);
			 var param = data.followtarget.split(".");
			 
			 $.ajax(
						{
							url : '/user/deleteFollow/'+param,
							dataType : "json",
							headers : {
								 "Accept" : "application/json",
								 "Content-Type" : "application/json"
							 },
							 context : this,
							 success : function(JSONData, status) {
								  /* $("#follow").val("following").css('background-color', '#3897f0').css('color', '#fff');  */
								 listFollow();
							 }
						}		
					)
				}; 
				
	</script>
	
	<style>
		.row {
			margin-top:20px;
			margin-left:20px;
		}
		.profile-sidebar {
		  /* padding: 20px 0 10px 0; */
		  background: #fff;
		}
		.profile-pic img {
		  float: none;
		  margin: 0 auto;
		  width:110px;
		  height:120px;
		  -webkit-border-radius: 50% !important;
		  -moz-border-radius: 50% !important;
		  border-radius: 50% !important;
		}
		.profile-content{
			text-align:center;
		}
	</style>
</head>
<body>
<jsp:include page="/common/toolbar.jsp"/>
<div class="container">
    <div class="row profile">
		<jsp:include page="/view/user/getProfile.jsp"/>
		
			<div class="col-md-9">
	          	<div class="profile-content">
					<div class="row">
						<div>
							<div class="result-profile-sidebar">
								
							</div>
						</div>         	
					</div>
				</div>
			</div>
	</div>
</div>
</body>
</html>
