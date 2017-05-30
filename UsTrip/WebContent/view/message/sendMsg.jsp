<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	
	//가입 연결
	 $(function() {
		$( ".btn.btn-info" ).on("click" , function() {
			$("form").attr("method" , "POST").attr("action" , "/message/sendMsg").submit();
		});
	});	
	
	</script>
	
	<style>
		.form-horizontal{
			margin-top: 100px;
		}
	</style>
</head>
<body>
	
	<form class="form-horizontal">
		
		<div class="form-group">
			  <label class="col-md-4 control-label" for="sender">SENDER</label>  
			  <div class="col-md-5">
				  <input id="sender" name="sender" type="text" placeholder="6 DIGIT SENDER ID" class="form-control input-md" required="" style="width:500px;">
				  <span class="help-block">ONLY ALPHABATE</span>  
			  </div>
		</div>
		
		<div class="form-group">
			  <label class="col-md-4 control-label" for="sender">RECEIVER</label>  
			  <div class="col-md-5">
				  <input id="receiver" name="receiver" type="text" placeholder="6 DIGIT SENDER ID" class="form-control input-md" required="" style="width:500px;">
				  <span class="help-block">ONLY ALPHABATE</span>  
			  </div>
		</div>
		
		<div class="form-group">
			  <label class="col-md-4 control-label" for="message">MESSAGE</label>
			  <div class="col-md-4">                     
			   	 <textarea maxlegnth="1000" class="form-control" id="msgContent" name="msgContent" style="height:200px; width:500px;"></textarea>
			  </div>
		</div>
		
		<div class="form-group">
			  <label class="col-md-4 control-label" for="SUBMIT"></label>
			  <div class="col-md-8">
				    <button id="SUBMIT" name="SUBMIT" class="btn btn-info">SEND SMS</button>
				    <button id="RESET" name="RESET" class="btn btn-danger">RESET</button>
			  </div>
		</div>
	</form>

</body>
</html>