<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

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

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	
	<script type="text/javascript">
	
	 $(function() {
		$( "#SUBMIT" ).on("click" , function() {
			$("form").attr("method" , "POST").attr("action" , "/message/sendMsg").submit();
		});
	 });
		
		$(function() {
		     $('textarea').keyup(function() {
		       var length = $(this).val().length;
		       $('#chars').text(length);
		     });
		 });
		
		//receiver 체크
		$(function(){
			
			$("#receiver").on("keyup", function(){
				
				var receiver = $("#receiver").val();
				if(receiver != "" && (receiver.indexOf('@') < 1 || receiver.indexOf('.') == -1) ){
					 $("#checkId").html("이메일형식이 아닙니다.");
				    	return;
				 }	
				var tempId = "";
				if(receiver.indexOf('.') >= 0) {
					tempId = receiver.split(".");
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
			    					 $("#checkId").html("존재하는 아이디입니다.").css('color', 'blue');
			    				 } else {
			    					 $("#checkId").html("존재하지않은 아이디입니다. 다시 입력해주세요.").css('color', 'red');
			    				 }	
		    			 	}
		    		 });			
				});		
			});
		
		$(function(){
			if( ! ${ empty message.msgContent} ){
				var mes = '${message.msgContent}'.replace("\r\n","<br>");
				var mes2 = 'RE:'+mes +'\n-----------------------------------------------------------------\n';
				$("#msgContent").val(mes2);
			}
		});	
	 
	</script>
	
</head>
<body>
<jsp:include page="/common/toolbar.jsp"/>
<div class="container">
	<form class="form-horizontal">
		<div class="form-group">
			  <label class="col-md-4 control-label" for="sender">SENDER</label>  
			  <div class="col-md-5">
				  <input id="sender" name="sender" type="text" placeholder="6 DIGIT SENDER ID" class="form-control input-md" required="" style="width:300px;" value="${user.userId }" readonly>
				  <span class="help-block">ONLY ALPHABATE</span>  
			  </div>
		</div>
		
		<div class="form-group">
			  <label class="col-md-4 control-label" for="sender">RECEIVER </label>    
 				 <div class="col-md-5">
					  <input id="receiver" name="receiver" type="text" value="${! empty message.sender ? message.sender : ""}" class="form-control input-md" required="" style="width:300px;">
					  <div id="checkId" style="color:red; font-size:12px;">ONLY E-MAIL</div>
				 </div>
		</div>
		
		<div class="form-group">
			  <label class="col-md-4 control-label" for="message">MESSAGE</label>
			  <div class="col-md-4">                     
			   	 <textarea maxlength="1000" class="form-control" id="msgContent" name="msgContent" style="height:200px; width:500px;resize: none;wrap:hard;">${!empty message.msgContent? message.msgContent:""}</textarea>
			  	 <span id="chars" style="text-align:right;"></span>/1000
			  </div>
		</div>
		
		<div class="form-group">
			  <label class="col-md-4 control-label" for="SUBMIT"></label>
			  <div class="col-md-8">
				    <button id="SUBMIT" name="SUBMIT" class="btn btn-info">SEND SMS</button>
				    <button id="RESET" name="RESET" class="btn btn-info">RESET</button>
			  </div>
		</div>
	</form>
</div>
</body>
</html>
