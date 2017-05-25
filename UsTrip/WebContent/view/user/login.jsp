<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- Bootstrap Core CSS -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    
    <!-- ///////////////////////īī����α��ι�ư �߰�/////////////////////////////// -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<!-- ////////////////////////////////////////////////////////////////////////// -->
	
	<!-- ///////////////////////// Modal popup  �� �޷�UI /////////////////////////////// -->
	<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- ///////////////////////// Modal popup /////////////////////////////// -->
		
	<script type="text/javascript">
	
	// īī���� �α��ι�ư ó��
	 Kakao.init('84c5f6e23594b89cadfb9500086ba376');
	 function loginWithKakao() {
	      // �α��� â�� ���ϴ�.
	      Kakao.Auth.login({
	        success: function(authObj) {
	          var accessToken = Kakao.Auth.getAccessToken();
	          Kakao.Auth.setAccessToken(accessToken);
	          
	          Kakao.API.request({
	        	  url: '/v1/user/me',
	        	  success: function(res) {
	        		  var userId = res.kaccount_email;
	        		  var tempId = userId.split(".");
	        		  console.log("userId :: " + userId);
	        		  console.log("tempId :: " + tempId);
	        		  self.location="/view/user/login.jsp?kakao=0";	
	        		
	        	  }	//success:(res) close	        	  
	          });
	        },
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	      });
	    };
		
		//�α��� Eventó��
		$( function() {
			
			$("#userId").focus();
			
			$("#login").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID�� �Է����� �����̽��ϴ�.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('�н����带 �Է����� �����̽��ϴ�.');
					$("#password").focus();
					return;
				}
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});							
		});			
		
		//============= ȸ��������ȭ���̵� =============
		$( function() {
			$("#join").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
	</script>		
	
	<style>
		#dialog-form { display:none; }
    	input.text { width:60%; padding: .4em; }
		fieldset { padding:0; border:0; margin-top:5px; }
		.validateTips { border: solid transparent; padding: 0.3em; color:blue; }
	</style>
	
</head>
<body class="bodycss">
<form>
        <div class="top-content" align="center">
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                            <div class="description">
                            	<p>
                            	</p>
                            </div>
                        </div>
                    </div>
                   
                    <div class="row">
                   	 	<div class="col-sm-4"></div>
                        <div class="col-sm-4">
                        	
                        	<div class="form-box">
	                        	<div class="form-top">
	                        		<div class="form-top-left">
	                        			<h4>Login to our site</h4>
	                            		<p>Enter userid and password to log on:</p>
	                        		</div>
	                        		
	                        		<div class="form-top-right">
	                        			<i class="fa fa-lock"></i>
	                        		</div>
	                            </div>
	                            
	                            <div class="form-bottom">
				                    <form role="form" action="" method="post" class="login-form">
				                    	<div class="form-group">
				                    		<label class="sr-only" for="form-username">Username</label>
				                        	<input type="text" name="userId" placeholder="UserId..." class="form-username form-control" id="userId">
				                        </div>
				                        
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-password">Password</label>
				                        	<input type="password" name="password" placeholder="Password..." class="form-password form-control" id="password">
				                        </div>
				                        
				                        <div class="form-group">
					                        <button type="submit" class="btn" id="login">Sign in!</button>
					                        <button type="button" class="btn" id="join">Join us!</button>
				                        </div>
				                        
				                        <div class="form-group">
					  		 				<div class="col-sm-offset text-center">					      
					      						<a id="kakao-login-btn" href="javascript:loginWithKakao()">
					      						<img src="/images/layout/kakao_account_login_btn_medium_narrow_ov.png" width="180"/>
												</a>
					   						 </div>
					 					 </div>
					 					 
					 					<!--  ////////////////////// Modal Popup /////////////////////// -->
					 					 <div id="dialog-form" title="�߰����� �Է�">
											  <p class="validateTips">��������� �Է����ּ���</p>											 
											  <form class="extraUserInfo" id="extraUserInfo">
											    	<fieldset>
													      <label for="nickName" >�г���</label>
													      <input type="text" name="nickName" id="nickName" class="text ui-widget-content ui-corner-all" >
													     	 <div id="checkNick" style="color:red; font-size:12px;">�г����� �Է����ּ���.</div>
													      
													      <label for="pw">��й�ȣ</label>
													      <input type="password" name="password" id="pw" class="text ui-widget-content ui-corner-all">
													      
													      <label for="pw2">��й�ȣȮ��</label>
														  <input type="password" name="password2" id="pw2" class="text ui-widget-content ui-corner-all">
														      	<div id="checkpw" style="color:red; font-size:12px;"></div>
													      
													      <label for="gender" >����</label>
													      <input type="radio" name="gender" id="gender" value="m" >��
													      <input type="radio" name="gender" id="gender" value="f" >��<br>
													      
													      <label for="birthDate">�������</label>
													      <input type="text" name="birthDate" id="birthDate" class="text ui-widget-content ui-corner-all"><hr>
													      
													      <div class="form-group">
														      <div class=" col-sm-offset text-center">
															      <button type="submit" class="btn btn-info" id="add">���</button>
															 	  <button type="button" class="btn btn-info" href="#">���</button>
														 	  </div>
													 	  </div>
													 	  
													      <!-- Allow form submission with keyboard without duplicating the dialog button -->
													      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
											    	</fieldset>
											  </form>
										</div>
								      <input type="hidden" value="${param.kakao}" id="kakao">
		                        <!--  ////////////////////// Modal Popup /////////////////////// -->
				                        
				                    </form>
			                    </div>
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </body>
</html>

<script type="text/javascript">
	
	if($('#kakao').val() =="0") {
		$('#dialog-form').dialog({		
			height: 400,
			width: 350,
			modal: true,
		});		
	}
	
	//���� ����
/* 	 $(function() {
		$( ".btn.btn-info" ).on("click" , function() {
			/* ajaxAddUser(); 
			/* $(".extraUserInfo").attr("method" , "POST").attr("action" , "/user/extraUserInfo").submit();  
			document.getElementById("extraUserInfo").attr("method" , "POST").attr("action" , "/user/extraUserInfo").submit();
		});
	});	
	 */
	$("#extraUserInfo").submit(function() {
		/* event.preventDefault(); */
		$.ajax({
			type: 'POST',
			url: '/user/extraUserInfo',
			data : $(this).seialize(),
			dataType: 'json',	
			 headers : {
   				 "Accept" : "application/json",
   				 "Content-Type" : "application/json"
			 }
		});		
	});
	
	//��� ����
	$(function() {
		$("a[href='#' ]").on("click" , function() {
			$("form")[0].reset();
		});
	});	
	
	/* //ajaxAddUser POST ���
	function ajaxAddUser() {
		var userId = $("#hiddenId").val();
		var addUserArrary = $("fieldset").find("input").serializeArray();
		
		$.ajax({
			type : 'POST',
			url: '/user/jsonAddUser',
			data: "",
			cache: false,
			async: true			
		}
		/* success: function(JSONData, status) {
			self.location="/user/login";
		} 
		);		
	} */
	
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
		    				   				 
		    				 if( JSONData.result ) {
		    					 $("#checkNick").html("��밡���� �г����Դϴ�.");
		    				 } else {
		    					 $("#checkNick").html("�����ϴ� �г����Դϴ�.");		    					 
		    				 }	
	    			 	}
	    		 });			
			});		
		});
	
	//��й�ȣ/ ��й�ȣȮ�� �Է� �������� üũ
	$(function(){		
		
		$("#pw").keyup( function(){
			$("#checkpw").text('');
		});
		
		$("#pw2").keyup( function() {
			if( $("#pw").val() != $("#pw2").val() ) {
				$("#checkpw").text('');
				$("#checkpw").html("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			} else {
				$("#checkpw").text('');
				$("#checkpw").html("��й�ȣ�� ��ġ�մϴ�.");
			} 
		});
	});
	
	//�޷� UI ///������� �Է¿� �°� �⵵ �� �� ����
	$(function() {
		$( "#birthDate" ).datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: 'c-100:c+10',
			dateFormat: "yy-mm-dd"
		});
	});

</script>