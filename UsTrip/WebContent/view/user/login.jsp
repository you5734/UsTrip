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
    
    <!-- ///////////////////////카카오 및 구글로그인 연동/////////////////////////////// -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet" type="text/css">
	<script src="https://apis.google.com/js/api:client.js"></script>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	
	<!-- ///////////////////////// Modal popup  및 달력UI /////////////////////////////// -->
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
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
	        		  /* 타계정 로그인 시 처음방문한 사람인지 확인 */
	        		  
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
			    				   				 
			    				 if( JSONData.result ) {	//처음방문자일경우
									self.location="/view/user/login.jsp?google=1&tempId="+tempId;
			    				 } else {	//이미 등록된 회원일경우
			    					 self.location="/user/getUser?userId="+userId;					 
			    				 }	
		    			 	}
		    		 });	
				  });
				});
			});
		});
	    
		//로그인 Event처리
		$( function() {
			
			$("#userId").focus();
			
			$("#signin").on("click" , function() {
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
				} 
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});							
		});			
		
		// 회원원가입화면이동
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
											<div id="customBtn" class="customGPlusSignIn" style="width:180px;" >
												<span class="icon"></span>
													<span class="buttonText" >Google</span>
											</div>
										</div>
										<div id="name"></div>
					 				</form>
			                    </div>
					 					<!--  ////////////////////// Modal Popup /////////////////////// -->
					 					 <div id="dialog-form" title="추가정보 입력">
											  <p class="validateTips">모든정보를 입력해주세요</p>											 
											  <form id="extraUserInfo" action="/user/extraUserInfo" method="POST">
									    													    		
										    		<div class="form-group">
										    			<label class="col-md-5 control-label" for="nickName" >닉네임</label>
										    			<div class="col-sm-7">
										    				<input type="text" name="nickName" id="nickName" >
										    				<div id="checkNick" style="color:red; font-size:12px;">닉네임을 입력해주세요.</div>
										    			</div>
										    		</div><br>
										    		
										    		<div class="form-group">
										    			<label class="col-md-5 control-label" for="password" >비밀번호</label>
										    			<div class="col-sm-7">
										    				<input type="password" name="password" id="pw" >
										    			</div>
										    		</div>
<!-- 										    		
										    		<div class="form-group">
										    			<label class="col-md-5 control-label" for="password2" >비밀번호확인</label>
										    			<div class="col-sm-5">
										    				<input type="password" name="password2" id="pw2" >
										    				<div id="checkpw" style="color:red; font-size:12px;"></div>
										    			</div>
										    		</div><br>		
										    		
									    			<div class="form-group">
										    			<label class="col-md-5 control-label" for="gender" >성별</label>
										    			<div class="col-sm-7">
										    				남<input type="radio" name="gender" id="gender" value="m" >
												      		여<input type="radio" name="gender" id="gender" value="f" >
										    			</div>
										    		</div>	<br>										    											    		
										    		
										    		<div class="form-group">
										    			<label class="col-md-4 control-label" for="birthDate" >생년월일</label>
										    			<div class="col-sm-8">
										    				<input type="text" name="birthDate" id="birthDate"  >
										    			</div>
										    		</div><hr>												  

													      <div class="form-group">
													      <div class="">
														      <button type="submit" class="btn btn-info btn" id="add">등록</button>
														 	  <button type="button" class="btn btn-info" href="#">취소</button>
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
		/* console.log("userId :: 가져오닝" + userId); */
		dialog = $('#dialog-form').dialog({			
			height: 550,
			width: 550,
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