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
    
	//���� ����
	 $(function() {
		$( ".btn.btn-info.btn" ).on("click" , function() {
			fncUpdateUser();
		});
	});	
	//��� ����
	$(function() {
		$("a[href='#' ]").on("click" , function() {
			$("form")[0].reset();
		});
	});	
	
	function fncUpdateUser() {
		
		var passwd = $("#password").val();
		var passwd2 = $("#password2").val();
		
		if( passwd == null || passwd.length < 1 ) {
			alert("��й�ȣ�� �ݵ�� �Է����ּ���.");
			return;
		}
		if( passwd2 == null || passwd2.length < 1 ) {
			alert("��й�ȣȮ���� �ݵ�� �Է����ּ���.");
			return;
		}
		
		$("form").attr("method" , "POST").attr("action" , "/user/updateUser").submit();
	}
    
	//�г��� �ߺ�üũ
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
		    					 $("#checkNick").html("�����ϴ� �г����Դϴ�.").css('color', 'red');
		    				 } else {
		    					 $("#checkNick").html("��밡���� �г����Դϴ�.").css('color', 'blue');
		    				 }	
	    			 	}
	    		 });			
			});		
		});
	
		//��й�ȣ/ ��й�ȣȮ�� �Է� �������� üũ
		$(function(){		
			$("#password").keyup( function(){
				$("#checkpw").text('');
			});
			
			$("#password2").keyup( function() {
				if( $("#password").val() != $("#password2").val() ) {
					$("#checkpw").text('');
					$("#checkpw").html("��й�ȣ�� ��ġ���� �ʽ��ϴ�.").css('color', 'red');
				} else {
					$("#checkpw").text('');
					$("#checkpw").html("��й�ȣ�� ��ġ�մϴ�.").css('color', 'blue');
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
	<h2 align="center">ȸ����������</h2><br>
		<form class="form-horizontal" enctype="multipart/form-data">
		<form class="form-horizontal">

		<!-- Text input-->
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="userId">I D</label>  
		  <div class="col-md-4">
		  	<input type="text" id="userId" name="userId"  value="${user.userId}" class="form-control input-md" readonly>
		  	<div style="color:red; font-size:12px;">ID �����Ұ�</div>
		  </div>
		</div>
		
		<!-- Text input-->
		<div class="form-group">
		  <label class="col-md-4 control-label" for="nickName">�г���</label>  
		  <div class="col-md-4">
		  	<input type="text" id="nickName" name="nickName" value="${user.nickName}"class="form-control input-md">
		  	<div id="checkNick" style="color:red; font-size:12px;">�г��� ���� �� �ߺ�üũ�� �ؾ��մϴ�.</div>
		  </div>
		</div>
		
		<div class="form-group">
		  <label class="col-md-4 control-label" for="password">��й�ȣ</label>  
		  <div class="col-md-4">
		  	<input type="password" id="password" name="password" class="form-control input-md">
		  </div>
		</div>
		
		<div class="form-group">
		  <label class="col-md-4 control-label" for="password2">��й�ȣȮ��</label>  
		  <div class="col-md-4">
		  	<input type="password" id="password2" name="password2" class="form-control input-md">
		    <div id="checkpw" style="color:red; font-size:12px;"></div>
		  </div>
		</div>
		
		<!-- /////////////  �������̹������  ////////////////////// -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="profileImage" >�������̹���</label>	
			<div class="col-md-4">	  			
		   		<input type="file" id="profileImage" name="file">
		   	</div>
		</div>
		
		<!-- Button -->
		<div class="form-group">
			<div class="col-sm-offset-4 col-sm-4 text-center">
				<button type="button" class="btn btn-info btn">����</button>
				<button type="button" class="btn btn-info" href="#">���</button>
			</div>	
		</div>

		</form>
</div>

</body>
</html>