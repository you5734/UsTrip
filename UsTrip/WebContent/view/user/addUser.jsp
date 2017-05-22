<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>

	<script type="text/javascript">
	
	//============= "����"  ���� =============
	 $(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$( "#join" ).on("click" , function() {
			fncAddUser();
		});
	});	
	
	//============= "���"  ó�� ��  ���� =============
	$(function() {
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]").on("click" , function() {
			$("form")[0].reset();
		});
	});	
	
	
	function fncAddUser() {
		
		var id=$("input[name='userId']").val();
		var nickname=$("input[name='nickName']").val();
		var pw=$("input[name='password']").val();
		var pw_confirm=$("input[name='password2']").val();
				
		//ID �� �г��� �ߺ�üũ ó���ؾ���
		if(id == null || id.length <1){
			alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		} else {
			if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
		    	alert("�̸��� ������ �ƴմϴ�.");
		     }
		}
		
		if(nickname == null || nickname.length <1){
			alert("�г�����  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		
		if(pw == null || pw.length <1){
			alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(pw_confirm == null || pw_confirm.length <1){
			alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		if( pw != pw_confirm ) {				
			alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
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
			<h1 class>ȸ������</h1>
			<form class="form-horizontal">
			
			<div>
				<label for="userId">���̵�</label>				
				<input type="text" id="userId" name="userId">
			</div>
			
			<div>
				<label for="nickName">�г���</label>				
				<input type="text" id="nickName" name="nickName">
			</div>
			
			<div>
				<label for="password">��й�ȣ</label>				
				<input type="text" id="password" name="password">
			</div>	
			
			<div>
				<label for="password2">��й�ȣȮ��</label>				
				<input type="text" id="password2" name="password2">
			</div>		
			
			<div>
				<label for="gender">����</label>				
				<input type="radio" id="male" name="male">��
				<input type="radio" id="female" name="female">��
			</div>		
			
			<div>
				<label for="birthDate">�������</label>				
				<input type="text" id="birthDate" name="birthDate">
			</div>	
			
			<!-- /////////////  �������̹������  ////////////////////// -->
			<div>
				<label for="profileImage" >�������̹���</label>		  			
			   		<input type="text" id="profileImage" name="profileImage" placeholder="�̹������" >	
			   		<button type="button" id="addImage">�̹������ε�</button>		
			</div>		

			<div>
				<button type="button" id="join">ȸ������</button>
				<button type="button" id="#">���</button>
			</div>	
		</form>
		</div>
		

</body>
</html>