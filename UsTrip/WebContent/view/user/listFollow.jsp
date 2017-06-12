<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<!-- Bootstrap Core CSS -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
	
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script type="text/javascript">
	
		 $(function() {
				$( "#listfollow" ).on("click" , function() {
					var targetUserId = $(".followTarget").val();
					alert("targetUserid :: " + targetUserId);
					targetUserId=targetUserId.split(".");
					
					$.ajax(
							{
								url : '/user/addFollow/'+targetUserId,
								method : "GET",
								dataType : "json",
								headers : {
									 "Accept" : "application/json",
									 "Content-Type" : "application/json"
								 },
								 context : this,
								 success : function(JSONData, status) {
									/*  $("#follow").val("following").css('background-color', '#3897f0').css('color', '#fff'); */
									/* location.reload(); */
									/*  $(this).val('following'); */
									alert("wwwwwwwww");
									 
								 }
							}		
						)
					});
				});	
				
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
<div class="container">
    <div class="row profile">
		<jsp:include page="/view/user/getProfile.jsp"/>
		
			<div class="col-md-9">
	          	<div class="profile-content">
					<div class="row">
						<div>
							<div class="profile-sidebar">
								<c:set var="i" value="0" />
			 					 	<c:forEach var="follow" items="${list}">
										<c:set var="i" value="${ i+1 }" />
											<div class="profile-pic" style="width:180px; float: left; height:250px;">
												<img src="/images/upload/profile/${follow.profileImage}" class="img-responsive" alt="">
												<span>${follow.nickName }	<%-- //	${follow.targetUserId } --%></span><br>
													<input type="button" class="btn btn-info btn-sm" id="listfollowing" value="following">
											</div>
									</c:forEach>
								</div>
							</div>         	
						</div>
					</div>
				</div>
	</div>
</div>
</body>
</html>
