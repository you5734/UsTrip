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
		
		//ȸ���������� Event ó��
		 $(function() {
			 $( ".btn.btn-info" ).on("click" , function() {
					self.location = "/user/updateUser?userId=${user.userId}"
			  });
		 });
		 $(function() {
			 $( ".btn.btn-info.btn" ).on("click" , function() {
				 $(self.location).attr("href","/message/sendMsg");
					/* self.location = "/message/sendMsg" */
			  });
		 });
		 
		 $(function() {
			 $( "#list" ).on("click" , function() {
				 alert("ddd");
				 self.location = "/message/listSendMsg" 
			  });
		 });
		 
		 $(function() {
			 $( "#listUser" ).on("click" , function() {
				 $("form").attr("method" , "POST").attr("action" , "/user/getUserList").submit();
			  });
		 });
	</script>
	
    <style>
    	.container{
    		margin-top: 50px;
    	}
    	.col-sm-8.col-md-8{
    		height:40px;
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
									<form class="form-horizontal">
										  <div class="row">
								<%-- 			<div class="col-sm-4 col-md-4" align="center">
												<img alt="User Pic" src="/images/upload/profile/${user.profileImage}" style="width:120px; height:130px;" class="img-circle img-responsive">
											</div>
								                 --%>
											
											<div class="col-sm-offset-3 col-sm-8 ">
											  <label class="col-xs-4 col-md-2" for="userId">���̵�</label>  
											  <div class="col-md-4">${user.userId}</div>
											</div>
								
											<div class="col-sm-offset-3 col-sm-8 ">
											  <label class="col-xs-4 col-md-2" for="nickName">�г���</label>  
											  <div class="col-md-4">${user.nickName}</div>
											</div>
											
											<div class="col-sm-offset-3 col-sm-8 ">
											  <label class="col-xs-4 col-md-2" for="gender">����</label>  
											  <div class="col-md-4"> <%-- ${user.gender } --%>
											  	 ${user.gender == 'm' ? '����' : '����' }
											  </div>
											</div>
											
											<div class="col-sm-offset-3 col-sm-8 ">
											  <label class="col-xs-4 col-md-2" for="birthDate">�������</label>  
											  <div class="col-md-4">${user.birthDate}</div>
											</div>
											
											<div class="col-sm-offset-2 col-sm-8 " >
												<button type="button" class="btn btn-info">ȸ����������</button>
												<button type="button" class="btn btn-info btn" href="#">����������</button>
												<button type="button" class="btn btn-info" id="list">����������</button>
												<button type="button" class="btn btn-info" id="listUser">���ȸ������</button>
											</div>	
										</div>
									</form>
								</div>
							</div>         	
						</div>
					</div>
				</div>
	</div>
</div>

</body>
</html>