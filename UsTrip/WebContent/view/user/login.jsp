<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
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
    
    <!-- ///////////////////////īī�� �� ���۷α��� ����/////////////////////////////// -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css">
	<script src="https://apis.google.com/js/api:client.js"></script>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	
	<!-- ///////////////////////// Modal popup  �� �޷�UI /////////////////////////////// -->
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
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
	        		  /* Ÿ���� �α��� �� ó���湮�� ������� Ȯ�� */
	        		  
					$.ajax(
						 {
			    			 url : '/user/checkUserId/'+tempId,
			    			 method : "GET",
			    			 dataType : "json",
			    			 headers : {
			    				 "Accept" : "application/json",
			    				 "Content-Type" : "application/json"
		    				 },
			    			 context : this,
			    			 success : function(JSONData, status) {		    				 
			    				   				 
			    				 if( JSONData.result ) {
			    					 self.location="/view/user/login.jsp?kakao=0&tempId="+tempId;	
			    				 } else {
			    					 self.location="/user/getUser?userId="+userId;						 
			    				 }	
		    			 	}
		    		 });	
	        	  }	//success:(res) close	        	  
	          });
	        },
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	      });
	    };
//	client_id: '874013762845-1vbc3sib3cn2fapfgg734rjjj4suktt1.apps.googleusercontent.com',
	    //google
		$( function() {
		    $(".buttonText").on("click" , function() {
				gapi.load('auth2', function() {
					auth2 = gapi.auth2.init({
					client_id: '874013762845-1vbc3sib3cn2fapfgg734rjjj4suktt1.apps.googleusercontent.com',
					cookiepolicy: 'single_host_origin',
					fetch_basic_profile: false,
					scope: 'profile'
		  		});
		
				// Sign the user in, and then retrieve their ID.
				auth2.signIn().then(function() {
				    console.log(auth2.currentUser.get().getId());
				    console.log(auth2.googleUser.get().getBasicProfile());
				    
				    var profile = auth2.currentUser.get().getBasicProfile();
				    console.log('Email: ' + profile.getEmail());
				    
				    var userId = profile.getEmail();
	        		var tempId = userId.split(".");
	        		
					$.ajax(
						 {
			    			 url : '/user/checkUserId/'+tempId,
			    			 method : "GET",
			    			 dataType : "json",
			    			 headers : {
			    				 "Accept" : "application/json",
			    				 "Content-Type" : "application/json"
		    				 },
			    			 context : this,
			    			 success : function(JSONData, status) {		    				 
			    				   				 
			    				 if( JSONData.result ) {	//ó���湮���ϰ��
									self.location="/view/user/login.jsp?google=1&tempId="+tempId;
			    				 } else {	//�̹� ��ϵ� ȸ���ϰ��
			    					 self.location="/user/getUser?userId="+userId;					 
			    				 }	
		    			 	}
		    		 });	
				  });
				});
			});
		});
	    
		//�α��� Eventó��
		$( function() {
			
			$("#userId").focus();
			
			$("#signin").on("click" , function() {
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
		
		// ȸ��������ȭ���̵�
		$( function() {
			$("#joinus").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
	</script>		
	
	<style>
 		.form-group{
			margin-bottom:15px;
		} 

		#dialog-form { display:none; }
    	input.text { width:60%; padding: .4em; }
		.validateTips { border: solid transparent; padding: 0.3em; color:red; }
		
		#customBtn {
			display: inline-block;
			background: white;
			color: #444;
			width: 180px;
			border-radius: 5px;
			border: thin solid #888;
			box-shadow: 1px 1px 1px grey;
			white-space: nowrap;
		}
		#customBtn:hover {
			cursor: pointer;
		}
		span.label {
			font-family: serif;
			font-weight: normal;
		}
		span.icon {
			background: url('/identity/sign-in/g-normal.png') transparent 5px 50% no-repeat;
			display: inline-block;
			vertical-align: middle;
			width: 42px;
			height: 42px;
		}
		span.buttonText {
			display: inline-block;
			vertical-align: middle;
			padding-left: 42px;
			padding-right: 42px;
			font-size: 14px;
			font-weight: bold;
			/* Use the Roboto font that is loaded in the <head> */
			font-family: 'Roboto', sans-serif;
		}
	</style>
</head>
<body>
	<jsp:include page="/common/toolbar.jsp"/>
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
                   
                    <div class="row" >
                   	 	<div class="col-sm-4"></div>
                        <div class="col-sm-4">
                        	
                        	<div class="form-box">
	                        	<div class="form-top">
	                        		<div class="form-top-left">
	                        			<i class="fa fa-lock"></i>
	                        			<h4>Login to our site</h4>
	                            		<p>Enter userid and password to log on:</p>
	                        		</div>
	                            
	                            <div class="form-bottom">
				                    <form role="form" action="" method="post" class="login-form">
				                    	<div class="form-group">
				                    		<label class="sr-only" for="form-username">UserId</label>
				                        	<input type="text" name="userId" placeholder="UserId..." class="form-username form-control" id="userId">
				                        </div>
				                        
				                        <div class="form-group">
				                        	<label class="sr-only" for="form-password">Password</label>
				                        	<input type="password" name="password" placeholder="Password..." class="form-password form-control" id="password">
				                        </div>
				                        
				                        <div class="form-group">
					                        <button type="submit" class="button" id="signin">Sign in!</button>
					                        <button type="button" class="button" id="joinus">Join us!</button>
				                        </div>
				                        
				                        <!-- ////////////////  īī�� �α��� ��ư ////////////////// -->
				                        <div class="form-group">
					  		 				<div class="col-sm-offset text-center">					      
					      						<a id="kakao-login-btn" href="javascript:loginWithKakao()">
					      						<img src="/images/layout/kakao_account_login_btn_medium_narrow_ov.png" width="180"/>
												</a>
					   						 </div>
					 					 </div>
					 					 
					 					 <!-- ////////////////  google �α��� ��ư ////////////////// -->
										<div id="gSignInWrapper">
											<div id="customBtn" class="customGPlusSignIn" style="width:180px;" >
												<span class="icon"></span>
													<span class="buttonText" >Google</span>
											</div>
										</div>
										<div id="name"></div>
					 				</form>
			                    </div>
					 					<!--  ////////////////////// Modal Popup /////////////////////// -->
					 					 <div id="dialog-form" title="�߰����� �Է�">
											  <p class="validateTips">��������� �Է����ּ���</p>											 
											  <form id="extraUserInfo" action="/user/extraUserInfo" method="POST">
									    													    		
										    		<div class="form-group">
										    			<label class="col-md-5 control-label" for="nickName" >�г���</label>
										    			<div class="col-sm-7">
										    				<input type="text" name="nickName" id="nickName" >
										    				<div id="checkNick" style="color:red; font-size:12px;">�г����� �Է����ּ���.</div>
										    			</div>
										    		</div><br>
										    		
										    		<div class="form-group">
										    			<label class="col-md-5 control-label" for="password" >��й�ȣ</label>
										    			<div class="col-sm-7">
										    				<input type="password" name="password" id="pw" >
										    			</div>
										    		</div>
<!-- 										    		
										    		<div class="form-group">
										    			<label class="col-md-5 control-label" for="password2" >��й�ȣȮ��</label>
										    			<div class="col-sm-5">
										    				<input type="password" name="password2" id="pw2" >
										    				<div id="checkpw" style="color:red; font-size:12px;"></div>
										    			</div>
										    		</div><br>		
										    		
									    			<div class="form-group">
										    			<label class="col-md-5 control-label" for="gender" >����</label>
										    			<div class="col-sm-7">
										    				��<input type="radio" name="gender" id="gender" value="m" >
												      		��<input type="radio" name="gender" id="gender" value="f" >
										    			</div>
										    		</div>	<br>										    											    		
										    		
										    		<div class="form-group">
										    			<label class="col-md-4 control-label" for="birthDate" >�������</label>
										    			<div class="col-sm-8">
										    				<input type="text" name="birthDate" id="birthDate"  >
										    			</div>
										    		</div><hr>												  

													      <div class="form-group">
													      <div class="">
														      <button type="submit" class="btn btn-info btn" id="add">���</button>
														 	  <button type="button" class="btn btn-info" href="#">���</button>
													 	  </div>
												 	  </div>  -->
													 	  
												 	 <input type="hidden" value="${param.tempId }" id="tempId" name="userId">
							     					 <input type="hidden" value="${param.kakao}" id="kakao">
							     					 <input type="hidden" value="${param.google}" id="google">
												      <!-- Allow form submission with keyboard without duplicating the dialog button -->
												      <!-- <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">  -->
												  </form>
											</div>
			                        <!--  ////////////////////// Modal Popup /////////////////////// -->
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
        
    </body>
</html>

<script type="text/javascript">
	
	var dialog, form;
	
	if($('#kakao').val() =="0" || $('#google').val() == '1' ) {
		var userId = $("#tempId").val();
		/* console.log("userId :: ��������" + userId); */
		dialog = $('#dialog-form').dialog({			
			height: 550,
			width: 550,
			modal: true
		});		
	}
	
	//���� ����
	 $(function() {
		$( "#add" ).on("click" , function() {
			alert("�Ǵ�?>>");
			 document.forms["extraUserInfo"].submit(); 
		});
	});	
	
	//��� ����
	$(function() {
		$("button[href='#' ]").on("click" , function() {
			$("form")[1].reset();
		});
	});	

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
		    					 $("#checkNick").html("��밡���� �г����Դϴ�.").css('color','blue');
		    				 } else {
		    					 $("#checkNick").html("�����ϴ� �г����Դϴ�.").css('color','red');		    					 
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
				$("#checkpw").html("��й�ȣ�� ��ġ���� �ʽ��ϴ�.").css('color','red');
			} else {
				$("#checkpw").text('');
				$("#checkpw").html("��й�ȣ�� ��ġ�մϴ�.").css('color','blue');
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