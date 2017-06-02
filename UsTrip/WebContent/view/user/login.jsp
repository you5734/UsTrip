<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- Bootstrap Core CSS -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
    
    <!-- ///////////////////////카카오톡로그인버튼 추가/////////////////////////////// -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css">
	<script src="https://apis.google.com/js/api:client.js"></script>
	<!-- ////////////////////////////////////////////////////////////////////////// -->
	
	<!-- ///////////////////////// Modal popup  및 달력UI /////////////////////////////// -->
	<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- ///////////////////////// Modal popup /////////////////////////////// -->
		
	<script type="text/javascript">
	
	// 카카오톡 로그인버튼 처리
	 Kakao.init('84c5f6e23594b89cadfb9500086ba376');
	 function loginWithKakao() {
	      // 로그인 창을 띄웁니다.
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
	        		  /* 타계정 로그인 시 처음방문한 사람인지 확인 
	        		  * self.location="/user/getUser?tempId="+tempId; */
	        		  
	        		  self.location="/view/user/login.jsp?kakao=0&tempId="+tempId;	
	        		
	        	  }	//success:(res) close	        	  
	          });
	        },
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	      });
	    };

	    //google
	    $( function() {
				var googleUser = {};
			$(".buttonText").on("click" , function() {
				console.log("dddddddd");
				gapi.load('auth2', function(){
				// Retrieve the singleton for the GoogleAuth library and set up the client.
				 auth2 = gapi.auth2.init({
					client_id: '240419245572-40o3ev6lrtro935gb6aqvske3rv8toah.apps.googleusercontent.com',
					cookiepolicy: 'single_host_origin',
					// Request scopes in addition to 'profile' and 'email'
					//scope: 'additional_scope'
				});
				attachSignin(document.getElementById('customBtn'));
				});
			});;
	    });
		
		function attachSignin(element) {
			console.log(element.id); 

			auth2.attachClickHandler(element, {},
				function(googleUser) {
				document.getElementById('name').innerText = "Signed in: " +
				/*  googleUser.getBasicProfile().getName(); */
				googleUser.getBasicProfile().getEmail();
			}, function(error) {
				alert(JSON.stringify(error, undefined, 2));
			});
		}
		
		//로그인 Event처리
		$( function() {
			
			$("#userId").focus();
			
			$("#login").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				if(id == null || id.length <1) {
					alert('ID를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				} else {
					
				}
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});							
		});			
		
		// 회원원가입화면이동
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
		.validateTips { border: solid transparent; padding: 0.3em; color:red; }
		
		#customBtn {
			display: inline-block;
			background: white;
			color: #444;
			width: 190px;
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
<body class="bodycss">
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
				                        
				                        <!-- ////////////////  카카오 로그인 버튼 ////////////////// -->
				                        <div class="form-group">
					  		 				<div class="col-sm-offset text-center">					      
					      						<a id="kakao-login-btn" href="javascript:loginWithKakao()">
					      						<img src="/images/layout/kakao_account_login_btn_medium_narrow_ov.png" width="180"/>
												</a>
					   						 </div>
					 					 </div>
					 					 
					 					 <!-- ////////////////  google 로그인 버튼 ////////////////// -->
										<div id="gSignInWrapper">
											<span class="label"> </span>
												<div id="customBtn" class="customGPlusSignIn">
													<span class="icon"></span>
													<span class="buttonText">Google</span>
												</div>
											</div>
											<div id="name"></div>
										<!-- <script>startApp();</script> -->
					 				</form>
			                    </div>
					 					<!--  ////////////////////// Modal Popup /////////////////////// -->
					 					 <div id="dialog-form" title="추가정보 입력">
											  <p class="validateTips">모든정보를 입력해주세요</p>											 
											  <form id="extraUserInfo" action="/user/extraUserInfo" method="POST">
											    		<div>
											    			<label for="nickName" >닉네임</label>
											    			<div style="flaot:left; width: 250px;">
											    				<input type="text" name="nickName" id="nickName" class="text ui-widget-content ui-corner-all" >
											    				<div id="checkNick" style="color:red; font-size:12px;">닉네임을 입력해주세요.</div>
											    			</div>
											    		</div><br>
											    		
											    		<div>
											    			<label for="password" >비밀번호</label>
											    			<div style="flaot:left; width: 250px;">
											    				<input type="password" name="password" id="pw" class="text ui-widget-content ui-corner-all" >
											    			</div>
											    		</div><br>
											    		
											    		<div>
											    			<label for="password2" >비밀번호확인</label>
											    			<div style="flaot:left; width: 250px;">
											    				<input type="password" name="password2" id="pw2" class="text ui-widget-content ui-corner-all" >
											    				<div id="checkpw" style="color:red; font-size:12px;"></div>
											    			</div>
											    		</div><br>		
											    		
											    		<div>
											    			<label for="gender" >성별</label>
											    			<div style="flaot:left; width: 250px;">
											    				남<input type="radio" name="gender" id="gender" value="m" >
													      		여<input type="radio" name="gender" id="gender" value="f" >
											    			</div>
											    		</div>	<br>										    											    		
											    		
											    		<div>
											    			<label for="birthDate" >생년월일</label>
											    			<div style="flaot:left; width: 250px;">
											    				<input type="text" name="birthDate" id="birthDate" class="text ui-widget-content ui-corner-all" >
											    			</div>
											    		</div><hr>												  

 													      <div class="form-group">
														      <div class=" col-sm-offset text-center">
															      <button type="submit" class="btn btn-info btn" id="add">등록</button>
															 	  <button type="button" class="btn btn-info" href="#">취소</button>
														 	  </div>
													 	  </div> 
													 	  
													 	  <input type="hidden" value="${param.tempId }" id="tempId" name="userId">
								     					 <input type="hidden" value="${param.kakao}" id="kakao">
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
        
    </body>
</html>

<script type="text/javascript">
	
	var dialog, form;
	
	if($('#kakao').val() =="0" ) {
		var userId = $("#tempId").val();
		alert("userId :: 가져오닝" + userId);
		dialog = $('#dialog-form').dialog({			
			height: 400,
			width: 350,
			modal: true
		});		
	}
	
	//가입 연결
	 $(function() {
		$( "#add" ).on("click" , function() {
			alert("되니?>>");
			 document.forms["extraUserInfo"].submit(); 
		});
	});	
	
	//취소 연결
	$(function() {
		$("button[href='#' ]").on("click" , function() {
			$("form")[1].reset();
		});
	});	

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
		    				   				 
		    				 if( JSONData.result ) {
		    					 $("#checkNick").html("사용가능한 닉네임입니다.").css('color','blue');
		    				 } else {
		    					 $("#checkNick").html("존재하는 닉네임입니다.").css('color','red');		    					 
		    				 }	
	    			 	}
	    		 });			
			});		
		});
	
	//비밀번호/ 비밀번호확인 입력 동일한지 체크
	$(function(){		
		
		$("#pw").keyup( function(){
			$("#checkpw").text('');
		});
		
		$("#pw2").keyup( function() {
			if( $("#pw").val() != $("#pw2").val() ) {
				$("#checkpw").text('');
				$("#checkpw").html("비밀번호가 일치하지 않습니다.").css('color','red');
			} else {
				$("#checkpw").text('');
				$("#checkpw").html("비밀번호가 일치합니다.").css('color','blue');
			} 
		});
	});
	
	//달력 UI ///생년월일 입력에 맞게 년도 및 월 설정
	$(function() {
		$( "#birthDate" ).datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: 'c-100:c+10',
			dateFormat: "yy-mm-dd"
		});
	});

</script>