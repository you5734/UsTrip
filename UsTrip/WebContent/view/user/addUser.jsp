<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>

	<script type="text/javascript">
	
	//============= "가입"  연결 =============
	 $(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "#join" ).on("click" , function() {
			fncAddUser();
		});
	});	
	
	//============= "취소"  처리 및  연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]").on("click" , function() {
			$("form")[0].reset();
		});
	});	
	
	
	function fncAddUser() {
		
		var id=$("input[name='userId']").val();
		var nickname=$("input[name='nickName']").val();
		var pw=$("input[name='password']").val();
		var pw_confirm=$("input[name='password2']").val();
				
		//ID 및 닉네임 중복체크 처리해야함
		if(id == null || id.length <1){
			alert("아이디는 반드시 입력하셔야 합니다.");
			return;
		} else {
			if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
		    	alert("이메일 형식이 아닙니다.");
		     }
		}
		
		if(nickname == null || nickname.length <1){
			alert("닉네임은  반드시 입력하셔야 합니다.");
			return;
		}
		
		if(pw == null || pw.length <1){
			alert("패스워드는  반드시 입력하셔야 합니다.");
			return;
		}
		if(pw_confirm == null || pw_confirm.length <1){
			alert("패스워드 확인은  반드시 입력하셔야 합니다.");
			return;
		}

		if( pw != pw_confirm ) {				
			alert("비밀번호 확인이 일치하지 않습니다.");
			$("input:text[name='password2']").focus();
			return;
		}
			
		$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
	}
	
	
	</script>

	<style>
	       body > div.container{
	            margin-top: 50px;
	            text-align: center;
	        }
	</style>
<body>

		<div class="container" align="center">
			<h1 class>회원가입</h1>
			<form class="form-horizontal">
			
			<div>
				<label for="userId">아이디</label>				
				<input type="text" id="userId" name="userId">
			</div>
			
			<div>
				<label for="nickName">닉네임</label>				
				<input type="text" id="nickName" name="nickName">
			</div>
			
			<div>
				<label for="password">비밀번호</label>				
				<input type="text" id="password" name="password">
			</div>	
			
			<div>
				<label for="password2">비밀번호확인</label>				
				<input type="text" id="password2" name="password2">
			</div>		
			
			<div>
				<label for="gender">성별</label>				
				<input type="radio" id="male" name="male">남
				<input type="radio" id="female" name="female">여
			</div>		
			
			<div>
				<label for="birthDate">생년월일</label>				
				<input type="text" id="birthDate" name="birthDate">
			</div>	
			
			<!-- /////////////  프로필이미지등록  ////////////////////// -->
			<div>
				<label for="profileImage" >프로필이미지</label>		  			
			   		<input type="text" id="profileImage" name="profileImage" placeholder="이미지등록" >	
			   		<button type="button" id="addImage">이미지업로드</button>		
			</div>		

			<div>
				<button type="button" id="join">회원가입</button>
				<button type="button" id="#">취소</button>
			</div>	
		</form>
		</div>
		

</body>
</html>