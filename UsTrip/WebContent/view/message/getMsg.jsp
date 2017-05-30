<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품정보</title>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- Bootstrap Core CSS -->
    <link href="../../css/bootstrap.min.css" rel="stylesheet">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<style>
 		body {
            padding-top : 60px;
        }
     </style>
     
	<script type="text/javascript">
	
		//답장보내기
		$( function() {
			$(".btn.btn-info").bind("click", function() {
				/* self.location = "/message/"; */
			});
		});
	
	</script>
</head>

<body>

<div class="container">
	<h3 align="center">쪽지조회</h3><br>
		<form class="form-horizontal">
			<!-- Text input-->
			<div class="form-group">
			  <label class="ccol-md-3 col-lg-3 " align="center" for="sender">보낸사람</label>  
			  <div class="col-md-4">${message.sender}</div>
			</div>

			<!-- Text input-->
			<div class="form-group">
			  <label class="ccol-md-3 col-lg-3 " align="center" for="receiver">받는사람</label>  
			  <div class="col-md-4">${message.receiver}</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group">
			  <label class="ccol-md-3 col-lg-3 " align="center" for="sendDate">보낸날짜</label>  
			  <div class="col-md-4">${message.sendDate}</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group">
			  <label class="ccol-md-3 col-lg-3 " align="center" for="readDate">읽은날짜</label>  
			  <div class="col-md-4">${message.readDate}</div>
			</div>
			
			<!-- Text input-->
			<div class="form-group" style="height:180px;">
			  <label class="ccol-md-3 col-lg-3 " align="center" for="msgContent">글내용</label>  
			  <div class="col-md-4"> ${message.msgContent }
			  </div>
			</div>

			<!-- Button -->
			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-4 text-center">
					<button type="button" class="btn btn-info">답장보내기</button>
				</div>	
			</div>
		</form>
</div>
</body>
</html>
