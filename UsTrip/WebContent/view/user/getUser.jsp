<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
		
		//회원정보수정 Event 처리
		 $(function() {
			 $( ".btn.btn-info" ).on("click" , function() {
					self.location = "/user/updateUser?userId=${user.userId}"
			  });
		 });
		 $(function() {
			 $( ".btn.btn-info.btn" ).on("click" , function() {
					self.location = "/message/sendMsg"
			  });
		 });
	</script>
	
    <style>
    	.container{
    		margin-top: 50px;
    	}
    </style>
       
</head>
<body>

<div class="container">
	<h3 align="center">회원정보조회</h3><br>
		<form class="form-horizontal">
			<div class="col-md-3 col-lg-3 " align="center"> 
				<img alt="User Pic" src="/images/upload/profile/${user.profileImage}" width="60" height="60" class="img-circle img-responsive">
			</div>
                
			<!-- Text input-->
			<div class="form-group">
			  <label class="col-xs-4 col-md-2" for="userId">I D</label>  
			  <div class="col-md-4">${user.userId}</div>
			</div>

			<div class="col-md-3 col-lg-3 " align="center"></div>
			<!-- Text input-->
			<div class="form-group">
			  <label class="col-xs-4 col-md-2" for="nickName">닉네임</label>  
			  <div class="col-md-4">${user.nickName}</div>
			</div>
			
			<div class="col-md-3 col-lg-3 " align="center"></div>
			<!-- Text input-->
			<div class="form-group">
			  <label class="col-xs-4 col-md-2" for="gender">성별</label>  
			  <div class="col-md-4"> ${user.gender }
			  	<%-- ${user.gender == 'm' ? 'male' : 'female' } --%>
		  	
			  </div>
			</div>
			
			<div class="col-md-3 col-lg-3 " align="center"></div>
			<!-- Text input-->
			<div class="form-group">
			  <label class="col-xs-4 col-md-2" for="birthDate">생년월일</label>  
			  <div class="col-md-4">${user.birthDate}</div>
			</div><br>
			
			<!-- Button -->
			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-4 text-center">
					<button type="button" class="btn btn-info">회원정보수정</button>
					<button type="button" class="btn btn-info btn">쪽지보내기</button>
				</div>	
			</div>
		</form>
</div>


</body>
</html>