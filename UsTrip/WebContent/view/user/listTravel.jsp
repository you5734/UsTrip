<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<!-- Bootstrap Core CSS -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
	
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<script src="https://use.fontawesome.com/04438b50a5.js"></script>
	
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
</head>
<body>

<div class="container">
    <div class="row profile">
		<div class="col-md-3">
			<div class="profile-sidebar">
				<!-- SIDEBAR USERPIC -->
				<div class="profile-userpic">
					<img src="/images/upload/profile/${user.profileImage}" class="img-responsive" alt="">
				</div>
				<!-- END SIDEBAR USERPIC -->
				<!-- SIDEBAR USER TITLE -->
				<div class="profile-usertitle">
					<div class="profile-usertitle-name" id=nickName>
						${user.nickName}
					</div>
					<div class="profile-usertitle-job" id="userId">
						${user.userId}
					</div>
				</div>
				<!-- END SIDEBAR USER TITLE -->
				<!-- SIDEBAR BUTTONS -->
				<div class="profile-userbuttons">
					<button type="button" class="btn btn-success btn-sm">Follow</button>
					<button type="button" class="btn btn-danger btn-sm">Message</button>
				</div>
				<!-- END SIDEBAR BUTTONS -->
				<!-- SIDEBAR MENU -->
				<div class="profile-usermenu">
					<ul class="nav">
						<li class="active">
							<a href="#">
							<i class="fa fa-plane" aria-hidden="true"></i>
							등록한 여행 </a>
						</li>
						<li>
							<a href="#">
							<i class="fa fa-heart" aria-hidden="true"></i>
							좋아요한 여행</a>
						</li>
						<li>
							<a href="#" target="_blank">
							<i class="fa fa-user-circle" aria-hidden="true"></i>
							팔로우 </a>
						</li>
						<li>
							<a href="#">
							<i class="fa fa-user-circle-o" aria-hidden="true"></i>
							팔로잉 </a>
						</li>
					</ul>
				</div>
				<!-- END MENU -->
			</div>
		</div>
		<div class="col-md-9">
            <div class="profile-content">
			   Some user related content goes here...
            </div>
		</div>
	</div>
</div>
<center>
<strong>Powered by <a href="http://j.mp/metronictheme" target="_blank">KeenThemes</a></strong>
</center>
<br>
<br>

</body>
</html>