<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
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
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<script type="text/javascript">
	
		//답장보내기
		$( function() {
			$(".btn.btn-info").bind("click", function() {
				var msgNo = $("#msgNo").val();
				alert("msgNo:: " + msgNo);
				self.location = "/message/sendMsg?msgNo="+msgNo; 
			});
		});
		
		$( function() {
			$("#confirm").bind("click", function() {
				history.go(-1);
			});
		});
		
		$( function() {
			if( ! (${ empty message.msgContent }()){
				var mes = '${message.msgContent}'.replace("\r\n","<br/>");
				$("#msgContent").val(mes);
			}; 
		});
	
	</script>
</head>

<body>
<jsp:include page="/common/toolbar.jsp"/>
<div class="container">
	<h3 align="center">쪽지조회</h3><br>
		<form class="form-horizontal">
			<input type="hidden" id="msgNo" name="msgNo" value="${message.msgNo}"/>
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
			  <div class="col-md-4" id="msgContent" name="msgContent"> ${message.msgContent }
			  </div>
			</div>

			<!-- Button -->
			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-4 text-center">
						<button type="button" class="btn btn-info">답장보내기</button>
						<button type="button" class="btn btn-info btn" id="confirm">확인</button>
				</div>	
			</div>
		</form>
</div>
</body>
</html>
