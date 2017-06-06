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
    
    <script type="text/javascript">
    
	//수정 연결
	 $(function() {
		$( ".btn.btn-info.btn" ).on("click" , function() {
			fncUpdateUser();
		});
	});	
	//취소 연결
	$(function() {
		$("a[href='#' ]").on("click" , function() {
			$("form")[0].reset();
		});
	});	
	
	function fncUpdateUser() {
		
		var passwd = $("#password").val();
		var passwd2 = $("#password2").val();
		
		if( passwd == null || passwd.length < 1 ) {
			alert("비밀번호를 반드시 입력해주세요.");
			return;
		}
		if( passwd2 == null || passwd2.length < 1 ) {
			alert("비밀번호확인을 반드시 입력해주세요.");
			return;
		}
		
		$("form").attr("method" , "POST").attr("action" , "/user/updateUser").submit();
	}
    
	//닉네임 중복체크
	$(function(){
		$("#nickName").on("keyup", function(){
			
			var nickName = $("#nickName").val();
				
			 $.ajax(
					 {
		    			 url : '/user/checkNickName/'+nickName,
		    			 method : "GET",
		    			 dataType : "json",
		    			 headers : {
		    				 "Accept" : "application/json",
		    				 "Content-Type" : "application/json"
	    				 },
		    			 context : this,
		    			 success : function(JSONData, status) {		    				 
		    				   				 
		    				 if(! JSONData.result) {
		    					 $("#checkNick").html("존재하는 닉네임입니다.").css('color', 'red');
		    				 } else {
		    					 $("#checkNick").html("사용가능한 닉네임입니다.").css('color', 'blue');
		    				 }	
	    			 	}
	    		 });			
			});		
		});
	
		//비밀번호/ 비밀번호확인 입력 동일한지 체크
		$(function(){		
			$("#password").keyup( function(){
				$("#checkpw").text('');
			});
			
			$("#password2").keyup( function() {
				if( $("#password").val() != $("#password2").val() ) {
					$("#checkpw").text('');
					$("#checkpw").html("비밀번호가 일치하지 않습니다.").css('color', 'red');
				} else {
					$("#checkpw").text('');
					$("#checkpw").html("비밀번호가 일치합니다.").css('color', 'blue');
				}
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
	<h2 align="center">회원정보수정</h2><br>
		<form class="form-horizontal" enctype="multipart/form-data">
		<form class="form-horizontal">

		<!-- Text input-->
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="userId">I D</label>  
		  <div class="col-md-4">
		  	<input type="text" id="userId" name="userId"  value="${user.userId}" class="form-control input-md" readonly>
		  	<div style="color:red; font-size:12px;">ID 수정불가</div>
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="nickName">닉네임</label>  
		  <div class="col-md-4">
		  	<input type="text" id="nickName" name="nickName" value="${user.nickName}"class="form-control input-md">
		  	<div id="checkNick" style="color:red; font-size:12px;">닉네임 변경 시 중복체크를 해야합니다.</div>
		  </div>
		</div>
		
		<div class="form-group">
		  <label class="col-md-4 control-label" for="password">비밀번호</label>  
		  <div class="col-md-4">
		  	<input type="password" id="password" name="password" class="form-control input-md">
		  </div>
		</div>
		
		<div class="form-group">
		  <label class="col-md-4 control-label" for="password2">비밀번호확인</label>  
		  <div class="col-md-4">
		  	<input type="password" id="password2" name="password2" class="form-control input-md">
		    <div id="checkpw" style="color:red; font-size:12px;"></div>
		  </div>
		</div>
		
		<!-- /////////////  프로필이미지등록  ////////////////////// -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="profileImage" >프로필이미지</label>	
			<div class="col-md-4">	  			
		   		<input type="file" id="profileImage" name="file">
		   	</div>
		</div>
		
		<!-- Button -->
		<div class="form-group">
			<div class="col-sm-offset-4 col-sm-4 text-center">
				<button type="button" class="btn btn-info btn">수정</button>
				<button type="button" class="btn btn-info" href="#">취소</button>
			</div>	
		</div>

		</form>
</div>

</body>
</html>