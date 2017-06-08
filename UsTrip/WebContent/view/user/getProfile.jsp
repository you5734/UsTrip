<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<script src="https://use.fontawesome.com/04438b50a5.js"></script>
	
	<script type="text/javascript">
	
	 $(function() {
			$( "#profileFollow" ).on("click" , function() {
				var targetUserId = $("#userId").val();
				alert("targetUserid :: " + targetUserId);
				targetUserId=targetUserId.split(".");
				/* self.location="/user/addFollow?targetUserId="+targetUserId; */
				
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
							 $(this).val('following');
							 
						 }
					}		
				)
			});
		});	
	 
	 $(function() {
		 
			$( "#listFollow" ).on("click" , function() {
				alert("ddddddd");
				self.location="/user/listFollow";
			});
			
			$( "#listFollowing" ).on("click" , function() {
				alert("dd");
				self.location="/user/listFollowing";
			});
			
			$( "#update" ).on("click" , function() {
				var userId = $("#userId").val();
				alert("userIddddddd " + userId)
				self.location="/user/updateUser?userId="+userId;
			});
			
			$( "#getUser" ).on("click" , function() {
				var userId = $("#userId").val();
				alert("userId :: " + userId)
				self.location="/user/getUser?userId="+userId;
			});
			
			$('.test').on('click', function() {
				if ($('.test').hasClass('active')) {
					$('.test').removeClass('active')
				}
				$(this).addClass('active');
				
			})
			
	 });
	 
	</script>
	
	<style>
		body {
		  background: #F1F3FA;
		}
		/* Profile container */
		.profile {
		  margin: 20px 0;
		}
		/* Profile sidebar */
		.profile-sidebar {
		  padding: 20px 0 10px 0;
		  background: #fff;
		}
		.profile-userpic img {
		  float: none;
		  margin: 0 auto;
		  width: 50%;
		  height: 50%;
		  -webkit-border-radius: 50% !important;
		  -moz-border-radius: 50% !important;
		  border-radius: 50% !important;
		}
		.profile-usertitle {
		  text-align: center;
		  margin-top: 20px;
		}
		.profile-usertitle-name {
		  color: #5a7391;
		  font-size: 16px;
		  font-weight: 600;
		  margin-bottom: 7px;
		}
		.profile-usertitle-job {
		  text-transform: uppercase;
		  color: #5b9bd1;
		  font-size: 12px;
		  font-weight: 600;
		  margin-bottom: 15px;
		}
		.profile-userbuttons {
		  text-align: center;
		  margin-top: 10px;
		}
		.profile-userbuttons .btn {
		  text-transform: uppercase;
		  font-size: 11px;
		  font-weight: 600;
		  padding: 6px 15px;
		  margin-right: 5px;
		}
		.profile-userbuttons .btn:last-child {
		  margin-right: 0px;
		}
		.profile-usermenu {
		  margin-top: 30px;
		}
		.profile-usermenu ul li {
		  border-bottom: 1px solid #f0f4f7;
		}
		.profile-usermenu ul li:last-child {
		  border-bottom: none;
		}
		.profile-usermenu ul li a {
		  color: #93a3b5;
		  font-size: 14px;
		  font-weight: 400;
		}
		.profile-usermenu ul li a i {
		  margin-right: 8px;
		  font-size: 14px;
		}
		.profile-usermenu ul li a:hover {
		  background-color: #fafcfd;
		  color: #5b9bd1;
		}
		.profile-usermenu ul li.active {
		  border-bottom: none;
		}
		.profile-usermenu ul li.active a {
		  color: #5b9bd1;
		  background-color: #f6f9fb;
		  border-left: 2px solid #5b9bd1;
		  margin-left: -2px;
		}
		/* Profile Content */
		.profile-content {
		  padding: 20px;
		  background: #fff;
		  min-height: 460px;
		}	
		.container{
			margin-top:100px;
		}
	
	</style>

		<div class="col-md-3">
			<div class="profile-sidebar">
				<!-- SIDEBAR USERPIC -->
				<div class="profile-userpic">
					<img src="/images/upload/profile/${user.profileImage}" class="img-responsive" alt="">
				</div>
				<!-- END SIDEBAR USERPIC -->
				<!-- SIDEBAR USER TITLE -->
				<div class="profile-usertitle">
					<div class="profile-usertitle-name">
						${user.nickName}
					</div>
					<div class="profile-usertitle-job">
					<input type="hidden" id="userId" value="${user.userId}">
						${user.userId}
					</div>
				</div>
				<!-- END SIDEBAR USER TITLE -->
				<!-- SIDEBAR BUTTONS -->                                                                                                                                                                                                                                                                                                                    
				<div class="profile-userbuttons">
				 	<c:if test="${sessionScope.user.userId != user.userId }"> 
						 <c:choose >
							 <c:when test="${ empty follow.targetUserId }">
								<input type="button" class="btn btn-sm" id="profileFollow" value="follow">
							</c:when>
							<c:otherwise >
								<input type="button" class="btn btn-sm" id="profileFollowing" value="following">
							</c:otherwise>
						</c:choose>
					</c:if>
				</div>
				<div class="profile-userbuttons">
					<c:if test="${sessionScope.user.userId == user.userId }"> 
						<button type="button" class="btn btn-sm" id="update">ȸ����������</button>
						<button type="button" class="btn btn-sm" id="getUser">ȸ��������ȸ</button>
						</c:if>
				</div>
				<!-- END SIDEBAR BUTTONS -->
				<!-- SIDEBAR MENU -->
				<div class="profile-usermenu">
					<ul class="nav">
						<li class="active test" >
							<a href="#">
							<i class="fa fa-plane" aria-hidden="true"></i>
							����� ���� </a>
						</li>
						<li  class="test">
							<a href="#">
							<i class="fa fa-heart" aria-hidden="true"></i>
							���ƿ��� ����</a>
						</li >
						<li id="listFollow" class="test">
							<a href="#">
							<i class="fa fa-user-circle" aria-hidden="true" ></i>
							�ȷο� </a>
						</li>
						<li id="listFollowing" class="test">
							<a href="#">
							<i class="fa fa-user-circle-o" aria-hidden="true"></i>
							�ȷ��� </a>
						</li>
					</ul>
				</div>
				<!-- END MENU -->
			</div>
		</div>
		