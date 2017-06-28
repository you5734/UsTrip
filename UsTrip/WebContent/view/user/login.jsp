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
	<!-- <script src="https://www.googleapis.com/plus/v1/activities/z12gtjhq3qn2xxl2o224exwiqruvtda0i?key=874013762845-1vbc3sib3cn2fapfgg734rjjj4suktt1.apps.googleusercontent.com"></script>
	 -->
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
//240419245572-40o3ev6lrtro935gb6aqvske3rv8toah.apps.googleusercontent.com

//google
		$( function() {
		    $(".buttonText").on("click" , function() {
				gapi.load('auth2', function() {
					auth2 = gapi.auth2.init({
					/* 	url: '/plus.login' */
					client_id: '240419245572-40o3ev6lrtro935gb6aqvske3rv8toah.apps.googleusercontent.com',
					cookiepolicy: 'single_host_origin',
					fetch_basic_profile: false,
					scope: 'profile'
		  		});
		
				// Sign the user in, and then retrieve their ID.
				auth2.signIn().then(function() {
				    console.log("dd :: " + auth2.currentUser.get().getId());
				    console.log("ss :: " + auth2.currentUser.get().getBasicProfile());
				    
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
			
			$("#findPwd").on("click" , function() {
				self.location="/view/user/findPwd.jsp";
			});

		});
		
	</script>		
	
	<style>
	#extraUserInfo> .form-group{
			margin-bottom:-5px;
		}  

		#dialog-form { 
			display:none;

			overflow-x:hidden;
                            overflow-y:auto;
                            position:relative;
		 }  
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
			padding-left: 25px;
			padding-right: 42px;
			font-size: 13px;
			font-weight: bold;
			/* Use the Roboto font that is loaded in the <head> */
			font-family: 'Roboto', sans-serif;
		}
/* 
///// */

@media (min-width: 768px) {
    .omb_row-sm-offset-3 div:first-child[class*="col-"] {
        margin-left: 25%;
    }
}

.omb_login .omb_authTitle {
    text-align: center;
	line-height: 300%;
}
	
.omb_login .omb_socialButtons a {
	color: white; // In yourUse @body-bg 
	opacity:0.9;
}
.omb_login .omb_socialButtons a:hover {
    color: white;
	opacity:1;    	
}
.omb_login .omb_socialButtons .omb_btn-facebook {background: #3b5998;}
.omb_login .omb_socialButtons .omb_btn-twitter {background: #00aced;}
.omb_login .omb_socialButtons .omb_btn-google {background: #c32f10;}

.omb_login .omb_loginOr {
	position: relative;
	font-size: 1.5em;
	color: #aaa;
	margin-top: 1em;
	margin-bottom: 1em;
	padding-top: 0.5em;
	padding-bottom: 0.5em;
}
.omb_login .omb_loginOr .omb_hrOr {
	background-color: #cdcdcd;
	height: 1px;
	margin-top: 0px !important;
	margin-bottom: 0px !important;
}
.omb_login .omb_loginOr .omb_spanOr {
	display: block;
	position: absolute;
	left: 50%;
	top: -0.6em;
	margin-left: -1.5em;
	background-color: white;
	width: 3em;
	text-align: center;
}			

.omb_login .omb_loginForm .input-group.i {
	width: 2em;
}
.omb_login .omb_loginForm  .help-block {
    color: red;
}
	
@media (min-width: 768px) {
    .omb_login .omb_forgotPwd {
        text-align: right;
 	}		
}

	</style>
</head>
<body>
	<jsp:include page="/common/toolbar.jsp"/>
        <div class="top-content" align="center">
            <div class="inner-bg">
                <div class="container">
                
					<div class="omb_login">
						<div class="row omb_row-sm-offset-3 omb_socialButtons">
							<div class="col-xs-6 col-sm-6">
								<a id="kakao-login-btn" href="javascript:loginWithKakao()">
									<img src="/images/layout/kakao_account_login_btn_medium_narrow_ov.png" >
										<span class="hidden-xs"></span>
								</a>
							</div>
<!-- 	        
     	<div class="col-xs-4 col-xs-2" style="width:180px;">
		 </div>  -->
<!-- 		    
		    	 <div class="col-xs-4 col-sm-2">
				   	<div id="gSignInWrapper">
						<div id="customBtn" class="customGPlusSignIn" >
							<span class="icon"></span>
								<span class="buttonText" >���۷� �α���</span>
						</div>
					</div>
				<div id="name"></div>
	        </div> -->	
					</div>

					<div class="row omb_row-sm-offset-3 omb_loginOr">
						<div class="col-xs-12 col-sm-6">
							<hr class="omb_hrOr">
							<span class="omb_spanOr">or</span>
						</div>
					</div>

					<div class="row omb_row-sm-offset-3">
						<div class="col-xs-12 col-sm-6">	
						    <form class="omb_loginForm" action="" autocomplete="off" method="POST">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-user"></i></span>
									<label class="sr-only" for="form-username">UserId</label>
			                 	<input type="text" name="userId" placeholder="UserId..." class="form-username form-control" id="userId">
								</div>
								<span class="help-block"></span>
													
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-lock"></i></span>
									<label class="sr-only" for="form-password">Password</label>
			                 	<input type="password" name="password" placeholder="Password..." class="form-password form-control" id="password">
								</div>
			                    <span class="help-block"></span>
								
								<button type="submit" class="button" id="signin">�α���</button>
								<button type="button" class="button" id="joinus">ȸ������</button>
							</form>
						</div>
					</div>
					<div class="row omb_row-sm-offset-3">
					<div class="col-xs-12 col-sm-3">
					</div>
					<div class="col-xs-12 col-sm-3">
						<p class="omb_forgotPwd">
							<a href="#"  id="findPwd">��й�ȣã��</a>
						</p>
					</div>
			</div>	  
		</div>
					<!-- <div class="row omb_row-sm-offset-3">
						<div class="col-xs-12 col-sm-3">
							<p class="omb_forgotPwd">
								<a href="#"  id="findPwd">��й�ȣã��</a>
							</p>
						</div>
					</div>	     -->	
				</div>
				<!--  ////////////////////// Modal Popup /////////////////////// -->
				<div id="dialog-form" title="�߰����� �Է�">
					<p class="validateTips">��������� �Է����ּ���</p>											 
					<form id="extraUserInfo" action="/user/extraUserInfo" method="POST" class="form-horizontal">
						<div class="form-group">
							<label class="col-md-4 control-label" for="nickName" >�г���</label>
							<div class="col-md-4">
								<input type="text" name="nickName" id="nickName" >
								<div id="checkNick" style="color:red; font-size:12px;">�г����� �Է����ּ���.</div>
							</div>
			    		</div><br>
			    		
		    			<div class="form-group">
			    			<label class="col-md-4 control-label" for="gender" >����</label>
			    			<div class="col-md-3">
			    				�� <input type="radio" name="gender" id="gender" value="m" checked>
					      		�� <input type="radio" name="gender" id="gender" value="f" >
			    			</div>
			    		</div><br>										    											    		
			    		
			    		<div class="form-group">
			    			<label class="col-md-4 control-label" for="birthDate" >�������</label>
			    			<div class="col-md-3">
			    				<input type="text" name="birthDate" id="birthDate"  >
			    			</div>
			    		</div><hr>												  

						<div class="form-group">
							<label class="col-md-4 control-label" ></label>
							<div class="col-md-4">
								<input type="button" class="btn btn-info btn-sm" id="add" value="���">
								<input type="button" class="btn btn-info btn-sm" id="cancle" value="���">
							</div>
						</div>
						 	  
					 	 <input type="hidden" value="${param.tempId }" id="tempId" name="userId">
     					 <input type="hidden" value="${param.kakao}" id="kakao">
     					 <input type="hidden" value="${param.google}" id="google">
					  </form>
				</div>
                    <!--  ////////////////////// Modal Popup /////////////////////// -->
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
			height: 400,
			width: 720, 
			modal: true,
			resizable:false
		});		
	}
	
	//���� ����
	 $(function() {
		$( "#add" ).on("click" , function() {
			 document.forms["extraUserInfo"].submit(); 
		});
	});	
	
	//��� ����
	$(function() {
		$("#cancle").on("click" , function() {
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