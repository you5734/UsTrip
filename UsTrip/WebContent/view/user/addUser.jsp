<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

	<!-- Bootstrap Core CSS -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
	
	<!-- �޷�UI -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- �޷�UI -->
	
	<script type="text/javascript">
	
	//���� ����
	 $(function() {
		$( ".btn.btn-info" ).on("click" , function() {
			fncAddUser();
		});
	});	
	
	//��� ����
	$(function() {
		$("a[href='#' ]").on("click" , function() {
			$("form")[0].reset();
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
	
	function fncAddUser() {
					
		var id=$("input[name='userId']").val();
		var nickname=$("input[name='nickName']").val();
		var pw=$("input[name='password']").val();
		var pw_confirm=$("input[name='password2']").val();
				
		//ID �� �г��� �ߺ�üũ ó���ؾ���
		if(id == null || id.length <1){
			//���̵� �Է����� �ʾ��� ���
			alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		
		if(nickname == null || nickname.length <1){
			alert("�г�����  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		
		if(pw == null || pw.length <1){
			alert("��й�ȣ��  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(pw_confirm == null || pw_confirm.length <1){
			alert("��й�ȣ Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}

		$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
	}
	
	//���̵� �ߺ�üũ
	$(function(){
		
		$("#userId").on("keyup", function(){
			
			var userId = $("#userId").val();
			if(userId != "" && (userId.indexOf('@') < 1 || userId.indexOf('.') == -1) ){
				 $("#checkId").html("�̸��������� �ƴմϴ�.");
			    	return;
			 }	
			var tempId = "";
			if(userId.indexOf('.') >= 0) {
				tempId = userId.split(".");
			}
						
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
		    				  	    				 
		    				 if(! JSONData.result) {
		    					 $("#checkId").html("�����ϴ� ���̵��Դϴ�.").css('color', 'red');
		    				 } else {
		    					 $("#checkId").html("��밡���� ���̵��Դϴ�.").css('color', 'blue');
		    				 }	
	    			 	}
	    		 });			
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
		    				   				 
		    				 if(! JSONData.result) {
		    					 $("#checkNick").html("�����ϴ� �г����Դϴ�.");
		    				 } else {
		    					 $("#checkNick").html("��밡���� �г����Դϴ�.");
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
				$("#checkpw").html("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
			} else {
				$("#checkpw").text('');
				$("#checkpw").html("��й�ȣ�� ��ġ�մϴ�.");
			}
		});
	});
		
	
	</script>

</head>
	
<body>

		<div class="container">
			<h1 align="center">ȸ������</h1>
			<div class="row">
				<form class="form-horizontal" enctype="multipart/form-data">
			
					<div class="form-group">
						<label class="col-md-4 control-label" for="userId">���̵�</label>		
						<div class="col-md-4">		
							<input class="form-control input-md" type="text" id="userId" name="userId">
								<div id="checkId" style="color:red; font-size:12px;">�̸����ּҷ� �Է����ּ���.</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-4 control-label" for="nickName">�г���</label>
						<div class="col-md-4">				
							<input class="form-control" type="text" id="nickName" name="nickName">
								<div id="checkNick" style="color:red; font-size:12px;">�г����� �Է����ּ���.</div>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-md-4 control-label" for="password">��й�ȣ</label>	
						<div class="col-md-4">				
							<input class="form-control input-md" type="password" id="password" name="password">
						</div>
					</div>		
					
					<div class="form-group">
						<label class="col-md-4 control-label" for="password2">��й�ȣȮ��</label>	
						<div class="col-md-4">				
							<input class="form-control input-md" type="password" id="password2" name="password2">
								<div id="checkpw" style="color:red; font-size:12px;"></div>
						</div>
					</div>		
					
					<div class="form-group">
						<label class="col-md-4 control-label" for="gender">����</label>		
						<div class="col-md-4">			
							<input type="radio" id="gender" name="gender" value="m">��
							<input type="radio" id="gender" name="gender" value="f">��
						</div>
					</div>		
					
					<div class="form-group">
						<label class="col-md-4 control-label" for="birthDate">�������</label>	
						<div class="col-md-4">					
							<input class="form-control input-md" type="text" id="birthDate" name="birthDate">
						</div>		
					</div>	
					
					<!-- /////////////  �������̹������  ////////////////////// -->
					<div class="form-group">
						<label class="col-md-4 control-label" for="profileImage" >�������̹���</label>	
						<div class="col-md-4">	  			
					   		<input type="file" id="profileImage" name="file">
					   	</div>
					</div>		
				
					<div class="form-group">
						<div class="col-sm-offset-4 col-sm-4 text-center">
							<button type="button" class="btn btn-info"  >���</button>
							<button type="button" class="btn btn-info" href="#">���</button>
					</div>	
				</div>
										
			</form>
		</div>
	</div>
	
</body>
</html>